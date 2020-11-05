Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590F9C55178
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B007B20936
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rEcUh+9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B007B20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kajf5-0001xn-JF
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 13:07:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajQz-0004Sw-83
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:31 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34211)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajQt-0004sQ-EB
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:28 -0500
Received: by mail-wr1-x443.google.com with SMTP id e6so2797984wro.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9rAsNLSka6AMk3Mjx1qnhDke8em3oiSkg4MaBZDRp2A=;
 b=rEcUh+9HaEgS3Rb+ma5TRQbrekXiMD/UO02zP0VaEgmPy7MXyUewjHo495AC/sMh2i
 v85sbu34LqeGJRWj0YXj9iXulkiav/EVNELT2iX33lMXFfpkdXxg8nR9H5AOs4+vgvEy
 bogZZs+3IJchr3Ei9u9cQeKOgslrLQEieTmZq8UE/r0mY78880nyTgqd1aZUC/pGxIGU
 Gm/zZqnpiMxVV7DhxCwxtKYXCCik91muO2F3j5Xk+48+MW9QrayG6rLXQ2b18q9r7aOC
 Z4xoudDKptEsoK2zRzznesXugiqX6HHet9WDidLWsaWWeHUp08u/KX+sptUP1Ids1cZQ
 YxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9rAsNLSka6AMk3Mjx1qnhDke8em3oiSkg4MaBZDRp2A=;
 b=Zuoz14Jl/Ji/gcFTUFsZplFNagDbIBFCjEObIweItFa+qtJicytkqdbgpMAUVy1M+1
 snx0zMDeu5tghpwlQg8b0X7iABa4yxzz/arTo7flqiVa7HQnixIwenWAnwfdAn2/hm/R
 ms35dNqaRjyk3Brk3U/qCzAJImD3lUHHf9KSIsC1lnyamQC0sae+IrSPs9CchEAwoQ2x
 sSRsncFD36RngqiKlCM4xv6Cy3dTokIGnNiTgbYuZszXkwrIsw7ivwdUNh3FhTO+xH7V
 xbgdAUDgz5DX5Qbr3aI0kGB0p6zDpb3R81SiAIZ9SzQVZ91gJVeMVL62A7ySjPYN6f8C
 KYHA==
X-Gm-Message-State: AOAM530mYxIhAbhm6cDzVjwbakBlgDrwEusBvaxQKVQ+msoO4C9iCqi3
 a2m6ugaSYCLCKDW9ZT9zOGGW2g==
X-Google-Smtp-Source: ABdhPJxiZz9cmPHY914vdQ9Gj2L9azVhsH3fW2iAYJRSsbT25axP7Pagw88YwDdnUqlOD82aW7sHFw==
X-Received: by 2002:adf:e443:: with SMTP id t3mr4397740wrm.14.1604598742039;
 Thu, 05 Nov 2020 09:52:22 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i33sm3597425wri.79.2020.11.05.09.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:52:08 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 92E741FF98;
 Thu,  5 Nov 2020 17:51:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH  09/15] meson.build: introduce CONFIG_XEN_HVM flag
Date: Thu,  5 Nov 2020 17:51:47 +0000
Message-Id: <20201105175153.30489-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105175153.30489-1-alex.bennee@linaro.org>
References: <20201105175153.30489-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
 Paolo Bonzini <pbonzini@redhat.com>, stefano.stabellini@xilinx.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While Xen traditionally uses i386-softmmu to run it's PV models on all
architectures some models are very much x86 only. This includes the
full hardware virtualisation (HVM) which is only used on x86 HW. By
introducing the symbol we can also fix the inclusion of
XEN_PCI_PASSTHROUGH which should only be built for x86 (and Linux)
systems.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 meson.build   | 6 +++++-
 accel/Kconfig | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 58e95227ea..46e4c2fc3a 100644
--- a/meson.build
+++ b/meson.build
@@ -83,6 +83,7 @@ endif
 if cpu in ['x86', 'x86_64']
   accelerator_targets += {
     'CONFIG_HAX': ['i386-softmmu', 'x86_64-softmmu'],
+    'CONFIG_XEN_HVM': ['i386-softmmu', 'x86_64-softmmu'],
     'CONFIG_HVF': ['x86_64-softmmu'],
     'CONFIG_WHPX': ['i386-softmmu', 'x86_64-softmmu'],
   }
@@ -204,6 +205,9 @@ if not get_option('kvm').disabled() and targetos == 'linux'
 endif
 if not get_option('xen').disabled() and 'CONFIG_XEN_BACKEND' in config_host
   accelerators += 'CONFIG_XEN'
+  if host_machine.cpu() == 'x86_64'
+    accelerators += 'CONFIG_XEN_HVM'
+  endif
   have_xen_pci_passthrough = not get_option('xen_pci_passthrough').disabled() and targetos == 'linux'
 else
   have_xen_pci_passthrough = false
@@ -916,7 +920,7 @@ foreach target : target_dirs
     if sym == 'CONFIG_TCG' or target in accelerator_targets.get(sym, [])
       config_target += { sym: 'y' }
       config_all += { sym: 'y' }
-      if sym == 'CONFIG_XEN' and have_xen_pci_passthrough
+      if sym == 'CONFIG_XEN_HVM' and have_xen_pci_passthrough
         config_target += { 'CONFIG_XEN_PCI_PASSTHROUGH': 'y' }
       endif
       have_accel = true
diff --git a/accel/Kconfig b/accel/Kconfig
index 2ad94a3839..4cd54029bd 100644
--- a/accel/Kconfig
+++ b/accel/Kconfig
@@ -7,3 +7,6 @@ config KVM
 config XEN
     bool
     select FSDEV_9P if VIRTFS
+
+config XEN_HVM
+    bool
-- 
2.20.1


