Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61E6C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E85320721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vpHhc531"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E85320721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZjp-0004EM-Nw
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZfl-0005rq-7P
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZfc-0000qh-5c
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:45 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:41389)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyZfb-0000pU-Lb
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:36 -0500
Received: by mail-wr1-x430.google.com with SMTP id c9so17471512wrw.8
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 03:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=NRbVFrv6SgHC+TfYUXUpW4ZRsyYWB1uSJNmKqyeZ98s=;
 b=vpHhc531vlEGP3FwGLA6kAZnEXzqn7NUdF5S3FH0KtjjG6D1QdpzRjEyoUnNqGJWmF
 hGnS5uNGrJPd2NzWPD7J6AYkFy12cVdEc2taPvoQWhVr5fyUUfhJvg3DWSayZTb+hvsV
 LrAx+2X6lWoGWajzYi2wOE1vBWkwFv/Lc3DkPNbX80UU6hdjNyCh2tOFraQyXnLtff5o
 wwIBisp8ROtEa888EYIH7rb90HtP9D0co6mq+X9JX2bvZst1uEofrekk+mNCxGw27MAm
 zDRzdMH2M6IkKroQ8hkZ9KJWFNZWINcBk86iBMnTDzSgqvEEFNmsudFwZ7LWbbZmsGUj
 8Brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NRbVFrv6SgHC+TfYUXUpW4ZRsyYWB1uSJNmKqyeZ98s=;
 b=mb2SGJ+Tg1j8P+4Vpef/GJzB0nZ0Rg2P7juUVogeUhABrzA37elV/puGdG9My//osk
 jUC8VdPrr2NDHniG7Gx3reR41lsegrjb43c48pRdVM2qZo1ECGjF73CAdSs43WM0sXJl
 JkX5NzrGzN6B0eQi+me6Td1ZE/gS30l4HYtjz9BEXfYzFRBufELq6JhlUTYi/Qen36dp
 3Y/K8SgWJzc2Z1Z0ZTzYG66U5WCAslFkv9KFPy2gt5oKB2o9ki41g+DI0Xku0BRnGuGd
 g1PUtAtk4Q1qImDAASDsh6kUI4eV39GUvx3rmc79ztnuw9g2PsRdGEHoUjzjFzO9tHvP
 FcDQ==
X-Gm-Message-State: APjAAAUMszel8A0+whf9aCdw9L+hjsvPiNuHUMeEGHhDbZAwTOF0lLtQ
 hmXUR3oU+4CDws14yKR0dObLbtreBmh6lw==
X-Google-Smtp-Source: APXvYqw1EznFO34DvRYLu8jPqMF9iPUqQihpx5aBpXk/beBjhQQXARXpf9vKNmQ6baxOlO/nhmOU7g==
X-Received: by 2002:adf:f44a:: with SMTP id f10mr15673166wrp.16.1580728411281; 
 Mon, 03 Feb 2020 03:13:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm24028917wme.35.2020.02.03.03.13.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 03:13:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/8] qemu-img: Convert invocation documentation to rST
Date: Mon,  3 Feb 2020 11:13:15 +0000
Message-Id: <20200203111318.23378-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203111318.23378-1-peter.maydell@linaro.org>
References: <20200203111318.23378-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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

The qemu-img documentation is currently in qemu-nbd.texi in Texinfo
format, which we present to the user as:
 * a qemu-img manpage
 * a section of the main qemu-doc HTML documentation

Convert the documentation to rST format, and present it to the user as:
 * a qemu-img manpage
 * part of the interop/ Sphinx manual

The qemu-img rST document uses the new hxtool extension
to handle pulling rST fragments out of qemu-img-cmds.hx.

The documentation of the various options and commands is rather
muddled, with some options being described inside the relevant
command description and some in a more general section near the start
of the manual.  All the command synopses are replicated in the .hx
file and then again in the manual.  A lot of text is also duplicated
in the qemu-img.c code for the help text.  I have not attempted to
deal with any of this, but have simply transposed the existing
structure into rST.

As usual, there are some minor formatting changes but no
textual changes, except that as with one or two other conversions
I have dropped the 'see also' section since it's not very
informative and looks odd in the HTML.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200124162606.8787-6-peter.maydell@linaro.org
---
 Makefile                  |  19 +-
 MAINTAINERS               |   1 +
 docs/interop/conf.py      |   2 +
 docs/interop/index.rst    |   1 +
 docs/interop/qemu-img.rst | 825 ++++++++++++++++++++++++++++++++++++++
 qemu-doc.texi             |  10 +-
 qemu-img.texi             | 798 ------------------------------------
 7 files changed, 840 insertions(+), 816 deletions(-)
 create mode 100644 docs/interop/qemu-img.rst
 delete mode 100644 qemu-img.texi

diff --git a/Makefile b/Makefile
index 6ccdb431a7a..c9dc4422170 100644
--- a/Makefile
+++ b/Makefile
@@ -344,7 +344,8 @@ MANUAL_BUILDDIR := docs
 endif
 
 ifdef BUILD_DOCS
-DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1
+DOCS=qemu-doc.html qemu-doc.txt qemu.1
+DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-img.1
 DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-nbd.8
 DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-ga.8
 DOCS+=$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
@@ -744,7 +745,7 @@ rm -f $(MANUAL_BUILDDIR)/$1/objects.inv $(MANUAL_BUILDDIR)/$1/searchindex.js $(M
 endef
 
 distclean: clean
-	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-options.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
+	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
 	rm -f tests/tcg/config-*.mak
 	rm -f config-all-devices.mak config-all-disas.mak config.status
 	rm -f $(SUBDIR_DEVICES_MAK)
@@ -842,7 +843,7 @@ ifdef CONFIG_POSIX
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-block-drivers.7 "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) docs/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
 ifeq ($(CONFIG_TOOLS),y)
-	$(INSTALL_DATA) qemu-img.1 "$(DESTDIR)$(mandir)/man1"
+	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-img.1 "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-nbd.8 "$(DESTDIR)$(mandir)/man8"
 endif
@@ -1040,7 +1041,7 @@ endef
 $(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
 	$(call build-manual,devel,html)
 
-$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
+$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop) $(SRC_PATH)/qemu-img-cmds.hx
 	$(call build-manual,interop,html)
 
 $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
@@ -1049,7 +1050,7 @@ $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
 $(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system)
 	$(call build-manual,system,html)
 
-$(call define-manpage-rule,interop,qemu-ga.8 qemu-nbd.8)
+$(call define-manpage-rule,interop,qemu-ga.8 qemu-img.1 qemu-nbd.8,$(SRC_PATH/qemu-img-cmds.hx))
 
 $(call define-manpage-rule,system,qemu-block-drivers.7)
 
@@ -1067,9 +1068,6 @@ qemu-monitor.texi: $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/scripts/hxtool
 qemu-monitor-info.texi: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
 
-qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
-
 docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
 	@cp -p $< $@
 
@@ -1078,7 +1076,6 @@ docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
 
 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
 qemu.1: qemu-option-trace.texi
-qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi
 fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
 docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
 scripts/qemu-trace-stap.1: scripts/qemu-trace-stap.texi
@@ -1089,9 +1086,9 @@ pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
 txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
 
 qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
-	qemu-img.texi qemu-options.texi \
+	qemu-options.texi \
 	qemu-tech.texi qemu-option-trace.texi \
-	qemu-deprecated.texi qemu-monitor.texi qemu-img-cmds.texi \
+	qemu-deprecated.texi qemu-monitor.texi \
 	qemu-monitor-info.texi \
 	docs/qemu-cpu-models.texi docs/security.texi
 
diff --git a/MAINTAINERS b/MAINTAINERS
index faffd447bf0..80263385190 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1834,6 +1834,7 @@ F: block/
 F: hw/block/
 F: include/block/
 F: qemu-img*
+F: docs/interop/qemu-img.rst
 F: qemu-io*
 F: tests/qemu-iotests/
 F: util/qemu-progress.c
diff --git a/docs/interop/conf.py b/docs/interop/conf.py
index 40b1ad811de..0de444a900d 100644
--- a/docs/interop/conf.py
+++ b/docs/interop/conf.py
@@ -19,6 +19,8 @@ html_theme_options['description'] = u'System Emulation Management and Interopera
 man_pages = [
     ('qemu-ga', 'qemu-ga', u'QEMU Guest Agent',
      ['Michael Roth <mdroth@linux.vnet.ibm.com>'], 8),
+    ('qemu-img', 'qemu-img', u'QEMU disk image utility',
+     ['Fabrice Bellard'], 1),
     ('qemu-nbd', 'qemu-nbd', u'QEMU Disk Network Block Device Server',
      ['Anthony Liguori <anthony@codemonkey.ws>'], 8)
 ]
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index c28f7785a55..5e4de07d4cc 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -18,6 +18,7 @@ Contents:
    live-block-operations
    pr-helper
    qemu-ga
+   qemu-img
    qemu-nbd
    vhost-user
    vhost-user-gpu
diff --git a/docs/interop/qemu-img.rst b/docs/interop/qemu-img.rst
new file mode 100644
index 00000000000..fa27e5c7b45
--- /dev/null
+++ b/docs/interop/qemu-img.rst
@@ -0,0 +1,825 @@
+QEMU disk image utility
+=======================
+
+Synopsis
+--------
+
+**qemu-img** [*standard options*] *command* [*command options*]
+
+Description
+-----------
+
+qemu-img allows you to create, convert and modify images offline. It can handle
+all image formats supported by QEMU.
+
+**Warning:** Never use qemu-img to modify images in use by a running virtual
+machine or any other process; this may destroy the image. Also, be aware that
+querying an image that is being modified by another process may encounter
+inconsistent state.
+
+Options
+-------
+
+.. program:: qemu-img
+
+Standard options:
+
+.. option:: -h, --help
+
+  Display this help and exit
+
+.. option:: -V, --version
+
+  Display version information and exit
+
+.. option:: -T, --trace [[enable=]PATTERN][,events=FILE][,file=FILE]
+
+  .. include:: qemu-option-trace.rst.inc
+
+The following commands are supported:
+
+.. hxtool-doc:: qemu-img-cmds.hx
+
+Command parameters:
+
+*FILENAME* is a disk image filename.
+
+*FMT* is the disk image format. It is guessed automatically in most
+cases. See below for a description of the supported disk formats.
+
+*SIZE* is the disk image size in bytes. Optional suffixes ``k`` or
+``K`` (kilobyte, 1024) ``M`` (megabyte, 1024k) and ``G`` (gigabyte,
+1024M) and T (terabyte, 1024G) are supported.  ``b`` is ignored.
+
+*OUTPUT_FILENAME* is the destination disk image filename.
+
+*OUTPUT_FMT* is the destination format.
+
+*OPTIONS* is a comma separated list of format specific options in a
+name=value format. Use ``-o ?`` for an overview of the options supported
+by the used format or see the format descriptions below for details.
+
+*SNAPSHOT_PARAM* is param used for internal snapshot, format is
+'snapshot.id=[ID],snapshot.name=[NAME]' or '[ID_OR_NAME]'.
+
+..
+  Note the use of a new 'program'; otherwise Sphinx complains about
+  the -h option appearing both in the above option list and this one.
+
+.. program:: qemu-img-common-opts
+
+.. option:: --object OBJECTDEF
+
+  is a QEMU user creatable object definition. See the :manpage:`qemu(1)`
+  manual page for a description of the object properties. The most common
+  object type is a ``secret``, which is used to supply passwords and/or
+  encryption keys.
+
+.. option:: --image-opts
+
+  Indicates that the source *FILENAME* parameter is to be interpreted as a
+  full option string, not a plain filename. This parameter is mutually
+  exclusive with the *-f* parameter.
+
+.. option:: --target-image-opts
+
+  Indicates that the OUTPUT_FILENAME parameter(s) are to be interpreted as
+  a full option string, not a plain filename. This parameter is mutually
+  exclusive with the *-O* parameters. It is currently required to also use
+  the *-n* parameter to skip image creation. This restriction may be relaxed
+  in a future release.
+
+.. option:: --force-share (-U)
+
+  If specified, ``qemu-img`` will open the image in shared mode, allowing
+  other QEMU processes to open it in write mode. For example, this can be used to
+  get the image information (with 'info' subcommand) when the image is used by a
+  running guest.  Note that this could produce inconsistent results because of
+  concurrent metadata changes, etc. This option is only allowed when opening
+  images in read-only mode.
+
+.. option:: --backing-chain
+
+  Will enumerate information about backing files in a disk image chain. Refer
+  below for further description.
+
+.. option:: -c
+
+  Indicates that target image must be compressed (qcow format only).
+
+.. option:: -h
+
+  With or without a command, shows help and lists the supported formats.
+
+.. option:: -p
+
+  Display progress bar (compare, convert and rebase commands only).
+  If the *-p* option is not used for a command that supports it, the
+  progress is reported when the process receives a ``SIGUSR1`` or
+  ``SIGINFO`` signal.
+
+.. option:: -q
+
+  Quiet mode - do not print any output (except errors). There's no progress bar
+  in case both *-q* and *-p* options are used.
+
+.. option:: -S SIZE
+
+  Indicates the consecutive number of bytes that must contain only zeros
+  for qemu-img to create a sparse image during conversion. This value is rounded
+  down to the nearest 512 bytes. You may use the common size suffixes like
+  ``k`` for kilobytes.
+
+.. option:: -t CACHE
+
+  Specifies the cache mode that should be used with the (destination) file. See
+  the documentation of the emulator's ``-drive cache=...`` option for allowed
+  values.
+
+.. option:: -T SRC_CACHE
+
+  Specifies the cache mode that should be used with the source file(s). See
+  the documentation of the emulator's ``-drive cache=...`` option for allowed
+  values.
+
+Parameters to snapshot subcommand:
+
+.. program:: qemu-img-snapshot
+
+.. option:: snapshot
+
+  Is the name of the snapshot to create, apply or delete
+
+.. option:: -a
+
+  Applies a snapshot (revert disk to saved state)
+
+.. option:: -c
+
+  Creates a snapshot
+
+.. option:: -d
+
+  Deletes a snapshot
+
+.. option:: -l
+
+  Lists all snapshots in the given image
+
+Parameters to compare subcommand:
+
+.. program:: qemu-img-compare
+
+.. option:: -f
+
+  First image format
+
+.. option:: -F
+
+  Second image format
+
+.. option:: -s
+
+  Strict mode - fail on different image size or sector allocation
+
+Parameters to convert subcommand:
+
+.. program:: qemu-img-convert
+
+.. option:: -n
+
+  Skip the creation of the target volume
+
+.. option:: -m
+
+  Number of parallel coroutines for the convert process
+
+.. option:: -W
+
+  Allow out-of-order writes to the destination. This option improves performance,
+  but is only recommended for preallocated devices like host devices or other
+  raw block devices.
+
+.. option:: -C
+
+  Try to use copy offloading to move data from source image to target. This may
+  improve performance if the data is remote, such as with NFS or iSCSI backends,
+  but will not automatically sparsify zero sectors, and may result in a fully
+  allocated target image depending on the host support for getting allocation
+  information.
+
+.. option:: --salvage
+
+  Try to ignore I/O errors when reading.  Unless in quiet mode (``-q``), errors
+  will still be printed.  Areas that cannot be read from the source will be
+  treated as containing only zeroes.
+
+Parameters to dd subcommand:
+
+.. program:: qemu-img-dd
+
+.. option:: bs=BLOCK_SIZE
+
+  Defines the block size
+
+.. option:: count=BLOCKS
+
+  Sets the number of input blocks to copy
+
+.. option:: if=INPUT
+
+  Sets the input file
+
+.. option:: of=OUTPUT
+
+  Sets the output file
+
+.. option:: skip=BLOCKS
+
+  Sets the number of input blocks to skip
+
+Command description:
+
+.. program:: qemu-img-commands
+
+.. option:: amend [--object OBJECTDEF] [--image-opts] [-p] [-q] [-f FMT] [-t CACHE] -o OPTIONS FILENAME
+
+  Amends the image format specific *OPTIONS* for the image file
+  *FILENAME*. Not all file formats support this operation.
+
+.. option:: bench [-c COUNT] [-d DEPTH] [-f FMT] [--flush-interval=FLUSH_INTERVAL] [-n] [-i AIO] [--no-drain] [-o OFFSET] [--pattern=PATTERN] [-q] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t CACHE] [-w] [-U] FILENAME
+
+  Run a simple sequential I/O benchmark on the specified image. If ``-w`` is
+  specified, a write test is performed, otherwise a read test is performed.
+
+  A total number of *COUNT* I/O requests is performed, each *BUFFER_SIZE*
+  bytes in size, and with *DEPTH* requests in parallel. The first request
+  starts at the position given by *OFFSET*, each following request increases
+  the current position by *STEP_SIZE*. If *STEP_SIZE* is not given,
+  *BUFFER_SIZE* is used for its value.
+
+  If *FLUSH_INTERVAL* is specified for a write test, the request queue is
+  drained and a flush is issued before new writes are made whenever the number of
+  remaining requests is a multiple of *FLUSH_INTERVAL*. If additionally
+  ``--no-drain`` is specified, a flush is issued without draining the request
+  queue first.
+
+  If ``-n`` is specified, the native AIO backend is used if possible. On
+  Linux, this option only works if ``-t none`` or ``-t directsync`` is
+  specified as well.
+
+  if ``-i`` is specified, *AIO* option can be used to specify different
+  AIO backends: ``threads``, ``native`` or ``io_uring``.
+
+  For write tests, by default a buffer filled with zeros is written. This can be
+  overridden with a pattern byte specified by *PATTERN*.
+
+.. option:: check [--object OBJECTDEF] [--image-opts] [-q] [-f FMT] [--output=OFMT] [-r [leaks | all]] [-T SRC_CACHE] [-U] FILENAME
+
+  Perform a consistency check on the disk image *FILENAME*. The command can
+  output in the format *OFMT* which is either ``human`` or ``json``.
+  The JSON output is an object of QAPI type ``ImageCheck``.
+
+  If ``-r`` is specified, qemu-img tries to repair any inconsistencies found
+  during the check. ``-r leaks`` repairs only cluster leaks, whereas
+  ``-r all`` fixes all kinds of errors, with a higher risk of choosing the
+  wrong fix or hiding corruption that has already occurred.
+
+  Only the formats ``qcow2``, ``qed`` and ``vdi`` support
+  consistency checks.
+
+  In case the image does not have any inconsistencies, check exits with ``0``.
+  Other exit codes indicate the kind of inconsistency found or if another error
+  occurred. The following table summarizes all exit codes of the check subcommand:
+
+  0
+    Check completed, the image is (now) consistent
+  1
+    Check not completed because of internal errors
+  2
+    Check completed, image is corrupted
+  3
+    Check completed, image has leaked clusters, but is not corrupted
+  63
+    Checks are not supported by the image format
+
+  If ``-r`` is specified, exit codes representing the image state refer to the
+  state after (the attempt at) repairing it. That is, a successful ``-r all``
+  will yield the exit code 0, independently of the image state before.
+
+.. option:: commit [--object OBJECTDEF] [--image-opts] [-q] [-f FMT] [-t CACHE] [-b BASE] [-d] [-p] FILENAME
+
+  Commit the changes recorded in *FILENAME* in its base image or backing file.
+  If the backing file is smaller than the snapshot, then the backing file will be
+  resized to be the same size as the snapshot.  If the snapshot is smaller than
+  the backing file, the backing file will not be truncated.  If you want the
+  backing file to match the size of the smaller snapshot, you can safely truncate
+  it yourself once the commit operation successfully completes.
+
+  The image *FILENAME* is emptied after the operation has succeeded. If you do
+  not need *FILENAME* afterwards and intend to drop it, you may skip emptying
+  *FILENAME* by specifying the ``-d`` flag.
+
+  If the backing chain of the given image file *FILENAME* has more than one
+  layer, the backing file into which the changes will be committed may be
+  specified as *BASE* (which has to be part of *FILENAME*'s backing
+  chain). If *BASE* is not specified, the immediate backing file of the top
+  image (which is *FILENAME*) will be used. Note that after a commit operation
+  all images between *BASE* and the top image will be invalid and may return
+  garbage data when read. For this reason, ``-b`` implies ``-d`` (so that
+  the top image stays valid).
+
+.. option:: compare [--object OBJECTDEF] [--image-opts] [-f FMT] [-F FMT] [-T SRC_CACHE] [-p] [-q] [-s] [-U] FILENAME1 FILENAME2
+
+  Check if two images have the same content. You can compare images with
+  different format or settings.
+
+  The format is probed unless you specify it by ``-f`` (used for
+  *FILENAME1*) and/or ``-F`` (used for *FILENAME2*) option.
+
+  By default, images with different size are considered identical if the larger
+  image contains only unallocated and/or zeroed sectors in the area after the end
+  of the other image. In addition, if any sector is not allocated in one image
+  and contains only zero bytes in the second one, it is evaluated as equal. You
+  can use Strict mode by specifying the ``-s`` option. When compare runs in
+  Strict mode, it fails in case image size differs or a sector is allocated in
+  one image and is not allocated in the second one.
+
+  By default, compare prints out a result message. This message displays
+  information that both images are same or the position of the first different
+  byte. In addition, result message can report different image size in case
+  Strict mode is used.
+
+  Compare exits with ``0`` in case the images are equal and with ``1``
+  in case the images differ. Other exit codes mean an error occurred during
+  execution and standard error output should contain an error message.
+  The following table sumarizes all exit codes of the compare subcommand:
+
+  0
+    Images are identical
+  1
+    Images differ
+  2
+    Error on opening an image
+  3
+    Error on checking a sector allocation
+  4
+    Error on reading data
+
+.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
+
+  Convert the disk image *FILENAME* or a snapshot *SNAPSHOT_PARAM*
+  to disk image *OUTPUT_FILENAME* using format *OUTPUT_FMT*. It can
+  be optionally compressed (``-c`` option) or use any format specific
+  options like encryption (``-o`` option).
+
+  Only the formats ``qcow`` and ``qcow2`` support compression. The
+  compression is read-only. It means that if a compressed sector is
+  rewritten, then it is rewritten as uncompressed data.
+
+  Image conversion is also useful to get smaller image when using a
+  growable format such as ``qcow``: the empty sectors are detected and
+  suppressed from the destination image.
+
+  *SPARSE_SIZE* indicates the consecutive number of bytes (defaults to 4k)
+  that must contain only zeros for qemu-img to create a sparse image during
+  conversion. If *SPARSE_SIZE* is 0, the source will not be scanned for
+  unallocated or zero sectors, and the destination image will always be
+  fully allocated.
+
+  You can use the *BACKING_FILE* option to force the output image to be
+  created as a copy on write image of the specified base image; the
+  *BACKING_FILE* should have the same content as the input's base image,
+  however the path, image format, etc may differ.
+
+  If a relative path name is given, the backing file is looked up relative to
+  the directory containing *OUTPUT_FILENAME*.
+
+  If the ``-n`` option is specified, the target volume creation will be
+  skipped. This is useful for formats such as ``rbd`` if the target
+  volume has already been created with site specific options that cannot
+  be supplied through qemu-img.
+
+  Out of order writes can be enabled with ``-W`` to improve performance.
+  This is only recommended for preallocated devices like host devices or other
+  raw block devices. Out of order write does not work in combination with
+  creating compressed images.
+
+  *NUM_COROUTINES* specifies how many coroutines work in parallel during
+  the convert process (defaults to 8).
+
+.. option:: create [--object OBJECTDEF] [-q] [-f FMT] [-b BACKING_FILE] [-F BACKING_FMT] [-u] [-o OPTIONS] FILENAME [SIZE]
+
+  Create the new disk image *FILENAME* of size *SIZE* and format
+  *FMT*. Depending on the file format, you can add one or more *OPTIONS*
+  that enable additional features of this format.
+
+  If the option *BACKING_FILE* is specified, then the image will record
+  only the differences from *BACKING_FILE*. No size needs to be specified in
+  this case. *BACKING_FILE* will never be modified unless you use the
+  ``commit`` monitor command (or qemu-img commit).
+
+  If a relative path name is given, the backing file is looked up relative to
+  the directory containing *FILENAME*.
+
+  Note that a given backing file will be opened to check that it is valid. Use
+  the ``-u`` option to enable unsafe backing file mode, which means that the
+  image will be created even if the associated backing file cannot be opened. A
+  matching backing file must be created or additional options be used to make the
+  backing file specification valid when you want to use an image created this
+  way.
+
+  The size can also be specified using the *SIZE* option with ``-o``,
+  it doesn't need to be specified separately in this case.
+
+
+.. option:: dd [--image-opts] [-U] [-f FMT] [-O OUTPUT_FMT] [bs=BLOCK_SIZE] [count=BLOCKS] [skip=BLOCKS] if=INPUT of=OUTPUT
+
+  dd copies from *INPUT* file to *OUTPUT* file converting it from
+  *FMT* format to *OUTPUT_FMT* format.
+
+  The data is by default read and written using blocks of 512 bytes but can be
+  modified by specifying *BLOCK_SIZE*. If count=\ *BLOCKS* is specified
+  dd will stop reading input after reading *BLOCKS* input blocks.
+
+  The size syntax is similar to :manpage:`dd(1)`'s size syntax.
+
+.. option:: info [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [--backing-chain] [-U] FILENAME
+
+  Give information about the disk image *FILENAME*. Use it in
+  particular to know the size reserved on disk which can be different
+  from the displayed size. If VM snapshots are stored in the disk image,
+  they are displayed too.
+
+  If a disk image has a backing file chain, information about each disk image in
+  the chain can be recursively enumerated by using the option ``--backing-chain``.
+
+  For instance, if you have an image chain like:
+
+  ::
+
+    base.qcow2 <- snap1.qcow2 <- snap2.qcow2
+
+  To enumerate information about each disk image in the above chain, starting from top to base, do:
+
+  ::
+
+    qemu-img info --backing-chain snap2.qcow2
+
+  The command can output in the format *OFMT* which is either ``human`` or
+  ``json``.  The JSON output is an object of QAPI type ``ImageInfo``; with
+  ``--backing-chain``, it is an array of ``ImageInfo`` objects.
+
+  ``--output=human`` reports the following information (for every image in the
+  chain):
+
+  *image*
+    The image file name
+
+  *file format*
+    The image format
+
+  *virtual size*
+    The size of the guest disk
+
+  *disk size*
+    How much space the image file occupies on the host file system (may be
+    shown as 0 if this information is unavailable, e.g. because there is no
+    file system)
+
+  *cluster_size*
+    Cluster size of the image format, if applicable
+
+  *encrypted*
+    Whether the image is encrypted (only present if so)
+
+  *cleanly shut down*
+    This is shown as ``no`` if the image is dirty and will have to be
+    auto-repaired the next time it is opened in qemu.
+
+  *backing file*
+    The backing file name, if present
+
+  *backing file format*
+    The format of the backing file, if the image enforces it
+
+  *Snapshot list*
+    A list of all internal snapshots
+
+  *Format specific information*
+    Further information whose structure depends on the image format.  This
+    section is a textual representation of the respective
+    ``ImageInfoSpecific*`` QAPI object (e.g. ``ImageInfoSpecificQCow2``
+    for qcow2 images).
+
+.. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [-U] FILENAME
+
+  Dump the metadata of image *FILENAME* and its backing file chain.
+  In particular, this commands dumps the allocation state of every sector
+  of *FILENAME*, together with the topmost file that allocates it in
+  the backing file chain.
+
+  Two option formats are possible.  The default format (``human``)
+  only dumps known-nonzero areas of the file.  Known-zero parts of the
+  file are omitted altogether, and likewise for parts that are not allocated
+  throughout the chain.  ``qemu-img`` output will identify a file
+  from where the data can be read, and the offset in the file.  Each line
+  will include four fields, the first three of which are hexadecimal
+  numbers.  For example the first line of:
+
+  ::
+
+    Offset          Length          Mapped to       File
+    0               0x20000         0x50000         /tmp/overlay.qcow2
+    0x100000        0x10000         0x95380000      /tmp/backing.qcow2
+
+  means that 0x20000 (131072) bytes starting at offset 0 in the image are
+  available in /tmp/overlay.qcow2 (opened in ``raw`` format) starting
+  at offset 0x50000 (327680).  Data that is compressed, encrypted, or
+  otherwise not available in raw format will cause an error if ``human``
+  format is in use.  Note that file names can include newlines, thus it is
+  not safe to parse this output format in scripts.
+
+  The alternative format ``json`` will return an array of dictionaries
+  in JSON format.  It will include similar information in
+  the ``start``, ``length``, ``offset`` fields;
+  it will also include other more specific information:
+
+  - whether the sectors contain actual data or not (boolean field ``data``;
+    if false, the sectors are either unallocated or stored as optimized
+    all-zero clusters);
+  - whether the data is known to read as zero (boolean field ``zero``);
+  - in order to make the output shorter, the target file is expressed as
+    a ``depth``; for example, a depth of 2 refers to the backing file
+    of the backing file of *FILENAME*.
+
+  In JSON format, the ``offset`` field is optional; it is absent in
+  cases where ``human`` format would omit the entry or exit with an error.
+  If ``data`` is false and the ``offset`` field is present, the
+  corresponding sectors in the file are not yet in use, but they are
+  preallocated.
+
+  For more information, consult ``include/block/block.h`` in QEMU's
+  source code.
+
+.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS] [--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [-l SNAPSHOT_PARAM] FILENAME]
+
+  Calculate the file size required for a new image.  This information
+  can be used to size logical volumes or SAN LUNs appropriately for
+  the image that will be placed in them.  The values reported are
+  guaranteed to be large enough to fit the image.  The command can
+  output in the format *OFMT* which is either ``human`` or ``json``.
+  The JSON output is an object of QAPI type ``BlockMeasureInfo``.
+
+  If the size *N* is given then act as if creating a new empty image file
+  using ``qemu-img create``.  If *FILENAME* is given then act as if
+  converting an existing image file using ``qemu-img convert``.  The format
+  of the new file is given by *OUTPUT_FMT* while the format of an existing
+  file is given by *FMT*.
+
+  A snapshot in an existing image can be specified using *SNAPSHOT_PARAM*.
+
+  The following fields are reported:
+
+  ::
+
+    required size: 524288
+    fully allocated size: 1074069504
+
+  The ``required size`` is the file size of the new image.  It may be smaller
+  than the virtual disk size if the image format supports compact representation.
+
+  The ``fully allocated size`` is the file size of the new image once data has
+  been written to all sectors.  This is the maximum size that the image file can
+  occupy with the exception of internal snapshots, dirty bitmaps, vmstate data,
+  and other advanced image format features.
+
+.. option:: snapshot [--object OBJECTDEF] [--image-opts] [-U] [-q] [-l | -a SNAPSHOT | -c SNAPSHOT | -d SNAPSHOT] FILENAME
+
+  List, apply, create or delete snapshots in image *FILENAME*.
+
+.. option:: rebase [--object OBJECTDEF] [--image-opts] [-U] [-q] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-p] [-u] -b BACKING_FILE [-F BACKING_FMT] FILENAME
+
+  Changes the backing file of an image. Only the formats ``qcow2`` and
+  ``qed`` support changing the backing file.
+
+  The backing file is changed to *BACKING_FILE* and (if the image format of
+  *FILENAME* supports this) the backing file format is changed to
+  *BACKING_FMT*. If *BACKING_FILE* is specified as "" (the empty
+  string), then the image is rebased onto no backing file (i.e. it will exist
+  independently of any backing file).
+
+  If a relative path name is given, the backing file is looked up relative to
+  the directory containing *FILENAME*.
+
+  *CACHE* specifies the cache mode to be used for *FILENAME*, whereas
+  *SRC_CACHE* specifies the cache mode for reading backing files.
+
+  There are two different modes in which ``rebase`` can operate:
+
+  Safe mode
+    This is the default mode and performs a real rebase operation. The
+    new backing file may differ from the old one and qemu-img rebase
+    will take care of keeping the guest-visible content of *FILENAME*
+    unchanged.
+
+    In order to achieve this, any clusters that differ between
+    *BACKING_FILE* and the old backing file of *FILENAME* are merged
+    into *FILENAME* before actually changing the backing file.
+
+    Note that the safe mode is an expensive operation, comparable to
+    converting an image. It only works if the old backing file still
+    exists.
+
+  Unsafe mode
+    qemu-img uses the unsafe mode if ``-u`` is specified. In this
+    mode, only the backing file name and format of *FILENAME* is changed
+    without any checks on the file contents. The user must take care of
+    specifying the correct new backing file, or the guest-visible
+    content of the image will be corrupted.
+
+    This mode is useful for renaming or moving the backing file to
+    somewhere else.  It can be used without an accessible old backing
+    file, i.e. you can use it to fix an image whose backing file has
+    already been moved/renamed.
+
+  You can use ``rebase`` to perform a "diff" operation on two
+  disk images.  This can be useful when you have copied or cloned
+  a guest, and you want to get back to a thin image on top of a
+  template or base image.
+
+  Say that ``base.img`` has been cloned as ``modified.img`` by
+  copying it, and that the ``modified.img`` guest has run so there
+  are now some changes compared to ``base.img``.  To construct a thin
+  image called ``diff.qcow2`` that contains just the differences, do:
+
+  ::
+
+    qemu-img create -f qcow2 -b modified.img diff.qcow2
+    qemu-img rebase -b base.img diff.qcow2
+
+  At this point, ``modified.img`` can be discarded, since
+  ``base.img + diff.qcow2`` contains the same information.
+
+.. option:: resize [--object OBJECTDEF] [--image-opts] [-f FMT] [--preallocation=PREALLOC] [-q] [--shrink] FILENAME [+ | -]SIZE
+
+  Change the disk image as if it had been created with *SIZE*.
+
+  Before using this command to shrink a disk image, you MUST use file system and
+  partitioning tools inside the VM to reduce allocated file systems and partition
+  sizes accordingly.  Failure to do so will result in data loss!
+
+  When shrinking images, the ``--shrink`` option must be given. This informs
+  qemu-img that the user acknowledges all loss of data beyond the truncated
+  image's end.
+
+  After using this command to grow a disk image, you must use file system and
+  partitioning tools inside the VM to actually begin using the new space on the
+  device.
+
+  When growing an image, the ``--preallocation`` option may be used to specify
+  how the additional image area should be allocated on the host.  See the format
+  description in the :ref:`notes` section which values are allowed.  Using this
+  option may result in slightly more data being allocated than necessary.
+
+.. _notes:
+
+Notes
+-----
+
+Supported image file formats:
+
+``raw``
+
+  Raw disk image format (default). This format has the advantage of
+  being simple and easily exportable to all other emulators. If your
+  file system supports *holes* (for example in ext2 or ext3 on
+  Linux or NTFS on Windows), then only the written sectors will reserve
+  space. Use ``qemu-img info`` to know the real size used by the
+  image or ``ls -ls`` on Unix/Linux.
+
+  Supported options:
+
+  ``preallocation``
+    Preallocation mode (allowed values: ``off``, ``falloc``,
+    ``full``).  ``falloc`` mode preallocates space for image by
+    calling ``posix_fallocate()``.  ``full`` mode preallocates space
+    for image by writing data to underlying storage.  This data may or
+    may not be zero, depending on the storage location.
+
+``qcow2``
+
+  QEMU image format, the most versatile format. Use it to have smaller
+  images (useful if your filesystem does not supports holes, for example
+  on Windows), optional AES encryption, zlib based compression and
+  support of multiple VM snapshots.
+
+  Supported options:
+
+  ``compat``
+    Determines the qcow2 version to use. ``compat=0.10`` uses the
+    traditional image format that can be read by any QEMU since 0.10.
+    ``compat=1.1`` enables image format extensions that only QEMU 1.1 and
+    newer understand (this is the default). Amongst others, this includes zero
+    clusters, which allow efficient copy-on-read for sparse images.
+
+  ``backing_file``
+    File name of a base image (see ``create`` subcommand)
+
+  ``backing_fmt``
+    Image format of the base image
+
+  ``encryption``
+    If this option is set to ``on``, the image is encrypted with
+    128-bit AES-CBC.
+
+    The use of encryption in qcow and qcow2 images is considered to be
+    flawed by modern cryptography standards, suffering from a number
+    of design problems:
+
+    - The AES-CBC cipher is used with predictable initialization
+      vectors based on the sector number. This makes it vulnerable to
+      chosen plaintext attacks which can reveal the existence of
+      encrypted data.
+
+    - The user passphrase is directly used as the encryption key. A
+      poorly chosen or short passphrase will compromise the security
+      of the encryption.
+
+    - In the event of the passphrase being compromised there is no way
+      to change the passphrase to protect data in any qcow images. The
+      files must be cloned, using a different encryption passphrase in
+      the new file. The original file must then be securely erased
+      using a program like shred, though even this is ineffective with
+      many modern storage technologies.
+
+    - Initialization vectors used to encrypt sectors are based on the
+      guest virtual sector number, instead of the host physical
+      sector. When a disk image has multiple internal snapshots this
+      means that data in multiple physical sectors is encrypted with
+      the same initialization vector. With the CBC mode, this opens
+      the possibility of watermarking attacks if the attack can
+      collect multiple sectors encrypted with the same IV and some
+      predictable data. Having multiple qcow2 images with the same
+      passphrase also exposes this weakness since the passphrase is
+      directly used as the key.
+
+    Use of qcow / qcow2 encryption is thus strongly discouraged. Users are
+    recommended to use an alternative encryption technology such as the
+    Linux dm-crypt / LUKS system.
+
+  ``cluster_size``
+    Changes the qcow2 cluster size (must be between 512 and
+    2M). Smaller cluster sizes can improve the image file size whereas
+    larger cluster sizes generally provide better performance.
+
+  ``preallocation``
+    Preallocation mode (allowed values: ``off``, ``metadata``,
+    ``falloc``, ``full``). An image with preallocated metadata is
+    initially larger but can improve performance when the image needs
+    to grow. ``falloc`` and ``full`` preallocations are like the same
+    options of ``raw`` format, but sets up metadata also.
+
+  ``lazy_refcounts``
+    If this option is set to ``on``, reference count updates are
+    postponed with the goal of avoiding metadata I/O and improving
+    performance. This is particularly interesting with
+    ``cache=writethrough`` which doesn't batch metadata
+    updates. The tradeoff is that after a host crash, the reference
+    count tables must be rebuilt, i.e. on the next open an (automatic)
+    ``qemu-img check -r all`` is required, which may take some time.
+
+    This option can only be enabled if ``compat=1.1`` is specified.
+
+  ``nocow``
+    If this option is set to ``on``, it will turn off COW of the file. It's
+    only valid on btrfs, no effect on other file systems.
+
+    Btrfs has low performance when hosting a VM image file, even more
+    when the guest on the VM also using btrfs as file system. Turning
+    off COW is a way to mitigate this bad performance. Generally there
+    are two ways to turn off COW on btrfs:
+
+    - Disable it by mounting with nodatacow, then all newly created files
+      will be NOCOW
+    - For an empty file, add the NOCOW file attribute. That's what this
+      option does.
+
+    Note: this option is only valid to new or empty files. If there is
+    an existing file which is COW and has data blocks already, it
+    couldn't be changed to NOCOW by setting ``nocow=on``. One can
+    issue ``lsattr filename`` to check if the NOCOW flag is set or not
+    (Capital 'C' is NOCOW flag).
+
+``Other``
+
+  QEMU also supports various other image file formats for
+  compatibility with older QEMU versions or other hypervisors,
+  including VMDK, VDI, VHD (vpc), VHDX, qcow1 and QED. For a full list
+  of supported formats see ``qemu-img --help``.  For a more detailed
+  description of these formats, see the QEMU block drivers reference
+  documentation.
+
+  The main purpose of the block drivers for these formats is image
+  conversion.  For running VMs, it is recommended to convert the disk
+  images to either raw or qcow2 in order to achieve good performance.
diff --git a/qemu-doc.texi b/qemu-doc.texi
index b79f1c340bd..a1ef6b64846 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -632,7 +632,6 @@ encrypted disk images.
 * disk_images_quickstart::    Quick start for disk image creation
 * disk_images_snapshot_mode:: Snapshot mode
 * vm_snapshots::              VM snapshots
-* qemu_img_invocation::       qemu-img Invocation
 @end menu
 
 @node disk_images_quickstart
@@ -646,7 +645,9 @@ where @var{myimage.img} is the disk image filename and @var{mysize} is its
 size in kilobytes. You can add an @code{M} suffix to give the size in
 megabytes and a @code{G} suffix for gigabytes.
 
-See @ref{qemu_img_invocation} for more information.
+@c When this document is converted to rst we should make this into
+@c a proper linked reference to the qemu-img documentation again:
+See the qemu-img invocation documentation for more information.
 
 @node disk_images_snapshot_mode
 @subsection Snapshot mode
@@ -708,11 +709,6 @@ A few device drivers still have incomplete snapshot support so their
 state is not saved or restored properly (in particular USB).
 @end itemize
 
-@node qemu_img_invocation
-@subsection @code{qemu-img} Invocation
-
-@include qemu-img.texi
-
 @node pcsys_network
 @section Network emulation
 
diff --git a/qemu-img.texi b/qemu-img.texi
deleted file mode 100644
index 20136fcb940..00000000000
--- a/qemu-img.texi
+++ /dev/null
@@ -1,798 +0,0 @@
-@example
-@c man begin SYNOPSIS
-@command{qemu-img} [@var{standard} @var{options}] @var{command} [@var{command} @var{options}]
-@c man end
-@end example
-
-@c man begin DESCRIPTION
-qemu-img allows you to create, convert and modify images offline. It can handle
-all image formats supported by QEMU.
-
-@b{Warning:} Never use qemu-img to modify images in use by a running virtual
-machine or any other process; this may destroy the image. Also, be aware that
-querying an image that is being modified by another process may encounter
-inconsistent state.
-@c man end
-
-@c man begin OPTIONS
-
-Standard options:
-@table @option
-@item -h, --help
-Display this help and exit
-@item -V, --version
-Display version information and exit
-@item -T, --trace [[enable=]@var{pattern}][,events=@var{file}][,file=@var{file}]
-@findex --trace
-@include qemu-option-trace.texi
-@end table
-
-The following commands are supported:
-
-@include qemu-img-cmds.texi
-
-Command parameters:
-@table @var
-
-@item filename
-is a disk image filename
-
-@item fmt
-is the disk image format. It is guessed automatically in most cases. See below
-for a description of the supported disk formats.
-
-@item size
-is the disk image size in bytes. Optional suffixes @code{k} or @code{K}
-(kilobyte, 1024) @code{M} (megabyte, 1024k) and @code{G} (gigabyte, 1024M)
-and T (terabyte, 1024G) are supported.  @code{b} is ignored.
-
-@item output_filename
-is the destination disk image filename
-
-@item output_fmt
-is the destination format
-
-@item options
-is a comma separated list of format specific options in a
-name=value format. Use @code{-o ?} for an overview of the options supported
-by the used format or see the format descriptions below for details.
-
-@item snapshot_param
-is param used for internal snapshot, format is
-'snapshot.id=[ID],snapshot.name=[NAME]' or '[ID_OR_NAME]'
-
-@end table
-
-@table @option
-
-@item --object @var{objectdef}
-is a QEMU user creatable object definition. See the @code{qemu(1)} manual
-page for a description of the object properties. The most common object
-type is a @code{secret}, which is used to supply passwords and/or encryption
-keys.
-
-@item --image-opts
-Indicates that the source @var{filename} parameter is to be interpreted as a
-full option string, not a plain filename. This parameter is mutually
-exclusive with the @var{-f} parameter.
-
-@item --target-image-opts
-Indicates that the @var{output_filename} parameter(s) are to be interpreted as
-a full option string, not a plain filename. This parameter is mutually
-exclusive with the @var{-O} parameters. It is currently required to also use
-the @var{-n} parameter to skip image creation. This restriction may be relaxed
-in a future release.
-
-@item --force-share (-U)
-If specified, @code{qemu-img} will open the image in shared mode, allowing
-other QEMU processes to open it in write mode. For example, this can be used to
-get the image information (with 'info' subcommand) when the image is used by a
-running guest.  Note that this could produce inconsistent results because of
-concurrent metadata changes, etc. This option is only allowed when opening
-images in read-only mode.
-
-@item --backing-chain
-will enumerate information about backing files in a disk image chain. Refer
-below for further description.
-
-@item -c
-indicates that target image must be compressed (qcow format only)
-
-@item -h
-with or without a command shows help and lists the supported formats
-
-@item -p
-display progress bar (compare, convert and rebase commands only).
-If the @var{-p} option is not used for a command that supports it, the
-progress is reported when the process receives a @code{SIGUSR1} or
-@code{SIGINFO} signal.
-
-@item -q
-Quiet mode - do not print any output (except errors). There's no progress bar
-in case both @var{-q} and @var{-p} options are used.
-
-@item -S @var{size}
-indicates the consecutive number of bytes that must contain only zeros
-for qemu-img to create a sparse image during conversion. This value is rounded
-down to the nearest 512 bytes. You may use the common size suffixes like
-@code{k} for kilobytes.
-
-@item -t @var{cache}
-specifies the cache mode that should be used with the (destination) file. See
-the documentation of the emulator's @code{-drive cache=...} option for allowed
-values.
-
-@item -T @var{src_cache}
-specifies the cache mode that should be used with the source file(s). See
-the documentation of the emulator's @code{-drive cache=...} option for allowed
-values.
-
-@end table
-
-Parameters to snapshot subcommand:
-
-@table @option
-
-@item snapshot
-is the name of the snapshot to create, apply or delete
-@item -a
-applies a snapshot (revert disk to saved state)
-@item -c
-creates a snapshot
-@item -d
-deletes a snapshot
-@item -l
-lists all snapshots in the given image
-@end table
-
-Parameters to compare subcommand:
-
-@table @option
-
-@item -f
-First image format
-@item -F
-Second image format
-@item -s
-Strict mode - fail on different image size or sector allocation
-@end table
-
-Parameters to convert subcommand:
-
-@table @option
-
-@item -n
-Skip the creation of the target volume
-@item -m
-Number of parallel coroutines for the convert process
-@item -W
-Allow out-of-order writes to the destination. This option improves performance,
-but is only recommended for preallocated devices like host devices or other
-raw block devices.
-@item -C
-Try to use copy offloading to move data from source image to target. This may
-improve performance if the data is remote, such as with NFS or iSCSI backends,
-but will not automatically sparsify zero sectors, and may result in a fully
-allocated target image depending on the host support for getting allocation
-information.
-@item --salvage
-Try to ignore I/O errors when reading.  Unless in quiet mode (@code{-q}), errors
-will still be printed.  Areas that cannot be read from the source will be
-treated as containing only zeroes.
-@end table
-
-Parameters to dd subcommand:
-
-@table @option
-
-@item bs=@var{block_size}
-defines the block size
-@item count=@var{blocks}
-sets the number of input blocks to copy
-@item if=@var{input}
-sets the input file
-@item of=@var{output}
-sets the output file
-@item skip=@var{blocks}
-sets the number of input blocks to skip
-@end table
-
-Command description:
-
-@table @option
-
-@item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
-
-Amends the image format specific @var{options} for the image file
-@var{filename}. Not all file formats support this operation.
-
-@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-interval=@var{flush_interval}] [-n] [-i @var{aio}] [--no-drain] [-o @var{offset}] [--pattern=@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @var{cache}] [-w] [-U] @var{filename}
-
-Run a simple sequential I/O benchmark on the specified image. If @code{-w} is
-specified, a write test is performed, otherwise a read test is performed.
-
-A total number of @var{count} I/O requests is performed, each @var{buffer_size}
-bytes in size, and with @var{depth} requests in parallel. The first request
-starts at the position given by @var{offset}, each following request increases
-the current position by @var{step_size}. If @var{step_size} is not given,
-@var{buffer_size} is used for its value.
-
-If @var{flush_interval} is specified for a write test, the request queue is
-drained and a flush is issued before new writes are made whenever the number of
-remaining requests is a multiple of @var{flush_interval}. If additionally
-@code{--no-drain} is specified, a flush is issued without draining the request
-queue first.
-
-If @code{-n} is specified, the native AIO backend is used if possible. On
-Linux, this option only works if @code{-t none} or @code{-t directsync} is
-specified as well.
-
-If @code{-i} is specified, aio option can be used to specify different AIO
-backends: @var{threads}, @var{native} or @var{io_uring}.
-
-For write tests, by default a buffer filled with zeros is written. This can be
-overridden with a pattern byte specified by @var{pattern}.
-
-@item check [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] [--output=@var{ofmt}] [-r [leaks | all]] [-T @var{src_cache}] [-U] @var{filename}
-
-Perform a consistency check on the disk image @var{filename}. The command can
-output in the format @var{ofmt} which is either @code{human} or @code{json}.
-The JSON output is an object of QAPI type @code{ImageCheck}.
-
-If @code{-r} is specified, qemu-img tries to repair any inconsistencies found
-during the check. @code{-r leaks} repairs only cluster leaks, whereas
-@code{-r all} fixes all kinds of errors, with a higher risk of choosing the
-wrong fix or hiding corruption that has already occurred.
-
-Only the formats @code{qcow2}, @code{qed} and @code{vdi} support
-consistency checks.
-
-In case the image does not have any inconsistencies, check exits with @code{0}.
-Other exit codes indicate the kind of inconsistency found or if another error
-occurred. The following table summarizes all exit codes of the check subcommand:
-
-@table @option
-
-@item 0
-Check completed, the image is (now) consistent
-@item 1
-Check not completed because of internal errors
-@item 2
-Check completed, image is corrupted
-@item 3
-Check completed, image has leaked clusters, but is not corrupted
-@item 63
-Checks are not supported by the image format
-
-@end table
-
-If @code{-r} is specified, exit codes representing the image state refer to the
-state after (the attempt at) repairing it. That is, a successful @code{-r all}
-will yield the exit code 0, independently of the image state before.
-
-@item commit [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] [-t @var{cache}] [-b @var{base}] [-d] [-p] @var{filename}
-
-Commit the changes recorded in @var{filename} in its base image or backing file.
-If the backing file is smaller than the snapshot, then the backing file will be
-resized to be the same size as the snapshot.  If the snapshot is smaller than
-the backing file, the backing file will not be truncated.  If you want the
-backing file to match the size of the smaller snapshot, you can safely truncate
-it yourself once the commit operation successfully completes.
-
-The image @var{filename} is emptied after the operation has succeeded. If you do
-not need @var{filename} afterwards and intend to drop it, you may skip emptying
-@var{filename} by specifying the @code{-d} flag.
-
-If the backing chain of the given image file @var{filename} has more than one
-layer, the backing file into which the changes will be committed may be
-specified as @var{base} (which has to be part of @var{filename}'s backing
-chain). If @var{base} is not specified, the immediate backing file of the top
-image (which is @var{filename}) will be used. Note that after a commit operation
-all images between @var{base} and the top image will be invalid and may return
-garbage data when read. For this reason, @code{-b} implies @code{-d} (so that
-the top image stays valid).
-
-@item compare [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [-F @var{fmt}] [-T @var{src_cache}] [-p] [-q] [-s] [-U] @var{filename1} @var{filename2}
-
-Check if two images have the same content. You can compare images with
-different format or settings.
-
-The format is probed unless you specify it by @var{-f} (used for
-@var{filename1}) and/or @var{-F} (used for @var{filename2}) option.
-
-By default, images with different size are considered identical if the larger
-image contains only unallocated and/or zeroed sectors in the area after the end
-of the other image. In addition, if any sector is not allocated in one image
-and contains only zero bytes in the second one, it is evaluated as equal. You
-can use Strict mode by specifying the @var{-s} option. When compare runs in
-Strict mode, it fails in case image size differs or a sector is allocated in
-one image and is not allocated in the second one.
-
-By default, compare prints out a result message. This message displays
-information that both images are same or the position of the first different
-byte. In addition, result message can report different image size in case
-Strict mode is used.
-
-Compare exits with @code{0} in case the images are equal and with @code{1}
-in case the images differ. Other exit codes mean an error occurred during
-execution and standard error output should contain an error message.
-The following table sumarizes all exit codes of the compare subcommand:
-
-@table @option
-
-@item 0
-Images are identical
-@item 1
-Images differ
-@item 2
-Error on opening an image
-@item 3
-Error on checking a sector allocation
-@item 4
-Error on reading data
-
-@end table
-
-@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
-
-Convert the disk image @var{filename} or a snapshot @var{snapshot_param}
-to disk image @var{output_filename} using format @var{output_fmt}. It can be optionally compressed (@code{-c}
-option) or use any format specific options like encryption (@code{-o} option).
-
-Only the formats @code{qcow} and @code{qcow2} support compression. The
-compression is read-only. It means that if a compressed sector is
-rewritten, then it is rewritten as uncompressed data.
-
-Image conversion is also useful to get smaller image when using a
-growable format such as @code{qcow}: the empty sectors are detected and
-suppressed from the destination image.
-
-@var{sparse_size} indicates the consecutive number of bytes (defaults to 4k)
-that must contain only zeros for qemu-img to create a sparse image during
-conversion. If @var{sparse_size} is 0, the source will not be scanned for
-unallocated or zero sectors, and the destination image will always be
-fully allocated.
-
-You can use the @var{backing_file} option to force the output image to be
-created as a copy on write image of the specified base image; the
-@var{backing_file} should have the same content as the input's base image,
-however the path, image format, etc may differ.
-
-If a relative path name is given, the backing file is looked up relative to
-the directory containing @var{output_filename}.
-
-If the @code{-n} option is specified, the target volume creation will be
-skipped. This is useful for formats such as @code{rbd} if the target
-volume has already been created with site specific options that cannot
-be supplied through qemu-img.
-
-Out of order writes can be enabled with @code{-W} to improve performance.
-This is only recommended for preallocated devices like host devices or other
-raw block devices. Out of order write does not work in combination with
-creating compressed images.
-
-@var{num_coroutines} specifies how many coroutines work in parallel during
-the convert process (defaults to 8).
-
-@item create [--object @var{objectdef}] [-q] [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_fmt}] [-u] [-o @var{options}] @var{filename} [@var{size}]
-
-Create the new disk image @var{filename} of size @var{size} and format
-@var{fmt}. Depending on the file format, you can add one or more @var{options}
-that enable additional features of this format.
-
-If the option @var{backing_file} is specified, then the image will record
-only the differences from @var{backing_file}. No size needs to be specified in
-this case. @var{backing_file} will never be modified unless you use the
-@code{commit} monitor command (or qemu-img commit).
-
-If a relative path name is given, the backing file is looked up relative to
-the directory containing @var{filename}.
-
-Note that a given backing file will be opened to check that it is valid. Use
-the @code{-u} option to enable unsafe backing file mode, which means that the
-image will be created even if the associated backing file cannot be opened. A
-matching backing file must be created or additional options be used to make the
-backing file specification valid when you want to use an image created this
-way.
-
-The size can also be specified using the @var{size} option with @code{-o},
-it doesn't need to be specified separately in this case.
-
-@item dd [--image-opts] [-U] [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
-
-Dd copies from @var{input} file to @var{output} file converting it from
-@var{fmt} format to @var{output_fmt} format.
-
-The data is by default read and written using blocks of 512 bytes but can be
-modified by specifying @var{block_size}. If count=@var{blocks} is specified
-dd will stop reading input after reading @var{blocks} input blocks.
-
-The size syntax is similar to dd(1)'s size syntax.
-
-@item info [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] [--backing-chain] [-U] @var{filename}
-
-Give information about the disk image @var{filename}. Use it in
-particular to know the size reserved on disk which can be different
-from the displayed size. If VM snapshots are stored in the disk image,
-they are displayed too.
-
-If a disk image has a backing file chain, information about each disk image in
-the chain can be recursively enumerated by using the option @code{--backing-chain}.
-
-For instance, if you have an image chain like:
-
-@example
-base.qcow2 <- snap1.qcow2 <- snap2.qcow2
-@end example
-
-To enumerate information about each disk image in the above chain, starting from top to base, do:
-
-@example
-qemu-img info --backing-chain snap2.qcow2
-@end example
-
-The command can output in the format @var{ofmt} which is either @code{human} or
-@code{json}.  The JSON output is an object of QAPI type @code{ImageInfo}; with
-@code{--backing-chain}, it is an array of @code{ImageInfo} objects.
-
-@code{--output=human} reports the following information (for every image in the
-chain):
-@table @var
-@item image
-The image file name
-
-@item file format
-The image format
-
-@item virtual size
-The size of the guest disk
-
-@item disk size
-How much space the image file occupies on the host file system (may be shown as
-0 if this information is unavailable, e.g. because there is no file system)
-
-@item cluster_size
-Cluster size of the image format, if applicable
-
-@item encrypted
-Whether the image is encrypted (only present if so)
-
-@item cleanly shut down
-This is shown as @code{no} if the image is dirty and will have to be
-auto-repaired the next time it is opened in qemu.
-
-@item backing file
-The backing file name, if present
-
-@item backing file format
-The format of the backing file, if the image enforces it
-
-@item Snapshot list
-A list of all internal snapshots
-
-@item Format specific information
-Further information whose structure depends on the image format.  This section
-is a textual representation of the respective @code{ImageInfoSpecific*} QAPI
-object (e.g. @code{ImageInfoSpecificQCow2} for qcow2 images).
-@end table
-
-@item map [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] [-U] @var{filename}
-
-Dump the metadata of image @var{filename} and its backing file chain.
-In particular, this commands dumps the allocation state of every sector
-of @var{filename}, together with the topmost file that allocates it in
-the backing file chain.
-
-Two option formats are possible.  The default format (@code{human})
-only dumps known-nonzero areas of the file.  Known-zero parts of the
-file are omitted altogether, and likewise for parts that are not allocated
-throughout the chain.  @command{qemu-img} output will identify a file
-from where the data can be read, and the offset in the file.  Each line
-will include four fields, the first three of which are hexadecimal
-numbers.  For example the first line of:
-@example
-Offset          Length          Mapped to       File
-0               0x20000         0x50000         /tmp/overlay.qcow2
-0x100000        0x10000         0x95380000      /tmp/backing.qcow2
-@end example
-@noindent
-means that 0x20000 (131072) bytes starting at offset 0 in the image are
-available in /tmp/overlay.qcow2 (opened in @code{raw} format) starting
-at offset 0x50000 (327680).  Data that is compressed, encrypted, or
-otherwise not available in raw format will cause an error if @code{human}
-format is in use.  Note that file names can include newlines, thus it is
-not safe to parse this output format in scripts.
-
-The alternative format @code{json} will return an array of dictionaries
-in JSON format.  It will include similar information in
-the @code{start}, @code{length}, @code{offset} fields;
-it will also include other more specific information:
-@itemize @minus
-@item
-whether the sectors contain actual data or not (boolean field @code{data};
-if false, the sectors are either unallocated or stored as optimized
-all-zero clusters);
-
-@item
-whether the data is known to read as zero (boolean field @code{zero});
-
-@item
-in order to make the output shorter, the target file is expressed as
-a @code{depth}; for example, a depth of 2 refers to the backing file
-of the backing file of @var{filename}.
-@end itemize
-
-In JSON format, the @code{offset} field is optional; it is absent in
-cases where @code{human} format would omit the entry or exit with an error.
-If @code{data} is false and the @code{offset} field is present, the
-corresponding sectors in the file are not yet in use, but they are
-preallocated.
-
-For more information, consult @file{include/block/block.h} in QEMU's
-source code.
-
-@item measure [--output=@var{ofmt}] [-O @var{output_fmt}] [-o @var{options}] [--size @var{N} | [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [-l @var{snapshot_param}] @var{filename}]
-
-Calculate the file size required for a new image.  This information can be used
-to size logical volumes or SAN LUNs appropriately for the image that will be
-placed in them.  The values reported are guaranteed to be large enough to fit
-the image.  The command can output in the format @var{ofmt} which is either
-@code{human} or @code{json}.  The JSON output is an object of QAPI type
-@code{BlockMeasureInfo}.
-
-If the size @var{N} is given then act as if creating a new empty image file
-using @command{qemu-img create}.  If @var{filename} is given then act as if
-converting an existing image file using @command{qemu-img convert}.  The format
-of the new file is given by @var{output_fmt} while the format of an existing
-file is given by @var{fmt}.
-
-A snapshot in an existing image can be specified using @var{snapshot_param}.
-
-The following fields are reported:
-@example
-required size: 524288
-fully allocated size: 1074069504
-@end example
-
-The @code{required size} is the file size of the new image.  It may be smaller
-than the virtual disk size if the image format supports compact representation.
-
-The @code{fully allocated size} is the file size of the new image once data has
-been written to all sectors.  This is the maximum size that the image file can
-occupy with the exception of internal snapshots, dirty bitmaps, vmstate data,
-and other advanced image format features.
-
-@item snapshot [--object @var{objectdef}] [--image-opts] [-U] [-q] [-l | -a @var{snapshot} | -c @var{snapshot} | -d @var{snapshot}] @var{filename}
-
-List, apply, create or delete snapshots in image @var{filename}.
-
-@item rebase [--object @var{objectdef}] [--image-opts] [-U] [-q] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-p] [-u] -b @var{backing_file} [-F @var{backing_fmt}] @var{filename}
-
-Changes the backing file of an image. Only the formats @code{qcow2} and
-@code{qed} support changing the backing file.
-
-The backing file is changed to @var{backing_file} and (if the image format of
-@var{filename} supports this) the backing file format is changed to
-@var{backing_fmt}. If @var{backing_file} is specified as ``'' (the empty
-string), then the image is rebased onto no backing file (i.e. it will exist
-independently of any backing file).
-
-If a relative path name is given, the backing file is looked up relative to
-the directory containing @var{filename}.
-
-@var{cache} specifies the cache mode to be used for @var{filename}, whereas
-@var{src_cache} specifies the cache mode for reading backing files.
-
-There are two different modes in which @code{rebase} can operate:
-@table @option
-@item Safe mode
-This is the default mode and performs a real rebase operation. The new backing
-file may differ from the old one and qemu-img rebase will take care of keeping
-the guest-visible content of @var{filename} unchanged.
-
-In order to achieve this, any clusters that differ between @var{backing_file}
-and the old backing file of @var{filename} are merged into @var{filename}
-before actually changing the backing file.
-
-Note that the safe mode is an expensive operation, comparable to converting
-an image. It only works if the old backing file still exists.
-
-@item Unsafe mode
-qemu-img uses the unsafe mode if @code{-u} is specified. In this mode, only the
-backing file name and format of @var{filename} is changed without any checks
-on the file contents. The user must take care of specifying the correct new
-backing file, or the guest-visible content of the image will be corrupted.
-
-This mode is useful for renaming or moving the backing file to somewhere else.
-It can be used without an accessible old backing file, i.e. you can use it to
-fix an image whose backing file has already been moved/renamed.
-@end table
-
-You can use @code{rebase} to perform a ``diff'' operation on two
-disk images.  This can be useful when you have copied or cloned
-a guest, and you want to get back to a thin image on top of a
-template or base image.
-
-Say that @code{base.img} has been cloned as @code{modified.img} by
-copying it, and that the @code{modified.img} guest has run so there
-are now some changes compared to @code{base.img}.  To construct a thin
-image called @code{diff.qcow2} that contains just the differences, do:
-
-@example
-qemu-img create -f qcow2 -b modified.img diff.qcow2
-qemu-img rebase -b base.img diff.qcow2
-@end example
-
-At this point, @code{modified.img} can be discarded, since
-@code{base.img + diff.qcow2} contains the same information.
-
-@item resize [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--preallocation=@var{prealloc}] [-q] [--shrink] @var{filename} [+ | -]@var{size}
-
-Change the disk image as if it had been created with @var{size}.
-
-Before using this command to shrink a disk image, you MUST use file system and
-partitioning tools inside the VM to reduce allocated file systems and partition
-sizes accordingly.  Failure to do so will result in data loss!
-
-When shrinking images, the @code{--shrink} option must be given. This informs
-qemu-img that the user acknowledges all loss of data beyond the truncated
-image's end.
-
-After using this command to grow a disk image, you must use file system and
-partitioning tools inside the VM to actually begin using the new space on the
-device.
-
-When growing an image, the @code{--preallocation} option may be used to specify
-how the additional image area should be allocated on the host.  See the format
-description in the @code{NOTES} section which values are allowed.  Using this
-option may result in slightly more data being allocated than necessary.
-
-@end table
-@c man end
-
-@ignore
-@c man begin NOTES
-Supported image file formats:
-
-@table @option
-@item raw
-
-Raw disk image format (default). This format has the advantage of
-being simple and easily exportable to all other emulators. If your
-file system supports @emph{holes} (for example in ext2 or ext3 on
-Linux or NTFS on Windows), then only the written sectors will reserve
-space. Use @code{qemu-img info} to know the real size used by the
-image or @code{ls -ls} on Unix/Linux.
-
-Supported options:
-@table @code
-@item preallocation
-Preallocation mode (allowed values: @code{off}, @code{falloc}, @code{full}).
-@code{falloc} mode preallocates space for image by calling posix_fallocate().
-@code{full} mode preallocates space for image by writing data to underlying
-storage.  This data may or may not be zero, depending on the storage location.
-@end table
-
-@item qcow2
-QEMU image format, the most versatile format. Use it to have smaller
-images (useful if your filesystem does not supports holes, for example
-on Windows), optional AES encryption, zlib based compression and
-support of multiple VM snapshots.
-
-Supported options:
-@table @code
-@item compat
-Determines the qcow2 version to use. @code{compat=0.10} uses the
-traditional image format that can be read by any QEMU since 0.10.
-@code{compat=1.1} enables image format extensions that only QEMU 1.1 and
-newer understand (this is the default). Amongst others, this includes zero
-clusters, which allow efficient copy-on-read for sparse images.
-
-@item backing_file
-File name of a base image (see @option{create} subcommand)
-@item backing_fmt
-Image format of the base image
-@item encryption
-If this option is set to @code{on}, the image is encrypted with 128-bit AES-CBC.
-
-The use of encryption in qcow and qcow2 images is considered to be flawed by
-modern cryptography standards, suffering from a number of design problems:
-
-@itemize @minus
-@item
-The AES-CBC cipher is used with predictable initialization vectors based
-on the sector number. This makes it vulnerable to chosen plaintext attacks
-which can reveal the existence of encrypted data.
-@item
-The user passphrase is directly used as the encryption key. A poorly
-chosen or short passphrase will compromise the security of the encryption.
-@item
-In the event of the passphrase being compromised there is no way to
-change the passphrase to protect data in any qcow images. The files must
-be cloned, using a different encryption passphrase in the new file. The
-original file must then be securely erased using a program like shred,
-though even this is ineffective with many modern storage technologies.
-@item
-Initialization vectors used to encrypt sectors are based on the
-guest virtual sector number, instead of the host physical sector. When
-a disk image has multiple internal snapshots this means that data in
-multiple physical sectors is encrypted with the same initialization
-vector. With the CBC mode, this opens the possibility of watermarking
-attacks if the attack can collect multiple sectors encrypted with the
-same IV and some predictable data. Having multiple qcow2 images with
-the same passphrase also exposes this weakness since the passphrase
-is directly used as the key.
-@end itemize
-
-Use of qcow / qcow2 encryption is thus strongly discouraged. Users are
-recommended to use an alternative encryption technology such as the
-Linux dm-crypt / LUKS system.
-
-@item cluster_size
-Changes the qcow2 cluster size (must be between 512 and 2M). Smaller cluster
-sizes can improve the image file size whereas larger cluster sizes generally
-provide better performance.
-
-@item preallocation
-Preallocation mode (allowed values: @code{off}, @code{metadata}, @code{falloc},
-@code{full}). An image with preallocated metadata is initially larger but can
-improve performance when the image needs to grow. @code{falloc} and @code{full}
-preallocations are like the same options of @code{raw} format, but sets up
-metadata also.
-
-@item lazy_refcounts
-If this option is set to @code{on}, reference count updates are postponed with
-the goal of avoiding metadata I/O and improving performance. This is
-particularly interesting with @option{cache=writethrough} which doesn't batch
-metadata updates. The tradeoff is that after a host crash, the reference count
-tables must be rebuilt, i.e. on the next open an (automatic) @code{qemu-img
-check -r all} is required, which may take some time.
-
-This option can only be enabled if @code{compat=1.1} is specified.
-
-@item nocow
-If this option is set to @code{on}, it will turn off COW of the file. It's only
-valid on btrfs, no effect on other file systems.
-
-Btrfs has low performance when hosting a VM image file, even more when the guest
-on the VM also using btrfs as file system. Turning off COW is a way to mitigate
-this bad performance. Generally there are two ways to turn off COW on btrfs:
-a) Disable it by mounting with nodatacow, then all newly created files will be
-NOCOW. b) For an empty file, add the NOCOW file attribute. That's what this option
-does.
-
-Note: this option is only valid to new or empty files. If there is an existing
-file which is COW and has data blocks already, it couldn't be changed to NOCOW
-by setting @code{nocow=on}. One can issue @code{lsattr filename} to check if
-the NOCOW flag is set or not (Capital 'C' is NOCOW flag).
-
-@end table
-
-@item Other
-QEMU also supports various other image file formats for compatibility with
-older QEMU versions or other hypervisors, including VMDK, VDI, VHD (vpc), VHDX,
-qcow1 and QED. For a full list of supported formats see @code{qemu-img --help}.
-For a more detailed description of these formats, see the QEMU Emulation User
-Documentation.
-
-The main purpose of the block drivers for these formats is image conversion.
-For running VMs, it is recommended to convert the disk images to either raw or
-qcow2 in order to achieve good performance.
-@end table
-
-
-@c man end
-
-@setfilename qemu-img
-@settitle QEMU disk image utility
-
-@c man begin SEEALSO
-The HTML documentation of QEMU for more precise information and Linux
-user mode emulator invocation.
-@c man end
-
-@c man begin AUTHOR
-Fabrice Bellard
-@c man end
-
-@end ignore
-- 
2.20.1


