Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634A4C54E8E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32827206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbRLi8I8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32827206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYW2Q-0003lA-CO
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jYW1f-0002pV-FV
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:36:55 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:37470)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jYW1e-0001JH-Sa
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:36:55 -0400
Received: by mail-lj1-x243.google.com with SMTP id o14so12854496ljp.4
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 07:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dzBtlKl4RMYdlW64mKwhHYF+72DhtBFqp3InSH+cs7o=;
 b=qbRLi8I82egX5mIxhD2Qe5VSN+1wUKvuzpMn8BsvrRGMrnsOIzlPIyz9Z68rpj4WjF
 Ot9pMpGeSIpmDOVPwitR5DKqmA+DxJ4s3ZQqwu0+KBHHLv7SHLzqLPbTU41Kh5QRIJTr
 /zQN7Mq1rzcuzoj1nWG3NJQIHvzCKnUjg4Fl7cIjVmz8yAq+oqDONVkStDdXxQHrokBP
 VntUcqz8t8+uBxwVs8MTm5auaCveRB1hDVN3uNzx4sb+U2m9oADmReeEUFRB8Bja4z/h
 HjEpPDHVcsH+MyHotl6WeXGadKwF4DMACaHzLvy928IL7QZd28hqxUwHcbyAWY3c+QJk
 gyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dzBtlKl4RMYdlW64mKwhHYF+72DhtBFqp3InSH+cs7o=;
 b=WBPogpqw22hMYWWvSgqbaBagDRVqDZ5Wxnv/750uiASeQFgeHl6oIJSQZ3T8pw0G/W
 +/AxvGSGXSM204ywZ4EKDq64B9ekh6w4TT21mFw1G1ug0fvlCctyaNTMAz5MwKNdW1Kx
 MOohJ1dyIfD7GpulN95TjWXOoH9hJMU3F2fUluJuClkfj0jQ+1/9pvNEIEbbWKDG1J84
 Hubd6Fjd51mwPKYl7PdYARr2ep5YwbY2feSwj8YGGBRFMAeeAuXZFNDJG71dCVITspFw
 IouPhmjG1o4p6/kyZulcKORszjFbPOachUH9sHTsrn7oW8moTTSHBQ5y25D+9PhFEMya
 Q2aw==
X-Gm-Message-State: AOAM530l88iN3KbbdNlmx2RI6rts3YS8gMAkxeEyjg7dZeyb7b8bLO3s
 DP88mnilRo07O31+ntlpf0Zn/GYAU8E=
X-Google-Smtp-Source: ABdhPJxV2p7JRMcw7bmwbESreavJ6IZ48yhc2NStpSSVvddUOulgP1qin+FU2lM3ZkdkNErKxGAGYA==
X-Received: by 2002:a2e:97c3:: with SMTP id m3mr3683389ljj.23.1589294212476;
 Tue, 12 May 2020 07:36:52 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id f9sm14321380lfm.62.2020.05.12.07.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 07:36:51 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/1] target/microblaze: Add MFS Rd,EDR translation
Date: Tue, 12 May 2020 16:36:49 +0200
Message-Id: <20200512143649.21655-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512143649.21655-1-edgar.iglesias@gmail.com>
References: <20200512143649.21655-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.399, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me, frederic.konrad@adacore.com,
 tong.ho@xilinx.com, philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tong Ho <tong.ho@xilinx.com>

This is to fix cpu-abort with 'qemu: fatal: unknown mfs reg d'
(in the default case) when microblaze guest issues 'MFS Rd,EDR'
instruction.

Since embeddedsw release 2019.2, XPlm_ExceptionHandler() issues
the instruction on exception, and microblaze model aborts when
PLM firmware guest encounters an exception.

Signed-off-by: Tong Ho <tong.ho@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 20b7427811..92b3630804 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -581,6 +581,7 @@ static void dec_msr(DisasContext *dc)
             case SR_ESR:
             case SR_FSR:
             case SR_BTR:
+            case SR_EDR:
                 tcg_gen_extrl_i64_i32(cpu_R[dc->rd], cpu_SR[sr]);
                 break;
             case 0x800:
-- 
2.20.1


