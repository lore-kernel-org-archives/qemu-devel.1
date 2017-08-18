Received: from eggs.gnu.org ([2001:4830:134:3::10]:43481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dinGP-0003lS-Ht
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dinGM-0005vx-Ex
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:49:01 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:36149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dinGM-0005vh-7V
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:48:58 -0400
Received: by mail-io0-x242.google.com with SMTP id j32so6224733iod.3
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 12:48:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <8d1c9c3b-2180-8c6e-a8e5-79e9c4afd8d4@redhat.com>
Date: Fri, 18 Aug 2017 15:48:55 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <1411A1A9-3DA9-4223-BA60-D78618BAFBAE@gmail.com>
References: <C2D23A89-6DB7-445C-BC25-71E9E49C288D@gmail.com>
	<ff49cfa1-5a00-c329-1647-3ad8367cc804@redhat.com>
	<5D42D1E3-A946-4E2C-BDC4-BB785D0B880D@gmail.com>
	<db1ad643-9dc6-6464-1487-44007b3609ee@redhat.com>
	<D7EDAC6E-E598-491A-BB4F-789DC57196A0@gmail.com>
	<CACXAS8BKpKbkAMXPDKw2exX-MKO7sC_R5NbMSysCvjcx0qZJ6Q@mail.gmail.com>
	<5ABAF863-78A7-4D17-A519-D823CF2E9135@gmail.com>
	<8d1c9c3b-2180-8c6e-a8e5-79e9c4afd8d4@redhat.com>
Subject: Re: [Qemu-devel] Help with Windows NT 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>


> On Aug 18, 2017, at 3:23 PM, John Snow <jsnow@redhat.com> wrote:
>=20
>=20
>=20
> On 08/18/2017 09:36 AM, Programmingkid wrote:
>>=20
>>> On Aug 18, 2017, at 4:46 AM, Artyom Tarasenko <atar4qemu@gmail.com> =
wrote:
>>>=20
>>> On Fri, Aug 18, 2017 at 6:31 AM, Programmingkid
>>> <programmingkidx@gmail.com> wrote:
>>>>=20
>>>>> On Aug 15, 2017, at 6:27 PM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>>>>>=20
>>>>> On 15/08/2017 20:46, Programmingkid wrote:
>>>>>>=20
>>>>>>> On Aug 14, 2017, at 2:51 AM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>>>>>>>=20
>>>>>>> On 13/08/2017 21:13, Programmingkid wrote:
>>>>>>>> Lately I found out that Windows NT 4.0 seems to work well with =
the
>>>>>>>> 486 and pentium processors. Using "-cpu 486" made installing it
>>>>>>>> actually work. Now I am seeing another issue. When I boot =
Windows NT
>>>>>>>> 4.0 I see this error message:
>>>>>>>>=20
>>>>>>>> *** STOP: 0x0000007B =
(0x807A8610,0x00000000,0x00000000,0x00000000)
>>>>>>>> INACESSIBLE_BOOT_DEVICE
>>>>>>>>=20
>>>>>>>> Would anyone know a way to solve this issue?
>>>>>>>=20
>>>>>>> Herv=C3=A9 is probably the best person to answer this question.  =
Maybe try
>>>>>>> installing it with SCSI disks ("-drive if=3Dscsi,id=3Dhd,file=3D..=
. -drive
>>>>>>> if=3Dscsi,id=3Dcd,file=3D... -device lsi -device =
scsi-hd,drive=3Dhd -device
>>>>>>> scsi-cd,drive=3Dcd").
>>>>>>>=20
>>>>>>> Thanks,
>>>>>>>=20
>>>>>>> Paolo
>>>>>>=20
>>>>>> Thanks for the help. Unfortunately trying to boot from the =
install CD leads to the INACCESSIBLE_BOOT_DEVICE error when using SCSI.
>>>>>=20
>>>>> Try with 0.12.
>>>>>=20
>>>>> Paolo
>>>>=20
>>>> I finally figured out why I was seeing the INACESSIBLE_BOOT_DEVICE =
error. It was because of the qcow2 image format. As soon as I switched =
to the qcow format, the error disappeared.
>>>=20
>>> That's weird. The image format is not guest visible. Probably you =
are
>>> hitting some sort of timing issue.
>>>=20
>>>=20
>>> --=20
>>> Regards,
>>> Artyom Tarasenko
>>>=20
>>> SPARC and PPC PReP under qemu blog: =
http://tyom.blogspot.com/search/label/qemu
>>=20
>> I'm not sure how timing is involved but I'm pretty sure I've heard =
about guests having problems with the qcow2 format in the past.=20
>>=20
>=20
> If the qcow2 driver in QEMU is written correctly, it should be 100%
> invisible to guests. There should be no actual way to determine in any
> way that qcow2 is being used.

That is what I thought.

> Either the qcow2 driver is broken (unlikely), or the way in which the
> qcow2 driver is written is exposing race conditions or other timing
> problems in either the qcow2 driver, the guest, or both.

Interesting idea.

>=20
> The odds of this being a "qcow2 problem" are pretty slim.
>=20
> --js

To anyone who wishes to recreate this test here is what you need to do.

Download this iso:
=
https://archive.org/download/Microsoft_Windows_NT_Workstation_4.0_Microsof=
t_1996/Microsoft%20Windows%20NT%20Workstation%20(4.0)%20(Microsoft)%20(199=
6).iso

Create the qcow hard drive image file:
qemu-img create -f qcow qcowtest.qcow 4G

Create the qcow2 hard drive image file:
qemu-img create -f qcow2 qcow2test.qcow2 4G

Install Windows NT 4.0 for each hard drive image file type:
qemu-system-i386 -cpu pentium -vga cirrus -hda qcowtest.qcow -boot c
-cdrom <Windows NT 4.0 iso file>

qemu-system-i386 -cpu pentium -vga cirrus -hda qcow2test.qcow2 -boot c
-cdrom <Windows NT 4.0 iso file>

The actual installation for Windows NT 4.0 only takes about 5 minutes to =
do, so it should be an easy test to do. Once done installing and setting =
up Windows, try quitting and relaunching QEMU for each image format.=20

Windows NT Workstation 4.0 CD-KEY: 30495-0006276-08164=20

Please let us know your results.=20=
