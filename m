Received: from eggs.gnu.org ([2001:4830:134:3::10]:38725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1di1Fc-0006Qt-LJ
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 12:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1di1FZ-0003tL-FF
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 12:33:00 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:38773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1di1FZ-0003rw-A3
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 12:32:57 -0400
Received: by mail-io0-x242.google.com with SMTP id o9so2573938iod.5
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 09:32:55 -0700 (PDT)
In-Reply-To: <db1ad643-9dc6-6464-1487-44007b3609ee@redhat.com>
References: <C2D23A89-6DB7-445C-BC25-71E9E49C288D@gmail.com>
	<ff49cfa1-5a00-c329-1647-3ad8367cc804@redhat.com>
	<5D42D1E3-A946-4E2C-BDC4-BB785D0B880D@gmail.com>
	<db1ad643-9dc6-6464-1487-44007b3609ee@redhat.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <949A5A1F-0C50-463D-A9B4-5639A3FF1D98@gmail.com>
Content-Transfer-Encoding: quoted-printable
From: G 3 <programmingkidx@gmail.com>
Date: Wed, 16 Aug 2017 12:32:48 -0400
Subject: Re: [Qemu-devel] Help with Windows NT 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>


On Aug 15, 2017, at 6:27 PM, Paolo Bonzini wrote:

> On 15/08/2017 20:46, Programmingkid wrote:
>>
>>> On Aug 14, 2017, at 2:51 AM, Paolo Bonzini <pbonzini@redhat.com> =20
>>> wrote:
>>>
>>> On 13/08/2017 21:13, Programmingkid wrote:
>>>> Lately I found out that Windows NT 4.0 seems to work well with the
>>>> 486 and pentium processors. Using "-cpu 486" made installing it
>>>> actually work. Now I am seeing another issue. When I boot =20
>>>> Windows NT
>>>> 4.0 I see this error message:
>>>>
>>>> *** STOP: 0x0000007B (0x807A8610,0x00000000,0x00000000,0x00000000)
>>>> INACESSIBLE_BOOT_DEVICE
>>>>
>>>> Would anyone know a way to solve this issue?
>>>
>>> Herv=E9 is probably the best person to answer this question.  Maybe =20=

>>> try
>>> installing it with SCSI disks ("-drive if=3Dscsi,id=3Dhd,file=3D... =
-drive
>>> if=3Dscsi,id=3Dcd,file=3D... -device lsi -device scsi-hd,drive=3Dhd =
-device
>>> scsi-cd,drive=3Dcd").
>>>
>>> Thanks,
>>>
>>> Paolo
>>
>> Thanks for the help. Unfortunately trying to boot from the install =20=

>> CD leads to the INACCESSIBLE_BOOT_DEVICE error when using SCSI.
>
> Try with 0.12.
>
> Paolo

Here is what I tried and the results:
QEMU	Windows NT 4.0 Status
---------	--------------------------------
0.9.1	Works
0.10.2	Freezes at the blue startup screen
0.13.0	Freezes at the blue startup screen
1.0.1	Freezes at the blue startup screen

I'm working to find if a single commit broke QEMU's Windows NT 4.0 =20
compatibility. I think its possible the BIOS might be the issue.=20=
