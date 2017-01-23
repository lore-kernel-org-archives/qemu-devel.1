Received: from eggs.gnu.org ([2001:4830:134:3::10]:46309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cVhZn-0000IP-Nm
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 11:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cVhZk-0000t1-J5
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 11:34:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cVhZk-0000sl-Ai
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 11:34:36 -0500
References: <1485186641-12220-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<148518739693.56.12407051583748682941@b042e9bf0dd0>
	<20170123172254.345fbecb@bahia.lan>
	<3478b86e-7a32-5e92-58cc-1cfe7ccecb41@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bc76a7c9-2951-ff8c-4174-46f8fbc65d47@redhat.com>
Date: Mon, 23 Jan 2017 10:34:31 -0600
MIME-Version: 1.0
In-Reply-To: <3478b86e-7a32-5e92-58cc-1cfe7ccecb41@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="e6fV9RFKGietsNHHjIBJAfT6cUSMM65ac"
Subject: Re: [Qemu-devel] [PATCH 0/2 V13] fsdev: add IO throttle support to
 fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Greg Kurz <groug@kaod.org>, pradeepkiruvale@gmail.com
Cc: berto@igalia.com, famz@redhat.com, qemu-devel@nongnu.org, aneesh.kumar@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e6fV9RFKGietsNHHjIBJAfT6cUSMM65ac
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 Greg Kurz <groug@kaod.org>, pradeepkiruvale@gmail.com
Cc: berto@igalia.com, famz@redhat.com, qemu-devel@nongnu.org,
 aneesh.kumar@linux.vnet.ibm.com
Message-ID: <bc76a7c9-2951-ff8c-4174-46f8fbc65d47@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2 V13] fsdev: add IO throttle support to
 fsdev devices
References: <1485186641-12220-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <148518739693.56.12407051583748682941@b042e9bf0dd0>
 <20170123172254.345fbecb@bahia.lan>
 <3478b86e-7a32-5e92-58cc-1cfe7ccecb41@huawei.com>
In-Reply-To: <3478b86e-7a32-5e92-58cc-1cfe7ccecb41@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/23/2017 10:30 AM, Pradeep Jagadeesh wrote:
> On 1/23/2017 5:22 PM, Greg Kurz wrote:
>> On Mon, 23 Jan 2017 08:03:18 -0800 (PST)
>> no-reply@patchew.org wrote:
>>> Hi,
>>>
>>> Your series seems to have some coding style problems. See output
>>> below for
>>> more information:
>>>
>>
> Ya, I observed signoff issue. I have created next version files.
> I will send them tomorrow.
>=20
> But, I do not know how to solve the second warning.
> i.e multi line macro issue.

I don't think there is anything to fix there; it is a false positive
from checkpatch.pl (unless you want to dive in to the perl script and
figure out how to relax it to allow that usage, as you are not the first
to have it).  Documenting in the commit message that checkpatch has a
false-positive warning is acceptable.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--e6fV9RFKGietsNHHjIBJAfT6cUSMM65ac
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYhjCXAAoJEKeha0olJ0NqEUEH/A8YNmmkAyrCjIgwKF6rTFKs
S5bxmJS4nl+i9M4yEXl6TVCABhVnDagi6KogASNPZWUNtbnXBsWdoJgdqYtffiIR
na+BtJqAwfHYaLC3jSMohZQgOwx9GxXqWiJPW5EnojaB7VvHUbgYFm1CiI/3/qGU
Ney4ZsOgwvofnMVu+6VFfSb5BBjqk4aL+5wOtknbkkkT+nSqDDcUKfnNOhxlpcT9
a8CA6Ip1lEo9dG15f7+fnhm033FbNTscI0b93VIL4LuwEmye5fuWrD1oQ07lM0kW
FtoJaDjpj13eeu3EL+TAQ12MXlsUg1/xFnwI5fIknVmlubqa0W/pFBx8iuo91NA=
=h9d+
-----END PGP SIGNATURE-----

--e6fV9RFKGietsNHHjIBJAfT6cUSMM65ac--
