Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDE5C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B931206F4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyU213aW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B931206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhrZ-00045Y-Aq
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQH-0002vB-Ux
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:09 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:43086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQF-0001Sp-U4
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:09 -0400
Received: by mail-wr1-x42b.google.com with SMTP id g12so6786389wrp.10
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QD62H5XkAmpd2dqgC0nz663beoGd0ich9bGXwmd81oM=;
 b=ZyU213aWb/FUh7lDABIArF7Qyn6GBo/fEcAf4QoVMz2rBRatuR3k+8z2H+Ls+83Vz1
 uC2Krdmx/oAQnxuJqvpYYgZoX3NgABvh4MqVztmpQHI1J7JkbxRofxAlvzzx9Q6P8jqa
 GE7t3zBOpDdBhWtiYlH2Z7+5HaK0NE3/TcTTjijkJM8B/3GyVcIaFhAHVbXJSgrNnbA0
 xvcOREczN0Xi3KEkS5zdyAXVStoc6t3IOOr17MyLwdfptyrp9YzzwwirEQNUO0OasZcF
 cdvxTgaWRuVyhZ71qw6sIO20Ub6T1t8f1FkWXvJw50nQqhGtc24FLajIP1lrVfW9Z1BL
 GiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QD62H5XkAmpd2dqgC0nz663beoGd0ich9bGXwmd81oM=;
 b=jWgV+CFPoZ6eejDAV6gaWQEfaQYVWUdXlyqEUSRwmxmEznW9P+wnLtcDgMxg35Tt+I
 /C3rFtTazKTt/TpdN8qPAEwouZZnzaoFufveJkRVEoO909KtxNTYdojJPlZmwZBR6l1l
 VALMDMRfyqonrjA3SPrgkTrrPe3DOI8q6kXrJzVgcTmkZlnY5GWCZ01oHRbOl0WPtv5A
 ZJTuSz42SPySoGsDomo8G//Kc8FpCgYoLQ77EP2ZEsRE9mAxaU9bZ/RZNP3lBB4W76uk
 MfNga8ISl3skMYP17GSwv7lmEwGPRBV01chGvfSs7XOklx3BNcROEEGdLeLS70StyyCP
 /3aQ==
X-Gm-Message-State: AOAM533Bee9/u30tDpCJM97TJdBxPYxjabvjsTI8M1fblPF8t+Jgw555
 v9oaVDyFNC3RHk6LSt12miaivXdVNF4=
X-Google-Smtp-Source: ABdhPJwXIgZ+eC+ZPkFFuy1qZ0WVh+wwNkIh0jrLe9LW77PDPVEFLnSNbMpj8rbwunDHf115eas5dg==
X-Received: by 2002:a5d:51ca:: with SMTP id n10mr3339504wrv.222.1601969406311; 
 Tue, 06 Oct 2020 00:30:06 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:30:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/37] configure: consistently pass CFLAGS/CXXFLAGS/LDFLAGS to
 meson
Date: Tue,  6 Oct 2020 09:29:32 +0200
Message-Id: <20201006072947.487729-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Environment variables like CFLAGS are easy to accidentally change.  Meson
warns if that happens, but in a project with a lot of configuration that
is easy to lose.  It is also surprising behavior since meson caches -D
options and remembers those on reconfiguration (which we rely on,
since configure options become -D options).

By placing the user-provided CFLAGS, CXXFLAGS and LDFLAGS in the
cross file, we at least get consistent behavior.  These environment
variables are still ugly and not really recommended, but there are
distros that rely on them.  For the gory details, refer to
https://github.com/mesonbuild/meson/issues/4664.

Tested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200923092617.1593722-5-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 25 +++++++++++++++----------
 meson.build | 14 ++++++++++++--
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/configure b/configure
index 1b173276ea..04c8cc017c 100755
--- a/configure
+++ b/configure
@@ -7130,24 +7130,29 @@ echo "export PYTHON='$python'" >> "$iotests_common_env"
 if test "$skip_meson" = no; then
 cross="config-meson.cross.new"
 meson_quote() {
-    echo "['$(echo $* | sed "s/ /','/g")']"
+    echo "'$(echo $* | sed "s/ /','/g")'"
 }
 
 echo "# Automatically generated by configure - do not modify" > $cross
 echo "[properties]" >> $cross
 test -z "$cxx" && echo "link_language = 'c'" >> $cross
+echo "[built-in options]" >> $cross
+echo "c_args = [${CFLAGS:+$(meson_quote $CFLAGS)}]" >> $cross
+echo "cpp_args = [${CXXFLAGS:+$(meson_quote $CXXFLAGS)}]" >> $cross
+echo "c_link_args = [${LDFLAGS:+$(meson_quote $LDFLAGS)}]" >> $cross
+echo "cpp_link_args = [${LDFLAGS:+$(meson_quote $LDFLAGS)}]" >> $cross
 echo "[binaries]" >> $cross
-echo "c = $(meson_quote $cc)" >> $cross
-test -n "$cxx" && echo "cpp = $(meson_quote $cxx)" >> $cross
-echo "ar = $(meson_quote $ar)" >> $cross
-echo "nm = $(meson_quote $nm)" >> $cross
-echo "pkgconfig = $(meson_quote $pkg_config_exe)" >> $cross
-echo "ranlib = $(meson_quote $ranlib)" >> $cross
+echo "c = [$(meson_quote $cc)]" >> $cross
+test -n "$cxx" && echo "cpp = [$(meson_quote $cxx)]" >> $cross
+echo "ar = [$(meson_quote $ar)]" >> $cross
+echo "nm = [$(meson_quote $nm)]" >> $cross
+echo "pkgconfig = [$(meson_quote $pkg_config_exe)]" >> $cross
+echo "ranlib = [$(meson_quote $ranlib)]" >> $cross
 if has $sdl2_config; then
-  echo "sdl2-config = $(meson_quote $sdl2_config)" >> $cross
+  echo "sdl2-config = [$(meson_quote $sdl2_config)]" >> $cross
 fi
-echo "strip = $(meson_quote $strip)" >> $cross
-echo "windres = $(meson_quote $windres)" >> $cross
+echo "strip = [$(meson_quote $strip)]" >> $cross
+echo "windres = [$(meson_quote $windres)]" >> $cross
 if test -n "$cross_prefix"; then
     cross_arg="--cross-file config-meson.cross"
     echo "[host_machine]" >> $cross
diff --git a/meson.build b/meson.build
index 8904f7d79b..17c89c87c6 100644
--- a/meson.build
+++ b/meson.build
@@ -1771,8 +1771,18 @@ if targetos == 'darwin'
   summary_info += {'Objective-C compiler': meson.get_compiler('objc').cmd_array()[0]}
 endif
 summary_info += {'ARFLAGS':           config_host['ARFLAGS']}
-summary_info += {'CFLAGS':            '-O' + get_option('optimization')
-                                           + (get_option('debug') ? ' -g' : '')}
+summary_info += {'CFLAGS':            ' '.join(get_option('c_args')
+                                               + ['-O' + get_option('optimization')]
+                                               + (get_option('debug') ? ['-g'] : []))}
+if link_language == 'cpp'
+  summary_info += {'CXXFLAGS':        ' '.join(get_option('cpp_args')
+                                               + ['-O' + get_option('optimization')]
+                                               + (get_option('debug') ? ['-g'] : []))}
+endif
+link_args = get_option(link_language + '_link_args')
+if link_args.length() > 0
+  summary_info += {'LDFLAGS':         ' '.join(link_args)}
+endif
 summary_info += {'QEMU_CFLAGS':       config_host['QEMU_CFLAGS']}
 summary_info += {'QEMU_LDFLAGS':      config_host['QEMU_LDFLAGS']}
 summary_info += {'make':              config_host['MAKE']}
-- 
2.26.2



