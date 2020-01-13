Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0E1C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 18:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27841207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 18:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T94s4IQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27841207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir49E-0004X1-BA
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 13:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ir48U-00040M-QN
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 13:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ir48R-0007ny-0j
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 13:08:22 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35055)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ir48Q-0007lM-LT
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 13:08:18 -0500
Received: by mail-wr1-x443.google.com with SMTP id g17so9598303wro.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 10:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CSdfDbS1OhVfUs2Hs2k6hfmVhColSkD9SoXIioJKrR8=;
 b=T94s4IQnLqUMAZtHM7M/1ZFnBfdPoJHwyXF/XHqrUdr7tDPiQeLtmE+s8W6Aq3bwAI
 u8iTmkyKT6TixapUts7NMuJ7GFESw957Of+mjU8+iPYkJ3rkmWLyuLuXrbt9Zv4C4Bih
 UXB/v5r3ZGedZnHH/OVEeCGExkZv+AKX8/Q2tfTi7KuuZbYtJlIYvA5nEAF/Gp1j4ehk
 ad48GhGxk0WQVS8RcaSREWusvBJbQT0utcAN9HDgZEj3U+GJaGLqkUclrmlqTy3wdbZ6
 J91tjlOLR6ewI1JFLSAISjlnI02xZmjD6/f96+iujNIoySRB/UlPXhu1HB8k+JwzZI8i
 bQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CSdfDbS1OhVfUs2Hs2k6hfmVhColSkD9SoXIioJKrR8=;
 b=jZPLKR2/mf00aput7XPg+6NPGsxSo/afoWNT9Xw9K+awQ6dVhnZ4SYBp5AK2J+3XbI
 IeNBUtuCSrqswgxfzCMbPwMZJSEujwTdpkUDQs7tmUmcSTtbQ2GpvdtFB3piqK3UJaeN
 urT49GixZoMkZJFvlyBZ6JFde19YVoWUArtapiiv20pY4aJT0dO2MoI4B3bf59yn1i6h
 KUY5hvRuq1beLvTyhnbJJ0eUqiv0jhwwXPGIRTPYqoIGkoyLwvaK39D8rOi0s0qnPspq
 Exuj5gh1Hi6ZzaLFsAj17CkDf6sVIHz3R7FwO8WTolhfB/q/wicdGsgzC9LtLJZ/YjVX
 c2lg==
X-Gm-Message-State: APjAAAWcNsoIw0/MFuAXuJot03kZI1+VwAzbqz8/jGz992unpzOgBKSD
 fTXx58huiIII1CBKQndY9mLYTqfum6Vyew==
X-Google-Smtp-Source: APXvYqz0czWyrVywssP7dT3DvdkBr+3KYvmKQOFZ6gtSV7IvrsjY08P5P5IkOrSb+jDXspZ/Upbqsg==
X-Received: by 2002:a5d:44ca:: with SMTP id z10mr21338624wrr.266.1578938895788; 
 Mon, 13 Jan 2020 10:08:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g2sm16043644wrw.76.2020.01.13.10.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 10:08:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu-nbd: Convert invocation documentation to rST
Date: Mon, 13 Jan 2020 18:08:12 +0000
Message-Id: <20200113180812.3442-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qemu-nbd documentation is currently in qemu-nbd.texi in Texinfo
format, which we present to the user as:
 * a qemu-nbd manpage
 * a section of the main qemu-doc HTML documentation

Convert the documentation to rST format, and present it to the user as:
 * a qemu-nbd manpage
 * part of the interop/ Sphinx manual

This follows the same pattern as commit 27a296fce982 did for the
qemu-ga manpage.

All the content of the old manpage is retained, except that I have
dropped the "This is free software; see the source for copying
conditions.  There is NO warranty..." text that was in the old AUTHOR
section; Sphinx's manpage builder doesn't expect that much text in
the AUTHOR section, and since none of our other manpages have it it
seems easiest to delete it rather than try to figure out where else
in the manpage to put it.

The only other textual change is that I have had to give the
--nocache option its own description ("Equivalent to --cache=none")
because Sphinx doesn't have an equivalent of using item/itemx
to share a description between two options.

Some minor aspects of the formatting have changed, to suit what is
easiest for Sphinx to output. (The most notable is that Sphinx
option section option syntax doesn't support '--option foo=bar'
with bar underlined rather than bold, so we have to switch to
'--option foo=BAR' instead.)

The contents of qemu-option-trace.texi are now duplicated in
docs/interop/qemu-option-trace.rst.inc, until such time as we complete
the conversion of the other files which use it; since it has had only
3 changes in 3 years, this shouldn't be too awkward a burden.
(We use .rst.inc because if this file fragment has a .rst extension
then Sphinx complains about not seeing it in a toctree.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Another step forward for https://wiki.qemu.org/Features/Documentation
(this is part of step 3 in the 'transition plan').
[A
---
 Makefile                               |  12 +-
 MAINTAINERS                            |   1 +
 docs/interop/conf.py                   |   4 +-
 docs/interop/index.rst                 |   1 +
 docs/interop/qemu-nbd.rst              | 263 +++++++++++++++++++++++++
 docs/interop/qemu-option-trace.rst.inc |  30 +++
 qemu-doc.texi                          |   6 -
 qemu-nbd.texi                          | 214 --------------------
 qemu-option-trace.texi                 |   4 +
 9 files changed, 309 insertions(+), 226 deletions(-)
 create mode 100644 docs/interop/qemu-nbd.rst
 create mode 100644 docs/interop/qemu-option-trace.rst.inc
 delete mode 100644 qemu-nbd.texi

diff --git a/Makefile b/Makefile
index 32bd554480e..608e451050e 100644
--- a/Makefile
+++ b/Makefile
@@ -338,7 +338,7 @@ MANUAL_BUILDDIR := docs
 endif
 
 ifdef BUILD_DOCS
-DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 $(MANUAL_BUILDDIR)/interop/qemu-ga.8
+DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 $(MANUAL_BUILDDIR)/interop/qemu-nbd.8 $(MANUAL_BUILDDIR)/interop/qemu-ga.8
 DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
 DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
 DOCS+=docs/qemu-block-drivers.7
@@ -827,7 +827,7 @@ ifdef CONFIG_POSIX
 ifeq ($(CONFIG_TOOLS),y)
 	$(INSTALL_DATA) qemu-img.1 "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
-	$(INSTALL_DATA) qemu-nbd.8 "$(DESTDIR)$(mandir)/man8"
+	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-nbd.8 "$(DESTDIR)$(mandir)/man8"
 endif
 ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_DATA) scripts/qemu-trace-stap.1 "$(DESTDIR)$(mandir)/man1"
@@ -1005,7 +1005,7 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/interop/index
 # a single doctree: https://github.com/sphinx-doc/sphinx/issues/2946
 build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" sphinx-build $(if $(V),,-q) -W -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
 # We assume all RST files in the manual's directory are used in it
-manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
+manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(wildcard $(SRC_PATH)/docs/$1/*.rst.inc) $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
 
 $(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
 	$(call build-manual,devel,html)
@@ -1019,6 +1019,9 @@ $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
 $(MANUAL_BUILDDIR)/interop/qemu-ga.8: $(call manual-deps,interop)
 	$(call build-manual,interop,man)
 
+$(MANUAL_BUILDDIR)/interop/qemu-nbd.8: $(call manual-deps,interop)
+	$(call build-manual,interop,man)
+
 $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-version.h
 	$(call quiet-command, sed "s|@@VERSION@@|${VERSION}|g" $< >$@, \
              "GEN","$@")
@@ -1045,7 +1048,6 @@ qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
 qemu.1: qemu-option-trace.texi
 qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi
 fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
-qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
 docs/qemu-block-drivers.7: docs/qemu-block-drivers.texi
 docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
 scripts/qemu-trace-stap.1: scripts/qemu-trace-stap.texi
@@ -1056,7 +1058,7 @@ pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
 txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
 
 qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
-	qemu-img.texi qemu-nbd.texi qemu-options.texi \
+	qemu-img.texi qemu-options.texi \
 	qemu-tech.texi qemu-option-trace.texi \
 	qemu-deprecated.texi qemu-monitor.texi qemu-img-cmds.texi \
 	qemu-monitor-info.texi docs/qemu-block-drivers.texi \
diff --git a/MAINTAINERS b/MAINTAINERS
index 483edfbc0b5..bfb6a9ba584 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2503,6 +2503,7 @@ F: include/block/nbd*
 F: qemu-nbd.*
 F: blockdev-nbd.c
 F: docs/interop/nbd.txt
+F: docs/interop/qemu-nbd.rst
 T: git https://repo.or.cz/qemu/ericb.git nbd
 
 NFS
diff --git a/docs/interop/conf.py b/docs/interop/conf.py
index e87b8c22bec..40b1ad811de 100644
--- a/docs/interop/conf.py
+++ b/docs/interop/conf.py
@@ -18,5 +18,7 @@ html_theme_options['description'] = u'System Emulation Management and Interopera
 # (source start file, name, description, authors, manual section).
 man_pages = [
     ('qemu-ga', 'qemu-ga', u'QEMU Guest Agent',
-     ['Michael Roth <mdroth@linux.vnet.ibm.com>'], 8)
+     ['Michael Roth <mdroth@linux.vnet.ibm.com>'], 8),
+    ('qemu-nbd', 'qemu-nbd', u'QEMU Disk Network Block Device Server',
+     ['Anthony Liguori <anthony@codemonkey.ws>'], 8)
 ]
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index 049387ac6de..c28f7785a55 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -18,5 +18,6 @@ Contents:
    live-block-operations
    pr-helper
    qemu-ga
+   qemu-nbd
    vhost-user
    vhost-user-gpu
diff --git a/docs/interop/qemu-nbd.rst b/docs/interop/qemu-nbd.rst
new file mode 100644
index 00000000000..873bb9e17d5
--- /dev/null
+++ b/docs/interop/qemu-nbd.rst
@@ -0,0 +1,263 @@
+QEMU Disk Network Block Device Server
+=====================================
+
+Synopsis
+--------
+
+**qemu-nbd** [*OPTION*]... *filename*
+
+**qemu-nbd** -L [*OPTION*]...
+
+**qemu-nbd** -d *dev*
+
+Description
+-----------
+
+Export a QEMU disk image using the NBD protocol.
+
+Other uses:
+
+- Bind a /dev/nbdX block device to a QEMU server (on Linux).
+- As a client to query exports of a remote NBD server.
+
+Options
+-------
+
+.. program:: qemu-nbd
+
+*filename* is a disk image filename, or a set of block
+driver options if ``--image-opts`` is specified.
+
+*dev* is an NBD device.
+
+.. option:: --object type,id=ID,...props...
+
+  Define a new instance of the *type* object class identified by *ID*.
+  See the :manpage:`qemu(1)` manual page for full details of the properties
+  supported. The common object types that it makes sense to define are the
+  ``secret`` object, which is used to supply passwords and/or encryption
+  keys, and the ``tls-creds`` object, which is used to supply TLS
+  credentials for the qemu-nbd server or client.
+
+.. option:: -p, --port=PORT
+
+  TCP port to listen on as a server, or connect to as a client
+  (default ``10809``).
+
+.. option:: -o, --offset=OFFSET
+
+  The offset into the image.
+
+.. option:: -b, --bind=IFACE
+
+  The interface to bind to as a server, or connect to as a client
+  (default ``0.0.0.0``).
+
+.. option:: -k, --socket=PATH
+
+  Use a unix socket with path *PATH*.
+
+.. option:: --image-opts
+
+  Treat *filename* as a set of image options, instead of a plain
+  filename. If this flag is specified, the ``-f`` flag should
+  not be used, instead the :option:`format=` option should be set.
+
+.. option:: -f, --format=FMT
+
+  Force the use of the block driver for format *FMT* instead of
+  auto-detecting.
+
+.. option:: -r, --read-only
+
+  Export the disk as read-only.
+
+.. option:: -P, --partition=NUM
+
+  Deprecated: Only expose MBR partition *NUM*.  Understands physical
+  partitions 1-4 and logical partition 5. New code should instead use
+  :option:`--image-opts` with the raw driver wrapping a subset of the
+  original image.
+
+.. option:: -B, --bitmap=NAME
+
+  If *filename* has a qcow2 persistent bitmap *NAME*, expose
+  that bitmap via the ``qemu:dirty-bitmap:NAME`` context
+  accessible through NBD_OPT_SET_META_CONTEXT.
+
+.. option:: -s, --snapshot
+
+  Use *filename* as an external snapshot, create a temporary
+  file with ``backing_file=``\ *filename*, redirect the write to
+  the temporary one.
+
+.. option:: -l, --load-snapshot=SNAPSHOT_PARAM
+
+  Load an internal snapshot inside *filename* and export it
+  as an read-only device, SNAPSHOT_PARAM format is
+  ``snapshot.id=[ID],snapshot.name=[NAME]`` or ``[ID_OR_NAME]``
+
+.. option:: --cache=CACHE
+
+  The cache mode to be used with the file.  See the documentation of
+  the emulator's ``-drive cache=...`` option for allowed values.
+
+.. option:: -n, --nocache
+
+  Equivalent to :option:`--cache=none`.
+
+.. option:: --aio=AIO
+
+  Set the asynchronous I/O mode between ``threads`` (the default)
+  and ``native`` (Linux only).
+
+.. option:: --discard=DISCARD
+
+  Control whether ``discard`` (also known as ``trim`` or ``unmap``)
+  requests are ignored or passed to the filesystem. *DISCARD* is one of
+  ``ignore`` (or ``off``), ``unmap`` (or ``on``).  The default is
+  ``ignore``.
+
+.. option:: --detect-zeroes=DETECT_ZEROES
+
+  Control the automatic conversion of plain zero writes by the OS to
+  driver-specific optimized zero write commands.  *DETECT_ZEROES* is one of
+  ``off``, ``on``, or ``unmap``.  ``unmap``
+  converts a zero write to an unmap operation and can only be used if
+  *DISCARD* is set to ``unmap``.  The default is ``off``.
+
+.. option:: -c, --connect=DEV
+
+  Connect *filename* to NBD device *DEV* (Linux only).
+
+.. option:: -d, --disconnect
+
+  Disconnect the device *DEV* (Linux only).
+
+.. option:: -e, --shared=NUM
+
+  Allow up to *NUM* clients to share the device (default
+  ``1``). Safe for readers, but for now, consistency is not
+  guaranteed between multiple writers.
+
+.. option:: -t, --persistent
+
+  Don't exit on the last connection.
+
+.. option:: -x, --export-name=NAME
+
+  Set the NBD volume export name (default of a zero-length string).
+
+.. option:: -D, --description=DESCRIPTION
+
+  Set the NBD volume export description, as a human-readable
+  string.
+
+.. option:: -L, --list
+
+  Connect as a client and list all details about the exports exposed by
+  a remote NBD server.  This enables list mode, and is incompatible
+  with options that change behavior related to a specific export (such as
+  :option:`--export-name`, :option:`--offset`, ...).
+
+.. option:: --tls-creds=ID
+
+  Enable mandatory TLS encryption for the server by setting the ID
+  of the TLS credentials object previously created with the --object
+  option; or provide the credentials needed for connecting as a client
+  in list mode.
+
+.. option:: --fork
+
+  Fork off the server process and exit the parent once the server is running.
+
+.. option:: --pid-file=PATH
+
+  Store the server's process ID in the given file.
+
+.. option:: --tls-authz=ID
+
+  Specify the ID of a qauthz object previously created with the
+  :option:`--object` option. This will be used to authorize connecting users
+  against their x509 distinguished name.
+
+.. option:: -v, --verbose
+
+  Display extra debugging information.
+
+.. option:: -h, --help
+
+  Display this help and exit.
+
+.. option:: -V, --version
+
+  Display version information and exit.
+
+.. option:: -T, --trace [[enable=]PATTERN][,events=FILE][,file=FILE]
+
+  .. include:: qemu-option-trace.rst.inc
+
+Examples
+--------
+
+Start a server listening on port 10809 that exposes only the
+guest-visible contents of a qcow2 file, with no TLS encryption, and
+with the default export name (an empty string). The command is
+one-shot, and will block until the first successful client
+disconnects:
+
+::
+
+  qemu-nbd -f qcow2 file.qcow2
+
+Start a long-running server listening with encryption on port 10810,
+and whitelist clients with a specific X.509 certificate to connect to
+a 1 megabyte subset of a raw file, using the export name 'subset':
+
+::
+
+  qemu-nbd \
+    --object tls-creds-x509,id=tls0,endpoint=server,dir=/path/to/qemutls \
+    --object 'authz-simple,id=auth0,identity=CN=laptop.example.com,,\
+              O=Example Org,,L=London,,ST=London,,C=GB' \
+    --tls-creds tls0 --tls-authz auth0 \
+    -t -x subset -p 10810 \
+    --image-opts driver=raw,offset=1M,size=1M,file.driver=file,file.filename=file.raw
+
+Serve a read-only copy of just the first MBR partition of a guest
+image over a Unix socket with as many as 5 simultaneous readers, with
+a persistent process forked as a daemon:
+
+::
+
+  qemu-nbd --fork --persistent --shared=5 --socket=/path/to/sock \
+    --partition=1 --read-only --format=qcow2 file.qcow2
+
+Expose the guest-visible contents of a qcow2 file via a block device
+/dev/nbd0 (and possibly creating /dev/nbd0p1 and friends for
+partitions found within), then disconnect the device when done.
+Access to bind qemu-nbd to an /dev/nbd device generally requires root
+privileges, and may also require the execution of ``modprobe nbd``
+to enable the kernel NBD client module.  *CAUTION*: Do not use
+this method to mount filesystems from an untrusted guest image - a
+malicious guest may have prepared the image to attempt to trigger
+kernel bugs in partition probing or file system mounting.
+
+::
+
+  qemu-nbd -c /dev/nbd0 -f qcow2 file.qcow2
+  qemu-nbd -d /dev/nbd0
+
+Query a remote server to see details about what export(s) it is
+serving on port 10809, and authenticating via PSK:
+
+::
+
+  qemu-nbd \
+    --object tls-creds-psk,id=tls0,dir=/tmp/keys,username=eblake,endpoint=client \
+    --tls-creds tls0 -L -b remote.example.com
+
+See also
+--------
+
+:manpage:`qemu(1)`, :manpage:`qemu-img(1)`
diff --git a/docs/interop/qemu-option-trace.rst.inc b/docs/interop/qemu-option-trace.rst.inc
new file mode 100644
index 00000000000..23cfcb48537
--- /dev/null
+++ b/docs/interop/qemu-option-trace.rst.inc
@@ -0,0 +1,30 @@
+..
+  The contents of this file must be kept in sync with qemu-option-trace.texi
+  until all the users of the texi file have been converted to rst and
+  the texi file can be removed.
+
+Specify tracing options.
+
+.. option:: [enable=]PATTERN
+
+  Immediately enable events matching *PATTERN*
+  (either event name or a globbing pattern).  This option is only
+  available if QEMU has been compiled with the ``simple``, ``log``
+  or ``ftrace`` tracing backend.  To specify multiple events or patterns,
+  specify the :option:`-trace` option multiple times.
+
+  Use :option:`-trace help` to print a list of names of trace points.
+
+.. option:: events=FILE
+
+  Immediately enable events listed in *FILE*.
+  The file must contain one event name (as listed in the ``trace-events-all``
+  file) per line; globbing patterns are accepted too.  This option is only
+  available if QEMU has been compiled with the ``simple``, ``log`` or
+  ``ftrace`` tracing backend.
+
+.. option:: file=FILE
+
+  Log output traces to *FILE*.
+  This option is only available if QEMU has been compiled with
+  the ``simple`` tracing backend.
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 39f950471f2..617485d1461 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -633,7 +633,6 @@ encrypted disk images.
 * disk_images_snapshot_mode:: Snapshot mode
 * vm_snapshots::              VM snapshots
 * qemu_img_invocation::       qemu-img Invocation
-* qemu_nbd_invocation::       qemu-nbd Invocation
 * disk_images_formats::       Disk image file formats
 * host_drives::               Using host drives
 * disk_images_fat_images::    Virtual FAT disk images
@@ -724,11 +723,6 @@ state is not saved or restored properly (in particular USB).
 
 @include qemu-img.texi
 
-@node qemu_nbd_invocation
-@subsection @code{qemu-nbd} Invocation
-
-@include qemu-nbd.texi
-
 @include docs/qemu-block-drivers.texi
 
 @node pcsys_network
diff --git a/qemu-nbd.texi b/qemu-nbd.texi
deleted file mode 100644
index 7f55657722b..00000000000
--- a/qemu-nbd.texi
+++ /dev/null
@@ -1,214 +0,0 @@
-@example
-@c man begin SYNOPSIS
-@command{qemu-nbd} [OPTION]... @var{filename}
-
-@command{qemu-nbd} @option{-L} [OPTION]...
-
-@command{qemu-nbd} @option{-d} @var{dev}
-@c man end
-@end example
-
-@c man begin DESCRIPTION
-
-Export a QEMU disk image using the NBD protocol.
-
-Other uses:
-@itemize
-@item
-Bind a /dev/nbdX block device to a QEMU server (on Linux).
-@item
-As a client to query exports of a remote NBD server.
-@end itemize
-
-@c man end
-
-@c man begin OPTIONS
-@var{filename} is a disk image filename, or a set of block
-driver options if @option{--image-opts} is specified.
-
-@var{dev} is an NBD device.
-
-@table @option
-@item --object type,id=@var{id},...props...
-Define a new instance of the @var{type} object class identified by @var{id}.
-See the @code{qemu(1)} manual page for full details of the properties
-supported. The common object types that it makes sense to define are the
-@code{secret} object, which is used to supply passwords and/or encryption
-keys, and the @code{tls-creds} object, which is used to supply TLS
-credentials for the qemu-nbd server or client.
-@item -p, --port=@var{port}
-The TCP port to listen on as a server, or connect to as a client
-(default @samp{10809}).
-@item -o, --offset=@var{offset}
-The offset into the image.
-@item -b, --bind=@var{iface}
-The interface to bind to as a server, or connect to as a client
-(default @samp{0.0.0.0}).
-@item -k, --socket=@var{path}
-Use a unix socket with path @var{path}.
-@item --image-opts
-Treat @var{filename} as a set of image options, instead of a plain
-filename. If this flag is specified, the @var{-f} flag should
-not be used, instead the '@code{format=}' option should be set.
-@item -f, --format=@var{fmt}
-Force the use of the block driver for format @var{fmt} instead of
-auto-detecting.
-@item -r, --read-only
-Export the disk as read-only.
-@item -P, --partition=@var{num}
-Deprecated: Only expose MBR partition @var{num}.  Understands physical
-partitions 1-4 and logical partition 5. New code should instead use
-@option{--image-opts} with the raw driver wrapping a subset of the
-original image.
-@item -B, --bitmap=@var{name}
-If @var{filename} has a qcow2 persistent bitmap @var{name}, expose
-that bitmap via the ``qemu:dirty-bitmap:@var{name}'' context
-accessible through NBD_OPT_SET_META_CONTEXT.
-@item -s, --snapshot
-Use @var{filename} as an external snapshot, create a temporary
-file with backing_file=@var{filename}, redirect the write to
-the temporary one.
-@item -l, --load-snapshot=@var{snapshot_param}
-Load an internal snapshot inside @var{filename} and export it
-as an read-only device, @var{snapshot_param} format is
-'snapshot.id=[ID],snapshot.name=[NAME]' or '[ID_OR_NAME]'
-@item -n, --nocache
-@itemx --cache=@var{cache}
-The cache mode to be used with the file.  See the documentation of
-the emulator's @code{-drive cache=...} option for allowed values.
-@item --aio=@var{aio}
-Set the asynchronous I/O mode between @samp{threads} (the default)
-and @samp{native} (Linux only).
-@item --discard=@var{discard}
-Control whether @dfn{discard} (also known as @dfn{trim} or @dfn{unmap})
-requests are ignored or passed to the filesystem.  @var{discard} is one of
-@samp{ignore} (or @samp{off}), @samp{unmap} (or @samp{on}).  The default is
-@samp{ignore}.
-@item --detect-zeroes=@var{detect-zeroes}
-Control the automatic conversion of plain zero writes by the OS to
-driver-specific optimized zero write commands.  @var{detect-zeroes} is one of
-@samp{off}, @samp{on} or @samp{unmap}.  @samp{unmap}
-converts a zero write to an unmap operation and can only be used if
-@var{discard} is set to @samp{unmap}.  The default is @samp{off}.
-@item -c, --connect=@var{dev}
-Connect @var{filename} to NBD device @var{dev} (Linux only).
-@item -d, --disconnect
-Disconnect the device @var{dev} (Linux only).
-@item -e, --shared=@var{num}
-Allow up to @var{num} clients to share the device (default
-@samp{1}). Safe for readers, but for now, consistency is not
-guaranteed between multiple writers.
-@item -t, --persistent
-Don't exit on the last connection.
-@item -x, --export-name=@var{name}
-Set the NBD volume export name (default of a zero-length string).
-@item -D, --description=@var{description}
-Set the NBD volume export description, as a human-readable
-string.
-@item -L, --list
-Connect as a client and list all details about the exports exposed by
-a remote NBD server.  This enables list mode, and is incompatible
-with options that change behavior related to a specific export (such as
-@option{--export-name}, @option{--offset}, ...).
-@item --tls-creds=ID
-Enable mandatory TLS encryption for the server by setting the ID
-of the TLS credentials object previously created with the --object
-option; or provide the credentials needed for connecting as a client
-in list mode.
-@item --fork
-Fork off the server process and exit the parent once the server is running.
-@item --pid-file=PATH
-Store the server's process ID in the given file.
-@item --tls-authz=ID
-Specify the ID of a qauthz object previously created with the
---object option. This will be used to authorize connecting users
-against their x509 distinguished name.
-@item -v, --verbose
-Display extra debugging information.
-@item -h, --help
-Display this help and exit.
-@item -V, --version
-Display version information and exit.
-@item -T, --trace [[enable=]@var{pattern}][,events=@var{file}][,file=@var{file}]
-@findex --trace
-@include qemu-option-trace.texi
-@end table
-
-@c man end
-
-@c man begin EXAMPLES
-Start a server listening on port 10809 that exposes only the
-guest-visible contents of a qcow2 file, with no TLS encryption, and
-with the default export name (an empty string). The command is
-one-shot, and will block until the first successful client
-disconnects:
-
-@example
-qemu-nbd -f qcow2 file.qcow2
-@end example
-
-Start a long-running server listening with encryption on port 10810,
-and whitelist clients with a specific X.509 certificate to connect to
-a 1 megabyte subset of a raw file, using the export name 'subset':
-
-@example
-qemu-nbd \
-  --object tls-creds-x509,id=tls0,endpoint=server,dir=/path/to/qemutls \
-  --object 'authz-simple,id=auth0,identity=CN=laptop.example.com,,\
-            O=Example Org,,L=London,,ST=London,,C=GB' \
-  --tls-creds tls0 --tls-authz auth0 \
-  -t -x subset -p 10810 \
-  --image-opts driver=raw,offset=1M,size=1M,file.driver=file,file.filename=file.raw
-@end example
-
-Serve a read-only copy of just the first MBR partition of a guest
-image over a Unix socket with as many as 5 simultaneous readers, with
-a persistent process forked as a daemon:
-
-@example
-qemu-nbd --fork --persistent --shared=5 --socket=/path/to/sock \
-  --partition=1 --read-only --format=qcow2 file.qcow2
-@end example
-
-Expose the guest-visible contents of a qcow2 file via a block device
-/dev/nbd0 (and possibly creating /dev/nbd0p1 and friends for
-partitions found within), then disconnect the device when done.
-Access to bind qemu-nbd to an /dev/nbd device generally requires root
-privileges, and may also require the execution of @code{modprobe nbd}
-to enable the kernel NBD client module.  @emph{CAUTION}: Do not use
-this method to mount filesystems from an untrusted guest image - a
-malicious guest may have prepared the image to attempt to trigger
-kernel bugs in partition probing or file system mounting.
-
-@example
-qemu-nbd -c /dev/nbd0 -f qcow2 file.qcow2
-qemu-nbd -d /dev/nbd0
-@end example
-
-Query a remote server to see details about what export(s) it is
-serving on port 10809, and authenticating via PSK:
-
-@example
-qemu-nbd \
-  --object tls-creds-psk,id=tls0,dir=/tmp/keys,username=eblake,endpoint=client \
-  --tls-creds tls0 -L -b remote.example.com
-@end example
-
-@c man end
-
-@ignore
-
-@setfilename qemu-nbd
-@settitle QEMU Disk Network Block Device Server
-
-@c man begin AUTHOR
-Copyright (C) 2006 Anthony Liguori <anthony@codemonkey.ws>.
-This is free software; see the source for copying conditions.  There is NO
-warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-@c man end
-
-@c man begin SEEALSO
-qemu(1), qemu-img(1)
-@c man end
-
-@end ignore
diff --git a/qemu-option-trace.texi b/qemu-option-trace.texi
index 7d1b7f05c54..162f1528d21 100644
--- a/qemu-option-trace.texi
+++ b/qemu-option-trace.texi
@@ -1,3 +1,7 @@
+@c The contents of this file must be kept in sync with qemu-option-trace.rst.inc
+@c until all the users of the texi file have been converted to rst and
+@c the texi file can be removed.
+
 Specify tracing options.
 
 @table @option
-- 
2.20.1


