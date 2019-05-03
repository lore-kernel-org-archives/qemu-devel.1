Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A5BC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 12:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E3F6206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 12:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8G8mx0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3F6206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39681 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWwu-0008Fd-LR
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 08:05:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMWvu-0007k8-Ku
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMWvt-0008HE-Je
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:04:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMWvt-0008D2-Ck
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:04:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id a9so7566889wrp.6
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 05:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=KgE5+3YNQw+Av7owDtg70coEsHJSLxFudkITymP49U4=;
	b=A8G8mx0x72XXxsjPicydk5sr/adnTum+HTsAtCJ+sPOI8yFf8Kap53KJkPClKPidby
	+c4U13MFGioGHtChEAHtHDpN4pAjFG3rArgUwBd58Shl739ARe0dCRT0zp/TEAYPucgS
	+Q674NpmFHPCpycK1MUprn3WGT9AjM5W9AF9C/4RhE+b7yiRh2QQZRZfoHfak3jR/qHc
	qh7KPojBNO+YLjxMLvdfaAv8InTNtLP6vq8kWBF39lB0DA6b/kHcdLcF2YcjIWuKKo9r
	6xLNVy6Npu+l0z57t7Qrav0ObC6A0skYtzSpRALgznFA58CArZF/enOV13QdWn2VN79K
	Nsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=KgE5+3YNQw+Av7owDtg70coEsHJSLxFudkITymP49U4=;
	b=cN+Ar5Q2dsgOEw45FSccaLUqT5w7nwSSO9h/SqNyntxs3m1VIG/pwAX1u/WtnaKq0e
	YvOBdBa/PsyDfgHq+zNwBhQ/9fh64gE1RaqdcEghdfqsB2zxlzVmimprLtaEip91x7YE
	LBbKlEEvS785B1TV0/Z1xl7SPwOMJTj50Zp9L254ESd2LepAD4wLtT6PDRnzYi61x3dV
	vGdPUeex1VanYdKFaxzBHWN1y+jL0zksEwEoWRyy0FiuVyddJuev5nTUh8HWcNg4O4ar
	OTHVU2XugmFNgBkfR+7kptOwbpKJeDe0DjLCRDm5WBtFH0yCr5NVMfmSZiT59GbeUM0C
	tX2w==
X-Gm-Message-State: APjAAAWNfPj84RBltz33TmlP6w5I8NRj3VNGGLmWixRAv9xmjXazM58N
	YmS+aAsGDTS2zZ9eSVdgWhzy7A==
X-Google-Smtp-Source: APXvYqz921fbtrMRA327zgmRKm/yiKguHdTzqlyYgFFh46UiTPRy/QkH/+2cFPONBW2RkuTzQGUmcQ==
X-Received: by 2002:adf:e989:: with SMTP id h9mr6342395wrm.157.1556885091774; 
	Fri, 03 May 2019 05:04:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm2116828wmg.46.2019.05.03.05.04.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 05:04:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:04:48 +0100
Message-Id: <20190503120448.13385-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v2] target/arm: Stop using variable length
 array in dc_zva
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503120448.hYhUkkcFW4mXAHcRx1YI6febTCeoshwdwZU0tqFEMPU@z>

Currently the dc_zva helper function uses a variable length
array. In fact we know (as the comment above remarks) that
the length of this array is bounded because the architecture
limits the block size and QEMU limits the target page size.
Use a fixed array size and assert that we don't run off it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Changes v1->v2:
 * use ARRAY_SIZE() instead of sizeof()
 * add a comment to make it a bit clearer that the
   expected size of hostaddr[] is only 2 entries
---
 target/arm/helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 81a92ab4911..10444d12b18 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "target/arm/idau.h"
 #include "trace.h"
 #include "cpu.h"
@@ -13099,14 +13100,17 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
          * We know that in fact for any v8 CPU the page size is at least 4K
          * and the block size must be 2K or less, but TARGET_PAGE_SIZE is only
          * 1K as an artefact of legacy v5 subpage support being present in the
-         * same QEMU executable.
+         * same QEMU executable. So in practice the hostaddr[] array has
+         * two entries, given the current setting of TARGET_PAGE_BITS_MIN.
          */
         int maxidx = DIV_ROUND_UP(blocklen, TARGET_PAGE_SIZE);
-        void *hostaddr[maxidx];
+        void *hostaddr[DIV_ROUND_UP(2 * KiB, 1 << TARGET_PAGE_BITS_MIN)];
         int try, i;
         unsigned mmu_idx = cpu_mmu_index(env, false);
         TCGMemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
 
+        assert(maxidx <= ARRAY_SIZE(hostaddr));
+
         for (try = 0; try < 2; try++) {
 
             for (i = 0; i < maxidx; i++) {
-- 
2.20.1


