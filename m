Received: from eggs.gnu.org ([2001:4830:134:3::10]:60170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3HFn-0005jR-DB
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3HFh-0007Vr-Pb
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:20:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d3HFh-0007VR-Jc
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:20:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9876B46D0B5
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 07:20:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170425223739.6703-1-quintela@redhat.com> (Juan Quintela's
	message of "Wed, 26 Apr 2017 00:37:13 +0200")
References: <20170425223739.6703-1-quintela@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 26 Apr 2017 09:20:32 +0200
Message-ID: <87a873my7z.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 00/26] Audio Cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

Juan Quintela <quintela@redhat.com> wrote:
> Hi

Hi  Gerd

I forgot to CC'd you, sorry.

Later, Juan.

> This are an old series that were hidden on my harddisk.  To give you
> one idea, I had a patch to remove this:
>
> commit 8307c294a355bbf3c5352e00877365b0cda66d52
> Author: Nutan Shinde <nutanshinde1992@gmail.com>
> Date:   Wed Oct 7 22:02:54 2015 +0530
>
>     Remove macros IO_READ_PROTO and IO_WRITE_PROTO
>
> And somebody else removed it and got it upstream.
>
> There are just cleanups of removing unused code, or moving audio to
> c89 and int*_t types.
>
> Please, review and consider them.
>
> Later, Juan.
>
>
> Juan Quintela (26):
>   adlib: Remove support for YMF262
>   audio: remove Y8950 configuration
>   audio: Remove YM3526 support
>   audio: YM3812 was always defined
>   audio: Remove UINT8
>   audio: remove UINT16
>   audio: remove UINT32
>   audio: Remove INT8
>   audio: remove INT16
>   audio: Remove INT32
>   audio: Unfold OPLSAMPLE
>   audio: Remove Unused OPL_TYPE_*
>   audio: Remove type field
>   audio: Remove unused fields
>   audio: GUSbyte is uint8_t
>   audio: remove GUSchar
>   audio: GUSword is uint16_t
>   audio: GUSword is uint16_t
>   audio: GUSsample is int16_t
>   audio: OPLSetIRQHandler is not used anywhere
>   audio: OPLSetUpdateHandler is not used anywhere
>   audio: IRQHandler is not used anymore
>   audio: UpdateHandler is not used anymore
>   audio: Remove unused typedefs
>   audio: un-export OPLResetChip
>   audio: Use ARRAY_SIZE from qemu/osdep.h
>
>  hw/audio/Makefile.objs  |   2 -
>  hw/audio/adlib.c        |  47 +-------
>  hw/audio/fmopl.c        | 277 ++++++++----------------------------------------
>  hw/audio/fmopl.h        | 175 +++++++++---------------------
>  hw/audio/gus.c          |   2 +-
>  hw/audio/gusemu.h       |  22 +---
>  hw/audio/gusemu_hal.c   |  74 ++++++-------
>  hw/audio/gusemu_mixer.c |  28 ++---
>  8 files changed, 153 insertions(+), 474 deletions(-)
