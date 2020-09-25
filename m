Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225D3C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:01:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89FFA2311D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BRVTziPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FFA2311D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqAG-0004w0-Cf
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLpps-0002ia-1t
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:36 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:40996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLppp-0007am-EX
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:35 -0400
Received: by mail-wr1-x42c.google.com with SMTP id w5so4062847wrp.8
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Eq5ug6TQ+UWKEm8ljjwiAREdUaKCvushWVwVKg/Ob2M=;
 b=BRVTziPRh3r1hZaLn45/uI8UP8IS0MV7348lJ87Z7216xOiuLlR+t50yDY9VtdAD/J
 +KkFL8yQJiDZVPZw52MVPQdnIJ45NDlz28F8xVnBARIztGi3VxhJmvAzFeauHTMXap0U
 x44a0AGIjVeA7SmpMtxeDyV8ugb57Eau+Z+jviot4xrVRabVvN0fddMRjcZVncMHgAnO
 BgS24KyFUXJhhJ0IK3aEdmKQkmDC70fCu+t+dcQ+IiwgGK/RFVyZV4qUm25Gfcz7UPv/
 q2QyhCitwPUZMsEiLuLG0Km+je5YNWzy+4bsLLSeL4J7kQGBdf6ewYZiJvXVtdeQlDdE
 FaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Eq5ug6TQ+UWKEm8ljjwiAREdUaKCvushWVwVKg/Ob2M=;
 b=r5+/+GtWdKHYPngHk9nwI1K6aauzYsWGqIW2wy8C5apdMjvHwthq/JKLzD68BBOYXl
 CS6Y1euscJPJ1ktMCQ5UWKGJOs81wjreYrolvag+IrBCpx+Oc+2YeuDcFyqxVDAOstWc
 rHOTFpE1vSrxjNZgOSBLMP7/T0M050REV0KmFFU1RLfLlYwRHKbHXV+DbYQaTrwjpwD5
 BFiuX2kNuZUQxTL9xHdrbQF2WeJ5+OEasMipBOHPfUc2ci87w8s/7jDlXY+4v61dwZyW
 7s07hqgAlcWisMDJUvFjVXKSPP9Uf+sPxthVfYBmEW0v0Yq9eY+7BPpjG4/UBovEB4K7
 V5NQ==
X-Gm-Message-State: AOAM532uXej44zCLGa6UVrmzspaW7e/5fsICDMnvb+lY8kjpNs+bNgHa
 /4FbYi4eih6No9jzmlVhI7yWPQ==
X-Google-Smtp-Source: ABdhPJx3VDNvBieNUSpj4GcSQL/a58+tJTbC2CwqBSV1W6U0xwhMVW/bKE3pdbe2W0uJmLvKuM+I4g==
X-Received: by 2002:a5d:4a0c:: with SMTP id m12mr5185502wrq.83.1601048431705; 
 Fri, 25 Sep 2020 08:40:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o4sm3155020wru.55.2020.09.25.08.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:40:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6CB4B1FF8C;
 Fri, 25 Sep 2020 16:40:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 02/15] meson: move libudev test
Date: Fri, 25 Sep 2020 16:40:14 +0100
Message-Id: <20200925154027.12672-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925154027.12672-1-alex.bennee@linaro.org>
References: <20200925154027.12672-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200916162621.100141-2-pbonzini@redhat.com>
Message-Id: <20200918103430.297167-2-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure   | 14 --------------
 meson.build |  7 ++++---
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/configure b/configure
index e8e8e984f245..48bf437021f6 100755
--- a/configure
+++ b/configure
@@ -908,7 +908,6 @@ Linux)
   linux_user="yes"
   kvm="yes"
   QEMU_INCLUDES="-isystem ${source_path}/linux-headers -Ilinux-headers $QEMU_INCLUDES"
-  libudev="yes"
 ;;
 esac
 
@@ -6283,15 +6282,6 @@ if test "$libnfs" != "no" ; then
 fi
 
 ##########################################
-# Do we have libudev
-if test "$libudev" != "no" ; then
-  if $pkg_config libudev && test "$static" != "yes"; then
-    libudev="yes"
-    libudev_libs=$($pkg_config --libs libudev)
-  else
-    libudev="no"
-  fi
-fi
 
 # Exclude --warn-common with TSan to suppress warnings from the TSan libraries.
 if test "$solaris" = "no" && test "$tsan" = "no"; then
@@ -7460,10 +7450,6 @@ if test "$gcov" = "yes" ; then
   echo "CONFIG_GCOV=y" >> $config_host_mak
 fi
 
-if test "$libudev" != "no"; then
-    echo "CONFIG_LIBUDEV=y" >> $config_host_mak
-    echo "LIBUDEV_LIBS=$libudev_libs" >> $config_host_mak
-fi
 if test "$fuzzing" != "no"; then
     echo "CONFIG_FUZZ=y" >> $config_host_mak
 fi
diff --git a/meson.build b/meson.build
index f4d1ab109680..48724988972d 100644
--- a/meson.build
+++ b/meson.build
@@ -252,8 +252,8 @@ if 'CONFIG_CURL' in config_host
                             link_args: config_host['CURL_LIBS'].split())
 endif
 libudev = not_found
-if 'CONFIG_LIBUDEV' in config_host
-  libudev = declare_dependency(link_args: config_host['LIBUDEV_LIBS'].split())
+if target_os == 'linux'
+  libudev = dependency('libudev', static: enable_static)
 endif
 brlapi = not_found
 if 'CONFIG_BRLAPI' in config_host
@@ -435,6 +435,7 @@ has_gettid = cc.has_function('gettid')
 
 # Create config-host.h
 
+config_host_data.set('CONFIG_LIBUDEV', libudev.found())
 config_host_data.set('CONFIG_SDL', sdl.found())
 config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
 config_host_data.set('CONFIG_VNC', vnc.found())
@@ -1515,7 +1516,7 @@ summary_info += {'sheepdog support':  config_host.has_key('CONFIG_SHEEPDOG')}
 summary_info += {'capstone':          config_host.has_key('CONFIG_CAPSTONE')}
 summary_info += {'libpmem support':   config_host.has_key('CONFIG_LIBPMEM')}
 summary_info += {'libdaxctl support': config_host.has_key('CONFIG_LIBDAXCTL')}
-summary_info += {'libudev':           config_host.has_key('CONFIG_LIBUDEV')}
+summary_info += {'libudev':           libudev.found()}
 summary_info += {'default devices':   config_host['CONFIG_MINIKCONF_MODE'] == '--defconfig'}
 summary_info += {'plugin support':    config_host.has_key('CONFIG_PLUGIN')}
 summary_info += {'fuzzing support':   config_host.has_key('CONFIG_FUZZ')}
-- 
2.20.1


