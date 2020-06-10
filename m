Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAC4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:16:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99322072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vK8HR0j+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99322072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj918-0006ry-3Q
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 18:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj8uO-0005jh-6D; Wed, 10 Jun 2020 18:09:20 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:38409)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj8uN-0008Hh-AV; Wed, 10 Jun 2020 18:09:19 -0400
Received: by mail-wm1-x335.google.com with SMTP id f185so3243559wmf.3;
 Wed, 10 Jun 2020 15:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XzOFucgxtfjR38oZ5MkUD0v5mG7X6NnkIWKTAPmldmc=;
 b=vK8HR0j+mopCPYdl1iaWXUF4aMDb2tdwRbayiDhOOVyOQnvLNpjDtWS72NHRedT1lx
 EWY+ye3hAh1ceV6hc/PkpD+OTjqXVovfMVv7j7qMS1Y3TWFKfyj8ao81iJ+YImVmL8xe
 sC2v8LNA39iD0OED/0kIv27p7Z6I6XfyjRv97N8iGgTbI5deN07092Kx39hZYoScuH/6
 DAobJwkxHzw3aN8noimc+BYerUbguyCgjSobmh9qUlcsPMKw7kdOvESD1P3zaLh/f7FF
 hMBtKem7vnz9migTJ7+8H8FdJ5LI381JFWkjb0dywOqMsXjPrp7z3QBuI/ntsedulr9S
 YQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=XzOFucgxtfjR38oZ5MkUD0v5mG7X6NnkIWKTAPmldmc=;
 b=HRZqzcXQGDBwwK/ucjf+AOgptHHFMbn+kdxAX7kzj7CV6W4aMUKvg73vxy3LIoaMkz
 x9p3DUo9YAvGKcSvlizKIApcXDR6yrzXqE3+r1ih6eBUvMjytf3dep+ZLDFieoF5yciz
 Kt8aBvMtQybP5Rn8aZdRBPxhoN/FxQ3rMlpIVn7XkWCS12Hx2/tXbxW8lfsWeoPZnhDw
 XkWT5Z6bMUkOBb7cfEHrLeGFF0o8vRAwHaLOt4k8cIMghE7VLtYP/td3+HmavI2VOTKm
 8arWupK33KXdLh6EwqzPpAb2yjqGjA4RZFKhEFTGjxAuj2qkUSibgPjdwnrU2VskkF0W
 B92Q==
X-Gm-Message-State: AOAM531lYRn1Uh22XQ5D2UE/0tglSS4JkCuv3swgq7910ytdh1wD9QsX
 wd7LpFhKWX4aHTW35n6ieQF3FtKX
X-Google-Smtp-Source: ABdhPJwiMZgP5l+GgMCL4OUAb0wnFhaaJT08CBIZI4gIeXyYwhmto98FgYcIwcA8RHqb4fXyL+D8/g==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr5292334wmi.126.1591826944907; 
 Wed, 10 Jun 2020 15:09:04 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 40sm1819354wrc.15.2020.06.10.15.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 15:09:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/11] MAINTAINERS: Add Yoshinori Sato as maintainer of
 Renesas peripherals
Date: Thu, 11 Jun 2020 00:08:48 +0200
Message-Id: <20200610220853.8558-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200610220853.8558-1-f4bug@amsat.org>
References: <20200610220853.8558-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Renesas peripherals are common to SH4/RX based MCUs. Their
datasheets share common sections. It makes sense to maintain
them altogether.

Yoshinori Sato volonteered to maintain them [*].

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg710928.html

Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Suggested-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0398634179..967ca378fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1953,8 +1953,8 @@ F: include/hw/*/*xive*
 F: docs/*/*xive*
 
 Renesas peripherals
-M: Magnus Damm <magnus.damm@gmail.com>
-S: Odd Fixes
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
+S: Maintained
 F: hw/char/sh_serial.c
 F: hw/timer/sh_timer.c
 F: include/hw/sh4/sh.h
-- 
2.21.3


