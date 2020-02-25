Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5832CC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140E321744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qP3Vrqyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140E321744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ax0-0004a1-8K
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 09:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6apM-0006dZ-Cg
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:04:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6apH-0005GI-Hk
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:04:48 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42750)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6apH-0005Fz-92
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:04:43 -0500
Received: by mail-wr1-x42c.google.com with SMTP id p18so11225751wre.9
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 06:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JFCUlRkNLcX1r81oXgYLDKM7sZ68zBPXSSRyXGj0Y8k=;
 b=qP3VrqyksFCvc752B0Rn98wxrWXnrgHqfC+4+jYpNMWhYhC+VHgQbYgFfaO3Va/V79
 /pNvOIye99vxhZBa4W6hPS+YEfFbBX2Hm12qE6jQ8o19VmNUkYgzoYpCg0mXmpgePpXi
 hnTJ6OAJ3GzbybdpB9WQQqUZhth/uGEVUaAi5YE6kcGEQSbleLSAA58jGXolQPeBi+vN
 SCYVWuzUah1Iqy1pmvkXsV6KfOEdpozfhK3MAIezp5dbzUPdm+9EZkS2AU5lAmORKhJk
 6H3jWA/ski33eHhneLafk7mmVUNOyM5kO9Nac96ImVesaDOdNyJcIF/ZvXA1poec2nGi
 tiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JFCUlRkNLcX1r81oXgYLDKM7sZ68zBPXSSRyXGj0Y8k=;
 b=b6AP5Uiy8jM0XGy6dAUxjXLzGbGvBMA7vT/+AO3rZpcG+FNpexcbLkcag9Tb+g2g+d
 0/zxAkkurGtIvwu8mJelz/F0GbE1US5H/PGWiUStRqubxTmhOebMyzYHSA7X1EFtVbVV
 IX73GxeVxn9OFz7Iz/KB/kVGYARrUQKoaHyhXj7QCjq/2QOLtGsmqL9Ct69a5qXndBrj
 /fzAELJPXc65/aII6HqFF5axr0vjDWZ46JXt64tPG+e3WzBBPGBKI+lmlfgTkvy2lLEk
 Px6Kdvz3GZkOH5Dki6iOU5tNfAFyNDzyfI/myHfjzAGahS1l1JfJvHwzo7oVwowelVAU
 w5/Q==
X-Gm-Message-State: APjAAAXoYbnfeEU5hmH6+qSBeROhhhleS8uO55+etV97xH7/nnSWssp5
 b7ZfDGahQ4xpW4GBCFMlY/mF18+TPKB8yQ==
X-Google-Smtp-Source: APXvYqxYwaFAjtcnSAsO2okZ5vF6w/puzdZm4MFwXUVIJLUo1S7wWg48LCFsbpvE32CWGc345jPEtQ==
X-Received: by 2002:adf:bbcf:: with SMTP id z15mr74356763wrg.266.1582639480941; 
 Tue, 25 Feb 2020 06:04:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f127sm4322136wma.4.2020.02.25.06.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 06:04:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/12] Convert QAPI doc comments to generate rST instead of
 texinfo
Date: Tue, 25 Feb 2020 14:04:25 +0000
Message-Id: <20200225140437.20609-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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

I've pushed out a v3 because a lot of v2 is now in master and
it seems like it might be easier (and less intimidating :-))
to review a patchset that's only got the remaining work and
which is based on current master.

Changes v2->v3:
 * all the "preliminary tidy up of existing doc comment" patches
   are now in master -- thanks!
 * rebased on current master (there were some minor conflicts with
   the just-committed creation of the tools manual)

We have 3 weeks left til softfreeze, so I'm still hopeful we
can land this in this release cycle, though I suppose it would
not be a disaster if it landed in the next. (I'm guessing we
will not complete conversion of the other bits of Texinfo to
rST this cycle, anyway.)

(All the text below is the same as the v2 cover letter, if
you've already read that.)


Changes v1->v2:
 * rebased (a few minor conflicts fixed)
 * I have fixed the failures to pass "make check"
 * minor tweaks to commit messages etc (noted in individual patches)
 * the old patch 12 ('qapi: Explicitly put "foo: dropped in n.n" notes
   into Notes section') has been deleted
 * patch 18 ('qapi: Delete all the "foo: dropped in n.n" notes')
 * I have not made the change to be more consistent about treating
   an apparent heading-comment with trailing lines of rST the same
   way as we would treat one with leading lines of rST, just because
   the whole area of how we handle headings is up in the air anyway.
   If we decide the approach here is basically right I'll make this
   change in a v3; otherwise it's likely to be moot anyway.
 * I have also not added a patch that rewraps long lines added
   by some of the earlier doc-comment adjustments; I figure we
   can come back and do that later.
 * I haven't (yet) written an extra patch that tries to guess
   what might be a good sphinx-build binary to use (none of my
   systems put it anywhere except 'sphinx-build')

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

Git branch of this series also available at
https://git.linaro.org/people/peter.maydell/qemu-arm.git sphinx-conversions

thanks
-- PMM


Peter Maydell (12):
  qapi/qapi-schema.json: Put headers in their own doc-comment blocks
  qapi/machine.json: Escape a literal '*' in doc comment
  tests/qapi/doc-good.json: Clean up markup
  scripts/qapi: Move doc-comment whitespace stripping to doc.py
  scripts/qapi/parser.py: improve doc comment indent handling
  docs/sphinx: Add new qapi-doc Sphinx extension
  docs/interop: Convert qemu-ga-ref to rST
  docs/interop: Convert qemu-qmp-ref to rST
  qapi: Use rST markup for literal blocks
  qga/qapi-schema.json: Add some headings
  scripts/qapi: Remove texinfo generation support
  docs/devel/qapi-code-gen.txt: Update to new rST backend conventions

 docs/devel/qapi-code-gen.txt    |  90 ++++--
 Makefile                        |  55 +---
 tests/Makefile.include          |  15 +-
 qapi/block-core.json            |  16 +-
 qapi/machine.json               |   2 +-
 qapi/qapi-schema.json           |  18 +-
 qga/qapi-schema.json            |  12 +-
 tests/qapi-schema/doc-good.json |  25 +-
 MAINTAINERS                     |   3 +-
 docs/conf.py                    |   6 +-
 docs/index.html.in              |   2 -
 docs/interop/conf.py            |   4 +
 docs/interop/index.rst          |   2 +
 docs/interop/qemu-ga-ref.rst    |   4 +
 docs/interop/qemu-ga-ref.texi   |  80 -----
 docs/interop/qemu-qmp-ref.rst   |   4 +
 docs/interop/qemu-qmp-ref.texi  |  80 -----
 docs/sphinx/qapidoc.py          | 504 ++++++++++++++++++++++++++++++++
 scripts/qapi-gen.py             |   2 -
 scripts/qapi/doc.py             | 301 -------------------
 scripts/qapi/gen.py             |   7 -
 scripts/qapi/parser.py          |  94 ++++--
 tests/qapi-schema/doc-good.out  |  22 +-
 tests/qapi-schema/doc-good.texi | 287 ------------------
 24 files changed, 726 insertions(+), 909 deletions(-)
 create mode 100644 docs/interop/qemu-ga-ref.rst
 delete mode 100644 docs/interop/qemu-ga-ref.texi
 create mode 100644 docs/interop/qemu-qmp-ref.rst
 delete mode 100644 docs/interop/qemu-qmp-ref.texi
 create mode 100644 docs/sphinx/qapidoc.py
 delete mode 100644 scripts/qapi/doc.py
 delete mode 100644 tests/qapi-schema/doc-good.texi

-- 
2.20.1


