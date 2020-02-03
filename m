Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A5AC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:14:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E662C20721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HaT74u3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E662C20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZga-0007WU-4B
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZfd-0005W2-Sg
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZfb-0000qL-EC
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:37 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34511)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyZfb-0000on-6U
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:35 -0500
Received: by mail-wr1-x441.google.com with SMTP id t2so17507557wrr.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 03:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=AK1hrbi/20FsSg0YgyKpmaye8nJIo7ROe97xRrAgEcI=;
 b=HaT74u3pn1Tk/QczOoYxLJC6z8smZJpEravj1B0zKuE4nTtlf5VU2I2am12I2c12v2
 8sSR1MR9ZiDaqaHwZhO5n9fOLPErD8FOoTklkgJN6+SnQmeolh4Rag6sY/VjY6H/0jsi
 ojYfOOx1DtXEX8z2CGIa33QDe2xZntE3c6PS4v0H/W0dyQFinM9m+DxUiIQbi4go72vs
 Zi8HFQ/OJ2tcRlVskv/VdNKzesOhtnPTL1qeDHcH1zcVegyVuel5vXvEulm4rIL7b7k1
 2tAK5IphguT8wtv7V7pr/JYPYZTT5z2K4bjntA4of+UnuFjsOL4mTtP/DqCeS/drVPdP
 VoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AK1hrbi/20FsSg0YgyKpmaye8nJIo7ROe97xRrAgEcI=;
 b=L4U2vGELwJ/bc5pW3ovu8f2GFIRJOxHisPBjUjyGnIVFMEKAUPbNejWqKvGUmao8li
 nhDZplxZxTXseIWXm1tcknBcFfUn6lbMCNg7Aac+KZNdtJhtZfS1U0+gclNuUg87eAZx
 qs3qQL8vH2DsuTflqrrritKhVlkLuf/Vxturp9FyjhA7p1YmQrwkDnYTXKA+Gc0Yg7Qq
 nqB6Zhn2UTAQFoVztzbJ9x4lgJ4vT2mOpp1wlBxb5dvcmLXTJMnL4J4puWOixdJB7T+z
 OvsxEazSuPKaakLam7LyjP7R4oxYhNsiFnQiXm5MGr2KGmswRouh9kjuf68tMt/HURld
 7RnQ==
X-Gm-Message-State: APjAAAV86e+1GNGAZciBgOB+Ao4n5+t9CpXcsqHxbNfdcFX7wrsFPC3J
 2xpP9GS2aqsc0o9TimXKT0RnCX7UR3hG9w==
X-Google-Smtp-Source: APXvYqxHuWAoGm51TiT1RxJ3XiJB3Av65rpJ4LLWt44AZleQJxm+zrADvWASnUpJquncENldP1riIw==
X-Received: by 2002:a5d:5752:: with SMTP id q18mr15643426wrw.277.1580728413674; 
 Mon, 03 Feb 2020 03:13:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm24028917wme.35.2020.02.03.03.13.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 03:13:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/8] scripts/qemu-trace-stap: Convert documentation to rST
Date: Mon,  3 Feb 2020 11:13:17 +0000
Message-Id: <20200203111318.23378-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203111318.23378-1-peter.maydell@linaro.org>
References: <20200203111318.23378-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

The qemu-trace-stap documentation is currently in
scripts/qemu-trace-stap.texi in Texinfo format, which we
present to the user as:
 * a qemu-trace-stap manpage
 * but not (unusually for QEMU) part of the HTML docs

Convert the documentation to rST format that lives in
the docs/ subdirectory, and present it to the user as:
 * a qemu-trace-stap manpage
 * part of the interop/ Sphinx manual

There are minor formatting changes to suit Sphinx, but no
content changes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200124162606.8787-8-peter.maydell@linaro.org
---
 Makefile                         |   9 +-
 MAINTAINERS                      |   1 +
 docs/interop/conf.py             |   4 +-
 docs/interop/index.rst           |   1 +
 docs/interop/qemu-trace-stap.rst | 124 +++++++++++++++++++++++++++
 scripts/qemu-trace-stap.texi     | 140 -------------------------------
 6 files changed, 134 insertions(+), 145 deletions(-)
 create mode 100644 docs/interop/qemu-trace-stap.rst
 delete mode 100644 scripts/qemu-trace-stap.texi

diff --git a/Makefile b/Makefile
index c9dc4422170..1e0440c3738 100644
--- a/Makefile
+++ b/Makefile
@@ -357,7 +357,7 @@ ifdef CONFIG_VIRTFS
 DOCS+=fsdev/virtfs-proxy-helper.1
 endif
 ifdef CONFIG_TRACE_SYSTEMTAP
-DOCS+=scripts/qemu-trace-stap.1
+DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-trace-stap.1
 endif
 else
 DOCS=
@@ -848,7 +848,7 @@ ifeq ($(CONFIG_TOOLS),y)
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-nbd.8 "$(DESTDIR)$(mandir)/man8"
 endif
 ifdef CONFIG_TRACE_SYSTEMTAP
-	$(INSTALL_DATA) scripts/qemu-trace-stap.1 "$(DESTDIR)$(mandir)/man1"
+	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-trace-stap.1 "$(DESTDIR)$(mandir)/man1"
 endif
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
@@ -1050,7 +1050,9 @@ $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
 $(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system)
 	$(call build-manual,system,html)
 
-$(call define-manpage-rule,interop,qemu-ga.8 qemu-img.1 qemu-nbd.8,$(SRC_PATH/qemu-img-cmds.hx))
+$(call define-manpage-rule,interop,\
+       qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1,\
+       $(SRC_PATH/qemu-img-cmds.hx))
 
 $(call define-manpage-rule,system,qemu-block-drivers.7)
 
@@ -1078,7 +1080,6 @@ qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
 qemu.1: qemu-option-trace.texi
 fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
 docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
-scripts/qemu-trace-stap.1: scripts/qemu-trace-stap.texi
 
 html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html sphinxdocs
 info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info
diff --git a/MAINTAINERS b/MAINTAINERS
index 80263385190..db3cbc18c92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2193,6 +2193,7 @@ F: qemu-option-trace.texi
 F: scripts/tracetool.py
 F: scripts/tracetool/
 F: scripts/qemu-trace-stap*
+F: docs/interop/qemu-trace-stap.rst
 F: docs/devel/tracing.txt
 T: git https://github.com/stefanha/qemu.git tracing
 
diff --git a/docs/interop/conf.py b/docs/interop/conf.py
index 0de444a900d..baea7fb50ee 100644
--- a/docs/interop/conf.py
+++ b/docs/interop/conf.py
@@ -22,5 +22,7 @@ man_pages = [
     ('qemu-img', 'qemu-img', u'QEMU disk image utility',
      ['Fabrice Bellard'], 1),
     ('qemu-nbd', 'qemu-nbd', u'QEMU Disk Network Block Device Server',
-     ['Anthony Liguori <anthony@codemonkey.ws>'], 8)
+     ['Anthony Liguori <anthony@codemonkey.ws>'], 8),
+    ('qemu-trace-stap', 'qemu-trace-stap', u'QEMU SystemTap trace tool',
+     [], 1)
 ]
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index 5e4de07d4cc..d756a826b26 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -20,5 +20,6 @@ Contents:
    qemu-ga
    qemu-img
    qemu-nbd
+   qemu-trace-stap
    vhost-user
    vhost-user-gpu
diff --git a/docs/interop/qemu-trace-stap.rst b/docs/interop/qemu-trace-stap.rst
new file mode 100644
index 00000000000..fb70445c751
--- /dev/null
+++ b/docs/interop/qemu-trace-stap.rst
@@ -0,0 +1,124 @@
+QEMU SystemTap trace tool
+=========================
+
+Synopsis
+--------
+
+**qemu-trace-stap** [*GLOBAL-OPTIONS*] *COMMAND* [*COMMAND-OPTIONS*] *ARGS*...
+
+Description
+-----------
+
+The ``qemu-trace-stap`` program facilitates tracing of the execution
+of QEMU emulators using SystemTap.
+
+It is required to have the SystemTap runtime environment installed to use
+this program, since it is a wrapper around execution of the ``stap``
+program.
+
+Options
+-------
+
+.. program:: qemu-trace-stap
+
+The following global options may be used regardless of which command
+is executed:
+
+.. option:: --verbose, -v
+
+  Display verbose information about command execution.
+
+The following commands are valid:
+
+.. option:: list BINARY PATTERN...
+
+  List all the probe names provided by *BINARY* that match
+  *PATTERN*.
+
+  If *BINARY* is not an absolute path, it will be located by searching
+  the directories listed in the ``$PATH`` environment variable.
+
+  *PATTERN* is a plain string that is used to filter the results of
+  this command. It may optionally contain a ``*`` wildcard to facilitate
+  matching multiple probes without listing each one explicitly. Multiple
+  *PATTERN* arguments may be given, causing listing of probes that match
+  any of the listed names. If no *PATTERN* is given, the all possible
+  probes will be listed.
+
+  For example, to list all probes available in the ``qemu-system-x86_64``
+  binary:
+
+  ::
+
+    $ qemu-trace-stap list qemu-system-x86_64
+
+  To filter the list to only cover probes related to QEMU's cryptographic
+  subsystem, in a binary outside ``$PATH``
+
+  ::
+
+    $ qemu-trace-stap list /opt/qemu/4.0.0/bin/qemu-system-x86_64 'qcrypto*'
+
+.. option:: run OPTIONS BINARY PATTERN...
+
+  Run a trace session, printing formatted output any time a process that is
+  executing *BINARY* triggers a probe matching *PATTERN*.
+
+  If *BINARY* is not an absolute path, it will be located by searching
+  the directories listed in the ``$PATH`` environment variable.
+
+  *PATTERN* is a plain string that matches a probe name shown by the
+  *LIST* command. It may optionally contain a ``*`` wildcard to
+  facilitate matching multiple probes without listing each one explicitly.
+  Multiple *PATTERN* arguments may be given, causing all matching probes
+  to be monitored. At least one *PATTERN* is required, since stap is not
+  capable of tracing all known QEMU probes concurrently without overflowing
+  its trace buffer.
+
+  Invocation of this command does not need to be synchronized with
+  invocation of the QEMU process(es). It will match probes on all
+  existing running processes and all future launched processes,
+  unless told to only monitor a specific process.
+
+  Valid command specific options are:
+
+  .. program:: qemu-trace-stap-run
+
+  .. option:: --pid=PID, -p PID
+
+    Restrict the tracing session so that it only triggers for the process
+    identified by *PID*.
+
+  For example, to monitor all processes executing ``qemu-system-x86_64``
+  as found on ``$PATH``, displaying all I/O related probes:
+
+  ::
+
+    $ qemu-trace-stap run qemu-system-x86_64 'qio*'
+
+  To monitor only the QEMU process with PID 1732
+
+  ::
+
+    $ qemu-trace-stap run --pid=1732 qemu-system-x86_64 'qio*'
+
+  To monitor QEMU processes running an alternative binary outside of
+  ``$PATH``, displaying verbose information about setup of the
+  tracing environment:
+
+  ::
+
+    $ qemu-trace-stap -v run /opt/qemu/4.0.0/qemu-system-x86_64 'qio*'
+
+See also
+--------
+
+:manpage:`qemu(1)`, :manpage:`stap(1)`
+
+..
+  Copyright (C) 2019 Red Hat, Inc.
+
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of the GNU General Public License as published by
+  the Free Software Foundation; either version 2 of the License, or
+  (at your option) any later version.
diff --git a/scripts/qemu-trace-stap.texi b/scripts/qemu-trace-stap.texi
deleted file mode 100644
index 07bb9eb94e7..00000000000
--- a/scripts/qemu-trace-stap.texi
+++ /dev/null
@@ -1,140 +0,0 @@
-@example
-@c man begin SYNOPSIS
-@command{qemu-trace-stap} @var{GLOBAL-OPTIONS} @var{COMMAND} @var{COMMAND-OPTIONS} @var{ARGS...}
-@c man end
-@end example
-
-@c man begin DESCRIPTION
-
-The @command{qemu-trace-stap} program facilitates tracing of the execution
-of QEMU emulators using SystemTap.
-
-It is required to have the SystemTap runtime environment installed to use
-this program, since it is a wrapper around execution of the @command{stap}
-program.
-
-@c man end
-
-@c man begin OPTIONS
-
-The following global options may be used regardless of which command
-is executed:
-
-@table @option
-@item @var{--verbose}, @var{-v}
-
-Display verbose information about command execution.
-
-@end table
-
-The following commands are valid:
-
-@table @option
-
-@item @var{list} @var{BINARY} @var{PATTERN...}
-
-List all the probe names provided by @var{BINARY} that match
-@var{PATTERN}.
-
-If @var{BINARY} is not an absolute path, it will be located by searching
-the directories listed in the @code{$PATH} environment variable.
-
-@var{PATTERN} is a plain string that is used to filter the results of
-this command. It may optionally contain a @code{*} wildcard to facilitate
-matching multiple probes without listing each one explicitly. Multiple
-@var{PATTERN} arguments may be given, causing listing of probes that match
-any of the listed names. If no @var{PATTERN} is given, the all possible
-probes will be listed.
-
-For example, to list all probes available in the @command{qemu-system-x86_64}
-binary:
-
-@example
-$ qemu-trace-stap list qemu-system-x86_64
-@end example
-
-To filter the list to only cover probes related to QEMU's cryptographic
-subsystem, in a binary outside @code{$PATH}
-
-@example
-$ qemu-trace-stap list /opt/qemu/4.0.0/bin/qemu-system-x86_64 'qcrypto*'
-@end example
-
-
-@item @var{run} @var{OPTIONS} @var{BINARY} @var{PATTERN...}
-
-Run a trace session, printing formatted output any time a process that is
-executing @var{BINARY} triggers a probe matching @var{PATTERN}.
-
-If @var{BINARY} is not an absolute path, it will be located by searching
-the directories listed in the @code{$PATH} environment variable.
-
-@var{PATTERN} is a plain string that matches a probe name shown by the
-@var{list} command. It may optionally contain a @code{*} wildcard to
-facilitate matching multiple probes without listing each one explicitly.
-Multiple @var{PATTERN} arguments may be given, causing all matching probes
-to be monitored. At least one @var{PATTERN} is required, since stap is not
-capable of tracing all known QEMU probes concurrently without overflowing
-its trace buffer.
-
-Invocation of this command does not need to be synchronized with
-invocation of the QEMU process(es). It will match probes on all
-existing running processes and all future launched processes,
-unless told to only monitor a specific process.
-
-Valid command specific options are:
-
-@table @option
-@item @var{--pid=PID}, @var{-p PID}
-
-Restrict the tracing session so that it only triggers for the process
-identified by @code{PID}.
-
-@end table
-
-For example, to monitor all processes executing @command{qemu-system-x86_64}
-as found on $PATH, displaying all I/O related probes:
-
-@example
-$ qemu-trace-stap run qemu-system-x86_64 'qio*'
-@end example
-
-To monitor only the QEMU process with PID 1732
-
-@example
-$ qemu-trace-stap run --pid=1732 qemu-system-x86_64 'qio*'
-@end example
-
-To monitor QEMU processes running an alternative binary outside of
-@code{$PATH}, displaying verbose information about setup of the
-tracing environment:
-
-@example
-$ qemu-trace-stap -v run /opt/qemu/4.0.0/qemu-system-x86_64 'qio*'
-@end example
-
-@end table
-
-@c man end
-
-@ignore
-
-@setfilename qemu-trace-stap
-@settitle QEMU SystemTap trace tool
-
-@c man begin LICENSE
-
-Copyright (C) 2019 Red Hat, Inc.
-
-This program is free software; you can redistribute it and/or modify
-it under the terms of the GNU General Public License as published by
-the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-
-@c man end
-
-@c man begin SEEALSO
-qemu(1), stap(1)
-@c man end
-
-@end ignore
-- 
2.20.1


