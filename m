Received: from eggs.gnu.org ([2001:4830:134:3::10]:38866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dimrS-0007vd-Dv
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dimrP-0006ac-9Q
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:23:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dimrO-0006Zm-W6
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:23:11 -0400
References: <C2D23A89-6DB7-445C-BC25-71E9E49C288D@gmail.com>
	<ff49cfa1-5a00-c329-1647-3ad8367cc804@redhat.com>
	<5D42D1E3-A946-4E2C-BDC4-BB785D0B880D@gmail.com>
	<db1ad643-9dc6-6464-1487-44007b3609ee@redhat.com>
	<D7EDAC6E-E598-491A-BB4F-789DC57196A0@gmail.com>
	<CACXAS8BKpKbkAMXPDKw2exX-MKO7sC_R5NbMSysCvjcx0qZJ6Q@mail.gmail.com>
	<5ABAF863-78A7-4D17-A519-D823CF2E9135@gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8d1c9c3b-2180-8c6e-a8e5-79e9c4afd8d4@redhat.com>
Date: Fri, 18 Aug 2017 15:23:06 -0400
MIME-Version: 1.0
In-Reply-To: <5ABAF863-78A7-4D17-A519-D823CF2E9135@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Help with Windows NT 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>



On 08/18/2017 09:36 AM, Programmingkid wrote:
>=20
>> On Aug 18, 2017, at 4:46 AM, Artyom Tarasenko <atar4qemu@gmail.com> wr=
ote:
>>
>> On Fri, Aug 18, 2017 at 6:31 AM, Programmingkid
>> <programmingkidx@gmail.com> wrote:
>>>
>>>> On Aug 15, 2017, at 6:27 PM, Paolo Bonzini <pbonzini@redhat.com> wro=
te:
>>>>
>>>> On 15/08/2017 20:46, Programmingkid wrote:
>>>>>
>>>>>> On Aug 14, 2017, at 2:51 AM, Paolo Bonzini <pbonzini@redhat.com> w=
rote:
>>>>>>
>>>>>> On 13/08/2017 21:13, Programmingkid wrote:
>>>>>>> Lately I found out that Windows NT 4.0 seems to work well with th=
e
>>>>>>> 486 and pentium processors. Using "-cpu 486" made installing it
>>>>>>> actually work. Now I am seeing another issue. When I boot Windows=
 NT
>>>>>>> 4.0 I see this error message:
>>>>>>>
>>>>>>> *** STOP: 0x0000007B (0x807A8610,0x00000000,0x00000000,0x00000000=
)
>>>>>>> INACESSIBLE_BOOT_DEVICE
>>>>>>>
>>>>>>> Would anyone know a way to solve this issue?
>>>>>>
>>>>>> Herv=C3=A9 is probably the best person to answer this question.  M=
aybe try
>>>>>> installing it with SCSI disks ("-drive if=3Dscsi,id=3Dhd,file=3D..=
. -drive
>>>>>> if=3Dscsi,id=3Dcd,file=3D... -device lsi -device scsi-hd,drive=3Dh=
d -device
>>>>>> scsi-cd,drive=3Dcd").
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> Paolo
>>>>>
>>>>> Thanks for the help. Unfortunately trying to boot from the install =
CD leads to the INACCESSIBLE_BOOT_DEVICE error when using SCSI.
>>>>
>>>> Try with 0.12.
>>>>
>>>> Paolo
>>>
>>> I finally figured out why I was seeing the INACESSIBLE_BOOT_DEVICE er=
ror. It was because of the qcow2 image format. As soon as I switched to t=
he qcow format, the error disappeared.
>>
>> That's weird. The image format is not guest visible. Probably you are
>> hitting some sort of timing issue.
>>
>>
>> --=20
>> Regards,
>> Artyom Tarasenko
>>
>> SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/la=
bel/qemu
>=20
> I'm not sure how timing is involved but I'm pretty sure I've heard abou=
t guests having problems with the qcow2 format in the past.=20
>=20

If the qcow2 driver in QEMU is written correctly, it should be 100%
invisible to guests. There should be no actual way to determine in any
way that qcow2 is being used.

Either the qcow2 driver is broken (unlikely), or the way in which the
qcow2 driver is written is exposing race conditions or other timing
problems in either the qcow2 driver, the guest, or both.

The odds of this being a "qcow2 problem" are pretty slim.

--js
