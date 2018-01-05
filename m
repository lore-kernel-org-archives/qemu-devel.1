Received: from eggs.gnu.org ([2001:4830:134:3::10]:55148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXVTy-00086J-5P
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:08:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXVTw-00079z-S9
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:08:38 -0500
References: <20180105133241.14141-1-muriloo@linux.vnet.ibm.com>
	<20180105133241.14141-2-muriloo@linux.vnet.ibm.com>
	<07c8789d-bebb-deed-b64c-806edf17f99c@redhat.com>
	<fb11ac10-0b17-b9d6-0e2a-540cac882900@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3dd18c73-5410-3306-2252-56afe45ff3e1@redhat.com>
Date: Fri, 5 Jan 2018 11:08:28 -0600
MIME-Version: 1.0
In-Reply-To: <fb11ac10-0b17-b9d6-0e2a-540cac882900@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HbrsVO8Ppw6a8hldDrn2Oksv8XajXIzCG"
Subject: Re: [Qemu-devel] [PATCH 1/1] block/nbd: fix segmentation fault when
 .desc is not null-terminated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Murilo_Opsfelder_Ara=c3=bajo?= <muriloo@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>, Max Reitz <mreitz@redhat.com>, R Nageswara Sastry <nasastry@in.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HbrsVO8Ppw6a8hldDrn2Oksv8XajXIzCG
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Murilo_Opsfelder_Ara=c3=bajo?= <muriloo@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, R Nageswara Sastry <nasastry@in.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3dd18c73-5410-3306-2252-56afe45ff3e1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] block/nbd: fix segmentation fault when
 .desc is not null-terminated
References: <20180105133241.14141-1-muriloo@linux.vnet.ibm.com>
 <20180105133241.14141-2-muriloo@linux.vnet.ibm.com>
 <07c8789d-bebb-deed-b64c-806edf17f99c@redhat.com>
 <fb11ac10-0b17-b9d6-0e2a-540cac882900@linux.vnet.ibm.com>
In-Reply-To: <fb11ac10-0b17-b9d6-0e2a-540cac882900@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2018 08:47 AM, Murilo Opsfelder Ara=C3=BAjo wrote:

>>> This patch fixes the segmentation fault in strcmp() by adding a NULL =
element at
>>> the end of nbd_runtime_opts.desc list, which is the common practice t=
o most of
>>> other structs like runtime_opts in block/null.c. Thus, the desc[i].na=
me !=3D NULL
>>> check becomes safe because it will not evaluate to true when .desc li=
st reached
>>> its end.
>>>
>>> Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>
>>> Buglink: https://bugs.launchpad.net/qemu/+bug/1727259
>>> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>
>>
>> I'll update the commit message to add in the commit id that introduced=


Commit 7ccc44fd7, in 2.7.0.

>> the problem, as well as check that other QemuOptsList do not have a
>> similar problem; I'm queueing this on the NBD tree and will submit a
>> pull request soon.
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Hi, Eric.
>=20
> A quick look brought my attention to:
>=20
> block/ssh.c
> 530:static QemuOptsList ssh_runtime_opts =3D {
>=20
> I've sent a patch to fix it too.

And my audit matches yours that there were no other culprits besides
those two.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HbrsVO8Ppw6a8hldDrn2Oksv8XajXIzCG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpPsQ0ACgkQp6FrSiUn
Q2oiowf+JA/MndvbkBwkig7iyrdz4YGHem+Lu4shedB3Jvyn2Lk/A0dg4yu3sMvZ
maHBG/S1KAbQRR9kvm0NaB4IhTqDuHzAWctHOd0nOs74+KuEdWfcVKnMO96G9d+h
zKFdoy0onNw57UDv+zJFLK6JEICd0RWQ33Uriyj4x5zOXs9m81L789A3ffo6vPdB
FPNrm1qM1fFwgxPHl/xm5L7BxK1vSb3q8fWMV33kOHNDbA9berG1PRGsQKl40Gx2
adJUoRTplFU7njXnHsCJH9zgsq6OQAcPA3XMXe11uKynAxn9RuLjovn9mAg3OXrZ
X3isV7108wd52GYswPYIW84J2kTzCA==
=uk9B
-----END PGP SIGNATURE-----

--HbrsVO8Ppw6a8hldDrn2Oksv8XajXIzCG--
