Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF33C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C21D5206E5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8tx+cBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21D5206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqYo-00025W-OX
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVH-0006Ma-1e
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:23 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:34991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVE-0006mg-OY
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:22 -0400
Received: by mail-wr1-x433.google.com with SMTP id e16so4264603wrm.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4JuJAQOcGSboTseFsN4yJ5Z5E73lpeQKf+mInJ0wY+U=;
 b=l8tx+cBgIoRqOMAgwPM1K8Jz6ruWCf9YRXJSV2f8bWIcZtYr4lbon8nh52mvlKzHlC
 Cd4E+NYHXKoepPXFlEM5i6XIg4KXpZzpKNA5OdenI0zXGBUuoIkY6b6xZOhXkcu/PyoB
 9HL7U85MJgXZILjgtZ0ZJWQMtW88AFE1DNgDwdPv5l4qyDAFNqSqS2c/37+BfUPr5KL3
 S7Rnr3Dp1vOtCR+Pcs10a5EqLfeQq/pveCBDmLKXr5514d9qUDB9OcUXBTjYj+9BGY3l
 gpLL3SWc1uleaKeIZCr/hGhq210LDcHQdKJZ4og/VaUgGBqzLErTEGyQ/S7oWfo3JpvS
 oJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4JuJAQOcGSboTseFsN4yJ5Z5E73lpeQKf+mInJ0wY+U=;
 b=aRNQ7vH5Vm2cI/aByDvGGrTGLa6zxy0GK3TveVZYwpmY7nba6cUDWAzQdpm/zPBxMk
 RmK195XSkyccpbZYcyGwygY6IT2RjU8KiCU8D9b4qMUF1vS10/U8h+t0tU9tfqJIkfaI
 4Prtc1JC8bUyHtEbFbfAdZgt1976Qovado/eBf5VYVEDR3kimiEMpzvtKKceCQKaeqQq
 tcPsaFU/ewUg2uczMzw1qx9im6RdXKWp2eGuiQzTUYD37i7kh3S7Tahg5EfHq0z222WW
 ffm6WEQ/YcGVQLUz33RgJB7OEi5YqJJfCmT5rY9PyRwj8i6qFwK7PYEbyOTjQvuf4sAH
 E7Ag==
X-Gm-Message-State: AOAM532TZBRKW34UrQxxX4uRp8eSr7QvgzInm/uiBvr1VbfmYHF+0ScZ
 Gs71hotc2n0bXanokznKGX19+duxlfaMK6+G
X-Google-Smtp-Source: ABdhPJzTO+BzIeDV1sVfbSGKGm3SJ/WZ31VyKu6JxlQsaQd0lEfnpNDrP1OPdBekrf1lZA9AQ+fLAQ==
X-Received: by 2002:adf:f852:: with SMTP id d18mr5325258wrq.245.1601050998020; 
 Fri, 25 Sep 2020 09:23:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d6sm3565824wrq.67.2020.09.25.09.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 09:23:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/21] Convert QAPI doc comments to generate rST instead of
 texinfo
Date: Fri, 25 Sep 2020 17:22:55 +0100
Message-Id: <20200925162316.21205-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series switches all our QAPI doc comments over from texinfo
format to rST.  It then removes all the texinfo machinery, because
this was the last user of texinfo.

I think I have now resolved all of Markus' issues raised in his
review of v5, and IMHO this is ready to commit.  If there are still
things needing fixing, it would be nice if we were able to commit
patches 1-5, which are the ones which add the new indent-sensitive
code to the QAPI parser.  That would put a stop to the steady trickle
of doc-comment changes which break the new rules...

Also available as a git branch at
https://git.linaro.org/people/peter.maydell/qemu-arm.git sphinx-conversions-v6

The basic approach is somewhat similar to how we deal with kerneldoc
and hxtool: we have a custom Sphinx extension which is passed a
filename which is the json file it should run the QAPI parser over and
generate documentation for. Unlike 'kerneldoc' but somewhat like
hxtool, I have chosen to generate documentation by generating a tree
of docutils nodes, rather than by generating rST source that is then
fed to the rST parser to generate docutils nodes.  Individual lumps of
doc comment go to the rST parser, but the structured parts we render
directly. This makes it easier to get the structure and heading level
nesting correct.

Changes from v5:
 * rebased (in particular, updated to meson build system)
 * new patch 1 fixes indent issues that hit master since v5
 * new patch 2 makes block-latency-histogram-set's use of Example
   sections match everybody else's, instead of special casing it
   in the parser
 * the .gitignore got pruned after meson conversion so we only
   need to change git.orderfile now
 * slightly reordered patches to bring the parser.py indent change nearer
   the start of the series in the hopes of being able to get at least
   that much of the series into master
 * we now tell Sphinx about all the json files for dependency info,
   so editing a json file correctly rebuilds the docs
 * added a test case for the bad-de-indent parser error
 * Adopted the various Python scripting suggestions from Markus
 * We don't insist on section headings being the only thing in their
   doc comment block any more (the existing "must be first line"
   requirement is sufficient)
 * added a test case for doc-generation that does a compare of
   the sphinx plain-text builder output against a reference file
 * Added the Python source files for Sphinx extensions (including
   the QAPI source files) to the dependency lists for the manuals,
   so that changes made to them correctly trigger a docs rebuild
 * qemu-ga-ref.rst and qemu-qmp-ref.rst now have a TODO note about
   making the manual licensing more visible to readers
 * fixed bug in reported file/line info for some errors in rST
   in doc comments when using Sphinx 1.6
 * don't insist on section headers being in their own freeform doc
   comment block; they're (after commit dcdc07a97cbe) always the
   first line in the comment block, so just handle the possibility
   of having text after that.

There are a few things I have left out of this initial series:

 * unlike the texinfo, there is no generation of index entries
   or an index in the HTML docs
 * although there are HTML anchors on all the command/object/etc
   headings, they are not stable but just serial-number based
   tags like '#qapidoc-35', so not suitable for trying to link
   to from other parts of the docs

My view is that we can add niceties like this later; the series
already seems big enough to me.

thanks
-- PMM


Peter Maydell (21):
  qapi: Fix doc comment indentation again
  qapi/block.json: Add newline after "Example:" for
    block-latency-histogram-set
  tests/qapi/doc-good.json: Prepare for qapi-doc Sphinx extension
  scripts/qapi: Move doc-comment whitespace stripping to doc.py
  scripts/qapi/parser.py: improve doc comment indent handling
  qapi/machine.json: Escape a literal '*' in doc comment
  docs/sphinx: Add new qapi-doc Sphinx extension
  docs/interop: Convert qemu-ga-ref to rST
  docs/interop: Convert qemu-qmp-ref to rST
  qapi: Use rST markup for literal blocks
  qga/qapi-schema.json: Add some headings
  tests/qapi-schema: Convert doc-good.json to rST-style strong/emphasis
  meson.build: Move SPHINX_ARGS to top level meson.build file
  meson.build: Make manuals depend on source to Sphinx extensions
  tests/qapi-schema: Add test of the rST QAPI doc-comment outputn
  scripts/qapi: Remove texinfo generation support
  docs/devel/qapi-code-gen.txt: Update to new rST backend conventions
  scripts/texi2pod: Delete unused script
  Remove Texinfo related line from git.orderfile
  configure: Drop texinfo requirement
  Remove texinfo dependency from docker and CI configs

 docs/conf.py                               |   6 +-
 docs/devel/qapi-code-gen.txt               | 106 ++--
 docs/index.html.in                         |   2 -
 docs/interop/conf.py                       |   4 +
 docs/interop/index.rst                     |   2 +
 docs/interop/qemu-ga-ref.rst               |   9 +
 docs/interop/qemu-ga-ref.texi              |  80 ---
 docs/interop/qemu-qmp-ref.rst              |   9 +
 docs/interop/qemu-qmp-ref.texi             |  80 ---
 docs/meson.build                           |  11 +-
 docs/sphinx/qapidoc.py                     | 550 +++++++++++++++++++++
 tests/qapi-schema/doc-good.rst             |   5 +
 configure                                  |  12 +-
 meson.build                                | 103 +---
 qapi/block-core.json                       |  20 +-
 qapi/block.json                            |  12 +-
 qapi/machine.json                          |   2 +-
 qapi/migration.json                        | 102 ++--
 qapi/qapi-schema.json                      |   6 +-
 qga/qapi-schema.json                       |   8 +-
 .travis.yml                                |   1 -
 MAINTAINERS                                |   3 +-
 qapi/meson.build                           |   4 +-
 qga/meson.build                            |   3 +-
 scripts/checkpatch.pl                      |   2 +-
 scripts/coverity-scan/coverity-scan.docker |   1 -
 scripts/git.orderfile                      |   1 -
 scripts/qapi-gen.py                        |   2 -
 scripts/qapi/doc.py                        | 301 -----------
 scripts/qapi/gen.py                        |   7 -
 scripts/qapi/parser.py                     | 105 +++-
 scripts/texi2pod.pl                        | 536 --------------------
 tests/docker/dockerfiles/debian10.docker   |   1 -
 tests/docker/dockerfiles/fedora.docker     |   1 -
 tests/docker/dockerfiles/ubuntu.docker     |   1 -
 tests/docker/dockerfiles/ubuntu1804.docker |   1 -
 tests/docker/dockerfiles/ubuntu2004.docker |   1 -
 tests/qapi-schema/doc-bad-indent.err       |   1 +
 tests/qapi-schema/doc-bad-indent.json      |   8 +
 tests/qapi-schema/doc-bad-indent.out       |   0
 tests/qapi-schema/doc-good.json            |  27 +-
 tests/qapi-schema/doc-good.out             |  24 +-
 tests/qapi-schema/doc-good.texi            | 319 ------------
 tests/qapi-schema/doc-good.txt             | 288 +++++++++++
 tests/qapi-schema/meson.build              |  63 ++-
 45 files changed, 1223 insertions(+), 1607 deletions(-)
 create mode 100644 docs/interop/qemu-ga-ref.rst
 delete mode 100644 docs/interop/qemu-ga-ref.texi
 create mode 100644 docs/interop/qemu-qmp-ref.rst
 delete mode 100644 docs/interop/qemu-qmp-ref.texi
 create mode 100644 docs/sphinx/qapidoc.py
 create mode 100644 tests/qapi-schema/doc-good.rst
 delete mode 100644 scripts/qapi/doc.py
 delete mode 100755 scripts/texi2pod.pl
 create mode 100644 tests/qapi-schema/doc-bad-indent.err
 create mode 100644 tests/qapi-schema/doc-bad-indent.json
 create mode 100644 tests/qapi-schema/doc-bad-indent.out
 delete mode 100644 tests/qapi-schema/doc-good.texi
 create mode 100644 tests/qapi-schema/doc-good.txt

-- 
2.20.1


