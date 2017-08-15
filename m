Received: from eggs.gnu.org ([2001:4830:134:3::10]:53821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dhhUU-000587-5M
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dhhUP-0006Yd-5g
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:27:02 -0400
Received: from mail-io0-x22d.google.com ([2607:f8b0:4001:c06::22d]:34455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dhhUP-0006Y7-0g
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:26:57 -0400
Received: by mail-io0-x22d.google.com with SMTP id o9so6551396iod.1
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 12:26:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <600cf481-8708-a622-cc6f-a7ecf14acdab@ilande.co.uk>
Date: Tue, 15 Aug 2017 15:26:54 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F3AA93F-6273-45D8-863C-B735397E2E05@gmail.com>
References: <C2D23A89-6DB7-445C-BC25-71E9E49C288D@gmail.com>
	<ff49cfa1-5a00-c329-1647-3ad8367cc804@redhat.com>
	<600cf481-8708-a622-cc6f-a7ecf14acdab@ilande.co.uk>
Subject: Re: [Qemu-devel] Help with Windows NT 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?utf-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


> On Aug 14, 2017, at 3:18 AM, Mark Cave-Ayland =
<mark.cave-ayland@ilande.co.uk> wrote:
>=20
> On 14/08/17 07:51, Paolo Bonzini wrote:
>=20
>> On 13/08/2017 21:13, Programmingkid wrote:
>>> Lately I found out that Windows NT 4.0 seems to work well with the
>>> 486 and pentium processors. Using "-cpu 486" made installing it
>>> actually work. Now I am seeing another issue. When I boot Windows NT
>>> 4.0 I see this error message:
>>>=20
>>> *** STOP: 0x0000007B (0x807A8610,0x00000000,0x00000000,0x00000000)=20=

>>> INACESSIBLE_BOOT_DEVICE
>>>=20
>>> Would anyone know a way to solve this issue?
>>=20
>> Herv=C3=A9 is probably the best person to answer this question.  =
Maybe try
>> installing it with SCSI disks ("-drive if=3Dscsi,id=3Dhd,file=3D... =
-drive
>> if=3Dscsi,id=3Dcd,file=3D... -device lsi -device scsi-hd,drive=3Dhd =
-device
>> scsi-cd,drive=3Dcd").
>=20
> FWIW I used to run NT 4.0 in QEMU 0.9.1 without too many problems,
> (although every so often the mouse would go crazy and it would require =
a
> reboot). The only thing I needed to do was install updated VGA drivers
> from http://www.bearwindows.boot-land.net/vbemp.htm in order to =
prevent
> issues with the mouse pointer not displaying correctly.
>=20
> I'm also fairly sure that was with a single -hda on the command line, =
so
> it might be useful to go back quite far back in time to figure out =
what
> changed.
>=20
>=20
> ATB,
>=20
> Mark.

Thanks for the info. Trying to build 0.9.1 is going to be challenging. =
It requires GCC 3.x.=20=
