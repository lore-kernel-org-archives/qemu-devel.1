Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E98C468C1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD70F20859
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DcWSN1C3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD70F20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46678 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haKfM-0006i7-LZ
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 09:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49906)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haKcU-0005Nn-9Q
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:45:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haKcR-0006cd-Qu
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:45:54 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38435)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haKcR-0006bY-E8
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:45:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id d18so9253410wrs.5
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 06:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EIjpDnN+RcNXCO5v9exrQGRfBzsGI5s/bm2XxXDBCuU=;
 b=DcWSN1C30XyYlS6Uifx4TzYH9+UqIdRjXLjodlhe9LGzZV27PYud97qKdGlYdc0Hk+
 3t8I3vWz1NolkGHLG6YTjUj0ZlcHvg9V/Jmt3LXctsynmyzZ4xsyss4rkXwoAxxdRxBp
 nHnzWhZB0kRhbEiJnQj+uhwVsnUtGJKQNhbrxkkiyk/ZEw+TExYaSixuaUiU4Of6tklu
 p9yxWRAfsRDKSTsF6wX6YF3rY8G7GF/IHx9eGt1FW7/RC82nKqKPyZP01DW6ClNGx5RH
 xD0cs24UmozDTug+R/ZFMi3mxWjXs6mVpH4nM5TARde/ytgfDMs3Z9HjOpvTePUSR7xA
 j2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EIjpDnN+RcNXCO5v9exrQGRfBzsGI5s/bm2XxXDBCuU=;
 b=DlSRDTuVgwfdTazmgsSQBYvSGbsn6KgN20VP2zXQPRHI/fmjPAQ1Z2TRi0Pt2DqfYC
 eszI/x7PnfXH0Vts3mHiWio0baFLyczfsdbZAvaqkhf/GJl1brw32dZqzpJ+qRVnZVJZ
 CX0N2EfsJBmZJY4iCHd7V/wndY7Ipcz1TGVxynA/rFxo/88X9yACCyc56a+MSeVGn8kc
 H7HWO38hPcinJ4Y/djBTIeKGleEvM/6AI5cJWTux3eHXUauf4ZN6EDYyuhqS5dyns14z
 NZjAJW5oxXqhTgj8N/IzZvlhmiEcdRn05PxO8W19ShqrnKHO2nPe1kYaTheLBNNp2Xsl
 hxaw==
X-Gm-Message-State: APjAAAXV8crrkFIwLIizJfSX94scyrGjS5lwhAIo4Ely7Q9px3DhVdJf
 oIBEiGEsldR0oYoVhJxkiqTKJ2PWV/7PRA==
X-Google-Smtp-Source: APXvYqw79ejAu2JcRAMncu/+HeFyZXoHQDRjzrbjhRGKMQvroX0AQHKuPT3ccA58ZB2IbTFKcUhLJg==
X-Received: by 2002:adf:df91:: with SMTP id z17mr38704124wrl.336.1560174348363; 
 Mon, 10 Jun 2019 06:45:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id l18sm8753158wrv.38.2019.06.10.06.45.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 06:45:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 14:45:45 +0100
Message-Id: <20190610134545.3743-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH] qemu-ga: Convert invocation documentation to
 rST
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qemu-ga documentation is currently in qemu-ga.texi in
Texinfo format, which we present to the user as:
 * a qemu-ga manpage
 * a section of the main qemu-doc HTML documentation

Convert the documentation to rST format, and present it to
the user as:
 * a qemu-ga manpage
 * part of the interop/ Sphinx manual

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is part of my general proposals about how we should
transition away from texinfo to sphinx (written up at
https://wiki.qemu.org/Features/Documentation). It's the
first part of step 3 (convert standalone manpages), so it's
interesting as a demonstration of Sphinx generating manpages
as well as HTML. The format of the output manpage is broadly
the same, though there are a few minor differences because
rST doesn't support quite the same kinds of output. (It also
fixes a bug where the current manpage renders some text intended
to be in bold as literally "B<unix-listen>".)

Having the infrastructure for creating a simple manpage via
Sphinx should be a useful assist for the work in step 1 of the
transition plan that involves conversion of the auto-generated
qemu-ga-ref and qemu-qmp-ref (which need to produce manpages).

The non-manpage HTML version of the doc moves from qemu-doc.html
into docs/interop/ (its final location in the new 5-manual setup).

 Makefile                 |  13 ++--
 MAINTAINERS              |   2 +-
 docs/conf.py             |  18 ++---
 docs/interop/conf.py     |   7 ++
 docs/interop/index.rst   |   1 +
 docs/interop/qemu-ga.rst | 133 +++++++++++++++++++++++++++++++++++++
 qemu-doc.texi            |   5 --
 qemu-ga.texi             | 137 ---------------------------------------
 8 files changed, 161 insertions(+), 155 deletions(-)
 create mode 100644 docs/interop/qemu-ga.rst
 delete mode 100644 qemu-ga.texi

diff --git a/Makefile b/Makefile
index 8e2fc6624c3..cdada210746 100644
--- a/Makefile
+++ b/Makefile
@@ -329,7 +329,7 @@ endif
 endif
 
 ifdef BUILD_DOCS
-DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga.8
+DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 docs/interop/qemu-ga.8
 DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
 DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
 DOCS+=docs/qemu-block-drivers.7
@@ -804,7 +804,7 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_DATA) scripts/qemu-trace-stap.1 "$(DESTDIR)$(mandir)/man1"
 endif
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
-	$(INSTALL_DATA) qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
+	$(INSTALL_DATA) docs/interop/qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
 	$(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) docs/interop/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) docs/interop/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"
@@ -969,12 +969,18 @@ build-manual = $(call quiet-command,sphinx-build $(if $(V),,-q) -W -n -b html -D
 # We assume all RST files in the manual's directory are used in it
 manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
 
+# Canned command to build manpages from a single manual
+build-manpages = $(call quiet-command,CONFDIR="$(qemu_confdir)" sphinx-build $(if $(V),,-q) -W -n -b man -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
+
 $(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
 	$(call build-manual,devel)
 
 $(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
 	$(call build-manual,interop)
 
+$(MANUAL_BUILDDIR)/interop/qemu-ga.8: $(call manual-deps,interop)
+	$(call build-manpages,interop)
+
 qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
 
@@ -998,7 +1004,6 @@ qemu.1: qemu-option-trace.texi
 qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi
 fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
 qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
-qemu-ga.8: qemu-ga.texi
 docs/qemu-block-drivers.7: docs/qemu-block-drivers.texi
 docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
 scripts/qemu-trace-stap.1: scripts/qemu-trace-stap.texi
@@ -1010,7 +1015,7 @@ txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
 
 qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
 	qemu-img.texi qemu-nbd.texi qemu-options.texi qemu-option-trace.texi \
-	qemu-deprecated.texi qemu-monitor.texi qemu-img-cmds.texi qemu-ga.texi \
+	qemu-deprecated.texi qemu-monitor.texi qemu-img-cmds.texi \
 	qemu-monitor-info.texi docs/qemu-block-drivers.texi \
 	docs/qemu-cpu-models.texi docs/security.texi
 
diff --git a/MAINTAINERS b/MAINTAINERS
index a96829ea83a..27a6ffa7431 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2024,7 +2024,7 @@ QEMU Guest Agent
 M: Michael Roth <mdroth@linux.vnet.ibm.com>
 S: Maintained
 F: qga/
-F: qemu-ga.texi
+F: docs/interop/qemu-ga.rst
 F: scripts/qemu-guest-agent/
 F: tests/test-qga.c
 F: docs/interop/qemu-ga-ref.texi
diff --git a/docs/conf.py b/docs/conf.py
index befbcc6c3e1..d34a94838ca 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -115,6 +115,14 @@ todo_include_todos = False
 # with "option::" in the document being processed. Turn that off.
 suppress_warnings = ["ref.option"]
 
+# The rst_epilog fragment is effectively included in every rST file.
+# We use it to define substitutions based on build config that
+# can then be used in the documentation. The fallback if the
+# environment variable is not set is for the benefit of readthedocs
+# style document building; our Makefile always sets the variable.
+confdir = os.getenv('CONFDIR', "/usr/local/etc")
+rst_epilog = ".. |CONFDIR| replace:: ``" + confdir + "``\n"
+
 # -- Options for HTML output ----------------------------------------------
 
 # The theme to use for HTML and HTML Help pages.  See the documentation for
@@ -192,14 +200,8 @@ latex_documents = [
 
 
 # -- Options for manual page output ---------------------------------------
-
-# One entry per manual page. List of tuples
-# (source start file, name, description, authors, manual section).
-man_pages = [
-    (master_doc, 'qemu', u'QEMU Documentation',
-     [author], 1)
-]
-
+# Individual manual/conf.py can override this to create man pages
+man_pages = []
 
 # -- Options for Texinfo output -------------------------------------------
 
diff --git a/docs/interop/conf.py b/docs/interop/conf.py
index cf3c69d4a7e..e87b8c22bec 100644
--- a/docs/interop/conf.py
+++ b/docs/interop/conf.py
@@ -13,3 +13,10 @@ exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
 # This slightly misuses the 'description', but is the best way to get
 # the manual title to appear in the sidebar.
 html_theme_options['description'] = u'System Emulation Management and Interoperability Guide'
+
+# One entry per manual page. List of tuples
+# (source start file, name, description, authors, manual section).
+man_pages = [
+    ('qemu-ga', 'qemu-ga', u'QEMU Guest Agent',
+     ['Michael Roth <mdroth@linux.vnet.ibm.com>'], 8)
+]
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index b4bfcab4171..3e33fb59332 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -15,5 +15,6 @@ Contents:
    bitmaps
    live-block-operations
    pr-helper
+   qemu-ga
    vhost-user
    vhost-user-gpu
diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
new file mode 100644
index 00000000000..56e17f27fca
--- /dev/null
+++ b/docs/interop/qemu-ga.rst
@@ -0,0 +1,133 @@
+QEMU Guest Agent
+================
+
+Synopsis
+--------
+
+**qemu-ga** [*OPTIONS*]
+
+Description
+-----------
+
+The QEMU Guest Agent is a daemon intended to be run within virtual
+machines. It allows the hypervisor host to perform various operations
+in the guest, such as:
+
+- get information from the guest
+- set the guest's system time
+- read/write a file
+- sync and freeze the filesystems
+- suspend the guest
+- reconfigure guest local processors
+- set user's password
+- ...
+
+qemu-ga will read a system configuration file on startup (located at
+|CONFDIR|\ ``/qemu-ga.conf`` by default), then parse remaining
+configuration options on the command line. For the same key, the last
+option wins, but the lists accumulate (see below for configuration
+file format).
+
+Options
+-------
+
+.. program:: qemu-ga
+
+.. option:: -m, --method=METHOD
+
+  Transport method: one of ``unix-listen``, ``virtio-serial``, or
+  ``isa-serial`` (``virtio-serial`` is the default).
+
+.. option:: -p, --path=PATH
+
+  Device/socket path (the default for virtio-serial is
+  ``/dev/virtio-ports/org.qemu.guest_agent.0``,
+  the default for isa-serial is ``/dev/ttyS0``)
+
+.. option:: -l, --logfile=PATH
+
+  Set log file path (default is stderr).
+
+.. option:: -f, --pidfile=PATH
+
+  Specify pid file (default is ``/var/run/qemu-ga.pid``).
+
+.. option:: -F, --fsfreeze-hook=PATH
+
+  Enable fsfreeze hook. Accepts an optional argument that specifies
+  script to run on freeze/thaw. Script will be called with
+  'freeze'/'thaw' arguments accordingly (default is
+  |CONFDIR|\ ``/fsfreeze-hook``). If using -F with an argument, do
+  not follow -F with a space (for example:
+  ``-F/var/run/fsfreezehook.sh``).
+
+.. option:: -t, --statedir=PATH
+
+  Specify the directory to store state information (absolute paths only,
+  default is ``/var/run``).
+
+.. option:: -v, --verbose
+
+  Log extra debugging information.
+
+.. option:: -V, --version
+
+  Print version information and exit.
+
+.. option:: -d, --daemon
+
+  Daemonize after startup (detach from terminal).
+
+.. option:: -b, --blacklist=LIST
+
+  Comma-separated list of RPCs to disable (no spaces, ``?`` to list
+  available RPCs).
+
+.. option:: -D, --dump-conf
+
+  Dump the configuration in a format compatible with ``qemu-ga.conf``
+  and exit.
+
+.. option:: -h, --help
+
+  Display this help and exit.
+
+Files
+-----
+
+
+The syntax of the ``qemu-ga.conf`` configuration file follows the
+Desktop Entry Specification, here is a quick summary: it consists of
+groups of key-value pairs, interspersed with comments.
+
+::
+
+    # qemu-ga configuration sample
+    [general]
+    daemonize = 0
+    pidfile = /var/run/qemu-ga.pid
+    verbose = 0
+    method = virtio-serial
+    path = /dev/virtio-ports/org.qemu.guest_agent.0
+    statedir = /var/run
+
+The list of keys follows the command line options:
+
+==============  ===========
+Key             Key type
+==============  ===========
+daemon=         boolean
+method=         string
+path=           string
+logfile=        string
+pidfile=        string
+fsfreeze-hook=  string
+statedir=       string
+verbose=        boolean
+blacklist=      string list
+==============  ===========
+
+See also
+--------
+
+:manpage:`qemu(1)`
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 577d1e83764..fbdca1a992a 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2525,11 +2525,6 @@ so should only be used with trusted guest OS.
 
 @c man end
 
-@node QEMU Guest Agent
-@chapter QEMU Guest Agent invocation
-
-@include qemu-ga.texi
-
 @node QEMU User space emulator
 @chapter QEMU User space emulator
 
diff --git a/qemu-ga.texi b/qemu-ga.texi
deleted file mode 100644
index f00ad830f28..00000000000
--- a/qemu-ga.texi
+++ /dev/null
@@ -1,137 +0,0 @@
-@example
-@c man begin SYNOPSIS
-@command{qemu-ga} [@var{OPTIONS}]
-@c man end
-@end example
-
-@c man begin DESCRIPTION
-
-The QEMU Guest Agent is a daemon intended to be run within virtual
-machines. It allows the hypervisor host to perform various operations
-in the guest, such as:
-
-@itemize
-@item
-get information from the guest
-@item
-set the guest's system time
-@item
-read/write a file
-@item
-sync and freeze the filesystems
-@item
-suspend the guest
-@item
-reconfigure guest local processors
-@item
-set user's password
-@item
-...
-@end itemize
-
-qemu-ga will read a system configuration file on startup (located at
-@file{@value{CONFDIR}/qemu-ga.conf} by default), then parse remaining
-configuration options on the command line. For the same key, the last
-option wins, but the lists accumulate (see below for configuration
-file format).
-
-@c man end
-
-@c man begin OPTIONS
-@table @option
-@item -m, --method=@var{method}
-  Transport method: one of @samp{unix-listen}, @samp{virtio-serial}, or
-  @samp{isa-serial} (@samp{virtio-serial} is the default).
-
-@item -p, --path=@var{path}
-  Device/socket path (the default for virtio-serial is
-  @samp{/dev/virtio-ports/org.qemu.guest_agent.0},
-  the default for isa-serial is @samp{/dev/ttyS0})
-
-@item -l, --logfile=@var{path}
-  Set log file path (default is stderr).
-
-@item -f, --pidfile=@var{path}
-  Specify pid file (default is @samp{/var/run/qemu-ga.pid}).
-
-@item -F, --fsfreeze-hook=@var{path}
-  Enable fsfreeze hook. Accepts an optional argument that specifies
-  script to run on freeze/thaw. Script will be called with
-  'freeze'/'thaw' arguments accordingly (default is
-  @samp{@value{CONFDIR}/fsfreeze-hook}). If using -F with an argument, do
-  not follow -F with a space (for example:
-  @samp{-F/var/run/fsfreezehook.sh}).
-
-@item -t, --statedir=@var{path}
-  Specify the directory to store state information (absolute paths only,
-  default is @samp{/var/run}).
-
-@item -v, --verbose
-  Log extra debugging information.
-
-@item -V, --version
-  Print version information and exit.
-
-@item -d, --daemon
-  Daemonize after startup (detach from terminal).
-
-@item -b, --blacklist=@var{list}
-  Comma-separated list of RPCs to disable (no spaces, @samp{?} to list
-  available RPCs).
-
-@item -D, --dump-conf
-  Dump the configuration in a format compatible with @file{qemu-ga.conf}
-  and exit.
-
-@item -h, --help
-  Display this help and exit.
-@end table
-
-@c man end
-
-@c man begin FILES
-
-The syntax of the @file{qemu-ga.conf} configuration file follows the
-Desktop Entry Specification, here is a quick summary: it consists of
-groups of key-value pairs, interspersed with comments.
-
-@example
-# qemu-ga configuration sample
-[general]
-daemonize = 0
-pidfile = /var/run/qemu-ga.pid
-verbose = 0
-method = virtio-serial
-path = /dev/virtio-ports/org.qemu.guest_agent.0
-statedir = /var/run
-@end example
-
-The list of keys follows the command line options:
-@table @option
-@item daemon= boolean
-@item method= string
-@item path= string
-@item logfile= string
-@item pidfile= string
-@item fsfreeze-hook= string
-@item statedir= string
-@item verbose= boolean
-@item blacklist= string list
-@end table
-
-@c man end
-
-@ignore
-
-@setfilename qemu-ga
-@settitle QEMU Guest Agent
-
-@c man begin AUTHOR
-Michael Roth <mdroth@linux.vnet.ibm.com>
-@c man end
-
-@c man begin SEEALSO
-qemu(1)
-@c man end
-
-@end ignore
-- 
2.20.1


