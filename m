Received: from eggs.gnu.org ([2001:4830:134:3::10]:57201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dkAyC-0007ep-Ug
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dkAy7-00045C-UX
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:19:56 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dkAy7-00044p-OF
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:19:51 -0400
Received: by mail-io0-f172.google.com with SMTP id g135so24463325iog.1
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 08:19:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <600cf481-8708-a622-cc6f-a7ecf14acdab@ilande.co.uk>
Date: Tue, 22 Aug 2017 11:19:43 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <161C9C21-7DBB-4A29-9AF5-4459D32B5DAE@gmail.com>
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

I encountered the mouse problem also. It acts very similar to what we =
saw with Mac OS 9 not too long ago.=20=
