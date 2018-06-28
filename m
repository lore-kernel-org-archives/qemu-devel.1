Received: from eggs.gnu.org ([2001:4830:134:3::10]:43316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYSrO-0002IX-W7
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYSrJ-0004j5-Dv
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:05:02 -0400
References: <20180627232334.14142-1-laurent@vivier.eu>
	<20180627232334.14142-9-laurent@vivier.eu>
	<20180628084437.GA4833@localhost.localdomain>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <14d0d332-d58b-a364-9582-d3e934ac0ff9@vivier.eu>
Date: Thu, 28 Jun 2018 11:04:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180628084437.GA4833@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [C v2 08/10] hw/m68k: add a dummy SWIM floppy
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Jason Wang <jasowang@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>

Le 28/06/2018 à 10:44, Kevin Wolf a écrit :
> Am 28.06.2018 um 01:23 hat Laurent Vivier geschrieben:
>> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> 
>> +static Property swim_properties[] = {
>> +    DEFINE_PROP_DRIVE("driveA", SWIMCtrl, drives[0].blk),
>> +    DEFINE_PROP_DRIVE("driveB", SWIMCtrl, drives[1].blk),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
> 
> This is not the right way to model things. The floppy controller needs
> to expose a bus and floppy drives need to be created with a separate
> -device option.
> 
> isa-fdc still has these options, but that's only for compatibility and
> their implementation is basically a wrapper around the modern qdev way.

Thank you Kevin, I will update this part.

Laurent
