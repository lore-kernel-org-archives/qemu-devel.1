Received: from eggs.gnu.org ([2001:4830:134:3::10]:45492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dihSR-0007Et-RB
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dihSO-00061d-O0
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:37:03 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:37671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dihSO-00061H-JH
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:37:00 -0400
Received: by mail-it0-x241.google.com with SMTP id 77so5944649itj.4
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 06:37:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CACXAS8BKpKbkAMXPDKw2exX-MKO7sC_R5NbMSysCvjcx0qZJ6Q@mail.gmail.com>
Date: Fri, 18 Aug 2017 09:36:56 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <5ABAF863-78A7-4D17-A519-D823CF2E9135@gmail.com>
References: <C2D23A89-6DB7-445C-BC25-71E9E49C288D@gmail.com>
	<ff49cfa1-5a00-c329-1647-3ad8367cc804@redhat.com>
	<5D42D1E3-A946-4E2C-BDC4-BB785D0B880D@gmail.com>
	<db1ad643-9dc6-6464-1487-44007b3609ee@redhat.com>
	<D7EDAC6E-E598-491A-BB4F-789DC57196A0@gmail.com>
	<CACXAS8BKpKbkAMXPDKw2exX-MKO7sC_R5NbMSysCvjcx0qZJ6Q@mail.gmail.com>
Subject: Re: [Qemu-devel] Help with Windows NT 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?utf-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>


> On Aug 18, 2017, at 4:46 AM, Artyom Tarasenko <atar4qemu@gmail.com> =
wrote:
>=20
> On Fri, Aug 18, 2017 at 6:31 AM, Programmingkid
> <programmingkidx@gmail.com> wrote:
>>=20
>>> On Aug 15, 2017, at 6:27 PM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>>>=20
>>> On 15/08/2017 20:46, Programmingkid wrote:
>>>>=20
>>>>> On Aug 14, 2017, at 2:51 AM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>>>>>=20
>>>>> On 13/08/2017 21:13, Programmingkid wrote:
>>>>>> Lately I found out that Windows NT 4.0 seems to work well with =
the
>>>>>> 486 and pentium processors. Using "-cpu 486" made installing it
>>>>>> actually work. Now I am seeing another issue. When I boot Windows =
NT
>>>>>> 4.0 I see this error message:
>>>>>>=20
>>>>>> *** STOP: 0x0000007B =
(0x807A8610,0x00000000,0x00000000,0x00000000)
>>>>>> INACESSIBLE_BOOT_DEVICE
>>>>>>=20
>>>>>> Would anyone know a way to solve this issue?
>>>>>=20
>>>>> Herv=C3=A9 is probably the best person to answer this question.  =
Maybe try
>>>>> installing it with SCSI disks ("-drive if=3Dscsi,id=3Dhd,file=3D... =
-drive
>>>>> if=3Dscsi,id=3Dcd,file=3D... -device lsi -device scsi-hd,drive=3Dhd =
-device
>>>>> scsi-cd,drive=3Dcd").
>>>>>=20
>>>>> Thanks,
>>>>>=20
>>>>> Paolo
>>>>=20
>>>> Thanks for the help. Unfortunately trying to boot from the install =
CD leads to the INACCESSIBLE_BOOT_DEVICE error when using SCSI.
>>>=20
>>> Try with 0.12.
>>>=20
>>> Paolo
>>=20
>> I finally figured out why I was seeing the INACESSIBLE_BOOT_DEVICE =
error. It was because of the qcow2 image format. As soon as I switched =
to the qcow format, the error disappeared.
>=20
> That's weird. The image format is not guest visible. Probably you are
> hitting some sort of timing issue.
>=20
>=20
> --=20
> Regards,
> Artyom Tarasenko
>=20
> SPARC and PPC PReP under qemu blog: =
http://tyom.blogspot.com/search/label/qemu

I'm not sure how timing is involved but I'm pretty sure I've heard about =
guests having problems with the qcow2 format in the past.=20=
