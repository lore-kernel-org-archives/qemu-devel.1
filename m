Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3580AC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB06206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0hZRf7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB06206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2Ty-0005LT-53
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KT-0003Xp-Jw
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52831
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KR-0006rS-LF
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598951507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Q/ZAsSwM+WifqfwQlCrXnImFd901hQ55k1t7JbU36Q=;
 b=f0hZRf7xg4XHPm4EBhPQTY+PTRddLeuSCMoElu2JfB1Lcz3HYpZrhBbHQL/+Mwu0Q9pO8J
 E+RmsIjJVMymZouB6WvFu0AikhV6GI6CFOKkOKZ8uYpS/uuLXwOoJsqRpfxQ7T667g62KE
 09P1dtcPSfRm1UlPo/vd7p+PMF1rjqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-8hIEIB2gMzSakQeNw7WkaQ-1; Tue, 01 Sep 2020 05:11:43 -0400
X-MC-Unique: 8hIEIB2gMzSakQeNw7WkaQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC3CF801AE2
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2020 09:11:42 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D73B60C04;
 Tue,  1 Sep 2020 09:11:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/24] meson: pass docdir option
Date: Tue,  1 Sep 2020 05:11:24 -0400
Message-Id: <20200901091132.29601-17-pbonzini@redhat.com>
In-Reply-To: <20200901091132.29601-1-pbonzini@redhat.com>
References: <20200901091132.29601-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When cross-compiling, by default qemu_docdir is 'c:\Program Files\QEMU\'
which is not recognized as being an absolute path, and meson will end up
adding the prefix again.

Add an option to pass docdir location to meson, pre-prefixed like we do
with other directories, build qemu_docdir with the common suffix and use
that instead of config_host['qemu_docdir'].

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200826110419.528931-7-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure         | 2 +-
 docs/meson.build  | 4 ++--
 meson.build       | 4 +++-
 meson_options.txt | 2 ++
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index 78aae9c2a0..1f478a46a9 100755
--- a/configure
+++ b/configure
@@ -6653,7 +6653,6 @@ echo "sysconfdir=$sysconfdir" >> $config_host_mak
 echo "qemu_confdir=$qemu_confdir" >> $config_host_mak
 echo "qemu_datadir=$qemu_datadir" >> $config_host_mak
 echo "qemu_firmwarepath=$firmwarepath" >> $config_host_mak
-echo "qemu_docdir=$qemu_docdir" >> $config_host_mak
 echo "qemu_moddir=$qemu_moddir" >> $config_host_mak
 if test "$mingw32" = "no" ; then
   echo "qemu_localstatedir=$local_statedir" >> $config_host_mak
@@ -8198,6 +8197,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         --mandir "${pre_prefix}$mandir" \
         --sysconfdir "${pre_prefix}$sysconfdir" \
         --localstatedir "${pre_prefix}$local_statedir" \
+        -Ddocdir="${pre_prefix}$docdir" \
         -Dqemu_suffix="$qemu_suffix" \
         -Doptimization=$(if test "$debug" = yes; then echo 0; else echo 2; fi) \
         -Ddebug=$(if test "$debug_info" = yes; then echo true; else echo false; fi) \
diff --git a/docs/meson.build b/docs/meson.build
index 8b059a8e39..50f367349b 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -10,7 +10,7 @@ if build_docs
   configure_file(output: 'index.html',
                  input: files('index.html.in'),
                  configuration: {'VERSION': meson.project_version()},
-                 install_dir: config_host['qemu_docdir'])
+                 install_dir: qemu_docdir)
   manuals = [ 'devel', 'interop', 'tools', 'specs', 'system', 'user' ]
   man_pages = {
     'interop' : {
@@ -48,7 +48,7 @@ if build_docs
                           input_dir, output_dir])
     sphinxdocs += this_manual
     if build_docs and manual != 'devel'
-      install_subdir(output_dir, install_dir: config_host['qemu_docdir'])
+      install_subdir(output_dir, install_dir: qemu_docdir)
     endif
 
     these_man_pages = []
diff --git a/meson.build b/meson.build
index bf6d1b3153..43e2c6e43d 100644
--- a/meson.build
+++ b/meson.build
@@ -19,6 +19,7 @@ enable_modules = 'CONFIG_MODULES' in config_host
 enable_static = 'CONFIG_STATIC' in config_host
 build_docs = 'BUILD_DOCS' in config_host
 qemu_datadir = get_option('datadir') / get_option('qemu_suffix')
+qemu_docdir = get_option('docdir') / get_option('qemu_suffix')
 config_host_data = configuration_data()
 genh = []
 
@@ -1182,7 +1183,7 @@ if build_docs
                       input: input,
                       output: output,
                       install: true,
-                      install_dir: config_host['qemu_docdir'] / 'interop',
+                      install_dir: qemu_docdir / 'interop',
                       command: cmd + args)
       endforeach
       alias_target(ext, t)
@@ -1245,6 +1246,7 @@ if targetos != 'windows'
 else
   summary_info += {'local state directory': 'queried at runtime'}
 endif
+summary_info += {'Doc directory':     get_option('docdir')}
 summary_info += {'Build directory':   meson.current_build_dir()}
 summary_info += {'Source path':       meson.current_source_dir()}
 summary_info += {'GIT binary':        config_host['GIT']}
diff --git a/meson_options.txt b/meson_options.txt
index f4275691bd..c3120fa359 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -1,5 +1,7 @@
 option('qemu_suffix', type : 'string', value: 'qemu',
        description: 'Suffix for QEMU data/modules/config directories (can be empty)')
+option('docdir', type : 'string', value : 'doc',
+       description: 'Base directory for documentation installation (can be empty)')
 option('gettext', type : 'boolean', value : true)
 option('sdl', type : 'feature', value : 'auto')
 option('sdl_image', type : 'feature', value : 'auto')
-- 
2.26.2



