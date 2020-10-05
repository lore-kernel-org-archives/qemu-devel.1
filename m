Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025E0C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:29:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE152078D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHVDhFBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE152078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPLsT-0005zo-By
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmo-0007yD-JT
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:23:58 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:45639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmm-0007JT-As
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:23:58 -0400
Received: by mail-wr1-x433.google.com with SMTP id x14so8452935wrl.12
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xPg4vE2e5UT4bb6kQB9Bs7T3LhbhUL0NoEoeD9YeMoA=;
 b=iHVDhFBuafhsGjH3MK9fnXppNGLCsKXlN/l7D42Esgymgj4l+LDfBKAlxHXWCaKFLA
 p+R3S1r/ibBUSuF8YeHeHEHESrqtYga4CZhURkI1r98EVtH8w6r2T7Yp2rE7+7gYVcwO
 oFoHCVWY7yyPzeV9vRHnNo072qk86Gzgl7T+GdKHsTPmbmv5ctZpqP5GE/2u+hMMEFSG
 FFF9F2NaYbQDYcMdQxLDDn+dFDCeFL15waRoTUrPwIPoJGFG48V3ogBiQkMvliadhHnY
 zq0ebq9cNnM0+/y0siVtBmF0lLDrru7sEc7LxuHXgqyElmW3vn878HgEpjCrVn0GG/9S
 z4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xPg4vE2e5UT4bb6kQB9Bs7T3LhbhUL0NoEoeD9YeMoA=;
 b=AjdDjwpUN/CYDb2FBx8qPxeaIEmK9s3zDc60iCoe4PGqAEdP4hWKsK5k96nl8ctG+H
 ILQ15CJ2tw2pVzp+rEa52RmUP3v6AuFadk2owZ5hQsa3YUuvyxoOMLSUptxwbXGd5UQF
 ivWsgZK4/ahbuLV3jrkXxZHTNwkTbVjKhnjAbAcHFhhEYobNm6v8VAYbNLzT6najiGWN
 IwhGjTxb7ME55O7JAuG4qlIaN2Z0YTT3/Rlo2BPoy81WkpOQmNo1jDIAEzMS7uxfd0EJ
 Jeyk/Zn64id+eX5o96SdPleGdxs4NrdjkN55qAO2sQw2rEEJytzXGsZgUiVDpfjMA0Z8
 23MA==
X-Gm-Message-State: AOAM530sO1FCLg7CU+vuMeMvH0fg8w2DTJk4rxZwPJCQRaGC7qXcp4kb
 1uK+Sxn/iqBJYYSAK+PK222+IRbezHY=
X-Google-Smtp-Source: ABdhPJy0FViSG7BjL3+Tpp17KwkZQqyF1fTqUjP/Eoczj0JHZ7BHOokGyN2kZ3vP3NJXaMtShmzcVw==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr16133539wrt.84.1601886234348; 
 Mon, 05 Oct 2020 01:23:54 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id z15sm11931434wrv.94.2020.10.05.01.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 01:23:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/19] configure: compute derivatives of target name in meson
Date: Mon,  5 Oct 2020 10:23:37 +0200
Message-Id: <20201005082349.354095-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005082349.354095-1-pbonzini@redhat.com>
References: <20201005082349.354095-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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

Several CONFIG_* symbols in config-target.mak are easily computed from just
the target name.  We do not need them in config-target.mak, and can instead
place them in the config_target dictionary only.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 11 +----------
 meson.build | 27 ++++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/configure b/configure
index 2133239593..7058ac10e9 100755
--- a/configure
+++ b/configure
@@ -7599,7 +7599,6 @@ upper() {
 
 target_arch_name="$(upper $TARGET_ARCH)"
 echo "TARGET_$target_arch_name=y" >> $config_target_mak
-echo "TARGET_NAME=$target_name" >> $config_target_mak
 echo "TARGET_BASE_ARCH=$TARGET_BASE_ARCH" >> $config_target_mak
 if [ "$TARGET_ABI_DIR" = "" ]; then
   TARGET_ABI_DIR=$TARGET_ARCH
@@ -7617,21 +7616,15 @@ if test "$target_bigendian" = "yes" ; then
   echo "TARGET_WORDS_BIGENDIAN=y" >> $config_target_mak
 fi
 if test "$target_softmmu" = "yes" ; then
-  echo "CONFIG_SOFTMMU=y" >> $config_target_mak
   if test "$mttcg" = "yes" ; then
     echo "TARGET_SUPPORTS_MTTCG=y" >> $config_target_mak
   fi
 fi
 if test "$target_user_only" = "yes" ; then
-  echo "CONFIG_USER_ONLY=y" >> $config_target_mak
-  echo "CONFIG_QEMU_INTERP_PREFIX=\"$interp_prefix1\"" >> $config_target_mak
   symlink "../qemu-$target_name" "$target_dir/qemu-$target_name"
 else
   symlink "../qemu-system-$target_name" "$target_dir/qemu-system-$target_name"
 fi
-if test "$target_linux_user" = "yes" ; then
-  echo "CONFIG_LINUX_USER=y" >> $config_target_mak
-fi
 list=""
 if test ! -z "$gdb_xml_files" ; then
   for x in $gdb_xml_files; do
@@ -7643,9 +7636,6 @@ fi
 if test "$target_user_only" = "yes" && test "$bflt" = "yes"; then
   echo "TARGET_HAS_BFLT=y" >> $config_target_mak
 fi
-if test "$target_bsd_user" = "yes" ; then
-  echo "CONFIG_BSD_USER=y" >> $config_target_mak
-fi
 
 done # for target in $targets
 
@@ -7655,6 +7645,7 @@ fi
 if [ "$capstone" = "git" -o "$capstone" = "internal" ]; then
   subdirs="$subdirs capstone"
 fi
+echo "CONFIG_QEMU_INTERP_PREFIX=$interp_prefix" | sed 's/%M/@0@/' >> $config_host_mak
 echo "SUBDIRS=$subdirs" >> $config_host_mak
 if test -n "$LIBCAPSTONE"; then
   echo "LIBCAPSTONE=$LIBCAPSTONE" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 43ce1272b9..4de1524941 100644
--- a/meson.build
+++ b/meson.build
@@ -639,12 +639,15 @@ config_host_data.set('QEMU_VERSION_MAJOR', meson.project_version().split('.')[0]
 config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().split('.')[1])
 config_host_data.set('QEMU_VERSION_MICRO', meson.project_version().split('.')[2])
 
+ignored = ['CONFIG_QEMU_INTERP_PREFIX'] # actually per-target
 arrays = ['CONFIG_AUDIO_DRIVERS', 'CONFIG_BDRV_RW_WHITELIST', 'CONFIG_BDRV_RO_WHITELIST']
 strings = ['HOST_DSOSUF', 'CONFIG_IASL', 'bindir', 'prefix', 'qemu_confdir', 'qemu_datadir',
            'qemu_moddir', 'qemu_localstatedir', 'qemu_helperdir', 'qemu_localedir',
            'qemu_icondir', 'qemu_desktopdir', 'qemu_firmwarepath', 'sysconfdir']
 foreach k, v: config_host
-  if arrays.contains(k)
+  if ignored.contains(k)
+    # do nothing
+  elif arrays.contains(k)
     if v != ''
       v = '"' + '", "'.join(v.split()) + '", '
     endif
@@ -721,7 +724,23 @@ kconfig_external_symbols = [
 ignored = ['TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_DIRS']
 
 foreach target : target_dirs
-  config_target = keyval.load(meson.current_build_dir() / target / 'config-target.mak')
+  config_target = { 'TARGET_NAME': target.split('-')[0] }
+  if target.endswith('linux-user')
+    assert(targetos == 'linux')
+    config_target += { 'CONFIG_LINUX_USER': 'y' }
+  elif target.endswith('bsd-user')
+    assert('CONFIG_BSD' in config_host)
+    config_target += { 'CONFIG_BSD_USER': 'y' }
+  elif target.endswith('softmmu')
+    config_target += { 'CONFIG_SOFTMMU': 'y' }
+  endif
+  if target.endswith('-user')
+    config_target += {
+      'CONFIG_USER_ONLY': 'y',
+      'CONFIG_QEMU_INTERP_PREFIX':
+        config_host['CONFIG_QEMU_INTERP_PREFIX'].format(config_target['TARGET_NAME'])
+    }
+  endif
 
   have_accel = false
   foreach sym: accelerators
@@ -736,6 +755,8 @@ foreach target : target_dirs
   endforeach
   assert(have_accel)
 
+  config_target += keyval.load('default-configs/targets' / target + '.mak')
+
   foreach k, v: disassemblers
     if config_host['ARCH'].startswith(k) or config_target['TARGET_BASE_ARCH'].startswith(k)
       foreach sym: v
@@ -753,7 +774,7 @@ foreach target : target_dirs
       # do nothing
     elif k == 'TARGET_BASE_ARCH'
       config_target_data.set('TARGET_' + v.to_upper(), 1)
-    elif k == 'TARGET_NAME'
+    elif k == 'TARGET_NAME' or k == 'CONFIG_QEMU_INTERP_PREFIX'
       config_target_data.set_quoted(k, v)
     elif v == 'y'
       config_target_data.set(k, 1)
-- 
2.26.2



