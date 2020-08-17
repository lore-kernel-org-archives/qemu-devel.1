Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B96DC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE20204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVn7IDAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE20204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gXG-0002j0-8z
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gH4-0004JL-Qz
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:10 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:37370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gH3-00069V-Ak
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:10 -0400
Received: by mail-wr1-x431.google.com with SMTP id y3so15280562wrl.4
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BWm4RLl9igLq5d2pFobzxBFb20HeIXdydgT8Jvp0JXU=;
 b=aVn7IDAI2mr+nV7f6jwaVMs42lRP7u8ELTT809lZVAVJNZBa7dWkHYPSWT3YOVNcfn
 7qOijsSimcfzvbnBK8jUCmh8PvgR1fXHh/cwpDSs6nzmqP7jg7huFytBqJBY+da15vdF
 JRusiqb66M9sAp6N4hHAsTP7YkNwOWaWDIpVPqM5l3seVGfN1JR6arBHNFVrIhf8JOPd
 uaA2jQpe75IMHC6ZV5dFAb1Y77I+ziL4zILYH0KH5731xUsJOIBhLBtFcfeZC39bcBcn
 BNmP6lmCG/H01uX+xM2fkNNV0rlAS75EFRYw/+PSxpdzdFnN75X0ThLtGrt0y3eeFAeT
 OPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BWm4RLl9igLq5d2pFobzxBFb20HeIXdydgT8Jvp0JXU=;
 b=lkPPcjoR6ucrzbXeqM9wr6IesJJu2jYhegfYH0RM7QUGHS91vv+3W2f06BPcplE+6l
 p2TC8JkFgQZpPX/HrDexlybHevX0X+EjWPtEDElkhSZicGbLho83nP37qSLKZ+/HXo4h
 FqPKorDKRb8dShG96alfuQ09Jtwtj4bt2vVJWHGs+HZ/LMgQELtnCo7GFmwSd+AM+4vW
 31XtdstSQuUDerh39QFmGX0/T+zePpzhWG0O7ElYdBSPKN2+iWuF6iAxrvf8ry6whx0e
 dOIYAGvf5FVOHUqC0aixbmDIeKEES5uOxJDp75hKqDrgHIgPRaJBh9Qx5LTe7/YLvnv7
 Nomw==
X-Gm-Message-State: AOAM533nwqq1t+XM6Tqwrvx1D0Q3/vpY7qLEN7FbjXGpK9zmPneFuqUa
 kO5jMrnQWtlAmUBjg7x5fwUSK5tUYWA=
X-Google-Smtp-Source: ABdhPJx1L57YnDx5gapbbDQIzRUYX5FoxW1Xd6l8rnSqv2dYuQntZ2bO7Lp5wSTPf3+uAmd0gO2i5Q==
X-Received: by 2002:adf:dfd0:: with SMTP id q16mr17185226wrn.60.1597675087466; 
 Mon, 17 Aug 2020 07:38:07 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.06 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 042/150] meson: convert dummy Windows qga/qemu-ga target
Date: Mon, 17 Aug 2020 16:35:35 +0200
Message-Id: <20200817143723.343284-43-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                  | 5 -----
 qga/meson.build           | 4 ++++
 qga/vss-win32/meson.build | 2 ++
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index a46b31b907..06c73b8d09 100644
--- a/Makefile
+++ b/Makefile
@@ -439,11 +439,6 @@ qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 qemu-keymap$(EXESUF): LIBS += $(XKBCOMMON_LIBS)
 qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)
 
-ifneq ($(EXESUF),)
-.PHONY: qga/qemu-ga
-qga/qemu-ga: qga/qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
-endif
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
diff --git a/qga/meson.build b/qga/meson.build
index 2d33c09fe6..7e7174b0a3 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -44,6 +44,7 @@ qga = executable('qemu-ga', qga_ss.sources(),
                  link_args: config_host['LIBS_QGA'].split(),
                  dependencies: [qemuutil, libudev],
                  install: true)
+all_qga = [qga]
 
 if host_machine.system() == 'windows'
   if 'CONFIG_QGA_VSS' in config_host
@@ -72,6 +73,9 @@ if host_machine.system() == 'windows'
                               config_host['QEMU_GA_MSI_WITH_VSS'].split(),
                               config_host['QEMU_GA_MSI_MINGW_DLL_PATH'].split(),
                             ])
+    all_qga += [qga-msi]
     alias_target('msi', qga_msi)
   endif
 endif
+
+alias_target('qemu-ga', all_qga)
diff --git a/qga/vss-win32/meson.build b/qga/vss-win32/meson.build
index 1f39e05335..780c461432 100644
--- a/qga/vss-win32/meson.build
+++ b/qga/vss-win32/meson.build
@@ -14,6 +14,8 @@ if add_languages('cpp', required: false)
                                cc.find_library('shlwapi'),
                                cc.find_library('uuid'),
                                cc.find_library('intl')])
+
+  all_qga += qga_vss
 endif
 
 # rules to build qga-vss.tlb
-- 
2.26.2



