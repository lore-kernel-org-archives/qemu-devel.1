Received: from eggs.gnu.org ([2001:4830:134:3::10]:39229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dh9eA-0005q8-QG
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 03:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dh9e5-0006V2-PI
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 03:18:46 -0400
Received: from chuckie.co.uk ([82.165.15.123]:47606
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dh9e5-0006TB-ID
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 03:18:41 -0400
References: <C2D23A89-6DB7-445C-BC25-71E9E49C288D@gmail.com>
	<ff49cfa1-5a00-c329-1647-3ad8367cc804@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <600cf481-8708-a622-cc6f-a7ecf14acdab@ilande.co.uk>
Date: Mon, 14 Aug 2017 08:18:19 +0100
MIME-Version: 1.0
In-Reply-To: <ff49cfa1-5a00-c329-1647-3ad8367cc804@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Help with Windows NT 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Programmingkid <programmingkidx@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 14/08/17 07:51, Paolo Bonzini wrote:

> On 13/08/2017 21:13, Programmingkid wrote:
>> Lately I found out that Windows NT 4.0 seems to work well with the
>> 486 and pentium processors. Using "-cpu 486" made installing it
>> actually work. Now I am seeing another issue. When I boot Windows NT
>> 4.0 I see this error message:
>>
>> *** STOP: 0x0000007B (0x807A8610,0x00000000,0x00000000,0x00000000) 
>> INACESSIBLE_BOOT_DEVICE
>>
>> Would anyone know a way to solve this issue?
> 
> Hervé is probably the best person to answer this question.  Maybe try
> installing it with SCSI disks ("-drive if=scsi,id=hd,file=... -drive
> if=scsi,id=cd,file=... -device lsi -device scsi-hd,drive=hd -device
> scsi-cd,drive=cd").

FWIW I used to run NT 4.0 in QEMU 0.9.1 without too many problems,
(although every so often the mouse would go crazy and it would require a
reboot). The only thing I needed to do was install updated VGA drivers
from http://www.bearwindows.boot-land.net/vbemp.htm in order to prevent
issues with the mouse pointer not displaying correctly.

I'm also fairly sure that was with a single -hda on the command line, so
it might be useful to go back quite far back in time to figure out what
changed.


ATB,

Mark.
