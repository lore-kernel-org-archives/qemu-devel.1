Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812B2C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF2622527
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bl6pHj62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF2622527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifNzM-0004Ov-Qh
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 07:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxl-0002Yz-Sh
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxk-0005Xh-Tb
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:01 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNxk-0005W5-MU
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:00 -0500
Received: by mail-wr1-x432.google.com with SMTP id q6so2580858wro.9
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UJRw/6pTHwg669MDPUQSE4YZuxiWLe8OTKSvZ9cB834=;
 b=Bl6pHj62C154FAn8yUHrU+tf6VBj9MsVCs9UDgm7DNU72lHYXrPCfp+u2GX9ss57VL
 PdShZdG13EdszCG0aAssaOcOBMqnMf/BJTZQT/RGuDvSKXjUqlU3j8UZb+S83HRe81aX
 F7+UpjDxtfef4uEcGdFHuE0fE8/dnsG0Qkcy4JvpUUZwDNF70rh3300dxdUjty6sL314
 P93oUzBSwMohrsP7digMCu+JxuyQ4+XZhKye0KlisQZIcP5ykYGUIEAPL3zMPyppc2xN
 xFUkruB4Dpyi93MLJr37nlhY+/ntz6HH7rZ5BGK+rRxkhaq8fxzkYwP9dVY9zuuJSuAP
 hXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=UJRw/6pTHwg669MDPUQSE4YZuxiWLe8OTKSvZ9cB834=;
 b=BUsvD1uZMRfybtcC7d8TqYjdeWNNqOSQ0Ncb5Lx12hIOxeAaxq2aWFKMBZxs4ft9ID
 yd+MNpVvEEwkmBgxmQkPkCW1Pe46BahOPZiKxKjk65IdPNN3u3oLmQSlgHkflMN4/YAK
 FFtbfpln9DSFDaL5D7QneSbYII0kEY1x5QB1FBv4V/27z7TLOVz9yMYgM7HuwN8rfUHH
 SxLfgTL+BMc+fnBKCSXPMCXdhxNqUnMexJS8BBH3+c5citaElOjawmS2EoyMeQjKFzqC
 rKuj8UnIofbLAbBMnlLUQR80w7WAr7Ep6I2E7RBsWQvaEnDupVGOW9UESt6CPMPAJQLn
 wBCQ==
X-Gm-Message-State: APjAAAU9a1ObQE/T4cUa3kd0aupWpfOh/Mjh3RA0UacfC3FkC5ZfQNEu
 K6nut+uCpZL8ENAkYvC+UCYvqQAZ
X-Google-Smtp-Source: APXvYqwejByHMZ9YhntEjizwraJccYaaiLfwwIlsZkvB6TmnNbLCZzJd9VI/OjKop6cnLyoalMKBLw==
X-Received: by 2002:adf:dfd2:: with SMTP id q18mr6163190wrn.152.1576155179330; 
 Thu, 12 Dec 2019 04:52:59 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.52.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:52:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 001/132] build-sys hack: ensure target directory is there
Date: Thu, 12 Dec 2019 13:50:45 +0100
Message-Id: <1576155176-2464-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

By removing some unnest-vars calls, we miss some directory creation
that may be required by some/dir/object.d.

This will go away once everything is converted to Meson.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 rules.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rules.mak b/rules.mak
index 967295d..e19ad19 100644
--- a/rules.mak
+++ b/rules.mak
@@ -66,6 +66,7 @@ expand-objs = $(strip $(sort $(filter %.o,$1)) \
                   $(filter-out %.o %.mo,$1))
 
 %.o: %.c
+	@mkdir -p $(dir $@)
 	$(call quiet-command,$(CC) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
 	       $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) \
 	       -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-- 
1.8.3.1



