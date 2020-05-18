Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B65AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 620B420643
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjIh11zC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620B420643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jalfh-00043z-EF
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 15:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaleO-0002Km-2n
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:42:12 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:37402)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaleM-0004Pp-Sg
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:42:11 -0400
Received: by mail-lf1-x141.google.com with SMTP id x22so6226299lfd.4
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 12:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J6WzEkuNK1tTO24Rs5ze3D460XBKSrdmIKSuTThJzYI=;
 b=gjIh11zCtGYEAXJOAe8nyrRoa1yUy/Sd/3o+0qx+RN/GQ6u3ls8g7JPRRGLcCiKIsI
 hXQEB8CxCRMaFjlrEta9L741x2s9U7Ax1O1jJ3NtDOP+DS/CRHoYV0XgSLAKtD68lI5P
 MrnxDOQA/OMCuF83tWf+MssmUQSiXtXjJBKpcNrEDV2TyO9aSqKfBwdbuqX48bxaKtUm
 ZgwMq9gnLOW8IwK+oFFJA9AhPQIsRbcQHUVxF4oeZpufv8x8I/XAezguR89TX0K//yx8
 b0wtQ4RyDD9hJmpgyYEX0eZXOt92aQz4Zju71GBtzycG9H7fG0dWjVk2tckmjEiqnuYD
 hyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J6WzEkuNK1tTO24Rs5ze3D460XBKSrdmIKSuTThJzYI=;
 b=rqpQMDvaJsN263fxDuPMTn/ru/oquTItgDvZ8AuD7P8maFJO+Dc9x/grgbSkvnRFDO
 k4cl3kJ+czfV6U0yaIVDWZFWqRC/Zfp18E5huqXNO7R1d5rQkfALpbNjgwZNsK5mNhMU
 hjwLmSwhxn/RCc7uNGozsUPep1Se0LVP1XgTBXapLmmbdUL3DZ/1icD/7nip4UA5fIUf
 PcUrt5/ELsCyqJYit8F7GJWGrjpsVQpWlzG4hQaymXS7fJrcmXxjaor/2umvIgJ8MsKV
 MDOqmI7gKYR6YXvGaDOm+qe4Sq4vdn2pLwF4rbTM6dMjI7Q+Y7nBMOAhg3hEMUmZpW+Q
 u81A==
X-Gm-Message-State: AOAM533ePg2WDdwMVJydFCnU0mzLi6KGLHNd/yfQc1YtFapALirHBA4m
 pARTA5vUqxeQ0yzSK8rkMhJQMz0dIBU=
X-Google-Smtp-Source: ABdhPJwRvkvMtKiY6AXev2qVPNi+j3IFL1oTomWl3/QkZe03jXl9dHdAiE1jLff1UB1UnqYNtsJavA==
X-Received: by 2002:ac2:58d7:: with SMTP id u23mr12299776lfo.119.1589830928556; 
 Mon, 18 May 2020 12:42:08 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id r15sm7593128lfp.34.2020.05.18.12.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 12:42:08 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/22] hw/tpm: fix usage of bool in tpm-tis.c
Date: Mon, 18 May 2020 21:41:28 +0200
Message-Id: <20200518194149.16281-2-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518194149.16281-1-aleksandar.qemu.devel@gmail.com>
References: <20200518194149.16281-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@syrmia.com, Jafar Abdi <cafer.abdi@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jafar Abdi <cafer.abdi@gmail.com>

Clean up wrong usage of FALSE and TRUE in places that use "bool" from stdbool.h.

FALSE and TRUE (with capital letters) are the constants defined by glib for
being used with the "gboolean" type of glib. But some parts of the code also use
TRUE and FALSE for variables that are declared as "bool" (the type from <stdbool.h>).

Signed-off-by: Jafar Abdi <cafer.abdi@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_tis_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index 9ce64d4836..1af4bce139 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -536,7 +536,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
             while ((TPM_TIS_IS_VALID_LOCTY(s->active_locty) &&
                     locty > s->active_locty) ||
                     !TPM_TIS_IS_VALID_LOCTY(s->active_locty)) {
-                bool higher_seize = FALSE;
+                bool higher_seize = false;
 
                 /* already a pending SEIZE ? */
                 if ((s->loc[locty].access & TPM_TIS_ACCESS_SEIZE)) {
@@ -546,7 +546,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
                 /* check for ongoing seize by a higher locality */
                 for (l = locty + 1; l < TPM_TIS_NUM_LOCALITIES; l++) {
                     if ((s->loc[l].access & TPM_TIS_ACCESS_SEIZE)) {
-                        higher_seize = TRUE;
+                        higher_seize = true;
                         break;
                     }
                 }
-- 
2.20.1


