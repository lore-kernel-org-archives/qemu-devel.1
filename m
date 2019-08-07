Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FC3C41514
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50CA721E71
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8S+nmc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CA721E71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvN2w-0004eb-ES
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41736)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hvN2H-0003Wk-7B
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hvN2G-0006af-37
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:35:29 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hvN2F-0006ZO-TJ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:35:28 -0400
Received: by mail-wr1-x443.google.com with SMTP id 31so91672246wrm.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g3k/h6Z/qWjEAJpRG1w1mf95HfntbrdREbdJcqPGBPA=;
 b=Y8S+nmc7WZMfWckeQMsc94TAUpMNuwtvLDxPRGoy0p/PYWykDzx4M5zNXcqdAo234d
 ++PUrwUP72YzUHc2ej19Cu0nAVD5tJabqhZNqIdKjAjzgA8Pp5/9Q5a4Z0YSI7Vmqo5x
 ALzeM2td15eXEUg9Xm3jsquS0g0ffPDDna8fBrZ//d3mGgNslurIqABLUIIu8V+1wnZ7
 FMrXxoL/l5bO38TdfmnhSVK1ND4XyUyOWZoHEvYpE6Aq+3JXts3as1jTKjvFj2oTKFMO
 2R1UjoD74o0Bvmhz0J/Cooiq03qAPWr8cTy+r3wNwBC/hzZ4wC86QEmFFRFxFSXwBcjP
 DRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=g3k/h6Z/qWjEAJpRG1w1mf95HfntbrdREbdJcqPGBPA=;
 b=SrkPn3P8/3559A4iWfl/ha1kqjXXmvyFqtpsJuhZ7UffT3ns75uTMfZFEwwu/ndCyb
 04wg2HAOb1312YRZy/Yy64JLeg5K2e6XZzMhrw0dsJLJPPTqb27SuDoHAh6/R/usCnkS
 9COze8lYYK00z53eRT6fKJNmbr54Ao0aYFIrT6w88lXp+WKba/4qP2RRs7cvNHlHoUrS
 N/QhIZf2m05ci1EljvgdepSbynxBSzxFQsQ3e8lYWjHbIodSKxUCg8zbhpd9FAbkeY/A
 D6DsvDdVXlMxYHQmIWrmG/LlRQCfD624zBsBDbeEBvzMMnQ8ozFKZe2YU4RBKZR5O++W
 LXWw==
X-Gm-Message-State: APjAAAUeZuco/Be+ZKDdZBpohVXbf9G+XnB1AKh00oeUVvLM3CHti2is
 Gm1jdMJ6qSqbYewI2IY9UxpBJGhb
X-Google-Smtp-Source: APXvYqydzo885uMbZM1OPKLKBl4Gmc+NkQo4iVgcyJ5CfI7eB6CTCsvUF/p27jwSAHcREJnggwBgxA==
X-Received: by 2002:adf:e841:: with SMTP id d1mr11469443wrn.204.1565188525550; 
 Wed, 07 Aug 2019 07:35:25 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:dc26:ed70:9e4c:3810])
 by smtp.gmail.com with ESMTPSA id o4sm86004wmh.35.2019.08.07.07.35.23
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 07:35:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  7 Aug 2019 16:35:20 +0200
Message-Id: <20190807143523.15917-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v2 0/3] tests/tcg: disentangle makefiles
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The tests/tcg rely a lot on per-target informations from
the QEMU makefiles, but most of the definitions in there
aren't really relevant to TCG tests.

This series is just a cleanup, but it could also be
a useful start in making it possible to compile tests/tcg
out of QEMU's tree, and/or making it a submodule, and/or
unifying the system emulation tests with kvm-unit-tests.

Paolo

v1->v2: fix configure from fresh directory, do not use $SHELL

Paolo Bonzini (3):
  tests/tcg: use EXTRA_CFLAGS everywhere
  tests/tcg: cleanup Makefile inclusions
  tests/tcg: move configuration to a sub-shell script

 Makefile                                  |   1 +
 Makefile.target                           |   3 -
 configure                                 | 155 ++-------------
 tests/Makefile.include                    |  25 +--
 tests/tcg/Makefile.include                |  88 ---------
 tests/tcg/Makefile.prereqs                |  18 ++
 tests/tcg/Makefile.probe                  |  31 ---
 tests/tcg/Makefile.qemu                   |  95 +++++++++
 tests/tcg/{Makefile => Makefile.target}   |  15 +-
 tests/tcg/aarch64/Makefile.include        |   8 -
 tests/tcg/aarch64/Makefile.softmmu-target |   4 +-
 tests/tcg/aarch64/Makefile.target         |  12 +-
 tests/tcg/alpha/Makefile.include          |   2 -
 tests/tcg/alpha/Makefile.softmmu-target   |   4 +-
 tests/tcg/arm/Makefile.include            |   8 -
 tests/tcg/arm/Makefile.softmmu-target     |   6 +-
 tests/tcg/configure.sh                    | 228 ++++++++++++++++++++++
 tests/tcg/cris/Makefile.include           |   6 -
 tests/tcg/hppa/Makefile.include           |   2 -
 tests/tcg/i386/Makefile.include           |   9 -
 tests/tcg/i386/Makefile.softmmu-target    |  12 +-
 tests/tcg/i386/Makefile.target            |  13 +-
 tests/tcg/m68k/Makefile.include           |   2 -
 tests/tcg/minilib/Makefile.target         |   2 +-
 tests/tcg/mips/Makefile.include           |  20 --
 tests/tcg/ppc/Makefile.include            |  10 -
 tests/tcg/riscv/Makefile.include          |  10 -
 tests/tcg/s390x/Makefile.include          |   2 -
 tests/tcg/sh4/Makefile.include            |   4 -
 tests/tcg/sparc64/Makefile.include        |   2 -
 tests/tcg/x86_64/Makefile.softmmu-target  |  36 ++++
 tests/tcg/x86_64/Makefile.target          |   7 +-
 tests/tcg/xtensa/Makefile.include         |  11 --
 tests/tcg/xtensa/Makefile.softmmu-target  |   4 +-
 34 files changed, 435 insertions(+), 420 deletions(-)
 delete mode 100644 tests/tcg/Makefile.include
 create mode 100644 tests/tcg/Makefile.prereqs
 delete mode 100644 tests/tcg/Makefile.probe
 create mode 100644 tests/tcg/Makefile.qemu
 rename tests/tcg/{Makefile => Makefile.target} (90%)
 delete mode 100644 tests/tcg/aarch64/Makefile.include
 delete mode 100644 tests/tcg/alpha/Makefile.include
 delete mode 100644 tests/tcg/arm/Makefile.include
 create mode 100644 tests/tcg/configure.sh
 delete mode 100644 tests/tcg/cris/Makefile.include
 delete mode 100644 tests/tcg/hppa/Makefile.include
 delete mode 100644 tests/tcg/i386/Makefile.include
 delete mode 100644 tests/tcg/m68k/Makefile.include
 delete mode 100644 tests/tcg/mips/Makefile.include
 delete mode 100644 tests/tcg/ppc/Makefile.include
 delete mode 100644 tests/tcg/riscv/Makefile.include
 delete mode 100644 tests/tcg/s390x/Makefile.include
 delete mode 100644 tests/tcg/sh4/Makefile.include
 delete mode 100644 tests/tcg/sparc64/Makefile.include
 create mode 100644 tests/tcg/x86_64/Makefile.softmmu-target
 delete mode 100644 tests/tcg/xtensa/Makefile.include

-- 
2.21.0


