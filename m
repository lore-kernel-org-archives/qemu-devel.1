Received: from eggs.gnu.org ([2001:4830:134:3::10]:42208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlJio-0002GI-Um
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 14:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlJio-00042A-3w
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 14:52:47 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-10-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3d184720-ee1c-f777-4ead-ad3f81318aa9@redhat.com>
Date: Fri, 25 Aug 2017 13:52:38 -0500
MIME-Version: 1.0
In-Reply-To: <20170804151440.320927-10-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="brKAdkabPsjDl15NjPWb8WETmWTar9wWx"
Subject: Re: [Qemu-devel] [PATCH 09/17] block/nbd-client: move
 nbd_co_receive_reply content into nbd_co_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--brKAdkabPsjDl15NjPWb8WETmWTar9wWx
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <3d184720-ee1c-f777-4ead-ad3f81318aa9@redhat.com>
Subject: Re: [PATCH 09/17] block/nbd-client: move nbd_co_receive_reply content
 into nbd_co_request
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
 <20170804151440.320927-10-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-10-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> Move code from nbd_co_receive_reply into nbd_co_request. This simplify

s/simplify/simplifies/

> things, makes further refactoring possible. Also, a function starting

s/makes/and makes/

> with qemu_coroutine_yield is weird.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 33 ++++++++++-----------------------
>  1 file changed, 10 insertions(+), 23 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--brKAdkabPsjDl15NjPWb8WETmWTar9wWx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmgcfYACgkQp6FrSiUn
Q2rbwQf+LCHWlgs0JZm+QvkezKlYmlB+7r4VUoP/nQxj/xD7aRUuuzR1KbTUF1eU
Vx9/ALyMqb8OrD+yT1XOBLIRfmbhf3daSjDLLZ8CUp5Ecoiss168Pl6CRGuPcs1F
QFbI4xDKRMlOxGvf+2XGY1BCzwiJR+fhZkv6GYaEjWn7CwVK2MoR5+gPMbnERppE
bWwCpj9MG/uHgjczLsfudYN6IbnI+lobZUPGLLHQ6jPQSFmTCig0k9jBpWZ1YBn3
eJBs/RPlQrhh3I+cMvT8baVDZ+y5IgmEEPB8l3IojL0ZbTzf/gAZvexRp0hzP4C5
t2MuhNkGFpkOTXzNYMqKXGlHyWwPlA==
=j6Zb
-----END PGP SIGNATURE-----

--brKAdkabPsjDl15NjPWb8WETmWTar9wWx--
