Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C599DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91409204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3FaDbyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91409204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gVe-0007eO-Pd
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGw-0004Ax-Kr
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:02 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGu-00066t-32
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:01 -0400
Received: by mail-wr1-x442.google.com with SMTP id c15so15227959wrs.11
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/2v2cBSvlqgwOfQ4NBBtOTdfUDnNSdQUL7TF+4lOREY=;
 b=u3FaDbyrr4ESPRp6/l/0nvG/0MQqRwHINYhPGV650nyBlqqSAxYUFpFBRoSIGqqeKM
 E8zUJBGn5RGh8S+SlDqKXmrzrfTz85ebryNDOMolI5dS9LybbqpYNOQyiAOcSXhQbRdo
 SgT8uvhODaPBdwyJzFFGYxEhqH5wS/X/CG4p75sW/CWogc7m9Me76ovG4v0pUngXbRwu
 BsCEpL7WS3RJ/nSZX9M/dld6H/9h8Hd0clrN8KGpA+O4ztlodB7QsMvAc3RnlJOOYShU
 TRTmotRfbusRsHAvQOygX9xMuXbzJ1vkf0uqQXNtrwiFbepO41uMNQXFdROZMCfCWJZz
 yrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/2v2cBSvlqgwOfQ4NBBtOTdfUDnNSdQUL7TF+4lOREY=;
 b=dRn6bMOZOYndS+9LOS3l7eQifdQPdRkuS/NUS1Tm44fAcTYAZvdvjzjPD1AOy4ColN
 395GQkvY2d2q8YegNMgrF10UycsYbjiuoExL5ELDCbWPcTY0wmuJOLROAnhm7hTNVReW
 eynSUPX6FMw92HCjfKrsyV8A34BezdAroQqvhnIzSzPPRla6Ssk7Rh4bDRsgT43pElrY
 eoLR9JjxYdG70xG60mgAkSM2Gvwr8kOPqMwgqRJP1ynXoq/kZX86ZgSU0mRNMI3p74y6
 J7Nr/NucnTum60K4XJyk9L8dsDkPOOZsT6k8t9vxaRI7fYUg0B5rj29NlMqwxarQUsOD
 PGpQ==
X-Gm-Message-State: AOAM530OMqago4S6wee79vSQ5WrrgtabRNrA8O8PQpov0Ds4SoEmuVqQ
 3rJLoO+qtJhQcKkc+upYBCBcfeKUtE0=
X-Google-Smtp-Source: ABdhPJyKDJmADqXwgjl4/KL16ndKsb9QvfpTM89OKBZqzm0ywBpL01MEa22jh3FlfeLjpRigEaHSTQ==
X-Received: by 2002:adf:e704:: with SMTP id c4mr16991541wrm.81.1597675078556; 
 Mon, 17 Aug 2020 07:37:58 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.57 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 032/150] contrib/rdmacm-mux: convert to Meson
Date: Mon, 17 Aug 2020 16:35:25 +0200
Message-Id: <20200817143723.343284-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x442.google.com
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

We can use config-host.mak to decide whether the tool has to be built,
apart from that the conversion is straightforward.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                         | 5 -----
 Makefile.objs                    | 1 -
 contrib/rdmacm-mux/Makefile.objs | 3 ---
 contrib/rdmacm-mux/meson.build   | 8 ++++++++
 meson.build                      | 2 ++
 5 files changed, 10 insertions(+), 9 deletions(-)
 delete mode 100644 contrib/rdmacm-mux/Makefile.objs
 create mode 100644 contrib/rdmacm-mux/meson.build

diff --git a/Makefile b/Makefile
index da1eefd827..78f2cb12c7 100644
--- a/Makefile
+++ b/Makefile
@@ -300,7 +300,6 @@ dummy := $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
-                rdmacm-mux-obj-y \
                 vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
@@ -522,10 +521,6 @@ ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
 
-rdmacm-mux$(EXESUF): LIBS += "-libumad"
-rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
-	$(call LINK, $^)
-
 vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
diff --git a/Makefile.objs b/Makefile.objs
index ab798b08a7..0f80b63554 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -106,7 +106,6 @@ qga-vss-dll-obj-y = qga/
 elf2dmp-obj-y = contrib/elf2dmp/
 ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
-rdmacm-mux-obj-y = contrib/rdmacm-mux/
 vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
 
diff --git a/contrib/rdmacm-mux/Makefile.objs b/contrib/rdmacm-mux/Makefile.objs
deleted file mode 100644
index 3df744af89..0000000000
--- a/contrib/rdmacm-mux/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-ifdef CONFIG_PVRDMA
-rdmacm-mux-obj-y = main.o
-endif
diff --git a/contrib/rdmacm-mux/meson.build b/contrib/rdmacm-mux/meson.build
new file mode 100644
index 0000000000..1a01bb9262
--- /dev/null
+++ b/contrib/rdmacm-mux/meson.build
@@ -0,0 +1,8 @@
+if 'CONFIG_PVRDMA' in config_host
+  # if not found, CONFIG_PVRDMA should not be set
+  libumad = cc.find_library('ibumad', required: true)
+  executable('rdmacm-mux', files('main.c'),
+             dependencies: [glib, libumad],
+             build_by_default: targetos == 'linux',
+             install: false)
+endif
diff --git a/meson.build b/meson.build
index 48ac6c3da3..730442de1d 100644
--- a/meson.build
+++ b/meson.build
@@ -256,6 +256,8 @@ qemuutil = declare_dependency(link_with: libqemuutil,
 # Other build targets
 
 if have_tools
+  subdir('contrib/rdmacm-mux')
+
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
-- 
2.26.2



