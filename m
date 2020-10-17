Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6726C43457
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7A620657
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYBQ4BEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7A620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTnBg-0001W4-Jo
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmpo-00046Y-FG
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:24 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:41367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmpm-0003z1-S8
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:24 -0400
Received: by mail-wr1-x430.google.com with SMTP id s9so6561702wro.8
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KkzjSFScIeOvIHF/kF8jPGG8E3yTqTBPtxI+D53JLeI=;
 b=jYBQ4BEKTh8kCYMjdPjLZtmWcnRefWvp967sxK+tfjl5IesMkqw+W7FOJFsq+rlUL8
 f/oJHwXi/9bmDDKaYJovE3iCFhFNbWVAjg8zR44xlG5Pb54d8BN1C7bqY6Ye2idfX1bt
 LBEGW0gAQenLHdHub7sr1n7c4UdQ4OPALLRKAHz5KEKhqvNSoP/+JazgPUh4/snXeSz3
 v6Lc3VVNMlTc5nDi6AQCzYPjY0GdWaZ0Rs7yIC4X2qLdncwhtpm0F/7Q0bWs0j6L5qQm
 2w3BdTcKa6zz0RGUpGnWTzyGniiqoPWmamjE1JK7RWgqyY11lgaWcQXsu0vdkJm9k/Y/
 srKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=KkzjSFScIeOvIHF/kF8jPGG8E3yTqTBPtxI+D53JLeI=;
 b=hBpyOgJ+z0vMYRJ8u44BKjtr2WQNCgKV+0nWSQp1CXvwW2evqFz5+MLmEMT8toPoEx
 e6Qa/OAzkUkzLGUlV8egZ42trII8z7EEAh3djAm7I5AivqfzbnoDEzfI/U57tW/D/f2p
 XyupI8C0YGo/nHisAyKTIzCtkPlJw0MxUosayS9bWe5MGU2FZb6pxy+YpVR2DAsN6HlI
 up3O/OWXB6SvcvxZmGdir9Q0EG2CpgMd53cOXmbFKf6l71HeJ8424gCFCNh0P3HcSBNM
 vYMjm7xhIbCeI91uCx28jhsvnrMnYevdV4z1djhnukleGtOKW9JpHyy4dXRUk/Zax4CW
 3SfQ==
X-Gm-Message-State: AOAM533bRNeDOFAJooPxpAzMiFUCW4Ei7rlFw+GHwz5B5yzBkTM3ObeG
 4gsGYUURabUxJs/CGv4kfk2G1CFfRm8=
X-Google-Smtp-Source: ABdhPJxKQFboNrStLicnmTgxcUWCi3KKpX6hw+lzpcdgj432g7otPb4sAUn78h0+StCYZz0lWiOtAg==
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr9917414wrn.186.1602943520242; 
 Sat, 17 Oct 2020 07:05:20 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id g83sm7477018wmf.15.2020.10.17.07.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:05:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/44] hw/mips/malta: Use clearer qdev style
Date: Sat, 17 Oct 2020 16:02:32 +0200
Message-Id: <20201017140243.1078718-34-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to be consistent with the other code base uses,
rewrite slightly how the MIPS_MALTA object is created.
No logical change.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20201012160503.3472140-3-f4bug@amsat.org>
---
 hw/mips/malta.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 944045d7701..ff3225bb8e3 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1235,11 +1235,11 @@ void mips_malta_init(MachineState *machine)
     DriveInfo *dinfo;
     int fl_idx = 0;
     int be;
+    MaltaState *s;
+    DeviceState *dev;
 
-    DeviceState *dev = qdev_new(TYPE_MIPS_MALTA);
-    MaltaState *s = MIPS_MALTA(dev);
-
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    s = MIPS_MALTA(qdev_new(TYPE_MIPS_MALTA));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
     /* create CPU */
     mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);
-- 
2.26.2


