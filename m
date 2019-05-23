Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C159EC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ACD021019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vycBGIs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACD021019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37726 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTop3-0004pL-Kn
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:35:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTodt-0002tw-Tc
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTodt-00076Q-0g
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:25 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:36085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTodr-0006vY-27
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:24 -0400
Received: by mail-wr1-x430.google.com with SMTP id s17so6533378wru.3
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=azbgycPFZ1DsGwmKdNJoyt5+e00qL8Rz3KbWhOofhPo=;
	b=vycBGIs8tPQSI0PzwFYHb5JudhXVdr7ogYAYmV3ktOF9nZdmMNN8g1oX2o9s8u0uVT
	xlF1UlPMSqInz0sPil66006fXgE7Q93VYz2TkXnuFQTLMriV3n4ST2J0ZPIl+NE5l+jO
	Zmhx+lz3rNwNe8d4KOS0hhzF5AjIoQiHiEAVFojOUjWDgpKGy3iqFSDCGHDkFrrnQkN0
	pHmTTuEEwQLd3E9UFV2LkBn6DrXAbkHuxrREaSW9p17+Ac3JhHblHvfdg9FoYsu+eYlE
	Ea6/9qp3/UPst5v6OwYXYfgXLiptOqJF88jBdKngTWKEDmAQf5EEnu/JrnkMDchEpbRU
	sw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=azbgycPFZ1DsGwmKdNJoyt5+e00qL8Rz3KbWhOofhPo=;
	b=qmB1nyZ+6c5fpOUW53t23srRUe2KBj6kOPgQmk6agKzDn/qNNwJGuyx8puZjZ15AP9
	cJq4ySmZLMo9lMQxsgzJURZ0dbGscrXeK24oLIK0JDploahnkwRLoZm7U0ELQXR5ptGY
	n8lq7JY+5JLSwlmVGw3AaBWolsoHAtxTHAg+PtcN2DSO3/h0vR/bmyyjXQN/671BKGGK
	hjp0k/udIdBrJhDES3/9uUM+m6WE9Oob3sjo2TRCIP0I7mlR/8KPj/x9e9/D1yewb3HL
	oUHyvdts6E7o3P/t/EKRxnb6JVvMS52gpkeGiyflUBAERrP2BJzIFk8G5TGTjPF+o68I
	hGbw==
X-Gm-Message-State: APjAAAUgLPSXHLhGBnhR/DNOHAavKfDnIs3rqZ2aXgWQymkTfe9Az2PF
	91AFdTbhnd9HeUhhM0/9oP0Rw3MNIuOclw==
X-Google-Smtp-Source: APXvYqwGrwhj/dt3PFDXnorW7VT0CffVjdiubWw9xOaWrquTYom+PeNeDY5Bw89qpLbZsXK1CuhqQw==
X-Received: by 2002:a5d:6b12:: with SMTP id v18mr3808692wrw.306.1558621450423; 
	Thu, 23 May 2019 07:24:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id z5sm9700617wmi.34.2019.05.23.07.24.09
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 07:24:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 15:23:55 +0100
Message-Id: <20190523142357.5175-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523142357.5175-1-peter.maydell@linaro.org>
References: <20190523142357.5175-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: [Qemu-devel] [PULL 10/12] hw/arm/exynos4: Use the IEC binary prefix
 definitions
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

It eases code review, unit is explicit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20190520214342.13709-3-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/exynos4_boards.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 1b82bce2f4d..fa0d7016413 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -22,6 +22,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu-common.h"
@@ -60,8 +61,8 @@ static int exynos4_board_smp_bootreg_addr[EXYNOS4_NUM_OF_BOARDS] = {
 };
 
 static unsigned long exynos4_board_ram_size[EXYNOS4_NUM_OF_BOARDS] = {
-    [EXYNOS4_BOARD_NURI]     = 0x40000000,
-    [EXYNOS4_BOARD_SMDKC210] = 0x40000000,
+    [EXYNOS4_BOARD_NURI]     = 1 * GiB,
+    [EXYNOS4_BOARD_SMDKC210] = 1 * GiB,
 };
 
 static struct arm_boot_info exynos4_board_binfo = {
-- 
2.20.1


