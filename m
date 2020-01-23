Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C2CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C64122464
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SuOWTaZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C64122464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuglw-0000kL-VT
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:00:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRo-0000WA-KP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRe-0003pl-UC
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:08 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35659)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iueRe-0003nC-E3
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:58 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so2998996wmb.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=zMlHNoRwh4yPNnOGjj4od/YG3+AUapjjoEKQXA71MrI=;
 b=SuOWTaZkdzDhEI1AImn5Bt0P6c8Iw6mCoUgMN3qHF12y0I8QkSxkG1NJSZoYaEbuQT
 TZ0wfAJUcdizd39PWlzjqWm7D5V6iY4kVV0fWh6KC2igRH4sZSzi0mLmqU93gPzT0Qsi
 04lfjUf8eWAl31ncL7OHxaJ7vXtDuRzgq8GEA3Er1TZ9xjgsCjJt7vdYbA6qyn8m3aRr
 pSuI+haZ52LnwacJgXmtgY/SqbqQkgYk83fBjIq1iZGzc3QCjKdPgJFYstXLSlFQvOeS
 Ghma6RBRSZvaTr0qap/IeWxcxDg+6XR9gpm7Rgdo3PmefSRElM2lX/ExcYYtV5aAiuXI
 Cg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zMlHNoRwh4yPNnOGjj4od/YG3+AUapjjoEKQXA71MrI=;
 b=EsugdxJISUhOqpS3vX9SBLZtuA3FkB+A6ggCA8jZJv8mDv7sg6cI3SD9kLj7JlxmR8
 PzPegKCTMkxI6ubdSpfx/16yvs8XxxZl1CmAaRr4CkkP40XFziBkvFDPRij124LmclFu
 XwYuU75tFgJAK0M62EZ4azkCLyfrd9UGzr8+0NKpt8tZFIRlMx/JCZV4m7XpWMu7oN5F
 wcfGVghK+YF4Jk6cItMyd4I7rFPI6KH8w/Xj9nyvnjBHTXXMK4dkRchx3loo41mrYENa
 T0U63Ag6gwDPB7Phip87EBCfJqwkhlIsTJAUvMAQMBZ55wI4gSxR3prU6yXrP9w+lxd7
 +OuA==
X-Gm-Message-State: APjAAAV4l4tRmVLOax0wb5Aq5ZfaCqhyxSTd96H3ZNXh2EDNpC7iwAxx
 RSbxbg2As9iGGDaCmTW/gsUkHkyDZbA6aQ==
X-Google-Smtp-Source: APXvYqx25CvZeRqvlfLxE1jFZ19WEzMGmI1C63FELLEMsSXPLLDOSQuW683Na07R72677SI5RWQfcg==
X-Received: by 2002:a1c:7718:: with SMTP id t24mr4015537wmi.119.1579793454645; 
 Thu, 23 Jan 2020 07:30:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm2903592wme.35.2020.01.23.07.30.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 07:30:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/20] qemu-block-drivers: Convert to rST
Date: Thu, 23 Jan 2020 15:30:31 +0000
Message-Id: <20200123153041.4248-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153041.4248-1-peter.maydell@linaro.org>
References: <20200123153041.4248-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

The qemu-block-drivers documentation is currently in
docs/qemu-block-drivers.texi in Texinfo format, which we present
to the user as:
 * a qemu-block-drivers manpage
 * a section of the main qemu-doc HTML documentation

Convert the documentation to rST format, and present it to
the user as:
 * a qemu-block-drivers manpage
 * part of the system/ Sphinx manual

This follows the same pattern we've done for qemu-ga and qemu-nbd.

We have to drop a cross-reference from the documentation of the
-cdrom option back to the qemu-block-drivers documentation, since
they're no longer within the same texinfo document.

As noted in a comment, the manpage output is slightly compromised
due to limitations in Sphinx. In an ideal world, the HTML output
would have the various headings like 'Disk image file formats'
as top-level section headings (which then appear in the overall
system manual's table-of-contents), and it would not have the
section headings which make sense only for the manpage like
'synopsis', 'description', and 'see also'. Unfortunately, the
mechanism Sphinx provides for restricting pieces of documentation
is limited to the point of being flawed: the 'only::' directive
is implemented as a filter that is applied at a very late stage
in the document processing pipeline, rather than as an early
equivalent of an #ifdef. This means that Sphinx's process of
identifying which section heading markup styles are which levels
of heading gets confused if the 'only::' directive contains
section headings which would affect the heading-level of a
later heading. I have opted to prioritise making the HTML format
look better, with the compromise being that in the manpage
the 'Disk image file formats' &c headings are top-level headings
rather than being sub-headings under the traditional 'Description'
top-level section title.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20200116141511.16849-4-peter.maydell@linaro.org
---
 Makefile                           |  11 +-
 docs/qemu-block-drivers.texi       | 889 --------------------------
 docs/system/conf.py                |   7 +
 docs/system/index.rst              |   1 +
 docs/system/qemu-block-drivers.rst | 985 +++++++++++++++++++++++++++++
 qemu-doc.texi                      |  12 -
 qemu-options.hx                    |   2 +-
 7 files changed, 1000 insertions(+), 907 deletions(-)
 delete mode 100644 docs/qemu-block-drivers.texi
 create mode 100644 docs/system/qemu-block-drivers.rst

diff --git a/Makefile b/Makefile
index 2ab6a17205f..9473509112a 100644
--- a/Makefile
+++ b/Makefile
@@ -342,9 +342,9 @@ ifdef BUILD_DOCS
 DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1
 DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-nbd.8
 DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-ga.8
+DOCS+=$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
 DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
 DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
-DOCS+=docs/qemu-block-drivers.7
 DOCS+=docs/qemu-cpu-models.7
 DOCS+=$(MANUAL_BUILDDIR)/index.html
 ifdef CONFIG_VIRTFS
@@ -751,7 +751,6 @@ distclean: clean
 	rm -f docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
 	rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
 	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
-	rm -f docs/qemu-block-drivers.7
 	rm -f docs/qemu-cpu-models.7
 	rm -rf .doctrees
 	$(call clean-manual,devel)
@@ -828,7 +827,7 @@ ifdef CONFIG_POSIX
 	$(INSTALL_DATA) qemu.1 "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
-	$(INSTALL_DATA) docs/qemu-block-drivers.7 "$(DESTDIR)$(mandir)/man7"
+	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-block-drivers.7 "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) docs/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
 ifeq ($(CONFIG_TOOLS),y)
 	$(INSTALL_DATA) qemu-img.1 "$(DESTDIR)$(mandir)/man1"
@@ -1036,6 +1035,9 @@ $(MANUAL_BUILDDIR)/interop/qemu-ga.8: $(call manual-deps,interop)
 $(MANUAL_BUILDDIR)/interop/qemu-nbd.8: $(call manual-deps,interop)
 	$(call build-manual,interop,man)
 
+$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7: $(call manual-deps,system)
+	$(call build-manual,system,man)
+
 $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-version.h
 	@mkdir -p "$(MANUAL_BUILDDIR)"
 	$(call quiet-command, sed "s|@@VERSION@@|${VERSION}|g" $< >$@, \
@@ -1063,7 +1065,6 @@ qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
 qemu.1: qemu-option-trace.texi
 qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi
 fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
-docs/qemu-block-drivers.7: docs/qemu-block-drivers.texi
 docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
 scripts/qemu-trace-stap.1: scripts/qemu-trace-stap.texi
 
@@ -1076,7 +1077,7 @@ qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
 	qemu-img.texi qemu-options.texi \
 	qemu-tech.texi qemu-option-trace.texi \
 	qemu-deprecated.texi qemu-monitor.texi qemu-img-cmds.texi \
-	qemu-monitor-info.texi docs/qemu-block-drivers.texi \
+	qemu-monitor-info.texi \
 	docs/qemu-cpu-models.texi docs/security.texi
 
 docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.texi
deleted file mode 100644
index 2c7ea49c32d..00000000000
--- a/docs/qemu-block-drivers.texi
+++ /dev/null
@@ -1,889 +0,0 @@
-@c man begin SYNOPSIS
-QEMU block driver reference manual
-@c man end
-
-@set qemu_system qemu-system-x86_64
-
-@c man begin DESCRIPTION
-
-@node disk_images_formats
-@subsection Disk image file formats
-
-QEMU supports many image file formats that can be used with VMs as well as with
-any of the tools (like @code{qemu-img}). This includes the preferred formats
-raw and qcow2 as well as formats that are supported for compatibility with
-older QEMU versions or other hypervisors.
-
-Depending on the image format, different options can be passed to
-@code{qemu-img create} and @code{qemu-img convert} using the @code{-o} option.
-This section describes each format and the options that are supported for it.
-
-@table @option
-@item raw
-
-Raw disk image format. This format has the advantage of
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
-on Windows), zlib based compression and support of multiple VM
-snapshots.
-
-Supported options:
-@table @code
-@item compat
-Determines the qcow2 version to use. @code{compat=0.10} uses the
-traditional image format that can be read by any QEMU since 0.10.
-@code{compat=1.1} enables image format extensions that only QEMU 1.1 and
-newer understand (this is the default). Amongst others, this includes
-zero clusters, which allow efficient copy-on-read for sparse images.
-
-@item backing_file
-File name of a base image (see @option{create} subcommand)
-@item backing_fmt
-Image format of the base image
-@item encryption
-This option is deprecated and equivalent to @code{encrypt.format=aes}
-
-@item encrypt.format
-
-If this is set to @code{luks}, it requests that the qcow2 payload (not
-qcow2 header) be encrypted using the LUKS format. The passphrase to
-use to unlock the LUKS key slot is given by the @code{encrypt.key-secret}
-parameter. LUKS encryption parameters can be tuned with the other
-@code{encrypt.*} parameters.
-
-If this is set to @code{aes}, the image is encrypted with 128-bit AES-CBC.
-The encryption key is given by the @code{encrypt.key-secret} parameter.
-This encryption format is considered to be flawed by modern cryptography
-standards, suffering from a number of design problems:
-
-@itemize @minus
-@item The AES-CBC cipher is used with predictable initialization vectors based
-on the sector number. This makes it vulnerable to chosen plaintext attacks
-which can reveal the existence of encrypted data.
-@item The user passphrase is directly used as the encryption key. A poorly
-chosen or short passphrase will compromise the security of the encryption.
-@item In the event of the passphrase being compromised there is no way to
-change the passphrase to protect data in any qcow images. The files must
-be cloned, using a different encryption passphrase in the new file. The
-original file must then be securely erased using a program like shred,
-though even this is ineffective with many modern storage technologies.
-@end itemize
-
-The use of this is no longer supported in system emulators. Support only
-remains in the command line utilities, for the purposes of data liberation
-and interoperability with old versions of QEMU. The @code{luks} format
-should be used instead.
-
-@item encrypt.key-secret
-
-Provides the ID of a @code{secret} object that contains the passphrase
-(@code{encrypt.format=luks}) or encryption key (@code{encrypt.format=aes}).
-
-@item encrypt.cipher-alg
-
-Name of the cipher algorithm and key length. Currently defaults
-to @code{aes-256}. Only used when @code{encrypt.format=luks}.
-
-@item encrypt.cipher-mode
-
-Name of the encryption mode to use. Currently defaults to @code{xts}.
-Only used when @code{encrypt.format=luks}.
-
-@item encrypt.ivgen-alg
-
-Name of the initialization vector generator algorithm. Currently defaults
-to @code{plain64}. Only used when @code{encrypt.format=luks}.
-
-@item encrypt.ivgen-hash-alg
-
-Name of the hash algorithm to use with the initialization vector generator
-(if required). Defaults to @code{sha256}. Only used when @code{encrypt.format=luks}.
-
-@item encrypt.hash-alg
-
-Name of the hash algorithm to use for PBKDF algorithm
-Defaults to @code{sha256}. Only used when @code{encrypt.format=luks}.
-
-@item encrypt.iter-time
-
-Amount of time, in milliseconds, to use for PBKDF algorithm per key slot.
-Defaults to @code{2000}. Only used when @code{encrypt.format=luks}.
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
-@item qed
-Old QEMU image format with support for backing files and compact image files
-(when your filesystem or transport medium does not support holes).
-
-When converting QED images to qcow2, you might want to consider using the
-@code{lazy_refcounts=on} option to get a more QED-like behaviour.
-
-Supported options:
-@table @code
-@item backing_file
-File name of a base image (see @option{create} subcommand).
-@item backing_fmt
-Image file format of backing file (optional).  Useful if the format cannot be
-autodetected because it has no header, like some vhd/vpc files.
-@item cluster_size
-Changes the cluster size (must be power-of-2 between 4K and 64K). Smaller
-cluster sizes can improve the image file size whereas larger cluster sizes
-generally provide better performance.
-@item table_size
-Changes the number of clusters per L1/L2 table (must be power-of-2 between 1
-and 16).  There is normally no need to change this value but this option can be
-used for performance benchmarking.
-@end table
-
-@item qcow
-Old QEMU image format with support for backing files, compact image files,
-encryption and compression.
-
-Supported options:
-@table @code
-@item backing_file
-File name of a base image (see @option{create} subcommand)
-@item encryption
-This option is deprecated and equivalent to @code{encrypt.format=aes}
-
-@item encrypt.format
-If this is set to @code{aes}, the image is encrypted with 128-bit AES-CBC.
-The encryption key is given by the @code{encrypt.key-secret} parameter.
-This encryption format is considered to be flawed by modern cryptography
-standards, suffering from a number of design problems enumerated previously
-against the @code{qcow2} image format.
-
-The use of this is no longer supported in system emulators. Support only
-remains in the command line utilities, for the purposes of data liberation
-and interoperability with old versions of QEMU.
-
-Users requiring native encryption should use the @code{qcow2} format
-instead with @code{encrypt.format=luks}.
-
-@item encrypt.key-secret
-
-Provides the ID of a @code{secret} object that contains the encryption
-key (@code{encrypt.format=aes}).
-
-@end table
-
-@item luks
-
-LUKS v1 encryption format, compatible with Linux dm-crypt/cryptsetup
-
-Supported options:
-@table @code
-
-@item key-secret
-
-Provides the ID of a @code{secret} object that contains the passphrase.
-
-@item cipher-alg
-
-Name of the cipher algorithm and key length. Currently defaults
-to @code{aes-256}.
-
-@item cipher-mode
-
-Name of the encryption mode to use. Currently defaults to @code{xts}.
-
-@item ivgen-alg
-
-Name of the initialization vector generator algorithm. Currently defaults
-to @code{plain64}.
-
-@item ivgen-hash-alg
-
-Name of the hash algorithm to use with the initialization vector generator
-(if required). Defaults to @code{sha256}.
-
-@item hash-alg
-
-Name of the hash algorithm to use for PBKDF algorithm
-Defaults to @code{sha256}.
-
-@item iter-time
-
-Amount of time, in milliseconds, to use for PBKDF algorithm per key slot.
-Defaults to @code{2000}.
-
-@end table
-
-@item vdi
-VirtualBox 1.1 compatible image format.
-Supported options:
-@table @code
-@item static
-If this option is set to @code{on}, the image is created with metadata
-preallocation.
-@end table
-
-@item vmdk
-VMware 3 and 4 compatible image format.
-
-Supported options:
-@table @code
-@item backing_file
-File name of a base image (see @option{create} subcommand).
-@item compat6
-Create a VMDK version 6 image (instead of version 4)
-@item hwversion
-Specify vmdk virtual hardware version. Compat6 flag cannot be enabled
-if hwversion is specified.
-@item subformat
-Specifies which VMDK subformat to use. Valid options are
-@code{monolithicSparse} (default),
-@code{monolithicFlat},
-@code{twoGbMaxExtentSparse},
-@code{twoGbMaxExtentFlat} and
-@code{streamOptimized}.
-@end table
-
-@item vpc
-VirtualPC compatible image format (VHD).
-Supported options:
-@table @code
-@item subformat
-Specifies which VHD subformat to use. Valid options are
-@code{dynamic} (default) and @code{fixed}.
-@end table
-
-@item VHDX
-Hyper-V compatible image format (VHDX).
-Supported options:
-@table @code
-@item subformat
-Specifies which VHDX subformat to use. Valid options are
-@code{dynamic} (default) and @code{fixed}.
-@item block_state_zero
-Force use of payload blocks of type 'ZERO'.  Can be set to @code{on} (default)
-or @code{off}.  When set to @code{off}, new blocks will be created as
-@code{PAYLOAD_BLOCK_NOT_PRESENT}, which means parsers are free to return
-arbitrary data for those blocks.  Do not set to @code{off} when using
-@code{qemu-img convert} with @code{subformat=dynamic}.
-@item block_size
-Block size; min 1 MB, max 256 MB.  0 means auto-calculate based on image size.
-@item log_size
-Log size; min 1 MB.
-@end table
-@end table
-
-@subsubsection Read-only formats
-More disk image file formats are supported in a read-only mode.
-@table @option
-@item bochs
-Bochs images of @code{growing} type.
-@item cloop
-Linux Compressed Loop image, useful only to reuse directly compressed
-CD-ROM images present for example in the Knoppix CD-ROMs.
-@item dmg
-Apple disk image.
-@item parallels
-Parallels disk image format.
-@end table
-
-
-@node host_drives
-@subsection Using host drives
-
-In addition to disk image files, QEMU can directly access host
-devices. We describe here the usage for QEMU version >= 0.8.3.
-
-@subsubsection Linux
-
-On Linux, you can directly use the host device filename instead of a
-disk image filename provided you have enough privileges to access
-it. For example, use @file{/dev/cdrom} to access to the CDROM.
-
-@table @code
-@item CD
-You can specify a CDROM device even if no CDROM is loaded. QEMU has
-specific code to detect CDROM insertion or removal. CDROM ejection by
-the guest OS is supported. Currently only data CDs are supported.
-@item Floppy
-You can specify a floppy device even if no floppy is loaded. Floppy
-removal is currently not detected accurately (if you change floppy
-without doing floppy access while the floppy is not loaded, the guest
-OS will think that the same floppy is loaded).
-Use of the host's floppy device is deprecated, and support for it will
-be removed in a future release.
-@item Hard disks
-Hard disks can be used. Normally you must specify the whole disk
-(@file{/dev/hdb} instead of @file{/dev/hdb1}) so that the guest OS can
-see it as a partitioned disk. WARNING: unless you know what you do, it
-is better to only make READ-ONLY accesses to the hard disk otherwise
-you may corrupt your host data (use the @option{-snapshot} command
-line option or modify the device permissions accordingly).
-@end table
-
-@subsubsection Windows
-
-@table @code
-@item CD
-The preferred syntax is the drive letter (e.g. @file{d:}). The
-alternate syntax @file{\\.\d:} is supported. @file{/dev/cdrom} is
-supported as an alias to the first CDROM drive.
-
-Currently there is no specific code to handle removable media, so it
-is better to use the @code{change} or @code{eject} monitor commands to
-change or eject media.
-@item Hard disks
-Hard disks can be used with the syntax: @file{\\.\PhysicalDrive@var{N}}
-where @var{N} is the drive number (0 is the first hard disk).
-
-WARNING: unless you know what you do, it is better to only make
-READ-ONLY accesses to the hard disk otherwise you may corrupt your
-host data (use the @option{-snapshot} command line so that the
-modifications are written in a temporary file).
-@end table
-
-
-@subsubsection Mac OS X
-
-@file{/dev/cdrom} is an alias to the first CDROM.
-
-Currently there is no specific code to handle removable media, so it
-is better to use the @code{change} or @code{eject} monitor commands to
-change or eject media.
-
-@node disk_images_fat_images
-@subsection Virtual FAT disk images
-
-QEMU can automatically create a virtual FAT disk image from a
-directory tree. In order to use it, just type:
-
-@example
-@value{qemu_system} linux.img -hdb fat:/my_directory
-@end example
-
-Then you access access to all the files in the @file{/my_directory}
-directory without having to copy them in a disk image or to export
-them via SAMBA or NFS. The default access is @emph{read-only}.
-
-Floppies can be emulated with the @code{:floppy:} option:
-
-@example
-@value{qemu_system} linux.img -fda fat:floppy:/my_directory
-@end example
-
-A read/write support is available for testing (beta stage) with the
-@code{:rw:} option:
-
-@example
-@value{qemu_system} linux.img -fda fat:floppy:rw:/my_directory
-@end example
-
-What you should @emph{never} do:
-@itemize
-@item use non-ASCII filenames ;
-@item use "-snapshot" together with ":rw:" ;
-@item expect it to work when loadvm'ing ;
-@item write to the FAT directory on the host system while accessing it with the guest system.
-@end itemize
-
-@node disk_images_nbd
-@subsection NBD access
-
-QEMU can access directly to block device exported using the Network Block Device
-protocol.
-
-@example
-@value{qemu_system} linux.img -hdb nbd://my_nbd_server.mydomain.org:1024/
-@end example
-
-If the NBD server is located on the same host, you can use an unix socket instead
-of an inet socket:
-
-@example
-@value{qemu_system} linux.img -hdb nbd+unix://?socket=/tmp/my_socket
-@end example
-
-In this case, the block device must be exported using qemu-nbd:
-
-@example
-qemu-nbd --socket=/tmp/my_socket my_disk.qcow2
-@end example
-
-The use of qemu-nbd allows sharing of a disk between several guests:
-@example
-qemu-nbd --socket=/tmp/my_socket --share=2 my_disk.qcow2
-@end example
-
-@noindent
-and then you can use it with two guests:
-@example
-@value{qemu_system} linux1.img -hdb nbd+unix://?socket=/tmp/my_socket
-@value{qemu_system} linux2.img -hdb nbd+unix://?socket=/tmp/my_socket
-@end example
-
-If the nbd-server uses named exports (supported since NBD 2.9.18, or with QEMU's
-own embedded NBD server), you must specify an export name in the URI:
-@example
-@value{qemu_system} -cdrom nbd://localhost/debian-500-ppc-netinst
-@value{qemu_system} -cdrom nbd://localhost/openSUSE-11.1-ppc-netinst
-@end example
-
-The URI syntax for NBD is supported since QEMU 1.3.  An alternative syntax is
-also available.  Here are some example of the older syntax:
-@example
-@value{qemu_system} linux.img -hdb nbd:my_nbd_server.mydomain.org:1024
-@value{qemu_system} linux2.img -hdb nbd:unix:/tmp/my_socket
-@value{qemu_system} -cdrom nbd:localhost:10809:exportname=debian-500-ppc-netinst
-@end example
-
-@node disk_images_sheepdog
-@subsection Sheepdog disk images
-
-Sheepdog is a distributed storage system for QEMU.  It provides highly
-available block level storage volumes that can be attached to
-QEMU-based virtual machines.
-
-You can create a Sheepdog disk image with the command:
-@example
-qemu-img create sheepdog:///@var{image} @var{size}
-@end example
-where @var{image} is the Sheepdog image name and @var{size} is its
-size.
-
-To import the existing @var{filename} to Sheepdog, you can use a
-convert command.
-@example
-qemu-img convert @var{filename} sheepdog:///@var{image}
-@end example
-
-You can boot from the Sheepdog disk image with the command:
-@example
-@value{qemu_system} sheepdog:///@var{image}
-@end example
-
-You can also create a snapshot of the Sheepdog image like qcow2.
-@example
-qemu-img snapshot -c @var{tag} sheepdog:///@var{image}
-@end example
-where @var{tag} is a tag name of the newly created snapshot.
-
-To boot from the Sheepdog snapshot, specify the tag name of the
-snapshot.
-@example
-@value{qemu_system} sheepdog:///@var{image}#@var{tag}
-@end example
-
-You can create a cloned image from the existing snapshot.
-@example
-qemu-img create -b sheepdog:///@var{base}#@var{tag} sheepdog:///@var{image}
-@end example
-where @var{base} is an image name of the source snapshot and @var{tag}
-is its tag name.
-
-You can use an unix socket instead of an inet socket:
-
-@example
-@value{qemu_system} sheepdog+unix:///@var{image}?socket=@var{path}
-@end example
-
-If the Sheepdog daemon doesn't run on the local host, you need to
-specify one of the Sheepdog servers to connect to.
-@example
-qemu-img create sheepdog://@var{hostname}:@var{port}/@var{image} @var{size}
-@value{qemu_system} sheepdog://@var{hostname}:@var{port}/@var{image}
-@end example
-
-@node disk_images_iscsi
-@subsection iSCSI LUNs
-
-iSCSI is a popular protocol used to access SCSI devices across a computer
-network.
-
-There are two different ways iSCSI devices can be used by QEMU.
-
-The first method is to mount the iSCSI LUN on the host, and make it appear as
-any other ordinary SCSI device on the host and then to access this device as a
-/dev/sd device from QEMU. How to do this differs between host OSes.
-
-The second method involves using the iSCSI initiator that is built into
-QEMU. This provides a mechanism that works the same way regardless of which
-host OS you are running QEMU on. This section will describe this second method
-of using iSCSI together with QEMU.
-
-In QEMU, iSCSI devices are described using special iSCSI URLs
-
-@example
-URL syntax:
-iscsi://[<username>[%<password>]@@]<host>[:<port>]/<target-iqn-name>/<lun>
-@end example
-
-Username and password are optional and only used if your target is set up
-using CHAP authentication for access control.
-Alternatively the username and password can also be set via environment
-variables to have these not show up in the process list
-
-@example
-export LIBISCSI_CHAP_USERNAME=<username>
-export LIBISCSI_CHAP_PASSWORD=<password>
-iscsi://<host>/<target-iqn-name>/<lun>
-@end example
-
-Various session related parameters can be set via special options, either
-in a configuration file provided via '-readconfig' or directly on the
-command line.
-
-If the initiator-name is not specified qemu will use a default name
-of 'iqn.2008-11.org.linux-kvm[:<uuid>'] where <uuid> is the UUID of the
-virtual machine. If the UUID is not specified qemu will use
-'iqn.2008-11.org.linux-kvm[:<name>'] where <name> is the name of the
-virtual machine.
-
-@example
-Setting a specific initiator name to use when logging in to the target
--iscsi initiator-name=iqn.qemu.test:my-initiator
-@end example
-
-@example
-Controlling which type of header digest to negotiate with the target
--iscsi header-digest=CRC32C|CRC32C-NONE|NONE-CRC32C|NONE
-@end example
-
-These can also be set via a configuration file
-@example
-[iscsi]
-  user = "CHAP username"
-  password = "CHAP password"
-  initiator-name = "iqn.qemu.test:my-initiator"
-  # header digest is one of CRC32C|CRC32C-NONE|NONE-CRC32C|NONE
-  header-digest = "CRC32C"
-@end example
-
-
-Setting the target name allows different options for different targets
-@example
-[iscsi "iqn.target.name"]
-  user = "CHAP username"
-  password = "CHAP password"
-  initiator-name = "iqn.qemu.test:my-initiator"
-  # header digest is one of CRC32C|CRC32C-NONE|NONE-CRC32C|NONE
-  header-digest = "CRC32C"
-@end example
-
-
-Howto use a configuration file to set iSCSI configuration options:
-@example
-cat >iscsi.conf <<EOF
-[iscsi]
-  user = "me"
-  password = "my password"
-  initiator-name = "iqn.qemu.test:my-initiator"
-  header-digest = "CRC32C"
-EOF
-
-@value{qemu_system} -drive file=iscsi://127.0.0.1/iqn.qemu.test/1 \
-    -readconfig iscsi.conf
-@end example
-
-
-How to set up a simple iSCSI target on loopback and access it via QEMU:
-@example
-This example shows how to set up an iSCSI target with one CDROM and one DISK
-using the Linux STGT software target. This target is available on Red Hat based
-systems as the package 'scsi-target-utils'.
-
-tgtd --iscsi portal=127.0.0.1:3260
-tgtadm --lld iscsi --op new --mode target --tid 1 -T iqn.qemu.test
-tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 1 \
-    -b /IMAGES/disk.img --device-type=disk
-tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 2 \
-    -b /IMAGES/cd.iso --device-type=cd
-tgtadm --lld iscsi --op bind --mode target --tid 1 -I ALL
-
-@value{qemu_system} -iscsi initiator-name=iqn.qemu.test:my-initiator \
-    -boot d -drive file=iscsi://127.0.0.1/iqn.qemu.test/1 \
-    -cdrom iscsi://127.0.0.1/iqn.qemu.test/2
-@end example
-
-@node disk_images_gluster
-@subsection GlusterFS disk images
-
-GlusterFS is a user space distributed file system.
-
-You can boot from the GlusterFS disk image with the command:
-@example
-URI:
-@value{qemu_system} -drive file=gluster[+@var{type}]://[@var{host}[:@var{port}]]/@var{volume}/@var{path}
-                               [?socket=...][,file.debug=9][,file.logfile=...]
-
-JSON:
-@value{qemu_system} 'json:@{"driver":"qcow2",
-                           "file":@{"driver":"gluster",
-                                    "volume":"testvol","path":"a.img","debug":9,"logfile":"...",
-                                    "server":[@{"type":"tcp","host":"...","port":"..."@},
-                                              @{"type":"unix","socket":"..."@}]@}@}'
-@end example
-
-@var{gluster} is the protocol.
-
-@var{type} specifies the transport type used to connect to gluster
-management daemon (glusterd). Valid transport types are
-tcp and unix. In the URI form, if a transport type isn't specified,
-then tcp type is assumed.
-
-@var{host} specifies the server where the volume file specification for
-the given volume resides. This can be either a hostname or an ipv4 address.
-If transport type is unix, then @var{host} field should not be specified.
-Instead @var{socket} field needs to be populated with the path to unix domain
-socket.
-
-@var{port} is the port number on which glusterd is listening. This is optional
-and if not specified, it defaults to port 24007. If the transport type is unix,
-then @var{port} should not be specified.
-
-@var{volume} is the name of the gluster volume which contains the disk image.
-
-@var{path} is the path to the actual disk image that resides on gluster volume.
-
-@var{debug} is the logging level of the gluster protocol driver. Debug levels
-are 0-9, with 9 being the most verbose, and 0 representing no debugging output.
-The default level is 4. The current logging levels defined in the gluster source
-are 0 - None, 1 - Emergency, 2 - Alert, 3 - Critical, 4 - Error, 5 - Warning,
-6 - Notice, 7 - Info, 8 - Debug, 9 - Trace
-
-@var{logfile} is a commandline option to mention log file path which helps in
-logging to the specified file and also help in persisting the gfapi logs. The
-default is stderr.
-
-
-
-
-You can create a GlusterFS disk image with the command:
-@example
-qemu-img create gluster://@var{host}/@var{volume}/@var{path} @var{size}
-@end example
-
-Examples
-@example
-@value{qemu_system} -drive file=gluster://1.2.3.4/testvol/a.img
-@value{qemu_system} -drive file=gluster+tcp://1.2.3.4/testvol/a.img
-@value{qemu_system} -drive file=gluster+tcp://1.2.3.4:24007/testvol/dir/a.img
-@value{qemu_system} -drive file=gluster+tcp://[1:2:3:4:5:6:7:8]/testvol/dir/a.img
-@value{qemu_system} -drive file=gluster+tcp://[1:2:3:4:5:6:7:8]:24007/testvol/dir/a.img
-@value{qemu_system} -drive file=gluster+tcp://server.domain.com:24007/testvol/dir/a.img
-@value{qemu_system} -drive file=gluster+unix:///testvol/dir/a.img?socket=/tmp/glusterd.socket
-@value{qemu_system} -drive file=gluster+rdma://1.2.3.4:24007/testvol/a.img
-@value{qemu_system} -drive file=gluster://1.2.3.4/testvol/a.img,file.debug=9,file.logfile=/var/log/qemu-gluster.log
-@value{qemu_system} 'json:@{"driver":"qcow2",
-                           "file":@{"driver":"gluster",
-                                    "volume":"testvol","path":"a.img",
-                                    "debug":9,"logfile":"/var/log/qemu-gluster.log",
-                                    "server":[@{"type":"tcp","host":"1.2.3.4","port":24007@},
-                                              @{"type":"unix","socket":"/var/run/glusterd.socket"@}]@}@}'
-@value{qemu_system} -drive driver=qcow2,file.driver=gluster,file.volume=testvol,file.path=/path/a.img,
-                                       file.debug=9,file.logfile=/var/log/qemu-gluster.log,
-                                       file.server.0.type=tcp,file.server.0.host=1.2.3.4,file.server.0.port=24007,
-                                       file.server.1.type=unix,file.server.1.socket=/var/run/glusterd.socket
-@end example
-
-@node disk_images_ssh
-@subsection Secure Shell (ssh) disk images
-
-You can access disk images located on a remote ssh server
-by using the ssh protocol:
-
-@example
-@value{qemu_system} -drive file=ssh://[@var{user}@@]@var{server}[:@var{port}]/@var{path}[?host_key_check=@var{host_key_check}]
-@end example
-
-Alternative syntax using properties:
-
-@example
-@value{qemu_system} -drive file.driver=ssh[,file.user=@var{user}],file.host=@var{server}[,file.port=@var{port}],file.path=@var{path}[,file.host_key_check=@var{host_key_check}]
-@end example
-
-@var{ssh} is the protocol.
-
-@var{user} is the remote user.  If not specified, then the local
-username is tried.
-
-@var{server} specifies the remote ssh server.  Any ssh server can be
-used, but it must implement the sftp-server protocol.  Most Unix/Linux
-systems should work without requiring any extra configuration.
-
-@var{port} is the port number on which sshd is listening.  By default
-the standard ssh port (22) is used.
-
-@var{path} is the path to the disk image.
-
-The optional @var{host_key_check} parameter controls how the remote
-host's key is checked.  The default is @code{yes} which means to use
-the local @file{.ssh/known_hosts} file.  Setting this to @code{no}
-turns off known-hosts checking.  Or you can check that the host key
-matches a specific fingerprint:
-@code{host_key_check=md5:78:45:8e:14:57:4f:d5:45:83:0a:0e:f3:49:82:c9:c8}
-(@code{sha1:} can also be used as a prefix, but note that OpenSSH
-tools only use MD5 to print fingerprints).
-
-Currently authentication must be done using ssh-agent.  Other
-authentication methods may be supported in future.
-
-Note: Many ssh servers do not support an @code{fsync}-style operation.
-The ssh driver cannot guarantee that disk flush requests are
-obeyed, and this causes a risk of disk corruption if the remote
-server or network goes down during writes.  The driver will
-print a warning when @code{fsync} is not supported:
-
-warning: ssh server @code{ssh.example.com:22} does not support fsync
-
-With sufficiently new versions of libssh and OpenSSH, @code{fsync} is
-supported.
-
-@node disk_images_nvme
-@subsection NVMe disk images
-
-NVM Express (NVMe) storage controllers can be accessed directly by a userspace
-driver in QEMU.  This bypasses the host kernel file system and block layers
-while retaining QEMU block layer functionalities, such as block jobs, I/O
-throttling, image formats, etc.  Disk I/O performance is typically higher than
-with @code{-drive file=/dev/sda} using either thread pool or linux-aio.
-
-The controller will be exclusively used by the QEMU process once started. To be
-able to share storage between multiple VMs and other applications on the host,
-please use the file based protocols.
-
-Before starting QEMU, bind the host NVMe controller to the host vfio-pci
-driver.  For example:
-
-@example
-# modprobe vfio-pci
-# lspci -n -s 0000:06:0d.0
-06:0d.0 0401: 1102:0002 (rev 08)
-# echo 0000:06:0d.0 > /sys/bus/pci/devices/0000:06:0d.0/driver/unbind
-# echo 1102 0002 > /sys/bus/pci/drivers/vfio-pci/new_id
-
-# @value{qemu_system} -drive file=nvme://@var{host}:@var{bus}:@var{slot}.@var{func}/@var{namespace}
-@end example
-
-Alternative syntax using properties:
-
-@example
-@value{qemu_system} -drive file.driver=nvme,file.device=@var{host}:@var{bus}:@var{slot}.@var{func},file.namespace=@var{namespace}
-@end example
-
-@var{host}:@var{bus}:@var{slot}.@var{func} is the NVMe controller's PCI device
-address on the host.
-
-@var{namespace} is the NVMe namespace number, starting from 1.
-
-@node disk_image_locking
-@subsection Disk image file locking
-
-By default, QEMU tries to protect image files from unexpected concurrent
-access, as long as it's supported by the block protocol driver and host
-operating system. If multiple QEMU processes (including QEMU emulators and
-utilities) try to open the same image with conflicting accessing modes, all but
-the first one will get an error.
-
-This feature is currently supported by the file protocol on Linux with the Open
-File Descriptor (OFD) locking API, and can be configured to fall back to POSIX
-locking if the POSIX host doesn't support Linux OFD locking.
-
-To explicitly enable image locking, specify "locking=on" in the file protocol
-driver options. If OFD locking is not possible, a warning will be printed and
-the POSIX locking API will be used. In this case there is a risk that the lock
-will get silently lost when doing hot plugging and block jobs, due to the
-shortcomings of the POSIX locking API.
-
-QEMU transparently handles lock handover during shared storage migration.  For
-shared virtual disk images between multiple VMs, the "share-rw" device option
-should be used.
-
-By default, the guest has exclusive write access to its disk image. If the
-guest can safely share the disk image with other writers the @code{-device
-...,share-rw=on} parameter can be used.  This is only safe if the guest is
-running software, such as a cluster file system, that coordinates disk accesses
-to avoid corruption.
-
-Note that share-rw=on only declares the guest's ability to share the disk.
-Some QEMU features, such as image file formats, require exclusive write access
-to the disk image and this is unaffected by the share-rw=on option.
-
-Alternatively, locking can be fully disabled by "locking=off" block device
-option. In the command line, the option is usually in the form of
-"file.locking=off" as the protocol driver is normally placed as a "file" child
-under a format driver. For example:
-
-@code{-blockdev driver=qcow2,file.filename=/path/to/image,file.locking=off,file.driver=file}
-
-To check if image locking is active, check the output of the "lslocks" command
-on host and see if there are locks held by the QEMU process on the image file.
-More than one byte could be locked by the QEMU instance, each byte of which
-reflects a particular permission that is acquired or protected by the running
-block driver.
-
-@c man end
-
-@ignore
-
-@setfilename qemu-block-drivers
-@settitle QEMU block drivers reference
-
-@c man begin SEEALSO
-The HTML documentation of QEMU for more precise information and Linux
-user mode emulator invocation.
-@c man end
-
-@c man begin AUTHOR
-Fabrice Bellard and the QEMU Project developers
-@c man end
-
-@end ignore
diff --git a/docs/system/conf.py b/docs/system/conf.py
index 6435b4d3f8e..7ca115f5e03 100644
--- a/docs/system/conf.py
+++ b/docs/system/conf.py
@@ -13,3 +13,10 @@ exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
 # This slightly misuses the 'description', but is the best way to get
 # the manual title to appear in the sidebar.
 html_theme_options['description'] = u'System Emulation User''s Guide'
+# One entry per manual page. List of tuples
+# (source start file, name, description, authors, manual section).
+man_pages = [
+    ('qemu-block-drivers', 'qemu-block-drivers',
+     u'QEMU block drivers reference',
+     ['Fabrice Bellard and the QEMU Project developers'], 7)
+]
diff --git a/docs/system/index.rst b/docs/system/index.rst
index ea8ea5fe3dc..f66e6ea585c 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -14,3 +14,4 @@ Contents:
 .. toctree::
    :maxdepth: 2
 
+   qemu-block-drivers
diff --git a/docs/system/qemu-block-drivers.rst b/docs/system/qemu-block-drivers.rst
new file mode 100644
index 00000000000..388adbefbf4
--- /dev/null
+++ b/docs/system/qemu-block-drivers.rst
@@ -0,0 +1,985 @@
+QEMU block drivers reference
+============================
+
+.. |qemu_system| replace:: qemu-system-x86_64
+
+..
+   We put the 'Synopsis' and 'See also' sections into the manpage, but not
+   the HTML. This makes the HTML docs read better and means the ToC in
+   the index has a more useful set of entries. Ideally, the section
+   headings 'Disk image file formats' would be top-level headings for
+   the HTML, but sub-headings of the conventional manpage 'Description'
+   header for the manpage. Unfortunately, due to deficiencies in
+   the Sphinx 'only' directive, this isn't possible: they must be headers
+   at the same level as 'Synopsis' and 'See also', otherwise Sphinx's
+   identification of which header underline style is which gets confused.
+
+.. only:: man
+
+  Synopsis
+  --------
+
+  QEMU block driver reference manual
+
+Disk image file formats
+-----------------------
+
+QEMU supports many image file formats that can be used with VMs as well as with
+any of the tools (like ``qemu-img``). This includes the preferred formats
+raw and qcow2 as well as formats that are supported for compatibility with
+older QEMU versions or other hypervisors.
+
+Depending on the image format, different options can be passed to
+``qemu-img create`` and ``qemu-img convert`` using the ``-o`` option.
+This section describes each format and the options that are supported for it.
+
+.. program:: image-formats
+.. option:: raw
+
+  Raw disk image format. This format has the advantage of
+  being simple and easily exportable to all other emulators. If your
+  file system supports *holes* (for example in ext2 or ext3 on
+  Linux or NTFS on Windows), then only the written sectors will reserve
+  space. Use ``qemu-img info`` to know the real size used by the
+  image or ``ls -ls`` on Unix/Linux.
+
+  Supported options:
+
+  .. program:: raw
+  .. option:: preallocation
+
+    Preallocation mode (allowed values: ``off``, ``falloc``,
+    ``full``). ``falloc`` mode preallocates space for image by
+    calling ``posix_fallocate()``. ``full`` mode preallocates space
+    for image by writing data to underlying storage. This data may or
+    may not be zero, depending on the storage location.
+
+.. program:: image-formats
+.. option:: qcow2
+
+  QEMU image format, the most versatile format. Use it to have smaller
+  images (useful if your filesystem does not supports holes, for example
+  on Windows), zlib based compression and support of multiple VM
+  snapshots.
+
+  Supported options:
+
+  .. program:: qcow2
+  .. option:: compat
+
+    Determines the qcow2 version to use. ``compat=0.10`` uses the
+    traditional image format that can be read by any QEMU since 0.10.
+    ``compat=1.1`` enables image format extensions that only QEMU 1.1 and
+    newer understand (this is the default). Amongst others, this includes
+    zero clusters, which allow efficient copy-on-read for sparse images.
+
+  .. option:: backing_file
+
+    File name of a base image (see ``create`` subcommand)
+
+  .. option:: backing_fmt
+
+    Image format of the base image
+
+  .. option:: encryption
+
+    This option is deprecated and equivalent to ``encrypt.format=aes``
+
+  .. option:: encrypt.format
+
+    If this is set to ``luks``, it requests that the qcow2 payload (not
+    qcow2 header) be encrypted using the LUKS format. The passphrase to
+    use to unlock the LUKS key slot is given by the ``encrypt.key-secret``
+    parameter. LUKS encryption parameters can be tuned with the other
+    ``encrypt.*`` parameters.
+
+    If this is set to ``aes``, the image is encrypted with 128-bit AES-CBC.
+    The encryption key is given by the ``encrypt.key-secret`` parameter.
+    This encryption format is considered to be flawed by modern cryptography
+    standards, suffering from a number of design problems:
+
+    - The AES-CBC cipher is used with predictable initialization vectors based
+      on the sector number. This makes it vulnerable to chosen plaintext attacks
+      which can reveal the existence of encrypted data.
+    - The user passphrase is directly used as the encryption key. A poorly
+      chosen or short passphrase will compromise the security of the encryption.
+    - In the event of the passphrase being compromised there is no way to
+      change the passphrase to protect data in any qcow images. The files must
+      be cloned, using a different encryption passphrase in the new file. The
+      original file must then be securely erased using a program like shred,
+      though even this is ineffective with many modern storage technologies.
+
+    The use of this is no longer supported in system emulators. Support only
+    remains in the command line utilities, for the purposes of data liberation
+    and interoperability with old versions of QEMU. The ``luks`` format
+    should be used instead.
+
+  .. option:: encrypt.key-secret
+
+    Provides the ID of a ``secret`` object that contains the passphrase
+    (``encrypt.format=luks``) or encryption key (``encrypt.format=aes``).
+
+  .. option:: encrypt.cipher-alg
+
+    Name of the cipher algorithm and key length. Currently defaults
+    to ``aes-256``. Only used when ``encrypt.format=luks``.
+
+  .. option:: encrypt.cipher-mode
+
+    Name of the encryption mode to use. Currently defaults to ``xts``.
+    Only used when ``encrypt.format=luks``.
+
+  .. option:: encrypt.ivgen-alg
+
+    Name of the initialization vector generator algorithm. Currently defaults
+    to ``plain64``. Only used when ``encrypt.format=luks``.
+
+  .. option:: encrypt.ivgen-hash-alg
+
+    Name of the hash algorithm to use with the initialization vector generator
+    (if required). Defaults to ``sha256``. Only used when ``encrypt.format=luks``.
+
+  .. option:: encrypt.hash-alg
+
+    Name of the hash algorithm to use for PBKDF algorithm
+    Defaults to ``sha256``. Only used when ``encrypt.format=luks``.
+
+  .. option:: encrypt.iter-time
+
+    Amount of time, in milliseconds, to use for PBKDF algorithm per key slot.
+    Defaults to ``2000``. Only used when ``encrypt.format=luks``.
+
+  .. option:: cluster_size
+
+    Changes the qcow2 cluster size (must be between 512 and 2M). Smaller cluster
+    sizes can improve the image file size whereas larger cluster sizes generally
+    provide better performance.
+
+  .. option:: preallocation
+
+    Preallocation mode (allowed values: ``off``, ``metadata``, ``falloc``,
+    ``full``). An image with preallocated metadata is initially larger but can
+    improve performance when the image needs to grow. ``falloc`` and ``full``
+    preallocations are like the same options of ``raw`` format, but sets up
+    metadata also.
+
+  .. option:: lazy_refcounts
+
+    If this option is set to ``on``, reference count updates are postponed with
+    the goal of avoiding metadata I/O and improving performance. This is
+    particularly interesting with :option:`cache=writethrough` which doesn't batch
+    metadata updates. The tradeoff is that after a host crash, the reference count
+    tables must be rebuilt, i.e. on the next open an (automatic) ``qemu-img
+    check -r all`` is required, which may take some time.
+
+    This option can only be enabled if ``compat=1.1`` is specified.
+
+  .. option:: nocow
+
+    If this option is set to ``on``, it will turn off COW of the file. It's only
+    valid on btrfs, no effect on other file systems.
+
+    Btrfs has low performance when hosting a VM image file, even more
+    when the guest on the VM also using btrfs as file system. Turning off
+    COW is a way to mitigate this bad performance. Generally there are two
+    ways to turn off COW on btrfs:
+
+    - Disable it by mounting with nodatacow, then all newly created files
+      will be NOCOW.
+    - For an empty file, add the NOCOW file attribute. That's what this
+      option does.
+
+    Note: this option is only valid to new or empty files. If there is
+    an existing file which is COW and has data blocks already, it couldn't
+    be changed to NOCOW by setting ``nocow=on``. One can issue ``lsattr
+    filename`` to check if the NOCOW flag is set or not (Capital 'C' is
+    NOCOW flag).
+
+.. program:: image-formats
+.. option:: qed
+
+   Old QEMU image format with support for backing files and compact image files
+   (when your filesystem or transport medium does not support holes).
+
+   When converting QED images to qcow2, you might want to consider using the
+   ``lazy_refcounts=on`` option to get a more QED-like behaviour.
+
+   Supported options:
+
+   .. program:: qed
+   .. option:: backing_file
+
+      File name of a base image (see ``create`` subcommand).
+
+   .. option:: backing_fmt
+
+     Image file format of backing file (optional).  Useful if the format cannot be
+     autodetected because it has no header, like some vhd/vpc files.
+
+   .. option:: cluster_size
+
+     Changes the cluster size (must be power-of-2 between 4K and 64K). Smaller
+     cluster sizes can improve the image file size whereas larger cluster sizes
+     generally provide better performance.
+
+   .. option:: table_size
+
+     Changes the number of clusters per L1/L2 table (must be
+     power-of-2 between 1 and 16).  There is normally no need to
+     change this value but this option can between used for
+     performance benchmarking.
+
+.. program:: image-formats
+.. option:: qcow
+
+  Old QEMU image format with support for backing files, compact image files,
+  encryption and compression.
+
+  Supported options:
+
+   .. program:: qcow
+   .. option:: backing_file
+
+     File name of a base image (see ``create`` subcommand)
+
+   .. option:: encryption
+
+     This option is deprecated and equivalent to ``encrypt.format=aes``
+
+   .. option:: encrypt.format
+
+     If this is set to ``aes``, the image is encrypted with 128-bit AES-CBC.
+     The encryption key is given by the ``encrypt.key-secret`` parameter.
+     This encryption format is considered to be flawed by modern cryptography
+     standards, suffering from a number of design problems enumerated previously
+     against the ``qcow2`` image format.
+
+     The use of this is no longer supported in system emulators. Support only
+     remains in the command line utilities, for the purposes of data liberation
+     and interoperability with old versions of QEMU.
+
+     Users requiring native encryption should use the ``qcow2`` format
+     instead with ``encrypt.format=luks``.
+
+   .. option:: encrypt.key-secret
+
+     Provides the ID of a ``secret`` object that contains the encryption
+     key (``encrypt.format=aes``).
+
+.. program:: image-formats
+.. option:: luks
+
+  LUKS v1 encryption format, compatible with Linux dm-crypt/cryptsetup
+
+  Supported options:
+
+  .. program:: luks
+  .. option:: key-secret
+
+    Provides the ID of a ``secret`` object that contains the passphrase.
+
+  .. option:: cipher-alg
+
+    Name of the cipher algorithm and key length. Currently defaults
+    to ``aes-256``.
+
+  .. option:: cipher-mode
+
+    Name of the encryption mode to use. Currently defaults to ``xts``.
+
+  .. option:: ivgen-alg
+
+    Name of the initialization vector generator algorithm. Currently defaults
+    to ``plain64``.
+
+  .. option:: ivgen-hash-alg
+
+    Name of the hash algorithm to use with the initialization vector generator
+    (if required). Defaults to ``sha256``.
+
+  .. option:: hash-alg
+
+    Name of the hash algorithm to use for PBKDF algorithm
+    Defaults to ``sha256``.
+
+  .. option:: iter-time
+
+    Amount of time, in milliseconds, to use for PBKDF algorithm per key slot.
+    Defaults to ``2000``.
+
+.. program:: image-formats
+.. option:: vdi
+
+  VirtualBox 1.1 compatible image format.
+
+  Supported options:
+
+  .. program:: vdi
+  .. option:: static
+
+    If this option is set to ``on``, the image is created with metadata
+    preallocation.
+
+.. program:: image-formats
+.. option:: vmdk
+
+  VMware 3 and 4 compatible image format.
+
+  Supported options:
+
+  .. program: vmdk
+  .. option:: backing_file
+
+    File name of a base image (see ``create`` subcommand).
+
+  .. option:: compat6
+
+    Create a VMDK version 6 image (instead of version 4)
+
+  .. option:: hwversion
+
+    Specify vmdk virtual hardware version. Compat6 flag cannot be enabled
+    if hwversion is specified.
+
+  .. option:: subformat
+
+    Specifies which VMDK subformat to use. Valid options are
+    ``monolithicSparse`` (default),
+    ``monolithicFlat``,
+    ``twoGbMaxExtentSparse``,
+    ``twoGbMaxExtentFlat`` and
+    ``streamOptimized``.
+
+.. program:: image-formats
+.. option:: vpc
+
+  VirtualPC compatible image format (VHD).
+
+  Supported options:
+
+  .. program:: vpc
+  .. option:: subformat
+
+    Specifies which VHD subformat to use. Valid options are
+    ``dynamic`` (default) and ``fixed``.
+
+.. program:: image-formats
+.. option:: VHDX
+
+  Hyper-V compatible image format (VHDX).
+
+  Supported options:
+
+  .. program:: VHDX
+  .. option:: subformat
+
+    Specifies which VHDX subformat to use. Valid options are
+    ``dynamic`` (default) and ``fixed``.
+
+    .. option:: block_state_zero
+
+      Force use of payload blocks of type 'ZERO'.  Can be set to ``on`` (default)
+      or ``off``.  When set to ``off``, new blocks will be created as
+      ``PAYLOAD_BLOCK_NOT_PRESENT``, which means parsers are free to return
+      arbitrary data for those blocks.  Do not set to ``off`` when using
+      ``qemu-img convert`` with ``subformat=dynamic``.
+
+    .. option:: block_size
+
+      Block size; min 1 MB, max 256 MB.  0 means auto-calculate based on
+      image size.
+
+    .. option:: log_size
+
+      Log size; min 1 MB.
+
+Read-only formats
+-----------------
+
+More disk image file formats are supported in a read-only mode.
+
+.. program:: image-formats
+.. option:: bochs
+
+  Bochs images of ``growing`` type.
+
+.. program:: image-formats
+.. option:: cloop
+
+  Linux Compressed Loop image, useful only to reuse directly compressed
+  CD-ROM images present for example in the Knoppix CD-ROMs.
+
+.. program:: image-formats
+.. option:: dmg
+
+  Apple disk image.
+
+.. program:: image-formats
+.. option:: parallels
+
+  Parallels disk image format.
+
+Using host drives
+-----------------
+
+In addition to disk image files, QEMU can directly access host
+devices. We describe here the usage for QEMU version >= 0.8.3.
+
+Linux
+'''''
+
+On Linux, you can directly use the host device filename instead of a
+disk image filename provided you have enough privileges to access
+it. For example, use ``/dev/cdrom`` to access to the CDROM.
+
+CD
+  You can specify a CDROM device even if no CDROM is loaded. QEMU has
+  specific code to detect CDROM insertion or removal. CDROM ejection by
+  the guest OS is supported. Currently only data CDs are supported.
+
+Floppy
+  You can specify a floppy device even if no floppy is loaded. Floppy
+  removal is currently not detected accurately (if you change floppy
+  without doing floppy access while the floppy is not loaded, the guest
+  OS will think that the same floppy is loaded).
+  Use of the host's floppy device is deprecated, and support for it will
+  be removed in a future release.
+
+Hard disks
+  Hard disks can be used. Normally you must specify the whole disk
+  (``/dev/hdb`` instead of ``/dev/hdb1``) so that the guest OS can
+  see it as a partitioned disk. WARNING: unless you know what you do, it
+  is better to only make READ-ONLY accesses to the hard disk otherwise
+  you may corrupt your host data (use the ``-snapshot`` command
+  line option or modify the device permissions accordingly).
+
+Windows
+'''''''
+
+CD
+  The preferred syntax is the drive letter (e.g. ``d:``). The
+  alternate syntax ``\\.\d:`` is supported. ``/dev/cdrom`` is
+  supported as an alias to the first CDROM drive.
+
+  Currently there is no specific code to handle removable media, so it
+  is better to use the ``change`` or ``eject`` monitor commands to
+  change or eject media.
+
+Hard disks
+  Hard disks can be used with the syntax: ``\\.\PhysicalDriveN``
+  where *N* is the drive number (0 is the first hard disk).
+
+  WARNING: unless you know what you do, it is better to only make
+  READ-ONLY accesses to the hard disk otherwise you may corrupt your
+  host data (use the ``-snapshot`` command line so that the
+  modifications are written in a temporary file).
+
+Mac OS X
+''''''''
+
+``/dev/cdrom`` is an alias to the first CDROM.
+
+Currently there is no specific code to handle removable media, so it
+is better to use the ``change`` or ``eject`` monitor commands to
+change or eject media.
+
+Virtual FAT disk images
+-----------------------
+
+QEMU can automatically create a virtual FAT disk image from a
+directory tree. In order to use it, just type:
+
+.. parsed-literal::
+
+  |qemu_system| linux.img -hdb fat:/my_directory
+
+Then you access access to all the files in the ``/my_directory``
+directory without having to copy them in a disk image or to export
+them via SAMBA or NFS. The default access is *read-only*.
+
+Floppies can be emulated with the ``:floppy:`` option:
+
+.. parsed-literal::
+
+  |qemu_system| linux.img -fda fat:floppy:/my_directory
+
+A read/write support is available for testing (beta stage) with the
+``:rw:`` option:
+
+.. parsed-literal::
+
+  |qemu_system| linux.img -fda fat:floppy:rw:/my_directory
+
+What you should *never* do:
+
+- use non-ASCII filenames
+- use "-snapshot" together with ":rw:"
+- expect it to work when loadvm'ing
+- write to the FAT directory on the host system while accessing it with the guest system
+
+NBD access
+----------
+
+QEMU can access directly to block device exported using the Network Block Device
+protocol.
+
+.. parsed-literal::
+
+  |qemu_system| linux.img -hdb nbd://my_nbd_server.mydomain.org:1024/
+
+If the NBD server is located on the same host, you can use an unix socket instead
+of an inet socket:
+
+.. parsed-literal::
+
+  |qemu_system| linux.img -hdb nbd+unix://?socket=/tmp/my_socket
+
+In this case, the block device must be exported using qemu-nbd:
+
+.. parsed-literal::
+
+  qemu-nbd --socket=/tmp/my_socket my_disk.qcow2
+
+The use of qemu-nbd allows sharing of a disk between several guests:
+
+.. parsed-literal::
+
+  qemu-nbd --socket=/tmp/my_socket --share=2 my_disk.qcow2
+
+and then you can use it with two guests:
+
+.. parsed-literal::
+
+  |qemu_system| linux1.img -hdb nbd+unix://?socket=/tmp/my_socket
+  |qemu_system| linux2.img -hdb nbd+unix://?socket=/tmp/my_socket
+
+If the nbd-server uses named exports (supported since NBD 2.9.18, or with QEMU's
+own embedded NBD server), you must specify an export name in the URI:
+
+.. parsed-literal::
+
+  |qemu_system| -cdrom nbd://localhost/debian-500-ppc-netinst
+  |qemu_system| -cdrom nbd://localhost/openSUSE-11.1-ppc-netinst
+
+The URI syntax for NBD is supported since QEMU 1.3.  An alternative syntax is
+also available.  Here are some example of the older syntax:
+
+.. parsed-literal::
+
+  |qemu_system| linux.img -hdb nbd:my_nbd_server.mydomain.org:1024
+  |qemu_system| linux2.img -hdb nbd:unix:/tmp/my_socket
+  |qemu_system| -cdrom nbd:localhost:10809:exportname=debian-500-ppc-netinst
+
+
+
+Sheepdog disk images
+--------------------
+
+Sheepdog is a distributed storage system for QEMU.  It provides highly
+available block level storage volumes that can be attached to
+QEMU-based virtual machines.
+
+You can create a Sheepdog disk image with the command:
+
+.. parsed-literal::
+
+  qemu-img create sheepdog:///IMAGE SIZE
+
+where *IMAGE* is the Sheepdog image name and *SIZE* is its
+size.
+
+To import the existing *FILENAME* to Sheepdog, you can use a
+convert command.
+
+.. parsed-literal::
+
+  qemu-img convert FILENAME sheepdog:///IMAGE
+
+You can boot from the Sheepdog disk image with the command:
+
+.. parsed-literal::
+
+  |qemu_system| sheepdog:///IMAGE
+
+You can also create a snapshot of the Sheepdog image like qcow2.
+
+.. parsed-literal::
+
+  qemu-img snapshot -c TAG sheepdog:///IMAGE
+
+where *TAG* is a tag name of the newly created snapshot.
+
+To boot from the Sheepdog snapshot, specify the tag name of the
+snapshot.
+
+.. parsed-literal::
+
+  |qemu_system| sheepdog:///IMAGE#TAG
+
+You can create a cloned image from the existing snapshot.
+
+.. parsed-literal::
+
+  qemu-img create -b sheepdog:///BASE#TAG sheepdog:///IMAGE
+
+where *BASE* is an image name of the source snapshot and *TAG*
+is its tag name.
+
+You can use an unix socket instead of an inet socket:
+
+.. parsed-literal::
+
+  |qemu_system| sheepdog+unix:///IMAGE?socket=PATH
+
+If the Sheepdog daemon doesn't run on the local host, you need to
+specify one of the Sheepdog servers to connect to.
+
+.. parsed-literal::
+
+  qemu-img create sheepdog://HOSTNAME:PORT/IMAGE SIZE
+  |qemu_system| sheepdog://HOSTNAME:PORT/IMAGE
+
+iSCSI LUNs
+----------
+
+iSCSI is a popular protocol used to access SCSI devices across a computer
+network.
+
+There are two different ways iSCSI devices can be used by QEMU.
+
+The first method is to mount the iSCSI LUN on the host, and make it appear as
+any other ordinary SCSI device on the host and then to access this device as a
+/dev/sd device from QEMU. How to do this differs between host OSes.
+
+The second method involves using the iSCSI initiator that is built into
+QEMU. This provides a mechanism that works the same way regardless of which
+host OS you are running QEMU on. This section will describe this second method
+of using iSCSI together with QEMU.
+
+In QEMU, iSCSI devices are described using special iSCSI URLs. URL syntax:
+
+::
+
+  iscsi://[<username>[%<password>]@]<host>[:<port>]/<target-iqn-name>/<lun>
+
+Username and password are optional and only used if your target is set up
+using CHAP authentication for access control.
+Alternatively the username and password can also be set via environment
+variables to have these not show up in the process list:
+
+::
+
+  export LIBISCSI_CHAP_USERNAME=<username>
+  export LIBISCSI_CHAP_PASSWORD=<password>
+  iscsi://<host>/<target-iqn-name>/<lun>
+
+Various session related parameters can be set via special options, either
+in a configuration file provided via '-readconfig' or directly on the
+command line.
+
+If the initiator-name is not specified qemu will use a default name
+of 'iqn.2008-11.org.linux-kvm[:<uuid>'] where <uuid> is the UUID of the
+virtual machine. If the UUID is not specified qemu will use
+'iqn.2008-11.org.linux-kvm[:<name>'] where <name> is the name of the
+virtual machine.
+
+Setting a specific initiator name to use when logging in to the target:
+
+::
+
+  -iscsi initiator-name=iqn.qemu.test:my-initiator
+
+Controlling which type of header digest to negotiate with the target:
+
+::
+
+  -iscsi header-digest=CRC32C|CRC32C-NONE|NONE-CRC32C|NONE
+
+These can also be set via a configuration file:
+
+::
+
+  [iscsi]
+    user = "CHAP username"
+    password = "CHAP password"
+    initiator-name = "iqn.qemu.test:my-initiator"
+    # header digest is one of CRC32C|CRC32C-NONE|NONE-CRC32C|NONE
+    header-digest = "CRC32C"
+
+Setting the target name allows different options for different targets:
+
+::
+
+  [iscsi "iqn.target.name"]
+    user = "CHAP username"
+    password = "CHAP password"
+    initiator-name = "iqn.qemu.test:my-initiator"
+    # header digest is one of CRC32C|CRC32C-NONE|NONE-CRC32C|NONE
+    header-digest = "CRC32C"
+
+How to use a configuration file to set iSCSI configuration options:
+
+.. parsed-literal::
+
+  cat >iscsi.conf <<EOF
+  [iscsi]
+    user = "me"
+    password = "my password"
+    initiator-name = "iqn.qemu.test:my-initiator"
+    header-digest = "CRC32C"
+  EOF
+
+  |qemu_system| -drive file=iscsi://127.0.0.1/iqn.qemu.test/1 \\
+    -readconfig iscsi.conf
+
+How to set up a simple iSCSI target on loopback and access it via QEMU:
+this example shows how to set up an iSCSI target with one CDROM and one DISK
+using the Linux STGT software target. This target is available on Red Hat based
+systems as the package 'scsi-target-utils'.
+
+.. parsed-literal::
+
+  tgtd --iscsi portal=127.0.0.1:3260
+  tgtadm --lld iscsi --op new --mode target --tid 1 -T iqn.qemu.test
+  tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 1 \\
+      -b /IMAGES/disk.img --device-type=disk
+  tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 2 \\
+      -b /IMAGES/cd.iso --device-type=cd
+  tgtadm --lld iscsi --op bind --mode target --tid 1 -I ALL
+
+  |qemu_system| -iscsi initiator-name=iqn.qemu.test:my-initiator \\
+    -boot d -drive file=iscsi://127.0.0.1/iqn.qemu.test/1 \\
+    -cdrom iscsi://127.0.0.1/iqn.qemu.test/2
+
+GlusterFS disk images
+---------------------
+
+GlusterFS is a user space distributed file system.
+
+You can boot from the GlusterFS disk image with the command:
+
+URI:
+
+.. parsed-literal::
+
+  |qemu_system| -drive file=gluster[+TYPE]://[HOST}[:PORT]]/VOLUME/PATH
+                               [?socket=...][,file.debug=9][,file.logfile=...]
+
+JSON:
+
+.. parsed-literal::
+
+  |qemu_system| 'json:{"driver":"qcow2",
+                           "file":{"driver":"gluster",
+                                    "volume":"testvol","path":"a.img","debug":9,"logfile":"...",
+                                    "server":[{"type":"tcp","host":"...","port":"..."},
+                                              {"type":"unix","socket":"..."}]}}'
+
+*gluster* is the protocol.
+
+*TYPE* specifies the transport type used to connect to gluster
+management daemon (glusterd). Valid transport types are
+tcp and unix. In the URI form, if a transport type isn't specified,
+then tcp type is assumed.
+
+*HOST* specifies the server where the volume file specification for
+the given volume resides. This can be either a hostname or an ipv4 address.
+If transport type is unix, then *HOST* field should not be specified.
+Instead *socket* field needs to be populated with the path to unix domain
+socket.
+
+*PORT* is the port number on which glusterd is listening. This is optional
+and if not specified, it defaults to port 24007. If the transport type is unix,
+then *PORT* should not be specified.
+
+*VOLUME* is the name of the gluster volume which contains the disk image.
+
+*PATH* is the path to the actual disk image that resides on gluster volume.
+
+*debug* is the logging level of the gluster protocol driver. Debug levels
+are 0-9, with 9 being the most verbose, and 0 representing no debugging output.
+The default level is 4. The current logging levels defined in the gluster source
+are 0 - None, 1 - Emergency, 2 - Alert, 3 - Critical, 4 - Error, 5 - Warning,
+6 - Notice, 7 - Info, 8 - Debug, 9 - Trace
+
+*logfile* is a commandline option to mention log file path which helps in
+logging to the specified file and also help in persisting the gfapi logs. The
+default is stderr.
+
+You can create a GlusterFS disk image with the command:
+
+.. parsed-literal::
+
+  qemu-img create gluster://HOST/VOLUME/PATH SIZE
+
+Examples
+
+.. parsed-literal::
+
+  |qemu_system| -drive file=gluster://1.2.3.4/testvol/a.img
+  |qemu_system| -drive file=gluster+tcp://1.2.3.4/testvol/a.img
+  |qemu_system| -drive file=gluster+tcp://1.2.3.4:24007/testvol/dir/a.img
+  |qemu_system| -drive file=gluster+tcp://[1:2:3:4:5:6:7:8]/testvol/dir/a.img
+  |qemu_system| -drive file=gluster+tcp://[1:2:3:4:5:6:7:8]:24007/testvol/dir/a.img
+  |qemu_system| -drive file=gluster+tcp://server.domain.com:24007/testvol/dir/a.img
+  |qemu_system| -drive file=gluster+unix:///testvol/dir/a.img?socket=/tmp/glusterd.socket
+  |qemu_system| -drive file=gluster+rdma://1.2.3.4:24007/testvol/a.img
+  |qemu_system| -drive file=gluster://1.2.3.4/testvol/a.img,file.debug=9,file.logfile=/var/log/qemu-gluster.log
+  |qemu_system| 'json:{"driver":"qcow2",
+                           "file":{"driver":"gluster",
+                                    "volume":"testvol","path":"a.img",
+                                    "debug":9,"logfile":"/var/log/qemu-gluster.log",
+                                    "server":[{"type":"tcp","host":"1.2.3.4","port":24007},
+                                              {"type":"unix","socket":"/var/run/glusterd.socket"}]}}'
+  |qemu_system| -drive driver=qcow2,file.driver=gluster,file.volume=testvol,file.path=/path/a.img,
+                                       file.debug=9,file.logfile=/var/log/qemu-gluster.log,
+                                       file.server.0.type=tcp,file.server.0.host=1.2.3.4,file.server.0.port=24007,
+                                       file.server.1.type=unix,file.server.1.socket=/var/run/glusterd.socket
+
+Secure Shell (ssh) disk images
+------------------------------
+
+You can access disk images located on a remote ssh server
+by using the ssh protocol:
+
+.. parsed-literal::
+
+  |qemu_system| -drive file=ssh://[USER@]SERVER[:PORT]/PATH[?host_key_check=HOST_KEY_CHECK]
+
+Alternative syntax using properties:
+
+.. parsed-literal::
+
+  |qemu_system| -drive file.driver=ssh[,file.user=USER],file.host=SERVER[,file.port=PORT],file.path=PATH[,file.host_key_check=HOST_KEY_CHECK]
+
+*ssh* is the protocol.
+
+*USER* is the remote user.  If not specified, then the local
+username is tried.
+
+*SERVER* specifies the remote ssh server.  Any ssh server can be
+used, but it must implement the sftp-server protocol.  Most Unix/Linux
+systems should work without requiring any extra configuration.
+
+*PORT* is the port number on which sshd is listening.  By default
+the standard ssh port (22) is used.
+
+*PATH* is the path to the disk image.
+
+The optional *HOST_KEY_CHECK* parameter controls how the remote
+host's key is checked.  The default is ``yes`` which means to use
+the local ``.ssh/known_hosts`` file.  Setting this to ``no``
+turns off known-hosts checking.  Or you can check that the host key
+matches a specific fingerprint:
+``host_key_check=md5:78:45:8e:14:57:4f:d5:45:83:0a:0e:f3:49:82:c9:c8``
+(``sha1:`` can also be used as a prefix, but note that OpenSSH
+tools only use MD5 to print fingerprints).
+
+Currently authentication must be done using ssh-agent.  Other
+authentication methods may be supported in future.
+
+Note: Many ssh servers do not support an ``fsync``-style operation.
+The ssh driver cannot guarantee that disk flush requests are
+obeyed, and this causes a risk of disk corruption if the remote
+server or network goes down during writes.  The driver will
+print a warning when ``fsync`` is not supported:
+
+::
+
+  warning: ssh server ssh.example.com:22 does not support fsync
+
+With sufficiently new versions of libssh and OpenSSH, ``fsync`` is
+supported.
+
+NVMe disk images
+----------------
+
+NVM Express (NVMe) storage controllers can be accessed directly by a userspace
+driver in QEMU.  This bypasses the host kernel file system and block layers
+while retaining QEMU block layer functionalities, such as block jobs, I/O
+throttling, image formats, etc.  Disk I/O performance is typically higher than
+with ``-drive file=/dev/sda`` using either thread pool or linux-aio.
+
+The controller will be exclusively used by the QEMU process once started. To be
+able to share storage between multiple VMs and other applications on the host,
+please use the file based protocols.
+
+Before starting QEMU, bind the host NVMe controller to the host vfio-pci
+driver.  For example:
+
+.. parsed-literal::
+
+  # modprobe vfio-pci
+  # lspci -n -s 0000:06:0d.0
+  06:0d.0 0401: 1102:0002 (rev 08)
+  # echo 0000:06:0d.0 > /sys/bus/pci/devices/0000:06:0d.0/driver/unbind
+  # echo 1102 0002 > /sys/bus/pci/drivers/vfio-pci/new_id
+
+  # |qemu_system| -drive file=nvme://HOST:BUS:SLOT.FUNC/NAMESPACE
+
+Alternative syntax using properties:
+
+.. parsed-literal::
+
+  |qemu_system| -drive file.driver=nvme,file.device=HOST:BUS:SLOT.FUNC,file.namespace=NAMESPACE
+
+*HOST*:*BUS*:*SLOT*.\ *FUNC* is the NVMe controller's PCI device
+address on the host.
+
+*NAMESPACE* is the NVMe namespace number, starting from 1.
+
+Disk image file locking
+-----------------------
+
+By default, QEMU tries to protect image files from unexpected concurrent
+access, as long as it's supported by the block protocol driver and host
+operating system. If multiple QEMU processes (including QEMU emulators and
+utilities) try to open the same image with conflicting accessing modes, all but
+the first one will get an error.
+
+This feature is currently supported by the file protocol on Linux with the Open
+File Descriptor (OFD) locking API, and can be configured to fall back to POSIX
+locking if the POSIX host doesn't support Linux OFD locking.
+
+To explicitly enable image locking, specify "locking=on" in the file protocol
+driver options. If OFD locking is not possible, a warning will be printed and
+the POSIX locking API will be used. In this case there is a risk that the lock
+will get silently lost when doing hot plugging and block jobs, due to the
+shortcomings of the POSIX locking API.
+
+QEMU transparently handles lock handover during shared storage migration.  For
+shared virtual disk images between multiple VMs, the "share-rw" device option
+should be used.
+
+By default, the guest has exclusive write access to its disk image. If the
+guest can safely share the disk image with other writers the
+``-device ...,share-rw=on`` parameter can be used.  This is only safe if
+the guest is running software, such as a cluster file system, that
+coordinates disk accesses to avoid corruption.
+
+Note that share-rw=on only declares the guest's ability to share the disk.
+Some QEMU features, such as image file formats, require exclusive write access
+to the disk image and this is unaffected by the share-rw=on option.
+
+Alternatively, locking can be fully disabled by "locking=off" block device
+option. In the command line, the option is usually in the form of
+"file.locking=off" as the protocol driver is normally placed as a "file" child
+under a format driver. For example:
+
+::
+
+  -blockdev driver=qcow2,file.filename=/path/to/image,file.locking=off,file.driver=file
+
+To check if image locking is active, check the output of the "lslocks" command
+on host and see if there are locks held by the QEMU process on the image file.
+More than one byte could be locked by the QEMU instance, each byte of which
+reflects a particular permission that is acquired or protected by the running
+block driver.
+
+.. only:: man
+
+  See also
+  --------
+
+  The HTML documentation of QEMU for more precise information and Linux
+  user mode emulator invocation.
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 617485d1461..2328e7ea476 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -633,16 +633,6 @@ encrypted disk images.
 * disk_images_snapshot_mode:: Snapshot mode
 * vm_snapshots::              VM snapshots
 * qemu_img_invocation::       qemu-img Invocation
-* disk_images_formats::       Disk image file formats
-* host_drives::               Using host drives
-* disk_images_fat_images::    Virtual FAT disk images
-* disk_images_nbd::           NBD access
-* disk_images_sheepdog::      Sheepdog disk images
-* disk_images_iscsi::         iSCSI LUNs
-* disk_images_gluster::       GlusterFS disk images
-* disk_images_ssh::           Secure Shell (ssh) disk images
-* disk_images_nvme::          NVMe userspace driver
-* disk_image_locking::        Disk image file locking
 @end menu
 
 @node disk_images_quickstart
@@ -723,8 +713,6 @@ state is not saved or restored properly (in particular USB).
 
 @include qemu-img.texi
 
-@include docs/qemu-block-drivers.texi
-
 @node pcsys_network
 @section Network emulation
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 709162c159a..224a8e8712a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -953,7 +953,7 @@ STEXI
 @findex -cdrom
 Use @var{file} as CD-ROM image (you cannot use @option{-hdc} and
 @option{-cdrom} at the same time). You can use the host CD-ROM by
-using @file{/dev/cdrom} as filename (@pxref{host_drives}).
+using @file{/dev/cdrom} as filename.
 ETEXI
 
 DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,
-- 
2.20.1


