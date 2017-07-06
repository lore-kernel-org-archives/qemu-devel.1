Received: from eggs.gnu.org ([2001:4830:134:3::10]:49503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dT85v-00006K-Pu
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dT85s-00048T-2P
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:49:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dT85r-00047y-Pa
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:49:24 -0400
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
	<20170621153424.16690-7-vsementsov@virtuozzo.com>
	<ac4e0a9b-1846-86b2-1e78-f8ae6a61c3ec@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <04346a67-66b0-2ca3-0b2c-ecdb8d2c2012@redhat.com>
Date: Thu, 6 Jul 2017 09:49:18 -0500
MIME-Version: 1.0
In-Reply-To: <ac4e0a9b-1846-86b2-1e78-f8ae6a61c3ec@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cvBBOVKKq6lqRpmi11EdRu71OfpJKfOAx"
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
Cc: pbonzini@redhat.com, stefanha@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cvBBOVKKq6lqRpmi11EdRu71OfpJKfOAx
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, den@openvz.org
Message-ID: <04346a67-66b0-2ca3-0b2c-ecdb8d2c2012@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/6] nbd: use generic trace subsystem
 instead of TRACE macro
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
 <20170621153424.16690-7-vsementsov@virtuozzo.com>
 <ac4e0a9b-1846-86b2-1e78-f8ae6a61c3ec@redhat.com>
In-Reply-To: <ac4e0a9b-1846-86b2-1e78-f8ae6a61c3ec@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/29/2017 03:12 PM, Eric Blake wrote:
> On 06/21/2017 10:34 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Starting from this patch to enable traces use -trace option of qemu or=

>> -T, --trace option of qemu-img, qemu-io and qemu-nbd. For qemu traces
>> also can be managed by qmp commands trace-event-{get,set}-state.
>=20
> Maybe:
>=20
> Let NBD use the trace mechanisms already present in qemu. Now you can
> use the -trace optino of qemu, or the -T/--trace option of qemu-img,
> qemu-io, and qemu-nbd, to select nbd traces.  For qemu, the QMP command=
s
> trace-event-{get,set}-state can also toggle tracing on the fly.
>=20
> I also mentioned in v1 that an actual command line example might be
> helpful (for example, is it qemu-nbd --trace "nbd_*" to get ALL nbd
> traces enabled?)

Answering myself: almost.  Either you have to use the pattern --trace
"*nbd_*", or better, you follow Paolo's advice to rename any 'do_nbd_'
traces to be just 'nbd_'.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cvBBOVKKq6lqRpmi11EdRu71OfpJKfOAx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXk3vAAoJEKeha0olJ0NqqyYH/02mmJtRnXfQXmNTp5R0wvxh
aeZdV+F3LIHqEot1nyprFe2RUjDT1R8hg14cwY9O6qiVkfPfFBRkLsqatEQqEKVz
8HG/+qh4x4gybV6tGwcZUqJbR/TFNOwvbXqRrIqi60RAAJW46Q+cOlQe0Lkw4MiX
KipR7S2NbS5PLfW2qqJJJLA2DReMOZ8CSim4zWv4z9o1IPZKdIqgoOe8vd1ilhM5
Wls54QqQlGizhBaVztiHwchgDFBLtdo3Bvm/y41eUhd1xdM3u4SOfL/oIFbfTrpz
QJ4Dm6W93+VR6xe72b17ZMIzsUl9Xrgn1f9fOLIhPwb1+E0uclsoH3ATF3MS2NI=
=e4S2
-----END PGP SIGNATURE-----

--cvBBOVKKq6lqRpmi11EdRu71OfpJKfOAx--
