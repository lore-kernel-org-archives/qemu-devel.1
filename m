Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07655C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C5020709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="je3SAwCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C5020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv1pW-0008B9-SN
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iv1ms-0002t9-IJ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:26:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iv1mp-0002wx-Tq
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:26:26 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54497)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iv1mp-0002wL-NT
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:26:23 -0500
Received: by mail-wm1-x344.google.com with SMTP id g1so39245wmh.4
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 08:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=osGy3uQzZ6AYLYVL2PB0rHasNbUPaTwHZ3YOV3fWqFU=;
 b=je3SAwCgia/S5N+YdIfnQQ9S0iL8w/ZRJmLExFigA95DtNllcyr6U6jMjaF2Ax75xg
 z9EozRi5hBMIP1q6vj8qjIRJBT6vqkiCiCBEs3U3gwVGjrWRoi/2h9OJ19zVdijmzK4l
 9x0ah9OfiA7mN5wlOxk324Ax0Ssu8y3e6KEGeXndW3vwwUM+nSBG012Xv4o0N7M0fTpn
 KEjNbbsExdiSoDa1ZYefgHhBRxnqokukhdfOO5TPsI4AI+z9leNZpR1RMxusR6SAChAQ
 qs+07I/o4zl3+cIpFCMXnksRbNmU7imnfnfNf0hesmUxyDtLBwokoyjvNkT804XuseIQ
 rY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=osGy3uQzZ6AYLYVL2PB0rHasNbUPaTwHZ3YOV3fWqFU=;
 b=bqSQbDA1xqB3I1Vo8JtOWtheB0J0WVdRAQBKkn02Y9IuWevTAlQQF6GOXVi9b6zqDB
 6Quq9c4rZI6uzEjdXz6TjsHqWXh5ZaoSUhNkUv6/37p4xANy3h76rqE7B3BdomCu3Ln9
 PDDdOXEg7q5/3VWIxnJp7+nPciI+nJ5/jX0kMkxbGBt7JqD17w0lXlqYDILhCA7HeOxj
 vDPSZuGVSzX5TzjX4Khvphm7UmJhLSvDy8wLnkSrgwk3l1GmM6SCAFiuGYeGiTeFxLG3
 luDtm8XJLBT4wwf+NgVVmX+QSyjzdL3aq4pUUkuuYXA12LKNdhrviVP9D3fy9wFmhZbg
 LoAg==
X-Gm-Message-State: APjAAAXLHeQxswG+Uxa6WTYy2x0ThXG1UkdeA1hnvHZ/JUAi7B1+LKUb
 aOe4fYKQafuD8iLultVnNilG1XFG1mrRhQ==
X-Google-Smtp-Source: APXvYqzPOSqvWPat435QKyNQ1v8O4Rag82lj9cS1UXofxejtrOcOYYlCjTX0ItI+8Heck7N0OSIchQ==
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr68586wma.24.1579883180799;
 Fri, 24 Jan 2020 08:26:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q3sm7054998wmj.38.2020.01.24.08.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 08:26:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/8] scripts/qemu-trace-stap: Convert documentation to rST
Date: Fri, 24 Jan 2020 16:26:05 +0000
Message-Id: <20200124162606.8787-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124162606.8787-1-peter.maydell@linaro.org>
References: <20200124162606.8787-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Greg Kurz <groug@kaod.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
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
index 4e1a5e9906c..5dded94bf63 100644
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
index 39423cd07f2..54c4429069d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2191,6 +2191,7 @@ F: qemu-option-trace.texi
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


