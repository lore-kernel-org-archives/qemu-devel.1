Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BBAC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589D620709
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wsI27co3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589D620709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kajk7-0006Tk-BH
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 13:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajR7-0004fT-AZ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:37 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajR5-0004tT-Mp
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:37 -0500
Received: by mail-wm1-x341.google.com with SMTP id p19so1618538wmg.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eQvIGlUj5ZImrXjMOfJf5Uck7kBzZj6a/Ka3js7fkVU=;
 b=wsI27co3r65Cnwo4ix7Gc225yTcc/aJvBuZm+Q7W2XVyJtyIDeCoBy0q21Wi3TabW+
 AOK2J+C/DBZUzDsPMw0e/+PtYt0IYUKbMP+/I7aQ5cvnSXIEdTLvrMvq8lq4EQ1TB8Ye
 pJXm+J1NoY6lVBePaMVGfRzQ/NGkL4/duLc8SUHB5BHkjs8E2FYw9OHHpbx9Tvb5/IiF
 zKb1gEok6oqWqalQENd7bYFWRrCgHXHB0thPF/Eh3d8fhceBlOHh27SodBP8XNZKe8T7
 tBAjJBj8fS0iYgBdANIfAgjT+MhKATf2N4zKDTnMhLoQ8kvfB1D+5mjDdzGV7imuS8BB
 1LLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eQvIGlUj5ZImrXjMOfJf5Uck7kBzZj6a/Ka3js7fkVU=;
 b=MuC9wF3L0T7UCnTkpSvGBwex2b6HJ2u0w8+He+EmKc3ItS5X6OKtOs5ZGWWdikUumA
 jZxNHO8sviYaXidPwGv49Kp8UpRT3duTPkNbOwvflMR6yNfFBszCu8HaiXNgcVlfl44t
 yJhRyMJY4lx/IURz/89SidOSvKTufjJLYUdO490mLMx9xMTi//P0IadDlzflkdTv04bZ
 mqe6prEdufDJESPeFf6sjMhi4oS2zVyS5j+agCu3BitWWcFue/qPRVlVL488J/MjR/X/
 NLSdqtUWKEZCw+bCqW0zWf0P1cXcNQFrp6JgfJgZg2SkYJvQ5igNiXO34dfTnsGxbja7
 KnhQ==
X-Gm-Message-State: AOAM530LqU9PYmkUWwWRbhcyoUq0meriCeT8w0vj2Qn+xdzE39otunQU
 I/9U9d3XNsg6QUd9+TYyj38X5g==
X-Google-Smtp-Source: ABdhPJzxHj7bd+GZ1L5+bw6UTAm3wwt5nI/3cOlJB+2ijOYvQTf0m0J1G8TJfEYSJ00XpEhFA9XqQw==
X-Received: by 2002:a1c:6843:: with SMTP id d64mr4084355wmc.131.1604598754433; 
 Thu, 05 Nov 2020 09:52:34 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y185sm3759171wmb.29.2020.11.05.09.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:52:32 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2B0991FF9E;
 Thu,  5 Nov 2020 17:51:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 15/15] meson.build: build a Xen aware qemu-aarch64-system
Date: Thu,  5 Nov 2020 17:51:53 +0000
Message-Id: <20201105175153.30489-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105175153.30489-1-alex.bennee@linaro.org>
References: <20201105175153.30489-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: julien@xen.org, masami.hiramatsu@linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org, takahiro.akashi@linaro.org,
 stefano.stabellini@xilinx.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The i386-softmmu is a bit of an oddity for running ARM Xen guests so
lets allow us to build an aarch64 binary with a reasonable name as
well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 meson.build | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 79b74fbda7..5280cd9e8f 100644
--- a/meson.build
+++ b/meson.build
@@ -74,15 +74,16 @@ else
 endif
 
 accelerator_targets = { 'CONFIG_KVM': kvm_targets }
-if cpu in ['x86', 'x86_64', 'arm', 'aarch64']
-  # i368 emulator provides xenpv machine type for multiple architectures
+if cpu in ['arm', 'aarch64']
+  # i386 emulator used to provide xenpv machine type for all
+  # supported architectures
   accelerator_targets += {
-    'CONFIG_XEN': ['i386-softmmu', 'x86_64-softmmu'],
+    'CONFIG_XEN': ['i386-softmmu', 'x86_64-softmmu', 'arm-softmmu', 'aarch64-softmmu'],
   }
-endif
-if cpu in ['x86', 'x86_64']
+elif cpu in ['x86', 'x86_64']
   accelerator_targets += {
     'CONFIG_HAX': ['i386-softmmu', 'x86_64-softmmu'],
+    'CONFIG_XEN': ['i386-softmmu', 'x86_64-softmmu'],
     'CONFIG_XEN_HVM': ['i386-softmmu', 'x86_64-softmmu'],
     'CONFIG_HVF': ['x86_64-softmmu'],
     'CONFIG_WHPX': ['i386-softmmu', 'x86_64-softmmu'],
-- 
2.20.1


