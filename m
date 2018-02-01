Received: from eggs.gnu.org ([2001:4830:134:3::10]:48839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehJ9C-0004aA-Pu
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehJ9B-0002W4-VG
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:59:42 -0500
References: <20180130062503.32596-1-famz@redhat.com>
	<7d94ad09-9c3e-da10-3f15-2c15147fb837@redhat.com>
	<CAK1Eb9k_x9guD5L2EPBEx1ipjuUmFAA0FbLsAHkgp==z+=r7dA@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8f78f816-a37e-e968-e844-a7088e87b9e4@redhat.com>
Date: Thu, 1 Feb 2018 18:59:29 +0100
MIME-Version: 1.0
In-Reply-To: <CAK1Eb9k_x9guD5L2EPBEx1ipjuUmFAA0FbLsAHkgp==z+=r7dA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eTXquTiLWH4lIcgtzJYc1qRMPT38BklIe"
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix CID for VMDK afl image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eTXquTiLWH4lIcgtzJYc1qRMPT38BklIe
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <8f78f816-a37e-e968-e844-a7088e87b9e4@redhat.com>
Subject: Re: [PATCH] iotests: Fix CID for VMDK afl image
References: <20180130062503.32596-1-famz@redhat.com>
 <7d94ad09-9c3e-da10-3f15-2c15147fb837@redhat.com>
 <CAK1Eb9k_x9guD5L2EPBEx1ipjuUmFAA0FbLsAHkgp==z+=r7dA@mail.gmail.com>
In-Reply-To: <CAK1Eb9k_x9guD5L2EPBEx1ipjuUmFAA0FbLsAHkgp==z+=r7dA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-01 01:55, Fam Zheng wrote:
> On Thu, Feb 1, 2018 at 2:58 AM, Max Reitz <mreitz@redhat.com> wrote:
>> On 2018-01-30 07:25, Fam Zheng wrote:
>>> This reverts commit 76bf133c4 which updated the reference output, and=

>>> fixed the reference image, because the code path we want to exercise =
is
>>> actually the invalid image size.
>>>
>>> The descriptor block in the image, which includes the CID to verify, =
has been
>>> invalid since the reference image was added. Since commit 9877860e7bd=
 we report
>>> this error earlier than the "file too large", so 059.out mismatches.
>>>
>>> The binary change is generated along the operations of:
>>>
>>>   $ bunzip2 afl9.vmdk.bz2
>>>   $ qemu-img create -f vmdk fix.vmdk 1G
>>>   $ dd if=3Dafl9.vmdk.bz2 of=3Dfix.vmdk bs=3D512 count=3D1 conv=3Dnot=
runc
>>>   $ mv fix.vmdk afl9.vmdk
>>>   $ bzip2 afl9.vmdk
>>>
>>> Signed-off-by: Fam Zheng <famz@redhat.com>
>>>
>>> ---
>>>
>>> v2: Fix commit message "qcow2 -> vmdk". [Kevin]
>>>     Revert 76bf133c4.
>>
>> Hmmmm, now this fails again on my 32 bit build. :-(
>>
>> The issue there is that you get a "Cannot allocate memory" when trying=

>> to open the file.  My current fix was 2291712c39111a732 which simply
>> converted that to "Invalid argument", but now it's getting a bit more
>> complicated...  Should I just continue to play the game and check the
>> output for "Cannot allocate memory" and print exactly what the referen=
ce
>> output is expecting...?
>=20
> Ahhh. OK, then, with a big comment.
>=20
> I'd say let's just _notrun on 32 bit.

Sounds OK, but how would we test that? uname? Or just _notrun when we
see the ENOMEM message?

Max


--eTXquTiLWH4lIcgtzJYc1qRMPT38BklIe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzVYESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AK7cH9i/k/wd51BTv0fwBjbHGNyNb1AgwVo/N
pvWltfQl2Wb/E3xdqZVcnJ1sitkgtVK0IkW3okKlsHL4n7xhK+CM87nfVH20tkNp
isan7zIEtUE/QeIOZy3y59OOiT4OSkKUP6W1+u85hn+5GUm2qhDzOIalZ3ixy179
a2c4cthfJQegf4WsSW00naCpa3rtBbAxRAPN8txrB+o+gz/hhJ4U5hJqUAQDg98Z
pxq98SftsYEGdMjazbrPsvN5nokYZnw36OX2HbtQpvMiYNYlZiuVjEo21DXkJ+v0
0Jd8ZfSgq2SShcFnbakvaCy0uB7rHAjKiFMe1Dzp1cQBb/iWCVwSfA==
=f7uG
-----END PGP SIGNATURE-----

--eTXquTiLWH4lIcgtzJYc1qRMPT38BklIe--
