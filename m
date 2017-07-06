Received: from eggs.gnu.org ([2001:4830:134:3::10]:37494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dT8wu-0002lr-Dr
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dT8wr-0006o3-Bh
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:44:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dT8wr-0006nT-27
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:44:09 -0400
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
	<20170621153424.16690-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b6c421c8-463a-aa8d-6555-533c4b7c4218@redhat.com>
Date: Thu, 6 Jul 2017 10:44:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170621153424.16690-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hgRBuNFvawb0jLhKlpK5wO4LFJLXU1Skb"
Subject: Re: [Qemu-devel] [PATCH v2 6/6] nbd: use generic trace subsystem
 instead of TRACE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hgRBuNFvawb0jLhKlpK5wO4LFJLXU1Skb
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <b6c421c8-463a-aa8d-6555-533c4b7c4218@redhat.com>
Subject: Re: [PATCH v2 6/6] nbd: use generic trace subsystem instead of TRACE
 macro
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
 <20170621153424.16690-7-vsementsov@virtuozzo.com>
In-Reply-To: <20170621153424.16690-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/21/2017 10:34 AM, Vladimir Sementsov-Ogievskiy wrote:
> Starting from this patch to enable traces use -trace option of qemu or
> -T, --trace option of qemu-img, qemu-io and qemu-nbd. For qemu traces
> also can be managed by qmp commands trace-event-{get,set}-state.
>=20
> Recompilation with CFLAGS=3D-DDEBUG_NBD is no more needed, furthermore,=

> DEBUG_NBD macro is removed from the code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

> +++ b/nbd/server.c

> @@ -441,7 +441,7 @@ static int nbd_negotiate_options(NBDClient *client,=
 Error **errp)
>          }
>          length =3D be32_to_cpu(length);
> =20
> -        TRACE("Checking option 0x%" PRIx32, clientflags);
> +        trace_nbd_negotiate_options_check_option(clientflags);

This variable is a stupid name (it has nothing to do with flags, but is
a single integer representing the option requested by the client). Now's
as good as any to rename it to something that makes sense (maybe 'option'=
).

> +nbd_negotiate_options_check_option(uint32_t clientflags) "Checking opt=
ion 0x%" PRIx32

and likewise use the saner name in the trace file.  Perhaps as a
separate cleanup patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hgRBuNFvawb0jLhKlpK5wO4LFJLXU1Skb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXlrCAAoJEKeha0olJ0NqXlwH/320i5UHS8wuhJrcMJb0CvBc
hgHDdgxEsW8XNiCmCEld/jw/30OEVqJSmqSA7RXZ7a9ytieZLq6y728KkNBBvfF1
RyJI99Bvk+5YqTsP54wCYLixQrN/qWH3OIfgoWVngB8IxRTBiZCaPYBO7CxoR8yF
A5a127dULlLaheCg17grhEhCqeRaC0Chi0nmA0jemQAGZQe6gTYDJre7pICxfb/t
5uN8U4Ofyg/O8d/WHohf9Rz+huNMte13DrJUX3we6YMH2m0GLin2dEhsGKcQiJxO
gXCJayxaob7Ej5/SlEUB60WrItZd2fMgUg2FN1Y67s4a2pxEnhDLf3YFek3aZqo=
=6lZW
-----END PGP SIGNATURE-----

--hgRBuNFvawb0jLhKlpK5wO4LFJLXU1Skb--
