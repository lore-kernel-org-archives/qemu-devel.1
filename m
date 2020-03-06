Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFB4C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:11:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 832E52073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SR20boQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832E52073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAAt7-0004s3-HX
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:11:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAArm-00030S-Ki
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAArk-00041p-82
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:06 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:39733)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAArj-0003xo-Vi
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:04 -0500
Received: by mail-wr1-x42d.google.com with SMTP id y17so1859167wrn.6
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=14xFk3qykptrt01P15Y4X4gUO65Z0xO/G6LfPpeZU2E=;
 b=SR20boQcX5gUTVU7HJUDHCfzJYxY5N6OOHKOKC65ElDdPuegcYxmMUcMbLKjvZOFKM
 FtSd0X8L+sq+KmY95Io3Pn03KJmYQqa2UsHNrDcak9f3JbBk/0+1A5n98z2piAGMz8Ib
 aKaOiEfE3f4U9KmeheMyq1mrnO1gK86whG2TifrYBbw+1oRFp9l3E/fGzvVwMYtabhLw
 KoVkOBK6xvSu+ujxqmxyJ4lIZDQNQ6UQLBmdqM1nes+AE1KgiIVIuBsOoM+F5cevm9p8
 qT8yosWKyOrD645JqpqCpg+OEBNNkAWwziboBrC8aswVdJYB5bcYaO2RbAMoJsJvgGgo
 zX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=14xFk3qykptrt01P15Y4X4gUO65Z0xO/G6LfPpeZU2E=;
 b=iVqB0dvIO9jN8GU4G39VZl5rEo/4dEwzCtv03Q6OIZ6g4gibBc8S5nM92NFPHijuVa
 Bywbd2Jysy0hi3qelxemNLV4sNLchftU9gSZF/29ZEHKzckyppkj0NuW+A/craxA0ArF
 snsfjM68nEBU4xbVwU0TIEQ90mr9SM1dbuQzBLow5xezo4POq6+a8tLSOCQqqzKHPGaR
 686R8jQo+Zo28bDbdedEGo57K3Hd6cC1lb8dWX1WhG9/JGEg3IEaPUAXBtuxmd2wfD/k
 M49ZeZUorJNqYnW3ykrU7BblGveFziiPE/Wp7is4ExsdaWWcc81QBpjcFj+YzgejwENu
 aMNw==
X-Gm-Message-State: ANhLgQ1XsUheBAfO9yfyDSd90tG42N8i1aauzbVJ9O5BXoefQLOJHOEL
 fC7+pewD2mEqIjwDS5CLfz/B2kCPEajgyg==
X-Google-Smtp-Source: ADFU+vtzT42waqH9g8MK9/nqi1usDP9HVeSr+qpCLGGoZt2zkrKA+gU6nc4gC7kRkdjA4OVnSndinQ==
X-Received: by 2002:adf:a50b:: with SMTP id i11mr3850700wrb.60.1583493002256; 
 Fri, 06 Mar 2020 03:10:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm12553029wma.26.2020.03.06.03.10.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 03:10:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/33] docs queue
Date: Fri,  6 Mar 2020 11:09:26 +0000
Message-Id: <20200306110959.29461-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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

As promised, here's a pull request with the patches which do the
qemu-doc rST conversion.

Minor changes since the patchset was posted:
 * rebased
 * the two auto-generated patches have been regenerated, to account
   for the qemu-options.hx changes that went into master since the
   patchset was posted

I have also now done the testing of the OSX change to the docs link.
We've agreed to leave updating the Windows installer for later.

thanks
-- PMM

The following changes since commit 6b02fca71329ed858423b710699952b7f017034e:

  Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-5.0-sf4' into staging (2020-03-05 20:53:53 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-docs-20200306

for you to fetch changes up to 29f9dff79073cfdc336466a950294be91b90f514:

  *.hx: Remove all the STEXI/ETEXI blocks (2020-03-06 11:06:55 +0000)

----------------------------------------------------------------
docs:
 * Convert qemu-doc from Texinfo to rST

----------------------------------------------------------------
Kashyap Chamarthy (1):
      docs/system: Convert qemu-cpu-models.texi to rST

Paolo Bonzini (13):
      qemu-doc: convert user-mode emulation to a separate Sphinx manual
      qemu-doc: remove target OS documentation
      texi2pod: parse @include directives outside "@c man" blocks
      qemu-doc: split CPU models doc between MIPS and x86 parts
      qemu-doc: split qemu-doc.texi in multiple files
      qemu-doc: extract common system emulator documentation from the PC section
      qemu-doc: move system requirements chapter inside PC section
      qemu-doc: split target sections to separate files
      qemu-doc: move qemu-tech.texi into main section
      qemu-doc: move included files to docs/system
      qemu-doc: remove indices other than findex
      docs/system: put qemu-block-drivers body in an included file
      docs/system: convert Texinfo documentation to rST

Peter Maydell (19):
      qemu-doc: Remove the "CPU emulation" part of the "Implementation notes"
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

 docs/specs/ivshmem-spec.txt                 |    4 +-
 Makefile                                    |   47 +-
 .gitignore                                  |    3 -
 MAINTAINERS                                 |    7 +-
 docs/conf.py                                |    6 +
 docs/defs.rst.inc                           |   15 +
 docs/index.html.in                          |    2 +-
 docs/index.rst                              |    1 +
 docs/qemu-cpu-models.texi                   |  677 ---
 docs/sphinx/hxtool.py                       |   10 +-
 docs/system/build-platforms.rst             |   79 +
 docs/system/conf.py                         |    8 +-
 docs/system/cpu-models-mips.rst.inc         |  105 +
 docs/system/cpu-models-x86.rst.inc          |  365 ++
 docs/system/deprecated.rst                  |  446 ++
 docs/system/device-url-syntax.rst.inc       |  228 +
 docs/system/gdb.rst                         |   81 +
 docs/system/images.rst                      |   85 +
 docs/system/index.rst                       |   22 +-
 docs/system/invocation.rst                  |   18 +
 docs/system/ivshmem.rst                     |   64 +
 docs/system/keys.rst                        |    6 +
 docs/system/keys.rst.inc                    |   35 +
 docs/system/license.rst                     |   11 +
 docs/system/linuxboot.rst                   |   30 +
 docs/system/managed-startup.rst             |   35 +
 docs/system/monitor.rst                     |   31 +
 docs/system/mux-chardev.rst                 |    6 +
 docs/system/mux-chardev.rst.inc             |   27 +
 docs/system/net.rst                         |  100 +
 docs/system/qemu-block-drivers.rst          |  989 +---
 docs/system/qemu-block-drivers.rst.inc      |  954 ++++
 docs/system/qemu-cpu-models.rst             |   20 +
 docs/system/qemu-manpage.rst                |   45 +
 docs/system/quickstart.rst                  |   13 +
 docs/{security.texi => system/security.rst} |   82 +-
 docs/system/target-arm.rst                  |  217 +
 docs/system/target-i386-desc.rst.inc        |   62 +
 docs/system/target-i386.rst                 |   23 +
 docs/system/target-m68k.rst                 |   21 +
 docs/system/target-mips.rst                 |  120 +
 docs/system/target-ppc.rst                  |   47 +
 docs/system/target-sparc.rst                |   62 +
 docs/system/target-sparc64.rst              |   37 +
 docs/system/target-xtensa.rst               |   27 +
 docs/system/targets.rst                     |   19 +
 docs/system/tls.rst                         |  328 ++
 docs/system/usb.rst                         |  137 +
 docs/system/vnc-security.rst                |  202 +
 docs/user/conf.py                           |   15 +
 docs/user/index.rst                         |   16 +
 docs/user/main.rst                          |  295 ++
 hmp-commands-info.hx                        |  600 +--
 hmp-commands.hx                             | 1451 +++---
 qemu-deprecated.texi                        |  377 --
 qemu-doc.texi                               | 2967 -----------
 qemu-option-trace.texi                      |   28 -
 qemu-options.hx                             | 7333 ++++++++++++++-------------
 qemu-tech.texi                              |  195 -
 scripts/hxtool-conv.pl                      |  137 +
 scripts/texi2pod.pl                         |   36 +-
 ui/cocoa.m                                  |    4 +-
 62 files changed, 9302 insertions(+), 10111 deletions(-)
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
 create mode 100644 docs/system/qemu-block-drivers.rst.inc
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

