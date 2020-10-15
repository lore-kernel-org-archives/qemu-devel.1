Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075A0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EFB820725
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqjEtqi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFB820725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT9eW-0003US-0K
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 16:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kT9ab-0007In-Cr
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 16:11:05 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:43881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kT9aW-0001jp-S7
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 16:11:04 -0400
Received: by mail-pf1-x42a.google.com with SMTP id a200so73063pfa.10
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 13:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CzNs/YN8L1Kjuoo27oaR8flYu8s2Nc26UZiNRlhmaFI=;
 b=dqjEtqi4PcJj4ouWzODnoQHEHPChrkB3rMPvwiNnedX4DTkH9vWb/pVOkPaTdli6SQ
 MM1J43GnSqr7RnvWjx4Xj3I9e/yEIlrJr6RMcZCaEprX2NjxTWa1StWEK1YCOHNt2c2L
 vk3sR7JMiHO/X9Vyv9R+0PqujH7sOyLv5fbjTuscF6jH2iU6t5DsnBh1hZFQgqM0sNDT
 73uCBgcxIr93pEmDj2t9KvwYA7XxH2KVemsa89R8qsDC9C0qDutjPJNeaTZ/XSZiVtjr
 DXMoKpi7d8BcbGsgttA8oD8fnoyGaeY/tbPAMkdEuxuUVpNoibKksOWiElSY8wYGmXsQ
 Tg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CzNs/YN8L1Kjuoo27oaR8flYu8s2Nc26UZiNRlhmaFI=;
 b=DecJywO8Rxo3yEE2vtXDOMPDD9gl9d61qD0cctaqAJkD73lQEkD6S2ReOmzE4jE6Yo
 u2QPSBsfLm9P/TH81iloNRnxG7bt0/eCR+E6jx3JAoptf1CtpmUI/qKEkjgQLqtAa0Ji
 rOUsTHydrTNqta0ZsBU39WmbhUsUtxKREJaEvA7Ciwv72FcKZfPYV0iUUxCZUJ7HQ7y/
 vINsk6wp0AoNifs0vOVG0hCWCbK25H9trAVVclNM153uWhAY91D/mfdLC2Ekp6aN16+V
 R0BLih0RZzOvfWPMobD4+E6hRquY1xhHKopuvWB0ZaFyXsXxLAVVQkqpR8VW9mEEEBnP
 VrrA==
X-Gm-Message-State: AOAM532mHgk9TVGjng48DFeAgwoZ9j0ds87PsBaB1/wtx9XEcq7LL3nv
 jdiDQaHx8a1KqpwUe8mYMExy6L8NO6ZYxgij
X-Google-Smtp-Source: ABdhPJySkK+LJwzSdgf9tMkCdmfZkvlgis4pdptt0oCt2QScoBMBOOrsxL9YVE71hNCue428LZRqjg==
X-Received: by 2002:a65:53cc:: with SMTP id z12mr200041pgr.333.1602792658147; 
 Thu, 15 Oct 2020 13:10:58 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x18sm104734pfj.90.2020.10.15.13.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 13:10:57 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] meson: Move the detection logic for sphinx to meson
Date: Fri, 16 Oct 2020 04:10:34 +0800
Message-Id: <20201015201035.1964-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201015201035.1964-1-luoyonggang@gmail.com>
References: <20201015201035.1964-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 configure                     | 59 +++--------------------------------
 docs/meson.build              |  4 +--
 meson.build                   | 59 ++++++++++++++++++++++++++++++-----
 meson_options.txt             |  5 ++-
 tests/qapi-schema/meson.build |  2 +-
 5 files changed, 63 insertions(+), 66 deletions(-)

diff --git a/configure b/configure
index 1ce31f97b4..ff593a8542 100755
--- a/configure
+++ b/configure
@@ -297,7 +297,7 @@ brlapi=""
 curl=""
 iconv="auto"
 curses="auto"
-docs=""
+docs="auto"
 fdt="auto"
 netmap="no"
 sdl="auto"
@@ -822,15 +822,6 @@ do
     fi
 done
 
-sphinx_build=
-for binary in sphinx-build-3 sphinx-build
-do
-    if has "$binary"
-    then
-        sphinx_build=$(command -v "$binary")
-        break
-    fi
-done
 
 # Check for ancillary tools used in testing
 genisoimage=
@@ -1226,9 +1217,9 @@ for opt do
   ;;
   --disable-crypto-afalg) crypto_afalg="no"
   ;;
-  --disable-docs) docs="no"
+  --disable-docs) docs="disabled"
   ;;
-  --enable-docs) docs="yes"
+  --enable-docs) docs="enabled"
   ;;
   --disable-vhost-net) vhost_net="no"
   ;;
@@ -4413,45 +4404,6 @@ if check_include linux/btrfs.h ; then
     btrfs=yes
 fi
 
-# If we're making warnings fatal, apply this to Sphinx runs as well
-sphinx_werror=""
-if test "$werror" = "yes"; then
-    sphinx_werror="-W"
-fi
-
-# Check we have a new enough version of sphinx-build
-has_sphinx_build() {
-    # This is a bit awkward but works: create a trivial document and
-    # try to run it with our configuration file (which enforces a
-    # version requirement). This will fail if either
-    # sphinx-build doesn't exist at all or if it is too old.
-    mkdir -p "$TMPDIR1/sphinx"
-    touch "$TMPDIR1/sphinx/index.rst"
-    "$sphinx_build" $sphinx_werror -c "$source_path/docs" \
-                    -b html "$TMPDIR1/sphinx" \
-                    "$TMPDIR1/sphinx/out"  >> config.log 2>&1
-}
-
-# Check if tools are available to build documentation.
-if test "$docs" != "no" ; then
-  if has_sphinx_build; then
-    sphinx_ok=yes
-  else
-    sphinx_ok=no
-  fi
-  if test "$sphinx_ok" = "yes"; then
-    docs=yes
-  else
-    if test "$docs" = "yes" ; then
-      if has $sphinx_build && test "$sphinx_ok" != "yes"; then
-        echo "Warning: $sphinx_build exists but it is either too old or uses too old a Python version" >&2
-      fi
-      feature_not_found "docs" "Install a Python 3 version of python-sphinx"
-    fi
-    docs=no
-  fi
-fi
-
 # Search for bswap_32 function
 byteswap_h=no
 cat > $TMPC << EOF
@@ -6087,9 +6039,6 @@ qemu_version=$(head $source_path/VERSION)
 echo "PKGVERSION=$pkgversion" >>$config_host_mak
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
-if [ "$docs" = "yes" ] ; then
-  echo "BUILD_DOCS=yes" >> $config_host_mak
-fi
 if test "$modules" = "yes"; then
   # $shacmd can generate a hash started with digit, which the compiler doesn't
   # like as an symbol. So prefix it with an underscore
@@ -6794,7 +6743,6 @@ fi
 echo "ROMS=$roms" >> $config_host_mak
 echo "MAKE=$make" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
-echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "MESON=$meson" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
@@ -7076,6 +7024,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
         -Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt \
         -Diconv=$iconv -Dcurses=$curses \
+        -Ddocs=$docs -Dsphinx_build=$sphinx_build \
         $cross_arg \
         "$PWD" "$source_path"
 
diff --git a/docs/meson.build b/docs/meson.build
index 0340d489ac..f566809a6a 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -37,7 +37,7 @@ if build_docs
                 input: [files('conf.py'), files(manual / 'conf.py')],
                 depfile: manual + '.d',
                 depend_files: sphinx_extn_depends,
-                command: [SPHINX_ARGS, '-Ddepfile=@DEPFILE@',
+                command: SPHINX_ARGS + ['-Ddepfile=@DEPFILE@',
                           '-Ddepfile_stamp=@OUTPUT0@',
                           '-b', 'html', '-d', private_dir,
                           input_dir, output_dir])
@@ -59,7 +59,7 @@ if build_docs
                          input: this_manual,
                          install: build_docs,
                          install_dir: install_dirs,
-                         command: [SPHINX_ARGS, '-b', 'man', '-d', private_dir,
+                         command: SPHINX_ARGS + ['-b', 'man', '-d', private_dir,
                                    input_dir, meson.current_build_dir()])
     endif
   endforeach
diff --git a/meson.build b/meson.build
index 8156df8b71..3cf54d82f6 100644
--- a/meson.build
+++ b/meson.build
@@ -17,7 +17,13 @@ cc = meson.get_compiler('c')
 config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
 enable_modules = 'CONFIG_MODULES' in config_host
 enable_static = 'CONFIG_STATIC' in config_host
-build_docs = 'BUILD_DOCS' in config_host
+
+# Temporary directory used for files created while
+# configure runs. Since it is in the build directory
+# we can safely blow away any previous version of it
+# (and we need not jump through hoops to try to delete
+# it when configure exits.)
+tmpdir = meson.current_build_dir() / 'config-temp'
 
 if get_option('qemu_suffix').startswith('/')
   error('qemu_suffix cannot start with a /')
@@ -1235,14 +1241,53 @@ foreach d : hx_headers
 endforeach
 genh += hxdep
 
-SPHINX_ARGS = [config_host['SPHINX_BUILD'],
-               '-Dversion=' + meson.project_version(),
-               '-Drelease=' + config_host['PKGVERSION']]
+sphinx_build = not_found
+sphinx_build_option = get_option('sphinx_build')
+if sphinx_build_option == ''
+  sphinx_build = find_program('sphinx-build', required: false)
+else
+  sphinx_build = find_program(sphinx_build_option, required: false)
+endif
 
+SPHINX_TEST_ARGS = []
+# If we're making warnings fatal, apply this to Sphinx runs as well
 if get_option('werror')
-  SPHINX_ARGS += [ '-W' ]
+  SPHINX_TEST_ARGS += [ '-W' ]
+endif
+
+build_docs = false
+docs_option = get_option('docs')
+# Check if tools are available to build documentation.
+if sphinx_build.found() and not docs_option.disabled()
+    # This is a bit awkward but works: create a trivial document and
+    # try to run it with our configuration file (which enforces a
+    # version requirement). This will fail if either
+    # sphinx-build doesn't exist at all or if it is too old.
+    run_command('mkdir', ['-p', tmpdir / 'sphinx'])
+    run_command('touch', [tmpdir / 'sphinx/index.rst'])
+    sphinx_build_test_out = run_command(sphinx_build, SPHINX_TEST_ARGS + [
+      '-c', meson.current_source_dir() / 'docs',
+      '-b', 'html', tmpdir / 'sphinx',
+      tmpdir / 'sphinx/out'])
+    message(sphinx_build_test_out.stderr())
+    message(sphinx_build_test_out.stdout())
+    if sphinx_build_test_out.returncode() == 0
+      build_docs = true
+    else
+      if docs_option.enabled()
+        if sphinx_build_option != ''
+          warning('Warning: @0@ exists but it is either too old or uses too old a Python version'.format(sphinx_build_option))
+        endif
+        error('Warning: Install a Python 3 version of python-sphinx')
+      endif
+      # do not building docs
+    endif
 endif
 
+SPHINX_ARGS = [sphinx_build]
+SPHINX_ARGS += SPHINX_TEST_ARGS
+SPHINX_ARGS += ['-Dversion=' + meson.project_version(), '-Drelease=' + config_host['PKGVERSION']]
+
 sphinx_extn_depends = [ meson.source_root() / 'docs/sphinx/depfile.py',
                         meson.source_root() / 'docs/sphinx/hxtool.py',
                         meson.source_root() / 'docs/sphinx/kerneldoc.py',
@@ -1918,7 +1963,7 @@ summary_info += {'QEMU_CFLAGS':       config_host['QEMU_CFLAGS']}
 summary_info += {'QEMU_LDFLAGS':      config_host['QEMU_LDFLAGS']}
 summary_info += {'make':              config_host['MAKE']}
 summary_info += {'python':            '@0@ (version: @1@)'.format(python.full_path(), python.language_version())}
-summary_info += {'sphinx-build':      config_host['SPHINX_BUILD']}
+summary_info += {'sphinx-build':      sphinx_build.found()}
 summary_info += {'genisoimage':       config_host['GENISOIMAGE']}
 # TODO: add back version
 summary_info += {'slirp support':     slirp_opt == 'disabled' ? false : slirp_opt}
@@ -1986,7 +2031,7 @@ if config_host.has_key('CONFIG_XEN_BACKEND')
   summary_info += {'xen ctrl version':  config_host['CONFIG_XEN_CTRL_INTERFACE_VERSION']}
 endif
 summary_info += {'brlapi support':    config_host.has_key('CONFIG_BRLAPI')}
-summary_info += {'Documentation':     config_host.has_key('BUILD_DOCS')}
+summary_info += {'Documentation':     build_docs}
 summary_info += {'PIE':               get_option('b_pie')}
 summary_info += {'vde support':       config_host.has_key('CONFIG_VDE')}
 summary_info += {'netmap support':    config_host.has_key('CONFIG_NETMAP')}
diff --git a/meson_options.txt b/meson_options.txt
index e6cb1e589b..0e3fa7136b 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -1,8 +1,11 @@
 option('qemu_suffix', type : 'string', value: 'qemu',
        description: 'Suffix for QEMU data/modules/config directories (can be empty)')
+option('docs', type : 'feature', value : 'auto',
+       description: 'Documentations build support')
 option('docdir', type : 'string', value : 'doc',
        description: 'Base directory for documentation installation (can be empty)')
-
+option('sphinx_build', type : 'string', value : '',
+       description: 'Use specified sphinx-build [$sphinx_build] for building document (default to be empty)')
 option('gettext', type : 'boolean', value : true,
        description: 'Localization of the GTK+ user interface')
 option('sparse', type : 'feature', value : 'auto',
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index 20a7641af8..e36079cece 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -237,7 +237,7 @@ qapi_doc_out = custom_target('QAPI rST doc',
                              # we want it to always really run the QAPI doc
                              # generation code. It also means we don't
                              # clutter up the build dir with the cache.
-                             command: [SPHINX_ARGS,
+                             command:  SPHINX_ARGS + [
                                        '-b', 'text', '-E',
                                        '-c', meson.source_root() / 'docs',
                                        '-D', 'master_doc=doc-good',
-- 
2.28.0.windows.1


