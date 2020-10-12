Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B30C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:04:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3962E20870
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3962E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8k0-0000Ma-9V
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 21:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kS7Ge-0001nH-LQ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 19:30:12 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:39380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kS7GG-00061K-NV
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 19:30:12 -0400
Received: by mail-pl1-f174.google.com with SMTP id y1so6064401plp.6
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 16:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K57xgAZy4BCUSPwpSO/jV3XqhkKM/aO2E5ESIw8V0Lg=;
 b=HvXDEH0RVHEdeJyF7wZftumjGK59Dg2YwCWcG/204c4PdqF5kmyat4zA81rhyLs61U
 7Xv5hxnEy7Ltlw279F6rRcMIRgrGMQq4vyclcXXk1AHMM31jpkV/TKDHcCa3LyMPbsJ2
 SGZpf6FexJVEF9o4PScb+yu5F7NRrqkyqVFjSqeMrlu9R3BhnYcjuMN0jxpyotVgGlmw
 8QdeZKEqRQEPE4kOM9NdKbXuPvr6cVdm9r+j3hihYDhtbOcIKShzpyxtPLuXuCJ8t28V
 i9F2U+J9XkRLHWWxEUzXVLpxUmraZevG1yvRRltUH8mzHaIft4sJ//HBmSU7sVemqe7C
 Dm1Q==
X-Gm-Message-State: AOAM532PnF23ChQUmjpSDWj5C+O//RnDThaq22TkkIumJtpkk9qegGPD
 p5mnXGju4THL1fPKYZuPwtq2/HyB5PI=
X-Google-Smtp-Source: ABdhPJxrAgFvvwo/NRT3mol7X3RL3WiuczHmAyuckqaUelFsGXKatxYyGGNt2oxEjbEGtwWFcWf/kw==
X-Received: by 2002:a17:902:7c93:b029:d4:e1c3:bde0 with SMTP id
 y19-20020a1709027c93b02900d4e1c3bde0mr3745368pll.85.1602545387333; 
 Mon, 12 Oct 2020 16:29:47 -0700 (PDT)
Received: from localhost.localdomain ([73.93.152.174])
 by smtp.gmail.com with ESMTPSA id f21sm8088315pfk.169.2020.10.12.16.29.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Oct 2020 16:29:46 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/10] slirp: update for iOS resolv fix
Date: Mon, 12 Oct 2020 16:29:34 -0700
Message-Id: <20201012232939.48481-6-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012232939.48481-1-j@getutm.app>
References: <20201012232939.48481-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.174; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f174.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 19:29:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 12 Oct 2020 20:56:29 -0400
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
Cc: Joelle van Dyne <j@getutm.app>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: osy <osy86@users.noreply.github.com>

We cannot access /etc/resolv.conf on iOS so libslirp is modified to use
libresolv instead.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 .gitmodules | 2 +-
 meson.build | 2 ++
 slirp       | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/.gitmodules b/.gitmodules
index 2bdeeacef8..f23e859210 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -51,7 +51,7 @@
 	url = https://git.qemu.org/git/edk2.git
 [submodule "slirp"]
 	path = slirp
-	url = https://git.qemu.org/git/libslirp.git
+	url = https://github.com/utmapp/libslirp.git
 [submodule "roms/opensbi"]
 	path = roms/opensbi
 	url = 	https://git.qemu.org/git/opensbi.git
diff --git a/meson.build b/meson.build
index 32cf08619f..da96e296e0 100644
--- a/meson.build
+++ b/meson.build
@@ -996,6 +996,8 @@ if have_system
     slirp_deps = []
     if targetos == 'windows'
       slirp_deps = cc.find_library('iphlpapi')
+    elif targetos == 'darwin'
+      slirp_deps = cc.find_library('resolv')
     endif
     slirp_conf = configuration_data()
     slirp_conf.set('SLIRP_MAJOR_VERSION', meson.project_version().split('.')[0])
diff --git a/slirp b/slirp
index ce94eba204..452c389d82 160000
--- a/slirp
+++ b/slirp
@@ -1 +1 @@
-Subproject commit ce94eba2042d52a0ba3d9e252ebce86715e94275
+Subproject commit 452c389d8288f81ec9d59d983a047d4e54f3194e
-- 
2.24.3 (Apple Git-128)


