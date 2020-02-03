Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4F4C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:14:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA31220721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oEc7l/3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA31220721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZgE-0006c2-Uj
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:14:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZfQ-00052H-Gj
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZfP-0000bo-9H
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:24 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:51488)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyZfP-0000b6-2k
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:23 -0500
Received: by mail-wm1-x32b.google.com with SMTP id t23so15395431wmi.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 03:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WDqb8kro4Lpskh0ToMLMlzcth3MMfpUWapeawHJmdq8=;
 b=oEc7l/3ubKzYM1qp8dlUZefKNi/VbC65+36tmsbhtFgelBm8KOgZ9vyWWmUMB3z+6z
 DtrpBR9Us+Gb0rTVQPMLv1yyi/swjXld2WWsujFuOBDZkvmFEa9fy3XYaDDpwhhurS71
 IMr7HaBWn+UNUOSRj1EdtYdQ6EMclZgnhs7Mxv3Z/W6bIlsajHWIuTv30qr9yChU/MPO
 pFYkks5i3nzBvXbXhTnXKYi2uCf7zq9CbNOtSNInd1i1BzSic3BrMGjgwgK+53QiY4ln
 mCGV+7yY6B26QWPybh141gxiqr5gvWlV+5seTrKt3Aln5C3jru/3psECh65m+mHgPPsK
 3frQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WDqb8kro4Lpskh0ToMLMlzcth3MMfpUWapeawHJmdq8=;
 b=GwgDpgoIJ+WCB79i+Jkt6thZPtWJD+JSgc2XlOmocjcrMFJsj6MVVZuKVK+EPYUp5g
 FqgJI66w+/a5UwzKIIGqgMUEHfOq0zoI1P1H7ecstr7mA9Ek1+qeCfUMyXivMtzxC6mJ
 FL7RCvJsn72Vq8I3hhTYxC88qMGlrll0O0lvyyvafuArdkgOpiu//SYFBEg6WSDxMoy7
 PauYtG9gGgQaVKHBF7QSwkpTsgIet0oJYwXH6GyHVz6YAm044Gi4BUrVBfUOLNTRFWno
 /nE7CrGsypTREge/nwFkmEFPBttEEdx9PQRTPapHS8N6DE6f9krHKwBpgL17dl5Gl43b
 hkfQ==
X-Gm-Message-State: APjAAAXaeZmSGHRFAm7K/U7C0ro+4uqrI0LgpIRk9vVziEnDsn7Fiidj
 2AKZoZ+XPFW5wUohHUPoaeRY6E1LEHcmSQ==
X-Google-Smtp-Source: APXvYqz6DVG/od8wRKdWqWkV8PBodQAgw6Z0PeW09Vm6xisUIFiAOWNOVGeWqarePs68/Us6aMhtdQ==
X-Received: by 2002:a7b:c407:: with SMTP id k7mr29394821wmi.46.1580728400888; 
 Mon, 03 Feb 2020 03:13:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm24028917wme.35.2020.02.03.03.13.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 03:13:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] docs queue
Date: Mon,  3 Feb 2020 11:13:10 +0000
Message-Id: <20200203111318.23378-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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

This 'docs' pullrequest is just my 8-patch series
which adds hxtool doc fragment support for rST and
converts qemu-img/qemu-trace-stap/virtfs-proxy-helper.

It has small fixes squashed in to account for commit
cdd267749a3ab78 (which adds a new option to the qemu-img
docs) now being in master.

thanks
-- PMM

The following changes since commit 035b21977ce1791a630c5cbf46e482e54552e05b:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.0-20200203' into staging (2020-02-03 09:52:43 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-docs-20200203

for you to fetch changes up to 78813586b04e89639754cfdcef23802dc9f54ff4:

  virtfs-proxy-helper: Convert documentation to rST (2020-02-03 11:02:23 +0000)

----------------------------------------------------------------
docs:
 * Fix Makefile concurrency bug where we could run Sphinx twice
   in parallel on the same manual (which makes it crash)
 * Support handling hxtool doc fragments for rST manuals
 * Convert qemu-img docs to rST
 * Convert qemu-trace-stap docs to rST
 * Convert virtfs-proxy-helper docs to rST

----------------------------------------------------------------
Peter Maydell (8):
      Makefile: Ensure we don't run Sphinx in parallel for manpages
      hxtool: Support SRST/ERST directives
      docs/sphinx: Add new hxtool Sphinx extension
      qemu-img-cmds.hx: Add rST documentation fragments
      qemu-img: Convert invocation documentation to rST
      qemu-img-cmds.hx: Remove texinfo document fragments
      scripts/qemu-trace-stap: Convert documentation to rST
      virtfs-proxy-helper: Convert documentation to rST

 Makefile                             |  46 +-
 MAINTAINERS                          |   3 +
 docs/conf.py                         |   3 +-
 docs/interop/conf.py                 |   9 +-
 docs/interop/index.rst               |   3 +
 docs/interop/qemu-img.rst            | 825 +++++++++++++++++++++++++++++++++++
 docs/interop/qemu-trace-stap.rst     | 124 ++++++
 docs/interop/virtfs-proxy-helper.rst |  72 +++
 docs/sphinx/hxtool.py                | 210 +++++++++
 fsdev/virtfs-proxy-helper.texi       |  63 ---
 qemu-doc.texi                        |  10 +-
 qemu-img-cmds.hx                     |  99 ++---
 qemu-img.texi                        | 798 ---------------------------------
 rules.mak                            |  36 ++
 scripts/hxtool                       |  33 +-
 scripts/qemu-trace-stap.texi         | 140 ------
 16 files changed, 1386 insertions(+), 1088 deletions(-)
 create mode 100644 docs/interop/qemu-img.rst
 create mode 100644 docs/interop/qemu-trace-stap.rst
 create mode 100644 docs/interop/virtfs-proxy-helper.rst
 create mode 100644 docs/sphinx/hxtool.py
 delete mode 100644 fsdev/virtfs-proxy-helper.texi
 delete mode 100644 qemu-img.texi
 delete mode 100644 scripts/qemu-trace-stap.texi

