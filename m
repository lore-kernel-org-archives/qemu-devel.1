Received: from eggs.gnu.org ([2001:4830:134:3::10]:48504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHSmT-0000YX-Px
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHSmO-0000U8-IT
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:05:57 -0400
References: <20181029134000.11157-1-mark.cave-ayland@ilande.co.uk>
	<20181029134000.11157-6-mark.cave-ayland@ilande.co.uk>
	<e361c22a-3a0e-6e28-ef03-8a527798836c@reactos.org>
	<ef9f3b7a-d9f7-d163-3bd2-16bac2947ce6@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <930fd4d9-5f58-6aeb-8bcf-4e6debfb8308@vivier.eu>
Date: Tue, 30 Oct 2018 13:05:23 +0100
MIME-Version: 1.0
In-Reply-To: <ef9f3b7a-d9f7-d163-3bd2-16bac2947ce6@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 05/11] hw/m68k: Apple Sound Chip (ASC)
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, afaerber@suse.de, aurelien@aurel32.net

Le 30/10/2018 à 11:46, Mark Cave-Ayland a écrit :
> On 30/10/2018 06:46, Hervé Poussineau wrote:
> 
>> Le 29/10/2018 à 14:39, Mark Cave-Ayland a écrit :
>>> From: Laurent Vivier <laurent@vivier.eu>
>>>
>>> This is broken as the linux driver seems broken too...
>>>
>>> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>> ---
>>>   hw/audio/Makefile.objs |   1 +
>>>   hw/audio/asc.c         | 446 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>   include/hw/audio/asc.h |  48 ++++++
>>>   3 files changed, 495 insertions(+)
>>>   create mode 100644 hw/audio/asc.c
>>>   create mode 100644 include/hw/audio/asc.h
>>
>> According to above comment, this device is broken.
>> Is it necessary for Q800 emulation? What happens if you remove it?
> 
> A quick test here shows that I can still boot without it, so it doesn't seem to be
> essential. Laurent, should we remove this from the next revision of the patchset? The
> general consensus seems to be that if a device isn't required (for now) then it
> shouldn't be included.

It can be removed.

I've just checked the kernel and in the case of the Quadra 800 the ASC
is not supported at all.

Thanks,
Laurent
