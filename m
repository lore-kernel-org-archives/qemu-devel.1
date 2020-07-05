Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27412C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 22:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36842075B
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 22:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quidZ443"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36842075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsCoa-0003bQ-74
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 18:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsCnS-00022q-Gb; Sun, 05 Jul 2020 18:07:38 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsCnR-0005gE-0i; Sun, 05 Jul 2020 18:07:38 -0400
Received: by mail-wr1-x441.google.com with SMTP id f7so35881711wrw.1;
 Sun, 05 Jul 2020 15:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vZ+WBWeTdBDzQf/K0c+km2EcL1wjbRgW81W4iCtBWhc=;
 b=quidZ4432CpZBbbR21K3pQIKe3Qfj6xPgYUL8xqt4uD8/c+pc7j2irwn9z2yn3KRWQ
 ssTHt2Z/D/g2Q1+oDZRSUwmez9cNHLhBb7uqq0OVE1YPFYV9gPoDuhSwHoTm1Pzd8Scj
 QO9YzlhZGYSp+Vb66te6RW4kE06KEPHJpXybeCEHx/YihpX322q3BI9ggbF8SdX+wVfs
 uekHxLrJOz9Nk9OO39CLejgK/hr0dSGK/GiZfanONp4r4FvCv4Af/yENn9Ype+NN6XpG
 7QmSvR/qP2jY/ulPQctHie/VoGNc/rCRuHW5ml0Szi5tIegcXAqLRtUoz0Be8ZNDySUZ
 wgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vZ+WBWeTdBDzQf/K0c+km2EcL1wjbRgW81W4iCtBWhc=;
 b=YLL1xw1y3/qvOIZm7MPVl2x5F8lA2qdo0hLwH9ynAvrdPvz5mdXQa0/pnI4IL5Boff
 C7cWtgTmsCIOfHLi6n0uK+0IU7aGy5dDwKtpWBplyZshqphFYa7dQpkSSk8iiu2cPwEx
 VqXwoZ/5tbQnAlks9rs8AhNea7UszmIwX10tswiGfHwKFsxeq0IOAmnzWHeHZzoyDCZT
 Rtg1v7v1qAIJDVK9T5q8SQ0MFRfnfGWpiYU9uTxKzm4gteaIA2NF+WNSqOYWuLJdh7tF
 G9SWxfjpucCCNwPsLoqWJP9pwc2ormd9XrC4qqIW0DNT/Ez9ExxOBREbbNToQk1rOe+s
 k6Ew==
X-Gm-Message-State: AOAM5306qTXcQ1Oidv5uvlW7T32dMHM1XvjWmvUPRMXAxL3ZHfNUf1I0
 5Xj8JdIcXjaqg7P7vWAtOcL09u2HwC0=
X-Google-Smtp-Source: ABdhPJxcHikvx281RvfuH+k6OOwkJzCcWwtGgvO8+2TkX8jQwHinYOWBA+UbCG9j9tS4XOjFaXWzmg==
X-Received: by 2002:adf:e60a:: with SMTP id p10mr43867083wrm.181.1593986855032; 
 Sun, 05 Jul 2020 15:07:35 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id j16sm21538214wrt.7.2020.07.05.15.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 15:07:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 1/2] hw/sd/ssi-sd: Deprecate the SPI to SD card 'adapter'
Date: Mon,  6 Jul 2020 00:07:30 +0200
Message-Id: <20200705220731.28101-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200705220731.28101-1-f4bug@amsat.org>
References: <20200705220731.28101-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <huth@tuxfamily.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 libvir-list@redhat.com, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This device duplicate the SPI mode of the sd-card device. The
SPI protocol is better handler in the sd-card, however as the
TYPE_SSI_SLAVE is not an interface, the sd-card can not implement
it easily to be pluggable on a SPI bus. Meanwhile the ssi-sd
device acts as a bridge, but is bitroting. Deprecate it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 docs/system/deprecated.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 47f84be8e0..5e67d7f3e0 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -343,6 +343,11 @@ The 'ide-drive' device is deprecated. Users should use 'ide-hd' or
 The 'scsi-disk' device is deprecated. Users should use 'scsi-hd' or
 'scsi-cd' as appropriate to get a SCSI hard disk or CD-ROM as needed.
 
+``ssi-sd`` (since 5.1)
+'''''''''''''''''''''''''
+
+The 'ssi-sd' (SSI to SD card adapter) device is deprecated.
+
 System emulator machines
 ------------------------
 
-- 
2.21.3


