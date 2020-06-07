Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595AFC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25FB72067B
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4mhadx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FB72067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji1I1-0005fh-BR
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 15:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1FX-0003ow-6p
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:31 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:38448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1FV-0004kc-Bw
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:30 -0400
Received: by mail-wr1-x430.google.com with SMTP id e1so15169553wrt.5
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 12:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vpjGR3SSo/dqO1sryzCVOBY48tat7koG6WnUT5kfYuU=;
 b=i4mhadx6/ynf7Kw3aBFKur7jf99VeoAanafiHFDGydNTQJUxMN+S394xTsylnxhabq
 B/FWSWqEJeveQU/gZ0aWp9+Hw62NRy/24/irF3XJjscOCXJatitxaj8LnD/vUvZVODq4
 Ss6yeSKZQtlHBpw84ra86lcsj3SVIJiPM+rfvO9CtiVwYacM/MG8MTtxR3KQNMU2eZZ3
 rx/2T9+ciPf0NmZ4j2mjPmqfdAUzTA6U3tStEfY0yUm7NSMVBFiHg2JdHhK5cNNCQNGt
 u6KgbYLBQyTRTKJzBbX/So0kS8iLbxWAdUQXkBXjcDQvyPAikoEY7hmGli9sUt+Bfv14
 kKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vpjGR3SSo/dqO1sryzCVOBY48tat7koG6WnUT5kfYuU=;
 b=izJQmArqzW1xvkqCJklB3hhvua5wwy9hckK0sqxwxnTB0wD7dn/W/xehe94GSzcZeh
 Pond5bNifIYZwhqVXBAfRscmZPoOzxt3oLomhfvphGDLNhucVCNrCa/Tg9JlCyrt8ZIT
 XqSMn5/TRfjDCqSPMCwanZ7IUQBHhcOKL/RPR0l4mHtv2cedSVJMkYfn1YJL1Hy7GbRU
 EU0S0CWO28TaEwkiTkDdmSfEczq+HIq8P0cxkxWtI8+xIseY0IMiSfxCccO/iYSvbZ0G
 5kztGUiTjqfRlZ0EqlMbXBTvcnuA+lihrbSg8x/AjO99kf0OgpUb8+2Lj/GmoIItkMKJ
 LlsA==
X-Gm-Message-State: AOAM530obX4Wu99S08xvh9XI19nsRcd4B7AnIJt8SsekQv1jP6OHOrzn
 SIWykrmICCqc3fJ66qhiXKqaPfE3
X-Google-Smtp-Source: ABdhPJy2CNGcRZpcxASVtmMo/y0s0naN5WFeYhXJG4p3QeJgwikw/6w6EFs1TBlkXDnaw0p8N1dF3A==
X-Received: by 2002:adf:ea90:: with SMTP id s16mr19956415wrm.299.1591559188013; 
 Sun, 07 Jun 2020 12:46:28 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id u130sm21091339wmg.32.2020.06.07.12.46.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Jun 2020 12:46:27 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 02/21] mailmap: Change email address of Stefan Brankovic
Date: Sun,  7 Jun 2020 21:46:06 +0200
Message-Id: <1591559185-31287-3-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Brankovic wants to use his new email address for his future
work in QEMU.

CC: Stefan Brankovic <stefan.brankovic@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Stefan Brankovic <stefan.brankovic@syrmia.com>
Message-Id: <20200602085215.12585-3-aleksandar.qemu.devel@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 9f2a3a5..84f3659 100644
--- a/.mailmap
+++ b/.mailmap
@@ -52,6 +52,7 @@ Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
 Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
 Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
 Philippe Mathieu-Daudé <philmd@redhat.com> <f4bug@amsat.org>
+Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
 Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
 
 # Also list preferred name forms where people have changed their
-- 
2.7.4


