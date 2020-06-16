Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F726C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E365F20644
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzBXBMUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E365F20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlD6S-0007ik-46
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQu-000413-Kf; Tue, 16 Jun 2020 10:19:24 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQs-000716-WC; Tue, 16 Jun 2020 10:19:24 -0400
Received: by mail-oi1-x241.google.com with SMTP id 25so19337111oiy.13;
 Tue, 16 Jun 2020 07:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=noqPjXnkCbN2ZwLY+0aBhSvH8URJIHJjto2UAYCZdFY=;
 b=OzBXBMUwVENfA+rErN79JRgTSK7Ty6MTtCvqcKXgUxY4H7BQBsH8lYGZF1p4rj/KIR
 XUwFeD3rxWUq2UOvtZYTpEWA2AFBU9fkZM4cFU+/nQsdySVQcIjmVM/u9wCMhFBcWogv
 WMPllz5L1uV/oLVhoWGS4a6MjgFVd6gS/NCo82WxU+oLvIvYfq/lj48zwitqnCx9PSys
 lTA+n0FOfqvGR1agwyN4h6yyiISEGpZfOO42tZPL/bgdjo3XM6l0UmShpT0VZc7XSy7G
 HYDFLckqnI2jN2GaW2p+eNvmlzq7GjhFcS5yXMf1p6yoPDPldEgTxe5q4rEIhg5GCmFJ
 AQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=noqPjXnkCbN2ZwLY+0aBhSvH8URJIHJjto2UAYCZdFY=;
 b=g59UHjwZzOolUZeZFgnffc84OndIAbimn15wjdaRsBjTm8cFxx3z/aulMHO70H/ibW
 MzDNTxVWIQd+s7vSButTfpmDV/LQXUjVLySJ7yQL2JNeHyNMFXyc7hO3mHjVT59w7BMW
 0tSF55dyDRuoLn+djFYcfSHS1n+WN8VDL9T9y1Mw5wJ8ou/b+Ehm1l16a3cS0iwU2Hrm
 JUvkrqn04iVttG1K6C2cTmsEwGBbbLpPF0oprvmc0DuXOf/aeXvpWPlL5VmpguHNpryu
 f+vl3glXeJlKnhIJsvCrpS8Oo2ULWRA0ezDg8lxaHBtu77K9zfStFwRwLa+tIeYL4ZS0
 P9gw==
X-Gm-Message-State: AOAM532dub78ZP8x4x0vnk8kv5I4wHXCuiDlpUa0Jn6bx91c2kEv6a/s
 slWsjDVTaVpY9OktyayD0ia+Z+gx
X-Google-Smtp-Source: ABdhPJwMfZ7dN6mWcGPBpohwjTSmFg7NPODTfRaEnaLUhGxxQi9ro0SmiHv+3rSBLkp1pn18fznqLw==
X-Received: by 2002:a05:6808:b14:: with SMTP id
 s20mr3636322oij.155.1592317161054; 
 Tue, 16 Jun 2020 07:19:21 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id m18sm4155903ooe.12.2020.06.16.07.19.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:19:20 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 65/78] dump: Fix writing of ELF section
Date: Tue, 16 Jun 2020 09:15:34 -0500
Message-Id: <20200616141547.24664-66-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x241.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

In write_elf_section() we set the 'shdr' pointer to point to local
structures shdr32 or shdr64, which we fill in to be written out to
the ELF dump.  Unfortunately the address we pass to fd_write_vmcore()
has a spurious '&' operator, so instead of writing out the section
header we write out the literal pointer value followed by whatever is
on the stack after the 'shdr' local variable.

Pass the correct address into fd_write_vmcore().

Spotted by Coverity: CID 1421970.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200324173630.12221-1-peter.maydell@linaro.org
(cherry picked from commit 174d2d6856bf435f4f58e9303ba30dd0e1279d3f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 dump/dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dump/dump.c b/dump/dump.c
index 6fb6e1245a..22ed1d3b0d 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -364,7 +364,7 @@ static void write_elf_section(DumpState *s, int type, Error **errp)
         shdr = &shdr64;
     }
 
-    ret = fd_write_vmcore(&shdr, shdr_size, s);
+    ret = fd_write_vmcore(shdr, shdr_size, s);
     if (ret < 0) {
         error_setg_errno(errp, -ret,
                          "dump: failed to write section header table");
-- 
2.17.1


