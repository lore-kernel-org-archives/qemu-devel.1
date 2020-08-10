Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC4DC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B0122BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tadt3Psi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B0122BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5DpQ-0001jb-Bx
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DoT-0008Rl-5e
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:29 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:33968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DoO-0004iS-FL
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:28 -0400
Received: by mail-wm1-x329.google.com with SMTP id c19so656749wmd.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xcEo0fp6CBFh276nl/6kLab5MtELflMN3HnoC47o0W0=;
 b=tadt3Psip72YGJ8bh9EqUMKNY5GeF7bFH4yvOV4LMdu4PCPCHsIEwRUHpj7IZeLVRW
 91lkkzrHBXJdr1m2F+deCddJYqpKrESZKwRCM5aftwPzi6U/iGlhOwiqjRANmVMd3SOZ
 OwSBhLwdhqSLOzvjLg5HpuAUy3B5QgI2/iX7g+LVuNfBiGC0zA0x5aLAjGzZz7jR5/SI
 S2LQBkvwpEpTkO7Y9DOp5O6OvK2YtQ6/P5K5OADUtKx8gLKTjyDTvOkuotpf5aCcq2Jc
 uAxN0vSrD17tSqZ3wuXrbFMHhSUugDpptBGUrepW8qbApGh++4v/PFmGBAM6a+XfeaUJ
 4zUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xcEo0fp6CBFh276nl/6kLab5MtELflMN3HnoC47o0W0=;
 b=RfTZIr/rVxWrL65x83GFtYA7gt6lqXVWHInLprcmMg+xXTAZVWsLYyicsO2Diryn/4
 1+mOe3/E/zAc2PGdzIakoI2ehKka5myYlXuJ7RzB1KL7RvTSpe2uTcDOQHWjOJ7oMn2o
 rjwlx4WOCKbg6EKQArveUJ+vMG2dUEbIDHwWPtIENyXs442KEsu5LayQt4sW5n7Xu+i/
 aT2oARDU/SIGPf/dFHrb6Jqoh8jOhP5/TKGej+rjSG1c1J6+P2jtukb3DQNXnEEF/a+n
 5CBNDKy55JL5dZrnoNDb5AwbZgJIKCWC5ke1epXI5J0IijmE7ZjMw4YL1tx1i46c64+D
 SIbA==
X-Gm-Message-State: AOAM530E9c7mdG70BYwF0J5Z75Db+tHUDWi1U59aJ7V05ElZj8UF3a78
 jjexJVxI/y2ZcNDIrhP0cz0/VuueO01E+A==
X-Google-Smtp-Source: ABdhPJzuvqK1Iz8wDe7hdY8Oh5tPkySqWyrPNAwMHUfVr5wEO8CsjaonPK3qRyPg5ODpvJxbFExJ7A==
X-Received: by 2002:a1c:bdd7:: with SMTP id n206mr500807wmf.1.1597089022072;
 Mon, 10 Aug 2020 12:50:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b129sm976087wmb.29.2020.08.10.12.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 12:50:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/20] Convert QAPI doc comments to generate rST instead of
 texinfo
Date: Mon, 10 Aug 2020 20:49:59 +0100
Message-Id: <20200810195019.25427-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series switches all our QAPI doc comments over from
texinfo format to rST. It then removes all the texinfo
machinery, because this was the last user of texinfo.

This is largely just a rebase of patchset v4 to current master.
I've had to add three new patches at the front which fix
up newly added QAPI doc comment deviations from the
tightened-up indent rules that the rST conversion requires.
In a couple of places where Markus had already reviewed
patches with a 'reviewed-by with these minor commit message
fixes' I've made the fixes and added his r-by tag.

I've sent this out to the mailing list since I've done the
rebase-work anyway and it seems more useful to review this
than v4. I haven't bothered to re-generate the "here's what
the rendered HTML looks like" since v4, though I can do that
if useful.

Also available as a git branch at
https://git.linaro.org/people/peter.maydell/qemu-arm.git sphinx-conversions-v5

thanks
-- PMM


Below is the same old text from the v3 cover letter, just
for convenience:

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

On headings:

Because the rST generator works by assembling a tree of docutils
nodes, it needs to know the structure of the document, in the
sense that it wants to know that there is a "section with a level
1 heading titled Foo", which contains "section with a level 2
heading titled Bar", which in turn contains the documentation for
commands Baz, Boz, Buz. This means we can't follow the texinfo
generator's approach of just treating '= Foo' as another kind
of markup to be turned into a '@section' texinfo and otherwise
just written out into the output stream. Instead we need to
be able to distinguish "this is a level 1 section heading"
from any other kind of doc-comment, and the user shouldn't be
able to insert directives specifying changes in the document
structure randomly in the middle of what would otherwise be a
lump of "just rST source to be fed to a rST parser".
The approach I've taken to letting the generator know the structure
is to special-case headings into "must be in their own freeform
doc-comment as a single line", like this:
 ##
 # = Foo
 ##
This is easy to spot in the 'freeform' method, and matches how
we already mark up headings in almost all cases. An alternative
approach would be to have parser.py detect heading markup, so
that instead of
        for doc in schema.docs:
            if doc.symbol:
                vis.symbol(doc, schema.lookup_entity(doc.symbol))
            else:
                vis.freeform(doc)
(ie "everything the parser gives you is either documenting
a symbol, or it is a freefrom comment") we have:
        for doc in schema.docs:
            if doc.symbol:
                vis.symbol(doc, schema.lookup_entity(doc.symbol))
            else if doc.is_section_header:
                vis.new_section(doc.heading_text, doc.heading_level)
            else:
                vis.freeform(doc)
(ie "everything the parser gives you is either documenting
a symbol, or a notification about the structure of the document,
or a freeform comment".) I feel that would be less simple than
we currently have, though.

There are a few things I have left out of this initial series:
 * unlike the texinfo, there is no generation of index entries
   or an index in the HTML docs
 * although there are HTML anchors on all the command/object/etc
   headings, they are not stable but just serial-number based
   tags like '#qapidoc-35', so not suitable for trying to link
   to from other parts of the docs
 * unlike the old texinfo generation, we make no attempt to regression
   test the rST generation in 'make check'. This is trickier than
   the texinfo equivalent, because we never generate rST source
   that we could compare against a golden reference. Comparing
   against generated HTML is liable to break with new Sphinx
   versions; trying to compare the data structure of docutils nodes
   would be a bit more robust but would require a bunch of code to
   mock up running Sphinx somehow.

My view is that we can add niceties like this later; the series
already seems big enough to me.




Peter Maydell (20):
  qapi/migration.json: Fix indentation
  qapi: Fix indentation, again
  qapi/block-core.json: Fix nbd-server-start docs
  qapi/qapi-schema.json: Put headers in their own doc-comment blocks
  qapi/machine.json: Escape a literal '*' in doc comment
  tests/qapi/doc-good.json: Prepare for qapi-doc Sphinx extension
  scripts/qapi: Move doc-comment whitespace stripping to doc.py
  scripts/qapi/parser.py: improve doc comment indent handling
  docs/sphinx: Add new qapi-doc Sphinx extension
  docs/interop: Convert qemu-ga-ref to rST
  docs/interop: Convert qemu-qmp-ref to rST
  qapi: Use rST markup for literal blocks
  qga/qapi-schema.json: Add some headings
  scripts/qapi: Remove texinfo generation support
  docs/devel/qapi-code-gen.txt: Update to new rST backend conventions
  Makefile: Remove redundant Texinfo related rules
  scripts/texi2pod: Delete unused script
  Remove Texinfo related files from .gitignore and git.orderfile
  configure: Drop texinfo requirement
  Remove texinfo dependency from docker and CI configs

 docs/conf.py                               |   6 +-
 docs/devel/qapi-code-gen.txt               |  90 ++--
 docs/index.html.in                         |   2 -
 docs/interop/conf.py                       |   4 +
 docs/interop/index.rst                     |   2 +
 docs/interop/qemu-ga-ref.rst               |   4 +
 docs/interop/qemu-ga-ref.texi              |  80 ---
 docs/interop/qemu-qmp-ref.rst              |   4 +
 docs/interop/qemu-qmp-ref.texi             |  80 ---
 docs/sphinx/qapidoc.py                     | 504 +++++++++++++++++++
 configure                                  |  12 +-
 Makefile                                   |  86 +---
 rules.mak                                  |  14 +-
 qapi/audio.json                            |  12 +-
 qapi/block-core.json                       |  30 +-
 qapi/control.json                          |   4 +-
 qapi/machine.json                          |   8 +-
 qapi/migration.json                        |  68 +--
 qapi/misc.json                             |   4 +-
 qapi/net.json                              |   2 +-
 qapi/qapi-schema.json                      |  18 +-
 qga/qapi-schema.json                       |  12 +-
 .gitignore                                 |  15 -
 .travis.yml                                |   1 -
 MAINTAINERS                                |   3 +-
 scripts/checkpatch.pl                      |   2 +-
 scripts/git.orderfile                      |   1 -
 scripts/qapi-gen.py                        |   2 -
 scripts/qapi/doc.py                        | 301 ------------
 scripts/qapi/gen.py                        |   7 -
 scripts/qapi/parser.py                     |  93 +++-
 scripts/texi2pod.pl                        | 536 ---------------------
 tests/Makefile.include                     |  15 +-
 tests/docker/dockerfiles/debian10.docker   |   1 -
 tests/docker/dockerfiles/debian9.docker    |   1 +
 tests/docker/dockerfiles/fedora.docker     |   1 -
 tests/docker/dockerfiles/ubuntu.docker     |   1 -
 tests/docker/dockerfiles/ubuntu1804.docker |   1 -
 tests/docker/dockerfiles/ubuntu2004.docker |   1 -
 tests/qapi-schema/doc-good.json            |  25 +-
 tests/qapi-schema/doc-good.out             |  22 +-
 tests/qapi-schema/doc-good.texi            | 319 ------------
 42 files changed, 784 insertions(+), 1610 deletions(-)
 create mode 100644 docs/interop/qemu-ga-ref.rst
 delete mode 100644 docs/interop/qemu-ga-ref.texi
 create mode 100644 docs/interop/qemu-qmp-ref.rst
 delete mode 100644 docs/interop/qemu-qmp-ref.texi
 create mode 100644 docs/sphinx/qapidoc.py
 delete mode 100644 scripts/qapi/doc.py
 delete mode 100755 scripts/texi2pod.pl
 delete mode 100644 tests/qapi-schema/doc-good.texi

-- 
2.20.1


