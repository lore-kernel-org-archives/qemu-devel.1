Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD37AC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D6F520709
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="em/jkiqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6F520709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kajSc-0005w3-Vp
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 12:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajQo-0004DO-Cb
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:18 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajQm-0004rg-Ky
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:18 -0500
Received: by mail-wm1-x342.google.com with SMTP id v5so2459651wmh.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q4/BNah4WCCk/oICyL+pXWdpc8fROe+nhzuyfin8Wc4=;
 b=em/jkiqxe+irvulRikttAPOMQYUQ0aNRhKPGqdQk+qZqM3Oq2mdS0NozBiHi9rk9RX
 UEj73oswf+CEpuy5e+pbNnauxYbLIdi2JfejV0SYnA3o68ZZKzpRDFQ37MFo9vivst0b
 S6Zn2hCeC8kGbgxv3P+qnfcVximpOXzoxDzserEvXPvg6LKG5vs4VGMpHDZtogq1ij4E
 ZIHYAjzEqYMTjwh/KfBmspQ2fw9hrRPciL8+SU6mgR2kIXQHceZJ+9rnGUbJbJ0r3a8Y
 bRvGnFTp4pn5J7nBQnQp6nGC2Egq2tuzJTXNhU6FoOMF85FvtdC1SYX+w4DBbDpS1T7F
 7Uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q4/BNah4WCCk/oICyL+pXWdpc8fROe+nhzuyfin8Wc4=;
 b=ZgL6oVu4A9dT3kGjaBaTBI3G0XStjxC5jXQvzA7sRzEZu/XuTkpM5oFQrOm0YWwHmy
 V0ASArstHb+De6eblzkJVnlyyma8BQJJx0Im0hK0O+qRdN8e3X1Y/sWyRhBDIIwa4ccw
 ezkoTUhwAFAVkePh0xuscTKug9FacQRu7JJ1Ix6g9fAx9G0aJy8S0B5bM62Tu5wTYmFs
 UJs6q0ZI1ZHtxyb/Zrn3BU7Q6yG/NDTkTHQhu1MNqZ/TZn36xHCx6SueKGedYTDubThg
 KjIuZhxiPs550tCzHvyyuddZxWXcdwUJs5N76jtXBG3jML2g4pJOIjOOtWdKGS43vpuM
 GR9g==
X-Gm-Message-State: AOAM5336f7M+R0cWU7PmHQXerJ4ZLSub0FHg+sAdUefTr6kCrpg+ZZy2
 30kH83pchjI1iJA8AtLZbxTg0g==
X-Google-Smtp-Source: ABdhPJxa/Az+vQ7FtocaVyXJ/i3V/baHS6rKuE1AT2Z8f1DKosvM28JKwJNPJa/8tgjZsd7X2eX2aA==
X-Received: by 2002:a1c:a952:: with SMTP id s79mr4103730wme.155.1604598735391; 
 Thu, 05 Nov 2020 09:52:15 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e25sm4136670wra.71.2020.11.05.09.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:52:04 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7D2781FF96;
 Thu,  5 Nov 2020 17:51:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 08/15] meson.build: fix building of Xen support for aarch64
Date: Thu,  5 Nov 2020 17:51:46 +0000
Message-Id: <20201105175153.30489-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105175153.30489-1-alex.bennee@linaro.org>
References: <20201105175153.30489-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, julien@xen.org,
 masami.hiramatsu@linaro.org, Paul Durrant <paul@xen.org>,
 andre.przywara@arm.com, stefano.stabellini@linaro.org,
 takahiro.akashi@linaro.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, stefano.stabellini@xilinx.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Xen is supported on ARM although weirdly using the i386-softmmu model.
Checking based on the host CPU meant we never enabled Xen support. It
would be nice to enable CONFIG_XEN for aarch64-softmmu to make it not
seem weird but that will require further build surgery.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Fixes: 8a19980e3f ("configure: move accelerator logic to meson")
---
 meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index f5175010df..58e95227ea 100644
--- a/meson.build
+++ b/meson.build
@@ -74,10 +74,15 @@ else
 endif
 
 accelerator_targets = { 'CONFIG_KVM': kvm_targets }
+if cpu in ['x86', 'x86_64', 'arm', 'aarch64']
+  # i368 emulator provides xenpv machine type for multiple architectures
+  accelerator_targets += {
+    'CONFIG_XEN': ['i386-softmmu', 'x86_64-softmmu'],
+  }
+endif
 if cpu in ['x86', 'x86_64']
   accelerator_targets += {
     'CONFIG_HAX': ['i386-softmmu', 'x86_64-softmmu'],
-    'CONFIG_XEN': ['i386-softmmu', 'x86_64-softmmu'],
     'CONFIG_HVF': ['x86_64-softmmu'],
     'CONFIG_WHPX': ['i386-softmmu', 'x86_64-softmmu'],
   }
-- 
2.20.1


