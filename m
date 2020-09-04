Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A065BC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18DDB20684
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nH1TnFnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18DDB20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEH5j-00032a-Tc
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 15:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH4s-0001Fc-P5
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:08:50 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH4r-0000mC-8q
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:08:50 -0400
Received: by mail-pg1-x543.google.com with SMTP id e33so4818531pgm.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 12:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4W7RubWumEglnK/FyOQH6KhBEYuwqvp7XgB4+69Mg6k=;
 b=nH1TnFnRmb2g643btEP9rwCYaPiYJeLQhm287dc5OZ2CRF2vf7oF9FZyNidh1Z7zhC
 Jz2RY6/jQbvUe++Tmf9ujGjsEMjyVdiQmfGmHGpzZqw5LlEbJrUMwXkE7g8LS7qpNChh
 xeVqzjKoXoVFWpnWgh3/K5VmIaDzA6rbTiNHFq2PKnoakvjeY+pdRdSNmIuKA6vJfWgl
 0euzJXO1nYxPMMJHfuizXNR3dSjJ3Nbtx25DrQ44yFpUUiEXsnHFs1LixHq5eyGIbnky
 Yd6y5EUgcJw55ocq8MKXYGQhCQiOPVZH8nUZpV1bEVkdq/mDIxKjDIuLe2KLK6msEomk
 H1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4W7RubWumEglnK/FyOQH6KhBEYuwqvp7XgB4+69Mg6k=;
 b=lDP+vapscFrppsKCuwZiBkK56z8BeyeDARwizrL9qD9nrWXtr+gzSWTsPNk1L3UIuN
 otEiE7mfXDDPZN9LJdrmicTFAdcRdWiwZ1XUlocvw2kljWaoMnBR9r69VjG1hvvxnpSn
 nVX8UVEM/GJxrohD2gVmwCMKu6NfQ9HLAQsgNaLoP+OFXPPcnNWdU6A1rlcCTUpIcuV9
 +lhLcBETt/MSoYaHREg/9R3dYrk7iyZLxZMj5vwnhfkZjRYBMIMN02Vzd5PRWowYCzCR
 +c+65GVI9cW9bemoLQeANjWcNwhS+DkiGCOWjuSXmOoKq+oeFmCEB/pQgJEUjUegjbhV
 AYSg==
X-Gm-Message-State: AOAM533i/A8WhMewzxaYsioPC8QLHm1T5KQiTVVHJBNR2LsHgf097MX8
 l+nu48UkL0dNTMDkMHY27ZO+S76U6KobOA==
X-Google-Smtp-Source: ABdhPJxKimJQcuXFL76R0eLPuVHAO/KEq4gz5or8x72mv9q0UTcprgsbIdXm2LEteB8P5lPGUckOkw==
X-Received: by 2002:a62:7c82:0:b029:13c:1611:6532 with SMTP id
 x124-20020a627c820000b029013c16116532mr8391529pfc.4.1599246527584; 
 Fri, 04 Sep 2020 12:08:47 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x19sm1897941pge.22.2020.09.04.12.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 12:08:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/19] target/microblaze: Renumber D_FLAG
Date: Fri,  4 Sep 2020 12:08:25 -0700
Message-Id: <20200904190842.2282109-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904190842.2282109-1-richard.henderson@linaro.org>
References: <20200904190842.2282109-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: edgar.iglesias@xilinx.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ESS[DS] is bit 19 in the manual, but the manual uses big-endian bit
numbering.  This corresponds to bit 12 in little-endian numbering.
Let the comment about matching the ESR be true by renumbering it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index a25a2b427f..32811f773d 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -264,10 +264,10 @@ struct CPUMBState {
 /* MSR_UM               (1 << 11) */
 /* MSR_VM               (1 << 13) */
 /* ESR_ESS_MASK         [11:5]    -- unwind into iflags for unaligned excp */
+#define D_FLAG		(1 << 12)  /* Bit in ESR.  */
 #define DRTI_FLAG	(1 << 16)
 #define DRTE_FLAG	(1 << 17)
 #define DRTB_FLAG	(1 << 18)
-#define D_FLAG		(1 << 19)  /* Bit in ESR.  */
 
 /* TB dependent CPUMBState.  */
 #define IFLAGS_TB_MASK  (D_FLAG | BIMM_FLAG | IMM_FLAG | \
-- 
2.25.1


