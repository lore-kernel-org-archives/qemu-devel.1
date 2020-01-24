Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61FAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B2520704
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ofEmVvu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B2520704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv1nj-0004Aw-RN
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iv1me-0002Qy-S7
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:26:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iv1md-0002if-9o
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:26:12 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:37939)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iv1md-0002hI-1L
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:26:11 -0500
Received: by mail-wr1-x433.google.com with SMTP id y17so2698288wrh.5
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 08:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9L8Au1O+yS2ujy0IZd2JyDoMFFfJ1Tv3zUpArmasx6s=;
 b=ofEmVvu4trlq5QUH+GX5LF+fazMSqp+7F10Ck4K2hhxR5NXcOjmeev1/ozwBYVEzxl
 qLMTaE0T6Z3LgR+yW86bD697nuMqVm20dvUvstJ17Z+ZCA7qrPqig6Eq41HNwGaNgAAv
 RUBGxk/pg40GpE0MHRiNLYx1k99F+3g54O1I0Yjz8n8gWDAeqfvHegSDDysx5UjldNFQ
 3xsppSjjaXsapDLSWZcu/8qpFbvAXoaqcGAYhRXD7N+MseokSAjagIZjfhmshrirs+M1
 kdvw9ErQva2VNDWFDJGxjlCYibCWixnChm+Nnjnxj/SGSfN5isIwncCDCsE+Zuw2VX35
 eUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9L8Au1O+yS2ujy0IZd2JyDoMFFfJ1Tv3zUpArmasx6s=;
 b=P9mSk+TCn0AGp1vq40az/+MnGM7WtfskWSUWEFN71l34vFSIWghLZ/o5hqLvLTlvS/
 m2XHobcIMlO+7PeUoRbgqF5Higxcjzm5zzITp+A24a8Mmck0UgtzABaZzhTe/4B0EMyh
 kDUmzVVi2ZKgRsDJ7H3ULkNBK0Z05aXdIP+lTWV8t/IPBa9hh4oV1e9FWYNVeQfF0PDH
 Jj3uU5u81fU48k5CmbIHW1X9zKW5meSRIWCiojQoubMx8nsfD6PLDXm4smTymSC0IfjF
 qYBKIjq4ETSKfDRVSVqBqzS7HN2iv9LRUw9j2G1KenE6q9RYgZ+1DCZc+/9f8go+TqwG
 W1+A==
X-Gm-Message-State: APjAAAUt9rvpHQssGh2EwNjCv0tMKXSCxGo0f/jcStG4JiksbufH3iJd
 CdH2evkahZs56VAyk2Ky8r+OXrXjl2tz2w==
X-Google-Smtp-Source: APXvYqx5+yCVMpOVrVaAWfaF3iBnoBPB1zGYKKfZT8ZmytOeI5FT5813U0uad7OsrMGvT8n6varsdQ==
X-Received: by 2002:adf:ebc1:: with SMTP id v1mr5413919wrn.351.1579883169439; 
 Fri, 24 Jan 2020 08:26:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q3sm7054998wmj.38.2020.01.24.08.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 08:26:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/8] qemu-img, qemu-trace-stap,
 virtfs-proxy-helper: convert to rST
Date: Fri, 24 Jan 2020 16:25:58 +0000
Message-Id: <20200124162606.8787-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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

This patchset converts the following documentation to rST format:
 * qemu-img
 * qemu-trace-stap
 * virtfs-proxy-helper

(That means everything in step 3 in the plan:
https://wiki.qemu.org/Features/Documentation#3:_Convert_things_which_are_mostly_standalone_manpages
will be done except for qemu-cpu-models.texi. That
should be a straightforward conversion but I haven't
touched it yet because I know there's an on-list patch
that updates the texi and wanted to avoid a conflict.)

The patchset includes a new Sphinx extension which handles parsing
the .hx files which provide documentation fragments for the qemu-img
manual.

Changes from v1 to v2:
 * rebased on master, since the qemu-nbd conversion has now
   gone in
 * the patches at the end to convert qemu-trace-stap and
   virtfs-proxy-helper are new
 * new patch at the start of the series which fixes a
   bug in our makefiles where we could try to invoke
   Sphinx twice in parallel on the same doctree (which
   causes it to crash, as well as being unnecessary work)
 * fixed the import line for ExtensionError, so this
   should now work with Sphinx 1.8

I've assigned manpages to interop/ or system/ according
to the structure set out in the wiki page above. We should
have a discussion about whether some of these should go
in a new tools/ manual or not (I'll start a separate
thread for that), but it's easy enough to move them
later if we need to.

The general approach follows the outline in the email I
sent the other day:
https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg03786.html

The new Sphinx extension implements the hxtool-doc::
directive, which indicates where the assembled rST
document fragments should be inserted into the manual.
qemu-img-cmds.hx doesn't use the DEFHEADING or ARCHHEADING
directives, but the extension implements them (tested
with some local modifications to the .hx file to check
that they do the right thing).

As noted in the commit message for the qemu-img.texi conversion,
I have not attempted to tackle any of the muddle in the
current documentation structure or the repetition between
the manual document, the fragments in the .hx file and
the C code; this is a "simplest thing that works"
like-for-like conversion.

Another deliberate omission is that I have not attempted
to get links between our various Sphinx manuals (system,
interop, etc) working yet, as this is not totally trivial
and the odd minor missed hyperlink doesn't seem to me
to be a deal-breaker.

Sorry about the size of the main 'convert qemu-img'
patch, but it's unavoidable when converting a big
document between formats.

thanks
-- PMM

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
 docs/interop/qemu-img.rst            | 822 +++++++++++++++++++++++++++
 docs/interop/qemu-trace-stap.rst     | 124 ++++
 docs/interop/virtfs-proxy-helper.rst |  72 +++
 docs/sphinx/hxtool.py                | 210 +++++++
 fsdev/virtfs-proxy-helper.texi       |  63 --
 qemu-doc.texi                        |  10 +-
 qemu-img-cmds.hx                     |  99 ++--
 qemu-img.texi                        | 795 --------------------------
 rules.mak                            |  36 ++
 scripts/hxtool                       |  33 +-
 scripts/qemu-trace-stap.texi         | 140 -----
 16 files changed, 1383 insertions(+), 1085 deletions(-)
 create mode 100644 docs/interop/qemu-img.rst
 create mode 100644 docs/interop/qemu-trace-stap.rst
 create mode 100644 docs/interop/virtfs-proxy-helper.rst
 create mode 100644 docs/sphinx/hxtool.py
 delete mode 100644 fsdev/virtfs-proxy-helper.texi
 delete mode 100644 qemu-img.texi
 delete mode 100644 scripts/qemu-trace-stap.texi

-- 
2.20.1


