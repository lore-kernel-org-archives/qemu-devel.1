Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A48CC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5623A248EB
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moQdMDv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5623A248EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmzPN-0006cp-Ir
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 08:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmzOP-00050V-Re
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:48:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmzOO-0002or-H2
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:48:13 -0400
Received: by mail-wm1-x344.google.com with SMTP id g10so12440673wmh.4
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 05:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BGnnG9Xy3PNvVbxTp72sTTRXPqYJOpLdaAYtg1CD7cQ=;
 b=moQdMDv2b3hG3cbKZ64kdvpDlgHfyazD4vFFY7sDOaSEzOoRssJznAnGCd5cKnjphL
 qArAGQkLOnBTCSpp5hVb+hHMyVLNe3MSY43bD33EwNxPAEhecxi8y8qVRvt661eFn4Sd
 OpUhJogrCQDmeUpD333NBBUC6UPVAewOSx4GGnCjQhFgdDdLZnPkOO+tHXzoGba6faaC
 YRYosVQA4GbhbXjHRigkzhRFWC4OYlnGl2q7cAo3UnpSh8k3h7twYRi8qKsxLub8iTbe
 jk2Ec2/gc+eyuy+2bHhy94IpGp4MEUmrhenk5+Wysb2aVkwoKkoEwKXuWaYpcXE8YOIS
 gFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BGnnG9Xy3PNvVbxTp72sTTRXPqYJOpLdaAYtg1CD7cQ=;
 b=djZDCeEAmeAO4R01XfHgq91mGE3dj6uuQ/26skwfJC5ruWqRDVdfIq+5WjHtjWvtHZ
 EwTeBLnX32SVtC89IpG8jVdsO23JkgxRJbPeePNu0+ozS99Rh0M1Lj9afb0fIqAnGIeJ
 +uOJXyh22Euuah+lUhjNzXQBL0gckNW72K+/vEaXNOfe6YozAOG+0PHBgMC/enbYN1vl
 yuPaU5/71mts+7bqd/+XvVLvPTCo+wiyixg2rSBIEopBQaUmrcVHmyGK11G7PoTbzjAe
 8vYCFTjxgwEMiwzS6nzyuTDd67OAMal5wTY6xcBvlC+xqi5wyp4T4igR+5rxfkAPmkqK
 sdhA==
X-Gm-Message-State: AOAM530JgkoywpEiyF6I7RDI2FlYPF6NzPGYE00sKZc0uvklPVGnCD3C
 COPzKVAVsSHAMe2B80ZtOUkhPfui
X-Google-Smtp-Source: ABdhPJzvGyj9nSDUbQTkREkquGwTNNUj1lshOJk+W+U+b0ebIwwzchdo9zJQDYgW50o7nNnMJ41Zkg==
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr12571593wml.57.1592743691186; 
 Sun, 21 Jun 2020 05:48:11 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o10sm13779362wrj.37.2020.06.21.05.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2020 05:48:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/15] MAINTAINERS: Cover sh_intc files in the R2D/Shix machine
 sections
Date: Sun, 21 Jun 2020 14:47:53 +0200
Message-Id: <20200621124807.17226-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200621124807.17226-1-f4bug@amsat.org>
References: <20200621124807.17226-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 81527b94ad added hw/intc/sh_intc.c, but only to the R2D
machine (it is also used by the Shix machine). Complete the
previous commit by adding the header to the R2D section, and
both source + header to the Shix section.

Suggested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 955cc8dd5c..67c495e841 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1261,12 +1261,15 @@ S: Maintained
 F: hw/sh4/r2d.c
 F: hw/intc/sh_intc.c
 F: hw/timer/sh_timer.c
+F: include/hw/sh4/sh_intc.h
 
 Shix
 M: Yoshinori Sato <ysato@users.sourceforge.jp>
 R: Magnus Damm <magnus.damm@gmail.com>
 S: Odd Fixes
 F: hw/sh4/shix.c
+F: hw/intc/sh_intc.c
+F: include/hw/sh4/sh_intc.h
 
 SPARC Machines
 --------------
-- 
2.21.3


