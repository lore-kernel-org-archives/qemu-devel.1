Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B760C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:02:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BFDC204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUWTEKq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFDC204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7geZ-0001yB-Ah
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gH6-0004Lz-3I
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:12 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gH4-00069g-H2
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:11 -0400
Received: by mail-wr1-x443.google.com with SMTP id y3so15280611wrl.4
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kf7BeJ8yweifSglyftbXaX9ZKpT7856D3iotyv/TdHg=;
 b=OUWTEKq8JGP84pCVQBEGzXPXGedcUT/8VL2T6a1vV/meg2tR5boh0LLbt3NX2Y6uq1
 NUlJ51cdnHyjSSXkZcqFErLprYO8MidpC8GWQOK1ReNOXQ0IgD+GftigENm8UVRsxFWT
 zjeO/7IlM27yOY0zUqGNXVJ/U3Fz/bUKjoKqJNgcTcO9Ik7GB+dn/eYBD/aI5zs77/z7
 3wHQW9IFBmXkcI4wQ+4xkAOv42W0g+JxYt/6a7TM1yDN+xYkHSfBOYwFhXMWBlgwWcL8
 NgQ7vGhj34eC6e6xJ4yS6HruyfIVmTPfptPTVlx3u4B85FWv6VRVLf97rxvUf+sC7La/
 I0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=kf7BeJ8yweifSglyftbXaX9ZKpT7856D3iotyv/TdHg=;
 b=FKiGAQ3VnT6EU1UCO3I5OGGpqJwDMJD29G8apmA0YDEqC7ZVQcDkjr/te/d1Ksf1gz
 YNhxivu/k99k/Jmc/oVbmNpLSuUdtx6CGba5G/oXj+oFph22OUW48d82bVfZvoofODNn
 s77psUzEO9m3FWs4P/GWMF/ctLi80RwU6PZosOzHm8w6Cdr+hGWVV8+azKFVKNWI9fSv
 Z706tlsqk9ZWAt8hK6ujw7TQXUR6+dXjf/BO+s0a8zcWJotrf1O1x6vHqWaFYvoPffqR
 zwA1cxPEByezM8mW6Sd1S0P+OjD96X/I5dPd2IOjM8qWPDvB0FzUPksJPinkMxShfMEy
 HmUQ==
X-Gm-Message-State: AOAM531aJRtQI2FflKDj7y/oyff2sYi+cJLkHChXFnwPyXu2kH9E+WnV
 3BLbUCTEdw6gcDZDhUpqDKACioUiEo4=
X-Google-Smtp-Source: ABdhPJzoe12wELTCpjV6BXOr9KUVWGugQx8pGOtCxqgnTfBWx0TmKeu13nHTDUCpK+JKhlrQdZcHUw==
X-Received: by 2002:adf:92a1:: with SMTP id 30mr17128981wrn.56.1597675088323; 
 Mon, 17 Aug 2020 07:38:08 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 043/150] meson: add qemu-bridge-helper
Date: Mon, 17 Aug 2020 16:35:36 +0200
Message-Id: <20200817143723.343284-44-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile    | 4 ----
 meson.build | 9 ++++++++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 06c73b8d09..cbd5bd1a87 100644
--- a/Makefile
+++ b/Makefile
@@ -186,8 +186,6 @@ LIBS+=-lz $(LIBS_TOOLS)
 
 HELPERS-y = $(HELPERS)
 
-HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) += qemu-bridge-helper$(EXESUF)
-
 # Sphinx does not allow building manuals into the same directory as
 # the source files, so if we're doing an in-tree QEMU build we must
 # build the manuals into a subdirectory (and then install them from
@@ -420,8 +418,6 @@ qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(chardev-obj-y) $(io-obj-y) $(qom-obj-y) $(storage-daemon-obj-y) $(COMMON_LDADDS)
 
-qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
-
 qemu-keymap$(EXESUF): qemu-keymap.o ui/input-keymap.o $(COMMON_LDADDS)
 
 qemu-edid$(EXESUF): qemu-edid.o hw/display/edid-generate.o $(COMMON_LDADDS)
diff --git a/meson.build b/meson.build
index 67a26314fa..8c05db2cb6 100644
--- a/meson.build
+++ b/meson.build
@@ -293,7 +293,6 @@ qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
 # Other build targets
-
 if 'CONFIG_GUEST_AGENT' in config_host
   subdir('qga')
 endif
@@ -311,6 +310,14 @@ if have_tools
     subdir('contrib/vhost-user-input')
     subdir('contrib/vhost-user-scsi')
   endif
+
+  if host_machine.system() == 'linux'
+    executable('qemu-bridge-helper', files('qemu-bridge-helper.c'),
+               dependencies: [qemuutil, libcap_ng],
+               install: true,
+               install_dir: get_option('libexecdir'))
+  endif
+
   if 'CONFIG_IVSHMEM' in config_host
     subdir('contrib/ivshmem-client')
     subdir('contrib/ivshmem-server')
-- 
2.26.2



