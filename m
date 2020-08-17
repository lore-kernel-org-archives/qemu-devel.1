Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5E2C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B342054F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhqNMLbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B342054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gnO-0004J6-LR
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHj-0005e9-Hx
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:51 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHh-0006HQ-Qu
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:51 -0400
Received: by mail-wr1-x441.google.com with SMTP id p20so15285942wrf.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vJYRzFczP3G71nLXPxT7FoelYpxmkicx4WZGHD1y9RM=;
 b=FhqNMLbqwag88fzLuyfmypOKCewKXIQ6RU3bszYK19rS+fnGuC4TYIOmB6h0DdNb96
 u5JrUyOrwjt7ll8cM83j8hYa7Pn/cWVMG6YZa5x5vP2HwPez+3ChNpMvkG6u6qJvbkU5
 hsJ6I/UjEAGM6rGpIQLjqEOTLI9ySo8gd1F/M8nuFQDObSFdYcvJYe6lu7ZeL/ow11Ib
 ESgOSulwiwkRYgPe/HS9UdwzIBGSIg4hjRNzpDtm2z01ycCL2IP/HiQgTsMYyrG/GHYt
 Is3y4BMIYjrxgrE0E9VnXKcBPNxhYBtkFSoYrlnPoI4o5zO2rSW449f5GMXwlPDv3Ot+
 8dHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vJYRzFczP3G71nLXPxT7FoelYpxmkicx4WZGHD1y9RM=;
 b=Ja/9TeIlY0iJcHKApA+1RH2MSVRx7CFGaqwrBd2jM4hehtzQ6t/6DDesQk1G9yL5SZ
 VZ0htq0tBl8Lv6yOBZuwEsJz+ZKOBVlFNC8V1LS9Mdis/b62IlT2+h7pE3LrmODJ//wW
 fF0+bv3vOOee6IckpMdZdwYa6OrvoIWZp2Si8eCc+4zGy8gVDsNlwNQwtPKYv56lvop7
 5jeMIGCO86y+GSEGYaL3n82EobKPa7tnjzSgrctNYUs/jxUBNyBXJ5QwiPXvy5SAWPmb
 mUpNynEaczzd69coUmbCN+kD6uAd9Pfz7ZPbnchCFFtiq3HmteH377bD6scJ3OGa9Ubd
 jm/Q==
X-Gm-Message-State: AOAM5307baMUopA9OqGogeFJDuO238LqHh5Dc7hlCus1LG9YPqqAjikH
 DaNO5r2crZTvf0eetstKadfZ5vJz5ak=
X-Google-Smtp-Source: ABdhPJxCtmKl+Lp+LZKS7iTo5ONQcVduXqP3f0GRGijbsf6bOh5mU6XFxlcczeQSj9AZDkn+XcX/nA==
X-Received: by 2002:a5d:440e:: with SMTP id z14mr15505487wrq.422.1597675128181; 
 Mon, 17 Aug 2020 07:38:48 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 083/150] meson: convert qapi-specific to meson
Date: Mon, 17 Aug 2020 16:36:16 +0200
Message-Id: <20200817143723.343284-84-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs      |  2 --
 Makefile.target    |  1 -
 qapi/Makefile.objs | 15 ---------------
 qapi/meson.build   | 10 +++++++---
 4 files changed, 7 insertions(+), 21 deletions(-)
 delete mode 100644 qapi/Makefile.objs

diff --git a/Makefile.objs b/Makefile.objs
index 3b32a4c9bb..c332323b81 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -64,8 +64,6 @@ common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF
 common-obj-y += hw/
 common-obj-m += hw/
 
-common-obj-y += qapi/
-
 common-obj-y += libqmp.fa
 
 endif # CONFIG_SOFTMMU
diff --git a/Makefile.target b/Makefile.target
index bf3fda92c1..386378b9c8 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -157,7 +157,6 @@ ifdef CONFIG_SOFTMMU
 obj-y += softmmu/
 obj-y += gdbstub.o
 obj-y += hw/
-obj-y += qapi/
 LIBS := $(libs_softmmu) $(LIBS)
 
 # Temporary until emulators are linked by Meson
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
deleted file mode 100644
index c0a31be1a1..0000000000
--- a/qapi/Makefile.objs
+++ /dev/null
@@ -1,15 +0,0 @@
-QAPI_TARGET_MODULES = machine-target misc-target
-
-obj-y = qapi-introspect.o
-obj-y += $(QAPI_TARGET_MODULES:%=qapi-types-%.o)
-obj-y += qapi-types.o
-obj-y += $(QAPI_TARGET_MODULES:%=qapi-visit-%.o)
-obj-y += qapi-visit.o
-obj-y += $(QAPI_TARGET_MODULES:%=qapi-events-%.o)
-obj-y += qapi-events.o
-obj-y += $(QAPI_TARGET_MODULES:%=qapi-commands-%.o)
-obj-y += qapi-commands.o
-obj-y += qapi-init-commands.o
-
-QAPI_MODULES_STORAGE_DAEMON = block-core char common control crypto
-QAPI_MODULES_STORAGE_DAEMON += introspect job qom sockets pragma transaction
diff --git a/qapi/meson.build b/qapi/meson.build
index f45b80bbfa..2b2872a41d 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -114,8 +114,12 @@ foreach output : qapi_util_outputs
   i = i + 1
 endforeach
 
-# These are still handled by the Makefile
-i += qapi_nonmodule_outputs.length()
-i += qapi_specific_outputs.length()
+foreach output : qapi_specific_outputs + qapi_nonmodule_outputs
+  if output.endswith('.h')
+    genh += qapi_files[i]
+  endif
+  specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: qapi_files[i])
+  i = i + 1
+endforeach
 
 qapi_doc_texi = qapi_files[i]
-- 
2.26.2



