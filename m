Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442EFC31E45
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 00:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C0A20850
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 00:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C0A20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46470 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbaIa-0005vu-NV
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 20:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43774)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hbaHF-0004d0-Rh
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 20:41:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hba5V-00056U-F3
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 20:29:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:17999)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hba5R-0004ya-Kd
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 20:28:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Jun 2019 17:28:48 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga006.fm.intel.com with ESMTP; 13 Jun 2019 17:28:47 -0700
Date: Fri, 14 Jun 2019 08:28:22 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190614002822.GA32195@richard>
References: <20190425032831.22551-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425032831.22551-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [PATCH] bitmap: get last word mask from nr directly
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: corentincj@iksaif.net, pl@kamp.de, qemu-devel@nongnu.org,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 25, 2019 at 11:28:31AM +0800, Wei Yang wrote:
>The value left in nr is the number of bits for the last word, which
>could be calculate the last word mask directly.
>
>Remove the unnecessary size.

Ping...

>
>Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>---
> util/bitmap.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)
>
>diff --git a/util/bitmap.c b/util/bitmap.c
>index cb618c65a5..5aa60b8717 100644
>--- a/util/bitmap.c
>+++ b/util/bitmap.c
>@@ -160,7 +160,6 @@ int slow_bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
> void bitmap_set(unsigned long *map, long start, long nr)
> {
>     unsigned long *p = map + BIT_WORD(start);
>-    const long size = start + nr;
>     int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
>     unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
> 
>@@ -174,7 +173,7 @@ void bitmap_set(unsigned long *map, long start, long nr)
>         p++;
>     }
>     if (nr) {
>-        mask_to_set &= BITMAP_LAST_WORD_MASK(size);
>+        mask_to_set &= BITMAP_LAST_WORD_MASK(nr);
>         *p |= mask_to_set;
>     }
> }
>@@ -221,7 +220,6 @@ void bitmap_set_atomic(unsigned long *map, long start, long nr)
> void bitmap_clear(unsigned long *map, long start, long nr)
> {
>     unsigned long *p = map + BIT_WORD(start);
>-    const long size = start + nr;
>     int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
>     unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
> 
>@@ -235,7 +233,7 @@ void bitmap_clear(unsigned long *map, long start, long nr)
>         p++;
>     }
>     if (nr) {
>-        mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
>+        mask_to_clear &= BITMAP_LAST_WORD_MASK(nr);
>         *p &= ~mask_to_clear;
>     }
> }
>-- 
>2.19.1

-- 
Wei Yang
Help you, Help me

