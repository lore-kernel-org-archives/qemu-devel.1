Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD7FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D93CD20671
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Paw4sG1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93CD20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEh8-0005NE-LB
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEcu-0007fS-Jt
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:20 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129]:35397)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEct-0003nU-Ri
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:20 -0400
Received: by mail-lf1-x129.google.com with SMTP id 82so1260498lfh.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/cXvZwwyTvG/wDqV3+ggOWwm7XO+vMd18cZdVrDcu8Q=;
 b=Paw4sG1vXyNPxXDl0NMkyb0swgYnGuF6Ico54OGJTOGD5rVgtUWfUGBHyRqXKcJWTO
 MS3ZwjNZA4ISfsIJ9NQHUbu7aI12oNUqSVne98Us+WSlo1hI+5dpktySZv0HkohWaGNQ
 VqrNLO8+LLpVUVkt9mdoskm+qvLqwFrNTl0znni7l+9+YYMlQmUZdj9L5HuR/fta1D6K
 UbZf+TGsGiGcHX49ZY2ozJ4nMecW+Mi8tccKrUxKy1tPFlK3/D7mr1DOkAauXDggAI0P
 2CvV2Xcro8q2kR1Rz3f1D2M60GV52wcSymdFW31t084XFo7KCUf89XtZr5o8EfEUm+T/
 oB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/cXvZwwyTvG/wDqV3+ggOWwm7XO+vMd18cZdVrDcu8Q=;
 b=iVDemDKQfKOvRT2oeZHNkM+yUyN/N17mvZhP5u0PS1p2gJqX7JXrc4LyWoJqlw/UoB
 WieSM6859NzYtOiiIx3i08zdJwzXBtoHrIJtFHDgCFHqdmuVTvnQaJOeuuFq2JaPSL5a
 UwgWUQ2QlNVCiKKG6Vkx+an6b40f0bOnCf02/nr4oVpvuygw7lx5yXNOA+xgePerFlXz
 Uk2mr76VrD5tYQbAV/+ihBD93Vi8w/2DvhGQIPb8rtXKBiyINKnURO5g3W0EnZB6Vt1U
 vZ7rb6tlwLZ91wCJwMv5IgZDs47xLSA4tlUDGN047KsqNO1Lt2fbIMUDN/1opyFUOurB
 zB4Q==
X-Gm-Message-State: AOAM532FDM7bpcMUbfFAZvUleBznGvNlUA2Y+NifHFwuwjnAuVc1TP4j
 T9NbXUegJ2zx8PutUkv71zIrxMaOWjU=
X-Google-Smtp-Source: ABdhPJyWAKlaCuvUpw/hbr6xvkFCG5nrvZ6L88NOAAw1YDzgSoeLJHjimAj96FoVN73ywoc6QV9reg==
X-Received: by 2002:a19:ad49:: with SMTP id s9mr3551750lfd.9.1589465657992;
 Thu, 14 May 2020 07:14:17 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id b25sm1537138ljp.105.2020.05.14.07.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:14:16 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 10/14] target/microblaze: Add MFS Rd,EDR translation
Date: Thu, 14 May 2020 16:13:58 +0200
Message-Id: <20200514141402.12498-11-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514141402.12498-1-edgar.iglesias@gmail.com>
References: <20200514141402.12498-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x129.google.com
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
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
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-Id: <20200512143649.21655-2-edgar.iglesias@gmail.com>
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


