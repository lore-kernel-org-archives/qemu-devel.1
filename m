Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A13C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C84206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C84206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7BG-0006cS-2Y
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zS-0005lO-17; Tue, 01 Sep 2020 10:10:26 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:34003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zO-0003vM-9z; Tue, 01 Sep 2020 10:10:25 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MF39M-1kO8YZ1I88-00FPlt; Tue, 01 Sep 2020 16:10:15 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 27/44] hw/ide/atapi: Replace magic '512' value by
 BDRV_SECTOR_SIZE
Date: Tue,  1 Sep 2020 16:09:37 +0200
Message-Id: <20200901140954.889743-28-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XxvDiAfEEf/04NBgoBcF9pZo4GWfl/h/H5eA0RtNc1GoJBaRxzA
 7a9L0pf3xltRzut/4I+nLUEaJWFqpMvKfrOeDM9I3xERbD43UbkrUA+9p8hBPwXlyArULK1
 CXzApjMmspuv/hmZwE9HWixkBa0meLnVX/A4V/jz2fb6SceC86ExY8ufbQPWnC76aCxbkAh
 WUsHLH/egpmzl9uyynddg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0j5L6IFBVXQ=:YWRmFRVEYEl7NwFBvgwZ1N
 zvL1EzYmCwBE3cQcgxjRRWGUkAn/zT9b480225Dn7QoLaWOZzaiuNjr7r20X0Jvll/vMAPLNF
 OsMIlYBe6H5cR87DnZ/UP9OkF+HYLozgPSE3TWiChI2hsjWZehXbrFFiAB10wjmN0ldbXAtsx
 po0/k4V3Ix58G9Qtlj9HRgbEnhaK+DxOxSD2Sl029CW+04PyLMtv19P5dKwBVPAHVncn55cm2
 a2Rq3zClLO5LDeDtgkboMfJTTZkXr1GhpwzbYfirbEeOov3gwJ2R30BbSGIJsf7fZRwiCMp/R
 sEMHu4YgujNHRRWEaZoaS3fVAb4OdZUoCEbmZ6QGHanAY7SrJXDHZ7gt2feuXWUv3x0B+D2QU
 0Ui1GHmCXFeIRcNH2bOF+Oly2niUMmEQNss2KVsuuJ/GcQ1kgiVFJ6G4TQuGqqVjOXtiQH7JF
 m+fIfvvXYV9tyq/4yygp0tMledU2QKZDHIHj6t0X8FYmGuFjN1tpAUlLCxvOsoMx+9h0v663v
 em5i36dE/z+3bhich2E9j0QA9NurAsGznT5kTJGkBVGA1xEX9fNuIC10WLUKseNs0evqf1Zfe
 W2Dt6Llncn1OSQ0S2Wn5m3crZbgUg4uDwF8jvUsdUJcEYxHYFPKSGzUaqglEEwpyrlwQ0lHFc
 F5xQ54UzUq0VQ0jmmt/LT4s3QIdmtJey1FEcB5gBquhz+CAwYxkLynTQ2VG91Tto68/77QXQZ
 RYwwsAfZlD3HzaDrIKdrcm2M+nebtiGKKrbiUqahq5TYEzLVhqMMg6wdMQAe6gecSR2VQDeYi
 KYWuECHweCBd7bOzY3tSfV0SJ0cod7/ZE5/btHURtriSyFysd4VTIQmmKUXFtxlpHo16cN+
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, Li Qiang <liq3ea@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Use self-explicit definitions instead of magic '512' value.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200814082841.27000-6-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/ide/atapi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index 17a9d635d842..14a2b0bb2f8a 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -824,9 +824,9 @@ static void cmd_get_configuration(IDEState *s, uint8_t *buf)
      *
      *      Only a problem if the feature/profiles grow.
      */
-    if (max_len > 512) {
+    if (max_len > BDRV_SECTOR_SIZE) {
         /* XXX: assume 1 sector */
-        max_len = 512;
+        max_len = BDRV_SECTOR_SIZE;
     }
 
     memset(buf, 0, max_len);
@@ -1186,8 +1186,8 @@ static void cmd_read_dvd_structure(IDEState *s, uint8_t* buf)
         }
     }
 
-    memset(buf, 0, max_len > IDE_DMA_BUF_SECTORS * 512 + 4 ?
-           IDE_DMA_BUF_SECTORS * 512 + 4 : max_len);
+    memset(buf, 0, max_len > IDE_DMA_BUF_SECTORS * BDRV_SECTOR_SIZE + 4 ?
+           IDE_DMA_BUF_SECTORS * BDRV_SECTOR_SIZE + 4 : max_len);
 
     switch (format) {
         case 0x00 ... 0x7f:
-- 
2.26.2


