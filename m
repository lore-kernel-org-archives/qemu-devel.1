Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6058C004C9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 00:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7396D20675
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 00:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7396D20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48265 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNRs7-0007ts-KO
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 20:52:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hNRrO-0007aO-3e
	for qemu-devel@nongnu.org; Sun, 05 May 2019 20:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hNRrM-0002mV-3g
	for qemu-devel@nongnu.org; Sun, 05 May 2019 20:52:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:24544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hNRrK-0001zs-H0; Sun, 05 May 2019 20:52:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 May 2019 17:50:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,435,1549958400"; d="scan'208";a="343760943"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga005.fm.intel.com with ESMTP; 05 May 2019 17:50:45 -0700
Date: Mon, 6 May 2019 08:50:19 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190506005019.GA22671@richard>
References: <20190505200602.12412-1-philmd@redhat.com>
	<20190505200602.12412-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190505200602.12412-2-philmd@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [PATCH 1/5] hw/block/pflash_cfi01: Removed an
 unused timer
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, qemu-stable@nongnu.org,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 05, 2019 at 10:05:58PM +0200, Philippe Mathieu-Daudé wrote:
>The 'CFI01' NOR flash was introduced in commit 29133e9a0fff, with
>timing modelled. One year later, the CFI02 model was introduced
>(commit 05ee37ebf630) based on the CFI01 model. As noted in the
>header, "It does not support timings". 12 years later, we never
>had to model the device timings. Time to remove the unused timer,
>we can still add it back if required.
>
>Suggested-by: Laszlo Ersek <lersek@redhat.com>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
>Yes, I plan to model those timings later. Actually I have a series
>working, but I'd rather first
>1/ refactor common code between the both CFI implementations,
>2/ discuss on list whether or not use timings for the Virt flash.
>---
> hw/block/pflash_cfi01.c | 15 ---------------
> 1 file changed, 15 deletions(-)
>
>diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>index 16dfae14b80..6dc04f156a7 100644
>--- a/hw/block/pflash_cfi01.c
>+++ b/hw/block/pflash_cfi01.c
>@@ -42,7 +42,6 @@
> #include "hw/block/flash.h"
> #include "sysemu/block-backend.h"
> #include "qapi/error.h"
>-#include "qemu/timer.h"
> #include "qemu/bitops.h"
> #include "qemu/host-utils.h"
> #include "qemu/log.h"
>@@ -86,7 +85,6 @@ struct PFlashCFI01 {
>     uint8_t cfi_table[0x52];
>     uint64_t counter;
>     unsigned int writeblock_size;
>-    QEMUTimer *timer;
>     MemoryRegion mem;
>     char *name;
>     void *storage;
>@@ -110,18 +108,6 @@ static const VMStateDescription vmstate_pflash = {
>     }
> };
> 
>-static void pflash_timer (void *opaque)
>-{
>-    PFlashCFI01 *pfl = opaque;
>-
>-    trace_pflash_timer_expired(pfl->cmd);
>-    /* Reset flash */
>-    pfl->status ^= 0x80;
>-    memory_region_rom_device_set_romd(&pfl->mem, true);
>-    pfl->wcycle = 0;
>-    pfl->cmd = 0;
>-}
>-
> /* Perform a CFI query based on the bank width of the flash.
>  * If this code is called we know we have a device_width set for
>  * this flash.
>@@ -771,7 +757,6 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>         pfl->max_device_width = pfl->device_width;
>     }
> 
>-    pfl->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, pflash_timer, pfl);
>     pfl->wcycle = 0;
>     pfl->cmd = 0;
>     pfl->status = 0;
>-- 
>2.20.1

-- 
Wei Yang
Help you, Help me

