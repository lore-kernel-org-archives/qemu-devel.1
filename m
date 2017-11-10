Received: from eggs.gnu.org ([2001:4830:134:3::10]:50620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDDE9-0004Fm-HM
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:36:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDDE8-00035O-Gw
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:36:25 -0500
References: <20171004152553.30263-1-mreitz@redhat.com>
	<87zi7u4hob.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f051da3e-9181-0e72-b9eb-4e9c2d61e971@redhat.com>
Date: Fri, 10 Nov 2017 18:36:18 +0100
MIME-Version: 1.0
In-Reply-To: <87zi7u4hob.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D8rfkD1TkAhvFrM0Di2T48IRUmHWNsIHs"
Subject: Re: [Qemu-devel] [PATCH v6 0/6] block: Don't compare strings in
 bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D8rfkD1TkAhvFrM0Di2T48IRUmHWNsIHs
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <f051da3e-9181-0e72-b9eb-4e9c2d61e971@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/6] block: Don't compare strings in
 bdrv_reopen_prepare()
References: <20171004152553.30263-1-mreitz@redhat.com>
 <87zi7u4hob.fsf@dusky.pond.sub.org>
In-Reply-To: <87zi7u4hob.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 10:16, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> bdrv_reopen_prepare() assumes that all BDS options are strings, which =
is
>> not necessarily correct. This series introduces a new qobject_is_equal=
()
>> function which can be used to test whether any options have changed,
>> independently of their type.
>=20
> Series looks ready to me.  It touches QAPI to achieve its purpose in th=
e
> block layer; I'd be fine with merging it via a block tree.

Thanks!  So now it's my problem to figure out whether this is 2.11
material...? :-)

Max


--D8rfkD1TkAhvFrM0Di2T48IRUmHWNsIHs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloF45ISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A460IAKnWB0zTP9Sp+u1UjwWXVam6EXjZv91t
caSS6GrN3HFaa5SO0tKWXt2O99ADQMQzJpCQmKa0a6juRBA3e4WQ7V1E8vbeYL+x
22Wl5Rv0qxT5gPdfJhiwoXVKbsqrRuTFRje1PbukExAKIahVrUVnCdAuQgfPh41a
Ksy8oh7Zrd42+yQP3gpmKptPql0Jv1veJ7dLhJarjeMNHhAjFJhgnih0Z/vHptyL
Mnweyqdwi8Ab+6H5sC7dyg+QFCj81GUnK+TZtJv+pzJRWAivkha8+rfr5x/2rjGC
udKqXX30mNfz7ALlOU2eGwUGh6QLR7KtzarR3kBY7cL7URdlOS+qSNw=
=V/SC
-----END PGP SIGNATURE-----

--D8rfkD1TkAhvFrM0Di2T48IRUmHWNsIHs--
