Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A077C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 19:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D51FA2071A
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 19:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urO+0X09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51FA2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpGuc-0007UP-6m
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 15:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jpGrd-0002My-Eo
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 15:51:49 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e]:45207)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jpGrb-0003uN-S7
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 15:51:49 -0400
Received: by mail-ed1-x52e.google.com with SMTP id d16so2831024edz.12
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 12:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wR1ioHxfvGUtQMv0UmPfszN6a56cZ8iXWTXbuTdKnfM=;
 b=urO+0X09PwFGm+jfJ/jD9gqGQvqYyyL9c7xZNjTayaCTqhVTCLtVwxo/o9t7AdFbk4
 NFbAMhZV0A9+IiYopHiRmu6IgqHuB1qdvcGwrwHFUa6lKOTp30hfKXwe8VFOKnj9Uavd
 jOKm8u+R+avc7UnyBumzp5g29AhB8CXiVszduCPniWNEd3NXIz8LIU1lqHSQ6iMoNY/n
 wBAEXK6TsFoiOM2I5APj+y9eCHJ8YPYQ8VJPxLkAVFpPHHQf8JcLsAxyG+5eW1RXMTgF
 NkgnBCgGgMaZ7MksYaFe89binYYPv8820+vl3kMiYUKYpZIp3ihMf5itW+hn8JOFKwzY
 +C8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wR1ioHxfvGUtQMv0UmPfszN6a56cZ8iXWTXbuTdKnfM=;
 b=J7Wo/yyslY1waRTj/IjvB3cwK7rgME4TOU4E58V63/UbiXYAzxPWcZQ40L5VbtNQ8T
 0A6EzAxfbKBQey7N208cy8ETqngYTv9UBZ+O+DRR7OXKKXYh4ZaTvJ2w13PQgD+FnpgT
 GfwoObWgKFsv55wYgsbSYr3QNyDTW8zVQHXc6QKTxNC7R2XjFmtt54+XjPWlPbMOxMGl
 YNhtp/5Wzz39sQqbdRiD8+7kf3rSv+ZMrpyMVsCmsAoarKmlBiRo/l3cg/sBsDwAjbFB
 6QUW7B3S8BkdvU9qRpWWX9o1kH2InKu2g8ED7gLAXMbfJAFMRSGmKOVu3Vd7daULkaAf
 PkVg==
X-Gm-Message-State: AOAM532nILmzxihTKyFmqDqMyge+Neo/wHxmtqfiRIK+4J2zojutS5WR
 Ki8YSvABpHycDIKKrppsGuQR/rip
X-Google-Smtp-Source: ABdhPJzD1uO5TWxO1JqknYRqQOjiW00C+JHYvVOyGisEXkVe2WJnhcQk3z4+VW2L5at/P+cSnyDwog==
X-Received: by 2002:aa7:da89:: with SMTP id q9mr10000083eds.273.1593287506550; 
 Sat, 27 Jun 2020 12:51:46 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id y11sm5298734ejw.63.2020.06.27.12.51.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 27 Jun 2020 12:51:46 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 3/6] MAINTAINERS: Add Loongson-3 maintainer and reviewer
Date: Sat, 27 Jun 2020 21:51:40 +0200
Message-Id: <1593287503-25197-4-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593287503-25197-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1593287503-25197-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ed1-x52e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Huacai Chen <zltjiangshi@gmail.com>

Add myself as the maintainer for Loongson-3 virtual platforms, and
also add Jiaxun Yang as the reviewer.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <1592995531-32600-5-git-send-email-chenhc@lemote.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b40446..fe925ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1096,6 +1096,13 @@ F: hw/isa/vt82c686.c
 F: hw/pci-host/bonito.c
 F: include/hw/isa/vt82c686.h
 
+Loongson-3 Virtual Platform
+M: Huacai Chen <chenhc@lemote.com>
+R: Jiaxun Yang <jiaxun.yang@flygoat.com>
+S: Maintained
+F: hw/mips/loongson3_virt.c
+F: hw/intc/loongson_liointc.c
+
 Boston
 M: Paul Burton <pburton@wavecomp.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
-- 
2.7.4


