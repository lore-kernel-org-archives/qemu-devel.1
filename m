Received: from eggs.gnu.org ([2001:4830:134:3::10]:48405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1di1t7-0001UR-8g
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 13:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1di1t4-00017c-2o
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 13:13:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1di1t3-00016p-PM
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 13:13:46 -0400
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1499182263-19139-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<87bmoxcuvn.fsf@dusky.pond.sub.org>
	<61626c42-9c47-14e5-24b7-e6086d042a6b@huawei.com>
	<87shh3fn7d.fsf@dusky.pond.sub.org>
	<w511soml2kh.fsf@maestria.local.igalia.com>
	<34e45421-0b22-15b4-deb7-980f26e5ca23@huawei.com>
	<w51shh2jfi9.fsf@maestria.local.igalia.com>
	<87wp6e6qb7.fsf@dusky.pond.sub.org>
	<dc14df7c-2f7c-300b-5f60-44411f3d6604@huawei.com>
	<66aac45f-6319-2eca-3703-aaab43557e00@redhat.com>
	<87shgz8k5q.fsf@dusky.pond.sub.org> <87pobv1oeo.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <77e7be70-4d71-56ba-18e3-92cb2b24b38e@redhat.com>
Date: Wed, 16 Aug 2017 12:13:39 -0500
MIME-Version: 1.0
In-Reply-To: <87pobv1oeo.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WHnKNH0OobdfJDQCMqIj1ETVWcm0LMMOe"
Subject: Re: [Qemu-devel] [PATCH v7 2/6] qmp: Create IOThrottle structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, greg kurz <groug@kaod.org>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WHnKNH0OobdfJDQCMqIj1ETVWcm0LMMOe
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 jani kokkonen <jani.kokkonen@huawei.com>, greg kurz <groug@kaod.org>,
 Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, qemu-devel@nongnu.org
Message-ID: <77e7be70-4d71-56ba-18e3-92cb2b24b38e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 2/6] qmp: Create IOThrottle structure
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1499182263-19139-3-git-send-email-pradeep.jagadeesh@huawei.com>
 <87bmoxcuvn.fsf@dusky.pond.sub.org>
 <61626c42-9c47-14e5-24b7-e6086d042a6b@huawei.com>
 <87shh3fn7d.fsf@dusky.pond.sub.org>
 <w511soml2kh.fsf@maestria.local.igalia.com>
 <34e45421-0b22-15b4-deb7-980f26e5ca23@huawei.com>
 <w51shh2jfi9.fsf@maestria.local.igalia.com>
 <87wp6e6qb7.fsf@dusky.pond.sub.org>
 <dc14df7c-2f7c-300b-5f60-44411f3d6604@huawei.com>
 <66aac45f-6319-2eca-3703-aaab43557e00@redhat.com>
 <87shgz8k5q.fsf@dusky.pond.sub.org> <87pobv1oeo.fsf@dusky.pond.sub.org>
In-Reply-To: <87pobv1oeo.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/16/2017 11:13 AM, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
>=20

>>
>> Conclusion: no consensus, yet.
>=20
> All right, let's start over and try to resolve the impasse and/or
> misunderstanding.
>=20
> Type BlockIOThrottle lives in qapi/block-core.json, and is used by QMP
> command block_set_io_throttle.  Since 1.1.
>=20
> Pradeep has a use case for throttling in fsdev.  Instead of duplicating=

> the relevant parts of BlockIOThrottle, qmp_block_set_io_throttle() and
> hmp_block_set_io_throttle(), he factors them out smartly, into
>=20
> * [PATCH 2] IOThrottle, base type of BlockIOThrottle
>=20
> * [PATCH 3] throttle_set_io_limits(), called by
>   qmp_block_set_io_throttle()
>=20
> * [PATCH 4] hmp_initialize_io_throttle(), called by
>   hmp_block_set_io_throttle()
>=20
> throttle_set_io_limits() goes into existing util/throttle.c, and
> hmp_initialize_io_throttle() goes into existing hmp.c.  The question is=

> where IOThrottle should go.

Good summary.

>=20
> Pradeep proposes to put it in new qapi/throttle.json.  Certainly
> defensible, but I really don't like putting every little thing shared
> across subsystem boundaries into its own schema file.

I agree with the dislike of creating new files, if an existing file is
adequate.

>=20
> Let me step back and discuss why we split the QAPI schema into multiple=

> files in the first place.  For me, the one and only reason is
> MAINTAINERS.

Indeed, that's a good description of why splits would be appropriate.
So the obvious next question is if this is a case that needs a new
maintainer.

>=20
> If the block folks should continue to maintain IOThrottle, then it
> should stay put in block-core.json.

I think Manos' work on making throttling a filter driver at the block
layer is proof enough that it it is still fine to keep throttling
maintained in block-core.json.

>=20
> If somebody else should start maintaining it, it should move.  We'd nee=
d
> a suitable entry in MAINTAINERS then.
>=20
> I don't see why maintenance should change, and therefore believe it
> should stay put.
>=20
> Eric?

I think we're in violent agreement: don't create a new file, and having
the new factored type live in block-core.json is the best fit because we
haven't come up with any reasons why it needs to be split.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WHnKNH0OobdfJDQCMqIj1ETVWcm0LMMOe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmUfUQACgkQp6FrSiUn
Q2qtXgf+IQSoKMQtovviknmd5Nt9Wwh9DoyEQiwrC4cBspZbGnpYosXAk6V0AIn2
xaOD6rCa65eDoYtfmIrkq4A1+vGhKFmFklxoH/1Ge+hOtsuPAf21R3GfTMts3jaO
zTGRy+3eg1Ycgv78fUPM5gDpCLylCag6iKaGCS6nXQGfYTSBPs8DP7zO3IMlJrN4
ez+uFKbdZgTRw7Q+0/IoP3qg8bIThjhi89OKPJnVwCQlwOijbryfI/t+koIzO7Mf
HmsK3IywoowJZFiXe1nthfiqYeVcOD3aWHg6o0sD24bI0PTGanWHEtUict7iKTLt
mVb59PtVGOTA/V4f8P7t83g/PJNDMw==
=v+SW
-----END PGP SIGNATURE-----

--WHnKNH0OobdfJDQCMqIj1ETVWcm0LMMOe--
