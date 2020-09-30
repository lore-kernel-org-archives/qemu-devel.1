Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A49C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:00:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4328D20709
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRKkWFT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4328D20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNiHR-0007Y9-UV
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 16:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kNiFd-0006Hk-GG
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 15:58:57 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:34354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kNiFb-000791-S1
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 15:58:57 -0400
Received: by mail-wm1-x32c.google.com with SMTP id l15so731370wmh.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2NvrrI8MicF0C3jTH/XcjfnBlEaqInQJ7ttu1ardrzE=;
 b=KRKkWFT81ffVU78DMPXFowB8sWBRfvN0O0K120IVcNaxn2pKFZAKOdkXAoZfNP10k5
 J/r3zrl/ttpzofjSan7XEGQg8k1kWMc03C00tjdTlwOeWkpfL7aRx1PL5uMY00A3TkYC
 YIc24Em8ewH5ZR5FSImUIKYRvcFw8FrcAIj3dJKSczNLlqe2tVKlJPtsDjxi238oJlEg
 xYKlFn2/D4Gu0noCORXo3vKL44kFnYTgzli3WrM9TR+E8cTezemqq1ot6Jdq9olLqBdd
 bNW/8PyfRPjrGkhKWqMV3EZn2+fWyPrBl3DZI2TrBPA7wJcwdWCtp8R7/08X55v86vwg
 rrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2NvrrI8MicF0C3jTH/XcjfnBlEaqInQJ7ttu1ardrzE=;
 b=Ftn0q2Qq+aT+BC2Iao6W+w7rohHVqTJRoTVYyxR0GMomrJu2zI6iPP8XCts8HkngrM
 yxeoOxUYeqxJFvCRJ0QDYLeSpv0a5yOuujx/YlKHIv/Oh9a0dj1Zg6mlmSoPc0V4zIAk
 0pO9IKYxhcpl0/ZZQ78QI4wVIPCIgLo9nK13hbjxe+qXrNnAF0rQ083TE6VbqQbLMlXb
 kDimmn02jOfY4DQfMy+PWvijv1tlfQFltFzqRT2aH7vga4I1dblpEJ5dJHJkKRSfBm7t
 eK0WZqN1O5IRc2lEwec+MMuKGm1zhVX2HsZg4jENVWh97TqJcftsWbJCS359MdvEKhgq
 yISg==
X-Gm-Message-State: AOAM532A+lC0i9CEontOcwfo/COme6kKNN48clpmo6lzhi8Fbq7J/6Kq
 bW8wjZ6Q2YPMkH2AeCpo9ACbz45U794=
X-Google-Smtp-Source: ABdhPJy1NDL4Eas5jC5e485qCyDPMyDt75BfNrw2/t4XLV6ZoZEMVL+ISaXwMpRKGtANEQS6pZJruA==
X-Received: by 2002:a05:600c:297:: with SMTP id
 23mr4485741wmk.184.1601495932204; 
 Wed, 30 Sep 2020 12:58:52 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:75e3:aaa7:77d6:f4e4])
 by smtp.gmail.com with ESMTPSA id
 b64sm4824204wmh.13.2020.09.30.12.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 12:58:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/86] meson: move libudev test
Date: Wed, 30 Sep 2020 21:58:48 +0200
Message-Id: <20200930195850.278104-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930195850.278104-1-pbonzini@redhat.com>
References: <20200930195850.278104-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 14 --------------
 meson.build |  7 ++++---
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/configure b/configure
index f9e2f3de65..6f2599f99f 100755
--- a/configure
+++ b/configure
@@ -908,7 +908,6 @@ Linux)
   linux_user="yes"
   kvm="yes"
   QEMU_INCLUDES="-isystem ${source_path}/linux-headers -Ilinux-headers $QEMU_INCLUDES"
-  libudev="yes"
 ;;
 esac
 
@@ -6287,15 +6286,6 @@ if test "$libnfs" != "no" ; then
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
@@ -7456,10 +7446,6 @@ if test "$gcov" = "yes" ; then
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
index 975a187e2c..cd3d1ee260 100644
--- a/meson.build
+++ b/meson.build
@@ -257,8 +257,8 @@ if 'CONFIG_CURL' in config_host
                             link_args: config_host['CURL_LIBS'].split())
 endif
 libudev = not_found
-if 'CONFIG_LIBUDEV' in config_host
-  libudev = declare_dependency(link_args: config_host['LIBUDEV_LIBS'].split())
+if targetos == 'linux' and (have_system or have_tools)
+  libudev = dependency('libudev', static: enable_static)
 endif
 brlapi = not_found
 if 'CONFIG_BRLAPI' in config_host
@@ -440,6 +440,7 @@ has_gettid = cc.has_function('gettid')
 
 # Create config-host.h
 
+config_host_data.set('CONFIG_LIBUDEV', libudev.found())
 config_host_data.set('CONFIG_SDL', sdl.found())
 config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
 config_host_data.set('CONFIG_VNC', vnc.found())
@@ -1450,7 +1451,7 @@ summary_info += {'sheepdog support':  config_host.has_key('CONFIG_SHEEPDOG')}
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



