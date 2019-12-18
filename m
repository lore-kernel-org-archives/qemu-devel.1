Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9758C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C16C2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyE6smu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C16C2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihghg-0001zP-LU
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 16:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ihgVA-0002Yr-RE
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ihgV9-0001PK-83
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:05:00 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39240)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ihgV7-0001OC-GQ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:04:59 -0500
Received: by mail-wr1-x443.google.com with SMTP id y11so3795404wrt.6
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 13:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4HdLLb+x1sSk14EP1nZnhRnMD/gxDRenHGKbmMsG/lM=;
 b=eyE6smu9QaJl7qklxWNNdPeSRlRx9F8XOUUs/mNa6dcVmxg2PoYRsjpIXyNeZC+5s9
 MFErYnGs2MqLTSW3NASO4rGCjHxtdzG2mibQ4C5xap07AO+zjaMPiwh13bfcwLnK6vYq
 bhcfEO2NKkCDVRRTU21zNY20wkvLlP6lqCGR3atD0p6XimfSDeStxMs7p3BaW6NZiU8l
 htTVOqO4hWGVJUl1Q4qqhRBB/FcEmfOUB2H8QjJQWf3pEOROAkyCvYDLSlD2ahyvCqKp
 JxOETPa0jrm0ffJjjfyyI+m/oSfgXaMPrRgyeclvncwHFfqh+NeSLdURbHAxkeifOmSZ
 SDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4HdLLb+x1sSk14EP1nZnhRnMD/gxDRenHGKbmMsG/lM=;
 b=LnY7g10NMW+xxtOfer5/G5wWvr7fFdMjCWVVSGAIwBjXgTR/oJFB+3zl1ylV3oMfdA
 wFyOtVXM6fMrj/0uW6lIcLVBOEsIu9FGpGlsyQemROAN5kWm1LgVxqiLBW0a14D6mr6q
 bgPgNGi8YS0k3QyUKJIDydXhnF8dG+3/iN45OAjw6SiKcDzR/ViCP9R1aTDcrZvHRk8+
 XhFIydNnKtDDN0en98Axb4akkCXTJ6xK0ePj+3awMVnrjgpWOrGui9gm8Ui2h9dsW/LE
 h/Ql5Mg7lCcUIt9f8H7SOSCdFx5HbbxtDDYHNQF2xoTWRAM5FZvXX1/0ArqN9ULb9qN2
 CyAg==
X-Gm-Message-State: APjAAAUR/3abIqsjnpN+Z3CELR0fdIeje2L6jbTMDc2g4O4f21LOUJWg
 AOar7/eowc240drXXbXgFC0oajwnFSfwsw==
X-Google-Smtp-Source: APXvYqw5Lr/xLcsSGf449KWmBZmEyyj3NUG8SarH3j13k0t2MnPApOlMiMBMzbSwoFpkLozdoUYpwQ==
X-Received: by 2002:adf:ea4e:: with SMTP id j14mr5195920wrn.101.1576703095199; 
 Wed, 18 Dec 2019 13:04:55 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-109-65-2-109.red.bezeqint.net. [109.65.2.109])
 by smtp.gmail.com with ESMTPSA id a133sm3808933wme.29.2019.12.18.13.04.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 18 Dec 2019 13:04:54 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v39 22/22] target/avr: Update MAINTAINERS file
Date: Wed, 18 Dec 2019 23:03:29 +0200
Message-Id: <20191218210329.1960-23-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191218210329.1960-1-mrolnik@gmail.com>
References: <20191218210329.1960-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Include AVR maintaners in MAINTAINERS file

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 MAINTAINERS | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 740401bcbb..9ed886106a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -163,6 +163,27 @@ S: Maintained
 F: hw/arm/smmu*
 F: include/hw/arm/smmu*
 
+AVR TCG CPUs
+M: Michael Rolnik <mrolnik@gmail.com>
+R: Sarah Harris <S.E.Harris@kent.ac.uk>
+S: Maintained
+F: target/avr/
+F: tests/acceptance/machine_avr6.py
+F: default-configs/avr-softmmu.mak
+F: gdb-xml/avr-cpu.xml
+
+AVR Machines
+M: Michael Rolnik <mrolnik@gmail.com>
+R: Sarah Harris <S.E.Harris@kent.ac.uk>
+S: Maintained
+F: hw/avr/
+F: hw/char/avr_usart.c
+F: include/hw/char/avr_usart.h
+F: hw/timer/avr_timer16.c
+F: include/hw/timer/avr_timer16.h
+F: hw/misc/avr_mask.c
+F: include/hw/misc/avr_mask.h
+
 CRIS TCG CPUs
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
-- 
2.17.2 (Apple Git-113)


