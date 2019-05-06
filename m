Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B52C004C9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 00:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27AD220675
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 00:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AD220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48308 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNRvT-0000s6-DU
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 20:56:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hNRuj-000056-7q
	for qemu-devel@nongnu.org; Sun, 05 May 2019 20:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hNRui-0005Tc-3k
	for qemu-devel@nongnu.org; Sun, 05 May 2019 20:55:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:31524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hNRuh-0005RB-PI; Sun, 05 May 2019 20:55:28 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 May 2019 17:55:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,435,1549958400"; d="scan'208";a="343761365"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga005.fm.intel.com with ESMTP; 05 May 2019 17:55:23 -0700
Date: Mon, 6 May 2019 08:54:57 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190506005457.GB22671@richard>
References: <20190505200602.12412-1-philmd@redhat.com>
	<20190505200602.12412-3-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190505200602.12412-3-philmd@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.126
Subject: Re: [Qemu-devel] [PATCH 2/5] hw/block/pflash_cfi01: Extract the
 pflash_reset() code
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

On Sun, May 05, 2019 at 10:05:59PM +0200, Philippe Mathieu-Daudé wrote:
>The reset() code is used in various places, refactor it.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> hw/block/pflash_cfi01.c | 21 ++++++++++++---------
> 1 file changed, 12 insertions(+), 9 deletions(-)
>
>diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>index 6dc04f156a7..073cd14978f 100644
>--- a/hw/block/pflash_cfi01.c
>+++ b/hw/block/pflash_cfi01.c
>@@ -108,6 +108,15 @@ static const VMStateDescription vmstate_pflash = {
>     }
> };
> 
>+static void pflash_reset(PFlashCFI01 *pfl)
>+{
>+    trace_pflash_reset();
>+    pfl->wcycle = 0;
>+    pfl->cmd = 0;
>+    pfl->status = 0;
>+    memory_region_rom_device_set_romd(&pfl->mem, true);
>+}
>+
> /* Perform a CFI query based on the bank width of the flash.
>  * If this code is called we know we have a device_width set for
>  * this flash.
>@@ -275,8 +284,7 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr offset,
>     default:
>         /* This should never happen : reset state & treat it as a read */
>         DPRINTF("%s: unknown command state: %x\n", __func__, pfl->cmd);
>-        pfl->wcycle = 0;
>-        pfl->cmd = 0;
>+        pflash_reset(pfl);
>         /* fall through to read code */
>     case 0x00:
>         /* Flash area read */
>@@ -639,10 +647,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
>                   "\n", __func__, offset, pfl->wcycle, pfl->cmd, value);
> 
>  reset_flash:
>-    trace_pflash_reset();
>-    memory_region_rom_device_set_romd(&pfl->mem, true);
>-    pfl->wcycle = 0;
>-    pfl->cmd = 0;
>+    pflash_reset(pfl);
> }
> 
> 
>@@ -757,9 +762,7 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>         pfl->max_device_width = pfl->device_width;
>     }
> 
>-    pfl->wcycle = 0;
>-    pfl->cmd = 0;
>-    pfl->status = 0;
>+    pflash_reset(pfl);
>     /* Hardcoded CFI table */
>     /* Standard "QRY" string */
>     pfl->cfi_table[0x10] = 'Q';
>-- 
>2.20.1

-- 
Wei Yang
Help you, Help me

