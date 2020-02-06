Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3263C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A732D21741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOWof8qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A732D21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izl1c-0008Jq-MH
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:33:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzJ-00062R-Nw
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzH-0003gN-A1
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:30:49 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:39058)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izkzH-0003ZK-0y
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:30:47 -0500
Received: by mail-wm1-x334.google.com with SMTP id c84so978619wme.4
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=78ISnKm1SjuBB9uqdVOttmoG/BsTbDda2NDgpbBGnnc=;
 b=gOWof8qgcRHZ65E3hv6Pe6BTMU0DYcmI8TH9Lkr3SZlb+lnYlc/JX2Rf9+ADkue4iF
 i4IzIbwxeU17A6QZ7GFYVR/elFgxJzA6/wiFr0AnoD3HhYDui/k4V5HUEJ3hfQYicYVM
 O69IVcmMXnQbHaXjRnnQr2Q7KRc9uLbAOBukpRJ58NsGbLufzyLIFK8zAqsG3ckkc1qH
 webMNb0IADZ+glSqok6vc3ceUryPlVkJCPz/STdUFrJiDX33njjw7WEBV/WRUJtkSfA9
 1h7L1hWel5U1YEaNvqkexWSi9tXlH25x/fpO4ETIsGhJySrxdgIGLlJq5RQ/2ZuDEtgU
 zPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=78ISnKm1SjuBB9uqdVOttmoG/BsTbDda2NDgpbBGnnc=;
 b=DN1zGJ3rS3agV5ccitvJ+ijyWzvNQ9KvJjVsRUTdGIpV2rXvNVj9SDTuEVeddVnUnn
 2h6yyTfpWkbM4UaFt5XGhGQZp9c5fKvPbn1zz29sCurVDE57PmKIS6IPQ6zFgSBWY04J
 6gpwMJWsoWKBSt/AuGAq3o4cJiyIOsZQ+5AS0o6th4bQN0m0a2/zCzR3Tta7h0HHBEnS
 gafI0UKJo99iMKYoda5xQ3jqWkGDUMhNqbX35WiTWDZ8upVbUB53tSIg4E+FJDaCfoX2
 TfyfhX5kgvttLXQ+X8/l+AxkeIttUMq+ZX8jvfRT0ROLFrPjSU5WJdYik6QRznG79Afn
 qtCg==
X-Gm-Message-State: APjAAAXnZeYHBdeXdlh0ckJxSWOUPXe5EAfnYMdbx3A3Zce0JRivRkQD
 ypoG/MrR2hKyioDjbZCD5uSR++bY4GM=
X-Google-Smtp-Source: APXvYqwY6Y4yuuFF9ZNVd0G23ADy1Vsp1501zBttNZnN5XDxJzJTfr2TOJOnNmuW78psfaDxkPcxKg==
X-Received: by 2002:a7b:c152:: with SMTP id z18mr5660152wmi.70.1581010244052; 
 Thu, 06 Feb 2020 09:30:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:30:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/29] Convert QAPI doc comments to generate rST instead of
 texinfo
Date: Thu,  6 Feb 2020 17:30:11 +0000
Message-Id: <20200206173040.17337-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


This series switches all our QAPI doc comments over from
texinfo format to rST.

The basic approach is somewhat similar to how we deal with kerneldoc
and hxtool: we have a custom Sphinx extension which is passed a
filename which is the json file it should run the QAPI parser over and
generate documentation for. Unlike 'kerneldoc' but somewhat like
hxtool, I have chosed to generate documentation by generating a tree
of docutils nodes, rather than by generating rST source that is then
fed to the rST parser to generate docutils nodes.  Individual lumps of
doc comment go to the rST parser, but the structured parts we render
directly. This makes it easier to get the structure and heading level
nesting correct.

Rather than trying to exactly handle all the existing comments I have
opted (as Markus suggested) to tweak them where this seemed more
sensible than contorting the rST generator to deal with
weirdnesses. The principal changes are:
 * whitespace is now significant, and multiline definitions must have
   their second and subsequent lines indented to match the first line
 * general rST format markup is permitted, not just the small set of
   markup the old texinfo generator handled. For most things (notably
   bulleted and itemized lists) the old format is the same as rST was.
 * Specific things that might trip people up:
   - instead of *bold* and _italic_ rST has **bold** and *italic*
   - lists need a preceding and following blank line
   - a lone literal '*' will need to be backslash-escaped to
     avoid a rST syntax error
 * the old leading '|' for example (literal text) blocks is replaced
   by the standard rST '::' literal block.
 * headings and subheadings must now be in a freeform documentation
   comment of their own
 * we support arbitrary levels of sub- and sub-sub-heading, not just a
   main and sub-heading like the old texinfo generator
 * as a special case, @foo is retained and is equivalent to ``foo``

This policy means that most of the patch series is cleanups to the doc
comments:
 - doc comments missing the ':' after @argument (misrenders
   in the texi, is a syntax error for rST)
 - doc comments with indent that doesn't match the tightened
   requirements (no effect on the texi, but rST cares)
 - some lists needed leading/trailing blank lines adding
 - a graph intended to be rendered as ascii-art wasn't correctly
   marked up as a literal block (misrenders in the texi, syntax error
   for rST)
 - some stray hardcoded tab characters needed changing to spaces
 - in a few places parts of a doc comment were in the wrong order
   resulting in it being rendered into the wrong section by mistake
 - a few instances of texinfo `quotes' needed to be changed to rST
   'quotes'; similarly _this_ isn't valid rST markup, and in one place
   a literal * needed backslash-escaping
 - numerous places were trying to have lists without using the list
   markup, which renders as weird run-on sentences
 - the two places which define headings in the middle of a doc comment
   are changed to put the heading definition in the
   standalone-comment-block that the new generator wants (no change to
   the texinfo output)

Patch 9 changes 663 lines in 20 files but it is purely a whitespace
change (verifiable with 'git show -w').  The other patches are
generally smaller and straightforward.

All of these patches except for the "escape a literal '*'" one at the
end have either no/minimal effect on the generated texinfo or fix
misrenderings.

Moving on to the actual code changes:
 * we start by changing the existing parser code to be more careful
   with leading whitespace: instead of stripping it all, it strips
   only the amount required for indented multiline definitions, and
   complains if it finds an unexpected de-indent. The texinfo
   generator code is updated to do whitespace stripping itself, so
   there is no change to the generated texi source.
 * then we add the new qapidoc Sphinx extension, which is not yet used
   by anything. This is a 500 line script, all added in one patch. I
   can split it if people think that would help, but I'm not sure I
   see a good split point.
 * then we can convert the two generated reference documents, one at a
   time. This is mostly just updating makefile rules and the like.
 * after that we can do some minor tweaks to doc comments that would
   have confused the texinfo parser: changing our two instances of
   '|'-markup literal blocks to rST '::' literal blocks, and adding
   some headings to the GA reference so the rST interop manual ToC
   looks better.
 * finally, we can delete the old texinfo machinery and update the
   markup docs in docs/devel/qapi-code-gen.txt

There are a few things I have left out of this initial series:
 * unlike the texinfo, there is no generation of index entries
   or an index in the HTML docs
 * although there are HTML anchors on all the command/object/etc
   headings, they are not stable but just serial-number based
   tags like '#qapidoc-35', so not suitable for trying to link
   to from other parts of the docs

My view is that we can add niceties like this later; the series
already seems big enough to me.

You can find the HTML rendered version of the results
of this series at:
http://people.linaro.org/~peter.maydell/qdoc-snapshot/interop/qemu-ga-ref.html
http://people.linaro.org/~peter.maydell/qdoc-snapshot/interop/qemu-qmp-ref.html
(look also at
 http://people.linaro.org/~peter.maydell/qdoc-snapshot/interop/index.html
 if you want to see how the ToC for the interop manual comes out)
The manpages are
http://people.linaro.org/~peter.maydell/qemu-ga-ref.7
http://people.linaro.org/~peter.maydell/qemu-qmp-ref.7
(download and render with 'man -l path/to/foo.7')

For comparison, the old texinfo-to-HTML versions of the docs are:
https://www.qemu.org/docs/master/qemu-ga-ref.html
https://www.qemu.org/docs/master/qemu-qmp-ref.html

The first four patches have already been posted separately and
reviewed.

I did at some point while working on this eyeball all the generated
documentation against the old versions, but there's an awful lot of
it, so I might have missed some minor stuff, and I didn't try to redo
that full-eyeball-diff with the absolute final version of the code. So
it's possible there are some minor misrenderings lurking, but I don't
think so.

thanks
-- PMM

Peter Maydell (29):
  configure: Allow user to specify sphinx-build binary
  configure: Check that sphinx-build is using Python 3
  Makefile: Fix typo in dependency list for interop manpages
  qga/qapi-schema.json: Fix missing '-' in GuestDiskBusType doc comment
  qga/qapi-schema.json: Fix indent level on doc comments
  qga/qapi-schema.json: minor format fixups for rST
  qapi/block-core.json: Use literal block for ascii art
  qapi: Use ':' after @argument in doc comments
  qapi: Fix indent level on doc comments in json files
  qapi: Remove hardcoded tabs
  qapi/ui.json: Put input-send-event body text in the right place
  qapi: Explicitly put "foo: dropped in n.n" notes into Notes section
  qapi/ui.json: Avoid `...' texinfo style quoting
  qapi/block-core.json: Use explicit bulleted lists
  qapi/ui.json: Use explicit bulleted lists
  qapi/{block,misc,tmp}.json: Use explicit bulleted lists
  qapi: Add blank lines before bulleted lists
  qapi/migration.json: Replace _this_ with *this*
  qapi/qapi-schema.json: Put headers in their own doc-comment blocks
  qapi/machine.json: Escape a literal '*' in doc comment
  scripts/qapi: Move doc-comment whitespace stripping to doc.py
  scripts/qapi/parser.py: improve doc comment indent handling
  docs/sphinx: Add new qapi-doc Sphinx extension
  docs/interop: Convert qemu-ga-ref to rST
  docs/interop: Convert qemu-qmp-ref to rST
  qapi: Use rST markup for literal blocks
  qga/qapi-schema.json: Add some headings
  scripts/qapi: Remove texinfo generation support
  docs/devel/qapi-code-gen.txt: Update to new rST backend conventions

 docs/devel/qapi-code-gen.txt   |   90 ++-
 configure                      |   22 +-
 Makefile                       |   58 +-
 tests/Makefile.include         |   15 +-
 qapi/block-core.json           | 1127 ++++++++++++++++----------------
 qapi/block.json                |   47 +-
 qapi/char.json                 |   10 +-
 qapi/dump.json                 |    4 +-
 qapi/introspect.json           |   12 +-
 qapi/job.json                  |   32 +-
 qapi/machine-target.json       |   18 +-
 qapi/machine.json              |   16 +-
 qapi/migration.json            |  206 +++---
 qapi/misc-target.json          |    8 +-
 qapi/misc.json                 |  138 ++--
 qapi/net.json                  |   26 +-
 qapi/qapi-schema.json          |   18 +-
 qapi/qdev.json                 |   10 +-
 qapi/qom.json                  |    4 +-
 qapi/rocker.json               |   12 +-
 qapi/run-state.json            |   34 +-
 qapi/sockets.json              |    8 +-
 qapi/tpm.json                  |    4 +-
 qapi/trace.json                |   15 +-
 qapi/transaction.json          |    4 +-
 qapi/ui.json                   |  119 ++--
 qga/qapi-schema.json           |  160 ++---
 MAINTAINERS                    |    3 +-
 docs/conf.py                   |   16 +-
 docs/index.html.in             |    2 -
 docs/interop/conf.py           |    4 +
 docs/interop/index.rst         |    2 +
 docs/interop/qemu-ga-ref.rst   |    4 +
 docs/interop/qemu-ga-ref.texi  |   80 ---
 docs/interop/qemu-qmp-ref.rst  |    4 +
 docs/interop/qemu-qmp-ref.texi |   80 ---
 docs/sphinx/qapidoc.py         |  504 ++++++++++++++
 scripts/qapi-gen.py            |    2 -
 scripts/qapi/doc.py            |  302 ---------
 scripts/qapi/gen.py            |    7 -
 scripts/qapi/parser.py         |   94 ++-
 41 files changed, 1726 insertions(+), 1595 deletions(-)
 create mode 100644 docs/interop/qemu-ga-ref.rst
 delete mode 100644 docs/interop/qemu-ga-ref.texi
 create mode 100644 docs/interop/qemu-qmp-ref.rst
 delete mode 100644 docs/interop/qemu-qmp-ref.texi
 create mode 100644 docs/sphinx/qapidoc.py
 delete mode 100644 scripts/qapi/doc.py

-- 
2.20.1


