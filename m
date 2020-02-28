Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84E5C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66EE5246AF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KtizOywn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EE5246AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7hhj-0001yu-Fi
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 10:37:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hgg-0000Pz-AI
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hge-0004hE-7i
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:26 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:56009)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7hgd-0004go-W2
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:24 -0500
Received: by mail-wm1-x336.google.com with SMTP id q9so3600938wmj.5
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 07:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Hh9+7XjdRAGt6X/nwdKXZ5TRHi/e2pqZe2Jax1yP08g=;
 b=KtizOywnq5tYJSSEG3+Xbkmu/41ro/6EOXNld98fvBk1wjHLxtdiEPRb0NQwWMqG86
 9XdP2usil4JeQyMUmsUiMOo/U8p2t8l9Tb6Ou+WWdL7yCAPOUKIHTJ6EOjxoHGltAd6f
 x7jNB9TBF2N5TzBHl6nv+Zo4SsfgFxCgcQbPJUXvTChrujAfJlybWsUU9nfP/zMu+Yxd
 PA9J5yzzaAqjFWdymYyyz3AxT3ZjmOZcxQDntRl8NUKV6p9GP6fwdmJ5G1ottqqH7wRT
 k7EW2dpzhJqHMAsx/3ii6C5cEDrQGlEJ3bx2gUKGle/EGWfif1q3QFGRx1P8T69oiXsg
 QFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Hh9+7XjdRAGt6X/nwdKXZ5TRHi/e2pqZe2Jax1yP08g=;
 b=KHiNoaw6mzBiaSvjyUHDrnmY2/sa43foCEzUTR1s+orb+LBq0i/WLgOw4g/PE6TW+v
 ZJE1LBvgrijokaW1gxKiVziKtJiUZRjXCfDPiHuEalBHXkkRFLTvHxSOl4HXovJG9NcV
 ESQGHTA9EMfnm2XBEUI3/6Ta+rc+M0y0iwDjuwfcqknuwyydH2chhD5Q2wWf0DS7uVJG
 JJhUL6HfUj0wwg5ODcoeXl6PO1lSD9gBudu8gAcJyCN6kjDLxn1j97htQTnM6cXOYZh/
 bt7nly3pVuzD7ScczfFPgUkKnmabahAdQKlq2qlCUwEXlApBdiPwfyut1wdkzMwETNwE
 29qQ==
X-Gm-Message-State: APjAAAVqq/bF9pMDtY1i7tKIHJIxBmRB0kh0RIdx6FGNYcqusG6xhclz
 +usHFtq8DVBkJkjm42Cd+Edwkm+CO9tVkw==
X-Google-Smtp-Source: APXvYqz+yRAFmd3gou+nUtsTbxR7TelT6w1DDuLhQqmqNKDY3gbKqHzYKpmFACUAgIFBUFSPZT0B7w==
X-Received: by 2002:a05:600c:2503:: with SMTP id
 d3mr5284799wma.84.1582904182071; 
 Fri, 28 Feb 2020 07:36:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u23sm2659452wmu.14.2020.02.28.07.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 07:36:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/33] Convert qemu-doc to rST
Date: Fri, 28 Feb 2020 15:35:46 +0000
Message-Id: <20200228153619.9906-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi; this series does a complete conversion of qemu-doc from
Texinfo to rST, including the hxtool-generated parts and
creation of the qemu.1 manpage from rST.

It's marked v3 because it's a development of the v2 that
Paolo sent out earlier this week.

Changes from v2:
 * I made the various review-comment fixes I suggested in
   replies to Paolo's series
 * rebased on current master
 * new patches at the end of the series which do the conversion
   of the .hx file doc fragments to rST
   (I did part of this semi-by-hand and then qemu-options.hx
   entirely automatically)
 * new patches which generate the qemu.1 manpage with Sphinx
 * new patches which remove the old qemu-doc makefile runes
   and other references to it
 * new patches which delete the old texinfo sources, etc

The only thing left still using Texinfo after this is the
docs autogenerated from the QAPI doc-comments, which are
their own standalone html and manpages so not affected by this.

A couple of notes:
 * I haven't actually been in a position to test the cocoa.m
   update of the HTML filename
 * qemu.nsi (the Windows installer config file) thinks that
   qemu-doc.html is the only doc file it needs to know about,
   which is clearly wrong. However I don't have any idea about
   the Windows installer to be able to update or test it...

The conversion is a little rough around the edges in a few
place (mostly I have noted in commit messages when this is
the case) but I would like to argue for (assuming we're happy
with the series broadly) taking it into master and then refining
it in-place. Having it out-of-tree for long is an invitation
to conflicts and to accidentally losing docs updates if they
hit master as changes to the texi or hx files before this
series goes in.

You can find a prerendered set of docs at
https://people.linaro.org/~peter.maydell/qdoc-no-texi/
(the interesting part is the system emulation user's guide,
mostly), and a copy of the new manpage at
https://people.linaro.org/~peter.maydell/qemu.1
(download and examine with 'man -l path/to/qemu.1').

thanks
-- PMM

Kashyap Chamarthy (1):
  docs/system: Convert qemu-cpu-models.texi to rST

Paolo Bonzini (13):
  qemu-doc: convert user-mode emulation to a separate Sphinx manual
  qemu-doc: remove target OS documentation
  texi2pod: parse @include directives outside "@c man" blocks
  qemu-doc: split CPU models doc between MIPS and x86 parts
  qemu-doc: split qemu-doc.texi in multiple files
  qemu-doc: extract common system emulator documentation from the PC
    section
  qemu-doc: move system requirements chapter inside PC section
  qemu-doc: split target sections to separate files
  qemu-doc: move qemu-tech.texi into main section
  qemu-doc: move included files to docs/system
  qemu-doc: remove indices other than findex
  docs/system: put qemu-block-drivers body in an included file
  docs/system: convert Texinfo documentation to rST

Peter Maydell (19):
  qemu-doc: Remove the "CPU emulation" part of the "Implementation
    notes"
  docs: Create defs.rst.inc as a place to define substitutions
  docs/system: Convert security.texi to rST format
  docs/system: convert managed startup to rST.
  docs/system: convert the documentation of deprecated features to rST.
  hmp-commands.hx: Add rST documentation fragments
  hmp-commands-info.hx: Add rST documentation fragments
  doc/scripts/hxtool.py: Strip trailing ':' from DEFHEADING/ARCHHEADING
  docs: Roll semihosting option information into qemu-options.hx
  docs: Roll -prom-env and -g target-specific info into qemu-options.hx
  scripts/hxtool-conv: Archive script used in qemu-options.hx conversion
  qemu-options.hx: Add rST documentation fragments
  qemu-options.hx: Fix up the autogenerated rST
  docs: Split out sections for the manpage into .rst.inc files
  docs: Generate qemu.1 manpage with Sphinx
  ui/cocoa.m: Update documentation file and pathname
  docs: Stop building qemu-doc
  docs: Remove old texinfo sources
  *.hx: Remove all the STEXI/ETEXI blocks

 docs/specs/ivshmem-spec.txt                   |    4 +-
 Makefile                                      |   47 +-
 .gitignore                                    |    3 -
 MAINTAINERS                                   |    7 +-
 docs/conf.py                                  |    6 +
 docs/defs.rst.inc                             |   15 +
 docs/index.html.in                            |    2 +-
 docs/index.rst                                |    1 +
 docs/qemu-cpu-models.texi                     |  677 --
 docs/sphinx/hxtool.py                         |   10 +-
 docs/system/build-platforms.rst               |   79 +
 docs/system/conf.py                           |    8 +-
 docs/system/cpu-models-mips.rst.inc           |  105 +
 docs/system/cpu-models-x86.rst.inc            |  365 +
 docs/system/deprecated.rst                    |  446 +
 docs/system/device-url-syntax.rst.inc         |  228 +
 docs/system/gdb.rst                           |   81 +
 docs/system/images.rst                        |   85 +
 docs/system/index.rst                         |   22 +-
 docs/system/invocation.rst                    |   18 +
 docs/system/ivshmem.rst                       |   64 +
 docs/system/keys.rst                          |    6 +
 docs/system/keys.rst.inc                      |   35 +
 docs/system/license.rst                       |   11 +
 docs/system/linuxboot.rst                     |   30 +
 docs/system/managed-startup.rst               |   35 +
 docs/system/monitor.rst                       |   31 +
 docs/system/mux-chardev.rst                   |    6 +
 docs/system/mux-chardev.rst.inc               |   27 +
 docs/system/net.rst                           |  100 +
 docs/system/qemu-block-drivers.rst            |  989 +--
 ...drivers.rst => qemu-block-drivers.rst.inc} |   59 +-
 docs/system/qemu-cpu-models.rst               |   20 +
 docs/system/qemu-manpage.rst                  |   45 +
 docs/system/quickstart.rst                    |   13 +
 docs/{security.texi => system/security.rst}   |   82 +-
 docs/system/target-arm.rst                    |  217 +
 docs/system/target-i386-desc.rst.inc          |   62 +
 docs/system/target-i386.rst                   |   23 +
 docs/system/target-m68k.rst                   |   21 +
 docs/system/target-mips.rst                   |  120 +
 docs/system/target-ppc.rst                    |   47 +
 docs/system/target-sparc.rst                  |   62 +
 docs/system/target-sparc64.rst                |   37 +
 docs/system/target-xtensa.rst                 |   27 +
 docs/system/targets.rst                       |   19 +
 docs/system/tls.rst                           |  328 +
 docs/system/usb.rst                           |  137 +
 docs/system/vnc-security.rst                  |  202 +
 docs/user/conf.py                             |   15 +
 docs/user/index.rst                           |   16 +
 docs/user/main.rst                            |  295 +
 hmp-commands-info.hx                          |  600 +-
 hmp-commands.hx                               | 1451 ++--
 qemu-deprecated.texi                          |  377 -
 qemu-doc.texi                                 | 2967 -------
 qemu-option-trace.texi                        |   28 -
 qemu-options.hx                               | 7291 +++++++++--------
 qemu-tech.texi                                |  195 -
 scripts/hxtool-conv.pl                        |  137 +
 scripts/texi2pod.pl                           |   36 +-
 ui/cocoa.m                                    |    4 +-
 62 files changed, 8341 insertions(+), 10135 deletions(-)
 create mode 100644 docs/defs.rst.inc
 delete mode 100644 docs/qemu-cpu-models.texi
 create mode 100644 docs/system/build-platforms.rst
 create mode 100644 docs/system/cpu-models-mips.rst.inc
 create mode 100644 docs/system/cpu-models-x86.rst.inc
 create mode 100644 docs/system/deprecated.rst
 create mode 100644 docs/system/device-url-syntax.rst.inc
 create mode 100644 docs/system/gdb.rst
 create mode 100644 docs/system/images.rst
 create mode 100644 docs/system/invocation.rst
 create mode 100644 docs/system/ivshmem.rst
 create mode 100644 docs/system/keys.rst
 create mode 100644 docs/system/keys.rst.inc
 create mode 100644 docs/system/license.rst
 create mode 100644 docs/system/linuxboot.rst
 create mode 100644 docs/system/managed-startup.rst
 create mode 100644 docs/system/monitor.rst
 create mode 100644 docs/system/mux-chardev.rst
 create mode 100644 docs/system/mux-chardev.rst.inc
 create mode 100644 docs/system/net.rst
 copy docs/system/{qemu-block-drivers.rst => qemu-block-drivers.rst.inc} (96%)
 create mode 100644 docs/system/qemu-cpu-models.rst
 create mode 100644 docs/system/qemu-manpage.rst
 create mode 100644 docs/system/quickstart.rst
 rename docs/{security.texi => system/security.rst} (77%)
 create mode 100644 docs/system/target-arm.rst
 create mode 100644 docs/system/target-i386-desc.rst.inc
 create mode 100644 docs/system/target-i386.rst
 create mode 100644 docs/system/target-m68k.rst
 create mode 100644 docs/system/target-mips.rst
 create mode 100644 docs/system/target-ppc.rst
 create mode 100644 docs/system/target-sparc.rst
 create mode 100644 docs/system/target-sparc64.rst
 create mode 100644 docs/system/target-xtensa.rst
 create mode 100644 docs/system/targets.rst
 create mode 100644 docs/system/tls.rst
 create mode 100644 docs/system/usb.rst
 create mode 100644 docs/system/vnc-security.rst
 create mode 100644 docs/user/conf.py
 create mode 100644 docs/user/index.rst
 create mode 100644 docs/user/main.rst
 delete mode 100644 qemu-deprecated.texi
 delete mode 100644 qemu-doc.texi
 delete mode 100644 qemu-option-trace.texi
 delete mode 100644 qemu-tech.texi
 create mode 100755 scripts/hxtool-conv.pl

-- 
2.20.1


