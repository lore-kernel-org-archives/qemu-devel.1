Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1174FC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E4B208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V9/OtmYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E4B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48186 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hct1w-0004zi-W4
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46811)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiS-0003n6-9J
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiR-0008CE-BD
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:36 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiQ-0008B4-Rp
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:35 -0400
Received: by mail-wr1-x442.google.com with SMTP id n4so10192535wrw.13
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=4QBUk4yePtKTDco8yX0s+6IInVsDCxdEuCWVUvL2BwI=;
 b=V9/OtmYxhJYFcTiD25xtSX4R8McnWsm4ut/iaD99/PZSsm3bEpAZFM+OydkgnvUfos
 jBLlE3KAxll2QS3NS44XRppzFaDxkATU19umbhAIxU9HfOLEMP66i+vScw7OQ4tkYZ2J
 vDW2sDNn99E1KvdCxT+RRsYysKLjo5+6vxq0sWsV2QP4FYS9HCcTAUkJBfPp4/a6y+vp
 stfa+L6754vf8mNJfQ/A3eAgniS4vkzvfOzJULqwojut+0GCtA0w6P3UO99iFIwi7FcT
 HpUUh/1Vhi6N5SyR/eIPfbIX2ueQ2zx2tAiQxRIkPByzT8+V10ovi2Uiqi9XdVH26gzM
 ArkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4QBUk4yePtKTDco8yX0s+6IInVsDCxdEuCWVUvL2BwI=;
 b=t2i+7oOirVhvpPNBJ9/CEYf37Io354gYdXv4+RbqYbQ/hJCK4xE04/xNUl07HTFPcj
 qMaiYBlFvEs6DZoyOtuYQv78UNsvZBvAj80kzObuaN9exHsR+CdsXEtrK5wU/n8l5gXP
 3QXA1/jM4ZbGDdRGFaNAgI4P4Q+EwrLsn0uwpfoPl6IqmUSCJpB7jRGDPHnFcYKDcIp9
 QURr66rq0pExoCmJ4TlZ45vCVNvzJhut9QVA2nH0/C6R8nJOqzMxEI1ON3m3xbnaLkSg
 j2h31W5CkoUDkysXaHhxNMWBwph3ZcdkTI6/bnS+l4ainLprTdt82LQ5zs0fH+Ij4pqb
 Etkg==
X-Gm-Message-State: APjAAAVmQCPJZAzYmOnk47dhKKVUMTeLDryKaN2sLnR3VFQJzf4796cB
 62Kmv9DzHQD4lQlemKdsJ+LEzAYra0JWqA==
X-Google-Smtp-Source: APXvYqzCAWF8Pq45jzq9aUv2oQNAHK105KB/u1twXPY4WO5AWgWPV07NcPVhh01An6mXGQTC0dAA9Q==
X-Received: by 2002:adf:de02:: with SMTP id b2mr539853wrm.349.1560782073277;
 Mon, 17 Jun 2019 07:34:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:34:05 +0100
Message-Id: <20190617143412.5734-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PULL 17/24] target/arm: Stop using cpu_F0s for
 NEON_2RM_VRECPE_F and NEON_2RM_VRSQRTE_F
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stop using cpu_F0s for NEON_2RM_VRECPE_F and NEON_2RM_VRSQRTE_F.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190613163917.28589-8-peter.maydell@linaro.org
---
 target/arm/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 124045a9ef6..75ed7cc7cb0 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4181,7 +4181,7 @@ static int neon_2rm_is_float_op(int op)
      * what we are asking here is "does the code for this case in
      * the Neon for-each-pass loop use cpu_F0s?".
      */
-    return op >= NEON_2RM_VRECPE_F;
+    return op >= NEON_2RM_VCVT_FS;
 }
 
 static bool neon_2rm_is_v8_op(int op)
@@ -6848,14 +6848,14 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         case NEON_2RM_VRECPE_F:
                         {
                             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            gen_helper_recpe_f32(cpu_F0s, cpu_F0s, fpstatus);
+                            gen_helper_recpe_f32(tmp, tmp, fpstatus);
                             tcg_temp_free_ptr(fpstatus);
                             break;
                         }
                         case NEON_2RM_VRSQRTE_F:
                         {
                             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            gen_helper_rsqrte_f32(cpu_F0s, cpu_F0s, fpstatus);
+                            gen_helper_rsqrte_f32(tmp, tmp, fpstatus);
                             tcg_temp_free_ptr(fpstatus);
                             break;
                         }
-- 
2.20.1


