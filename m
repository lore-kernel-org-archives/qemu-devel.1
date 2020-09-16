Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB65C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC46E206B7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh6/sBm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC46E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIaHT-00049l-Mx
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kIaGL-0003I3-I9
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:26:29 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:45278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kIaGJ-0000oc-IT
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:26:29 -0400
Received: by mail-wr1-x429.google.com with SMTP id x14so7524434wrl.12
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iMSNpRYkuxORHU6f+AgXIb0a+Cm9/6sUG5ZTlxMixc8=;
 b=fh6/sBm4DHwFK8qczrd19K1rHUAZFiXExf8NAZWMHCO/nnyZ5QrOEiFAGabfQeuinD
 xkgPHxcfrj4EdUalmW0Jkzl3GHtlMXQgpqbsb6FPRXT0nV2Mu/XnBczT84DDH4CL2oXu
 W8ny3m4uUg/kCZMMLDl5EKA8+iwkgFnlJiRdRs9OXx03RbEyCeg/Vx8Y3cCZp7JbujeK
 Npy7hvDcJhMygcmazVZtMSWxcfabUo6viEUoJOZh1tWeVio9w/C6Xvx7JIcAoRPmXefr
 j5waV6mPhkM+CcIW/8YfSSTP7WJ5h44ZIFhUwOL4dCE1Ct9WR1N8JhH7yd4+kb7AUQYB
 nxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=iMSNpRYkuxORHU6f+AgXIb0a+Cm9/6sUG5ZTlxMixc8=;
 b=iTSU/syq9G53nS9voA9fMsjLFR0u9va452BrLfBfOV+Icj9QZGu7GB+Ho2u7o0TdpF
 dc6i2TaU/FppGwzFzr2JNMunB9o+mpfPcXnZ8mQtykBiAFCQLqYvlYE1ZPJvO6BLJBwy
 Robhc5ckvgjBBuYjvbH4ct1ax6AYMYsm7Ac7ZICKCDyUcLxKBAGSjFeOscSymydCW0N8
 +1GaiF2kzheUA2+MeWQMswOCBulSNFhuruvqamqkSe636jpx9eFgTZhtfixQIrmROnRm
 IYpyPT/IdPmdtWXtlHxF+RDrX+ZYiiUJipQUXkdV/rqyU4SryPQdn8q+Dd5xxMU+CGOd
 U3Pg==
X-Gm-Message-State: AOAM532LLQkNf72yedYuNXkAqNdRKPDEhdXPgJodpvfnJiZtmJCeQ+cl
 JL2XayGVbomMr2bivwEHVQHyKoluPl4=
X-Google-Smtp-Source: ABdhPJwTOEQrrWrtifFPglwcwuyAbFDXF7cCiohkzLgcIU0WSL+k7h/ge8ey2vXCjUUU5RaWVK+rXA==
X-Received: by 2002:a5d:55c8:: with SMTP id i8mr28060213wrw.331.1600273584748; 
 Wed, 16 Sep 2020 09:26:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:cf8e:a9a0:1aed:9a37])
 by smtp.gmail.com with ESMTPSA id v128sm6111933wme.2.2020.09.16.09.26.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 09:26:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] meson: move libudev test
Date: Wed, 16 Sep 2020 18:26:20 +0200
Message-Id: <20200916162621.100141-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200916162621.100141-1-pbonzini@redhat.com>
References: <20200916162621.100141-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 configure   | 14 --------------
 meson.build |  7 ++++---
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/configure b/configure
index 1a86c1f146..83ccbc6d70 100755
--- a/configure
+++ b/configure
@@ -876,7 +876,6 @@ Linux)
   linux_user="yes"
   kvm="yes"
   QEMU_INCLUDES="-isystem ${source_path}/linux-headers -Ilinux-headers $QEMU_INCLUDES"
-  libudev="yes"
 ;;
 esac
 
@@ -6258,15 +6257,6 @@ if test "$libnfs" != "no" ; then
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
@@ -7435,10 +7425,6 @@ if test "$gcov" = "yes" ; then
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
index 64c0058dfb..5092aec439 100644
--- a/meson.build
+++ b/meson.build
@@ -257,8 +257,8 @@ if 'CONFIG_CURL' in config_host
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
@@ -446,6 +446,7 @@ has_gettid = cc.has_function('gettid')
 
 # Create config-host.h
 
+config_host_data.set('CONFIG_LIBUDEV', libudev.found())
 config_host_data.set('CONFIG_SDL', sdl.found())
 config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
 config_host_data.set('CONFIG_VNC', vnc.found())
@@ -1527,7 +1528,7 @@ summary_info += {'sheepdog support':  config_host.has_key('CONFIG_SHEEPDOG')}
 summary_info += {'capstone':          config_host.has_key('CONFIG_CAPSTONE')}
 summary_info += {'libpmem support':   config_host.has_key('CONFIG_LIBPMEM')}
 summary_info += {'libdaxctl support': config_host.has_key('CONFIG_LIBDAXCTL')}
-summary_info += {'libudev':           config_host.has_key('CONFIG_LIBUDEV')}
+summary_info += {'libudev':           libudev.found()}
 summary_info += {'default devices':   config_host['CONFIG_MINIKCONF_MODE'] == '--defconfig'}
 summary_info += {'plugin support':    config_host.has_key('CONFIG_PLUGIN')}
 summary_info += {'fuzzing support':   config_host.has_key('CONFIG_FUZZ')}
-- 
2.26.2



