Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC0AC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 06:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA9E21D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 06:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mv66V7Ns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA9E21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLhC2-0002iN-7S
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 02:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim.cournoyer@gmail.com>)
 id 1kLdf9-0004L4-QK
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 22:40:43 -0400
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f]:40794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxim.cournoyer@gmail.com>)
 id 1kLdf7-00088G-2Q
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 22:40:43 -0400
Received: by mail-qv1-xf2f.google.com with SMTP id j3so616541qvi.7
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 19:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+T7swFY/5OL/bQ/lM0AT9E0hq6eUNp+O81f0PcvH+qg=;
 b=mv66V7Nsnj9D4BwTmcKdiHEeKi5284zMdh46qe806P6R4RWSv/peZyeIGPsKeQFYPY
 S3mX4tYhMjnCOmvJD5H/UN57aHYTum+oJ2MOXP4ONeVMBdfTgWl0sEpCU74CIx1sGdHo
 tRX0Y9A9nctapterDIC0wBXQAHE9nRXTV0GuSn9P3x1qe7sBbVdxEELdBxldKVj8FU3L
 FEFt6EWMKCm+I8AB4gQnWXfB64K6uRWw0SkHJlM9Se1AReIie82dZk8GGeebB0ig6wXf
 lPozpxLMjxI9CCbeEydM7ft7iUAXaygLsxPy3RyjAq380v1jLbvcQGv9kc4sibkNew1E
 zkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+T7swFY/5OL/bQ/lM0AT9E0hq6eUNp+O81f0PcvH+qg=;
 b=B+CtODs2UcC8wsCUCR9PYxydv4UMbvhEWR0i12Jbc9NxPGEyq1kupmcIOMm6JQ0Znu
 4su9kGF+Nxv4nPALfck6mqL2iJSviRVvkRi3ezRiyXS0Xrg4f42YkFj0QpwUvt8rJ0gk
 BFzv5aXv44Jy0A0iDTztgG225e5/NVvIDxMnVvcXHLBAqQBfD4Bqzt/NP1Z32EhWcFyU
 e2G78SOK2O6JEG+TN8d2AdGhksF0C3ArIbw62ySyqf2koprajQH3pOw2uDWYIePRZUED
 K1PvD9MVKFtfrpqIIboVo0k93Uw2tZvl8t8ujyU+MBcN4wBfagrJcvoSnBYNMks6UbjL
 nrxA==
X-Gm-Message-State: AOAM530GOi51gOej0/G6JutTrNDm3fjB2wanoiUMw34dvisn9/FIVPnt
 5nVm0SdilbzHkOlExRRtfJUmPJVA2pLkEw==
X-Google-Smtp-Source: ABdhPJxTyp9cmanyeL0Hu9CIJoMO4u5Jgny/wU4sSQFdnoPeYIQlcoO1VQQhOjpLgcpwC8Qb2+3qjA==
X-Received: by 2002:a0c:dd8d:: with SMTP id v13mr2315414qvk.22.1601001640093; 
 Thu, 24 Sep 2020 19:40:40 -0700 (PDT)
Received: from localhost.localdomain (dsl-10-130-151.b2b2c.ca. [72.10.130.151])
 by smtp.gmail.com with ESMTPSA id f14sm841913qkh.134.2020.09.24.19.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 19:40:39 -0700 (PDT)
From: Maxim Cournoyer <maxim.cournoyer@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] build: Build and install the info manual.
Date: Thu, 24 Sep 2020 22:41:43 -0400
Message-Id: <20200925024143.26492-1-maxim.cournoyer@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=maxim.cournoyer@gmail.com; helo=mail-qv1-xf2f.google.com
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
X-Mailman-Approved-At: Fri, 25 Sep 2020 02:23:46 -0400
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
Cc: Maxim Cournoyer <maxim.cournoyer@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Take advantage of the Sphinx texinfo backend to generate a QEMU info
manual.  The texinfo format allows for more structure and info readers
provide more advanced navigation capabilities compared to manpages
readers.

* configure (infodir): Add the --infodir option, which allows
configuring the directory under which the info manuals are installed.
* docs/index.rst: Include the top level documents to prevent
warnings (treated as errors by sphinx-build).
* docs/meson.build (sphinxinfo): Add new target.
---
 configure        |  3 +++
 docs/index.rst   |  2 ++
 docs/meson.build | 13 +++++++++++++
 meson.build      |  4 +++-
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index e8e8e984f2..9dfd10e063 100755
--- a/configure
+++ b/configure
@@ -1069,6 +1069,8 @@ for opt do
     static="yes"
     QEMU_PKG_CONFIG_FLAGS="--static $QEMU_PKG_CONFIG_FLAGS"
   ;;
+  --infodir=*) infodir="$optarg"
+  ;;
   --mandir=*) mandir="$optarg"
   ;;
   --bindir=*) bindir="$optarg"
@@ -1786,6 +1788,7 @@ Advanced options (experts only):
   --smbd=SMBD              use specified smbd [$smbd]
   --with-git=GIT           use specified git [$git]
   --static                 enable static build [$static]
+  --infodir=PATH           install info manual in PATH
   --mandir=PATH            install man pages in PATH
   --datadir=PATH           install firmware in PATH/$qemu_suffix
   --docdir=PATH            install documentation in PATH/$qemu_suffix
diff --git a/docs/index.rst b/docs/index.rst
index 763e3d0426..4f155b51d7 100644
--- a/docs/index.rst
+++ b/docs/index.rst
@@ -9,6 +9,7 @@ Welcome to QEMU's documentation!
 .. toctree::
    :maxdepth: 2
    :caption: Contents:
+   :glob:
 
    system/index
    user/index
@@ -16,3 +17,4 @@ Welcome to QEMU's documentation!
    interop/index
    specs/index
    devel/index
+   *
diff --git a/docs/meson.build b/docs/meson.build
index 50f367349b..eb94e4f3cf 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -32,10 +32,13 @@ if build_docs
 
   sphinxdocs = []
   sphinxmans = []
+  conf_py_files = [files('conf.py')]
+
   foreach manual : manuals
     private_dir = meson.current_build_dir() / (manual + '.p')
     output_dir = meson.current_build_dir() / manual
     input_dir = meson.current_source_dir() / manual
+    conf_py_files += files(manual / 'conf.py')
 
     this_manual = custom_target(manual + ' manual',
                 build_by_default: build_docs,
@@ -70,4 +73,14 @@ if build_docs
   endforeach
   alias_target('sphinxdocs', sphinxdocs)
   alias_target('man', sphinxmans)
+
+  sphinxinfo = custom_target(
+    'QEMU info manual generated source',
+    output: ['QEMU.texi', 'sphinxinfo.stamp'],
+    input: conf_py_files,
+    depfile: 'sphinxinfo.d',
+    command: [SPHINX_ARGS, '-Ddepfile=@DEPFILE@', '-Ddepfile_stamp=@OUTPUT1@',
+             '-b', 'texinfo',
+             meson.current_source_dir(), meson.current_build_dir()])
+  alias_target('sphinxinfo', sphinxinfo)
 endif
diff --git a/meson.build b/meson.build
index f4d1ab1096..4156b585ba 100644
--- a/meson.build
+++ b/meson.build
@@ -1218,6 +1218,7 @@ if build_docs
                                               'qemu_confdir': config_host['qemu_confdir']})
 
   texi = {
+    'QEMU': sphinxinfo,
     'qemu-qmp-ref': ['docs/interop/qemu-qmp-ref.texi', qapi_doc_texi, version_texi],
   }
   if 'CONFIG_GUEST_AGENT' in config_host
@@ -1241,7 +1242,8 @@ if build_docs
                       input: input,
                       output: output,
                       install: true,
-                      install_dir: qemu_docdir / 'interop',
+                      install_dir: ext == 'info' ? get_option('infodir') \
+                                                 : qemu_docdir / 'interop',
                       command: cmd + args)
       endforeach
       alias_target(ext, t)
-- 
2.28.0


