Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFD1C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:32:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4595E2467B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZNgIdNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4595E2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6uv2-0002Cv-EN
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6uti-0000Zk-1F
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6utg-0005bJ-9x
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:37 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:52424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6utg-0005Uz-2G
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:36 -0500
Received: by mail-wm1-x332.google.com with SMTP id p9so2629762wmc.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 03:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=f/JiFLpLocad7KTqMiffOL6S3nSUzVVBEOJ4mjx5M1M=;
 b=nZNgIdNpopg48MilSkINZuOW49OBTOaWmJ66pHR3a+k3xzkn+KWoMXuIdJlg76+xyP
 6BqBlMx7WEKdRwwcttLOW3WJGVi6IU6hJGDKeQyLg0Dz4qsfdO2MpQw0TWeaEfhnqsac
 peS7/68mNdujspRycDMPHR1sVm0qGFae7LRjq4AcUhAnQ1izA0MfoBWFKJdkaE3EhBEr
 cSCifinqJUFgmIXr3dNO6HGungxS9BUHbb7C79k1/1gUdjbSJtWHjzqoKE7NneiWoTdF
 K2L+a9DbgHYgtfHjbwFGrwl+A4cvfOh12dCJQ+ybUMlb5vPKi8RvmqPVY1L1X5kwAuFE
 s+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=f/JiFLpLocad7KTqMiffOL6S3nSUzVVBEOJ4mjx5M1M=;
 b=JJmyZW07tCBaBlpAQA7oYNU0YAgz85lsRG206az/qdc+aABGDx11B/iUgzrqWAtzcc
 OYVsR58p459sO9MyoaJHWYmEOYWtxBJCTdEN7pDzIlpLmzjmlRdwxkaDmbybC4zQOc7F
 WQbRTZ+hHKVxVnHfrXB/ngnCHuSA3rjwokY2lqqI23xfFfX/flLhpyiJ32t+BsDV1oGl
 ycj6jgORBZjtnvyjpyyfRJMvzfTtwmwKKdelVwSTVn500FxG7ZGWqHVCTIUaW20OAsg5
 Oh6de/NBGPWRIORflAWZ2+4iDLUMJhYn3DvvKNnP5Ra/SdmM2hu220u6DL2R3jRQsPgM
 TlZw==
X-Gm-Message-State: APjAAAULJW5PS8o9nk5dESPD1ydrtqLHwdP91OqU3/9feabr4KyAA2xJ
 4eG+54hZQO2v7saoPRLilc+PZnBL
X-Google-Smtp-Source: APXvYqyr/QSJYxcsnQivI6HhC4QkNTE0J1sgaeonGBBMEFCXHWiHITIQqne/WrSxCSR5UEsSKwClHQ==
X-Received: by 2002:a1c:660a:: with SMTP id a10mr5037467wmc.122.1582716634387; 
 Wed, 26 Feb 2020 03:30:34 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id h128sm2628154wmh.33.2020.02.26.03.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 03:30:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/18] qemu-doc reorganization and Sphinx version
Date: Wed, 26 Feb 2020 12:30:16 +0100
Message-Id: <20200226113034.6741-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series converts qemu-doc to Sphinx, providing the fourth and fifth
manuals (user-mode emulation and system emulation).

Patch 1 extracts the user-mode emulation documentation to docs/user,
converting it to rST.

Patches 2 to 12 split qemu-doc.texi in multiple files, slightly
reorganizing the sections and removing wildly obsolete material.
At this point qemu-doc.texi looks very much like what docs/system
will be.

Patch 13 tweaks the construction of the qemu-block-drivers man page
from the material that goes in docs/system.  Instead of usihg an
"only" directive, the man page is in an orphaned .rst file and
the common material is included.

Patch 14 is Kashyap's conversion of qemu-cpu-models.texi to rST,
tweaked in the same way as patch 12.

Patches 15 to 17 are Peter's manual conversion of security.texi,
qemu-tech.texi and qemu-deprecated.texi.

Patch 18 finally is the mass automated conversion of everything
else.  The content is temporarily preserved in qemu-doc.texi as well,
until the hxtool-based documentation is converted to rST.

Paolo

Supersedes: <20200225163758.12996-1-pbonzini@redhat.com>

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

Peter Maydell (4):
  qemu-doc: Remove the "CPU emulation" part of the "Implementation
    notes"
  docs/system: Convert security.texi to rST format
  docs/system: convert managed startup to rST.
  docs/system: convert the documentation of deprecated features to rST.

 MAINTAINERS                                   |    6 +-
 Makefile                                      |   42 +-
 docs/conf.py                                  |    2 +-
 docs/system/build-platforms.rst               |   79 +
 docs/system/build-platforms.texi              |   67 +
 docs/system/conf.py                           |   10 +-
 docs/system/cpu-models-mips.rst.inc           |  105 +
 docs/system/cpu-models-mips.texi              |  157 +
 docs/system/cpu-models-x86.rst.inc            |  365 +++
 .../cpu-models-x86.texi}                      |  221 +-
 docs/system/defs.rst.inc                      |    2 +
 docs/system/deprecated.rst                    |  446 +++
 .../system/deprecated.texi                    |    0
 docs/system/gdb.rst                           |   81 +
 docs/system/gdb.texi                          |   71 +
 docs/system/images.rst                        |   85 +
 docs/system/images.texi                       |   88 +
 docs/system/index.rst                         |   22 +-
 docs/system/invocation.rst                    |  242 ++
 docs/system/invocation.texi                   |  240 ++
 docs/system/ivshmem.rst                       |   64 +
 docs/system/ivshmem.texi                      |   60 +
 docs/system/keys.rst                          |   40 +
 docs/system/keys.texi                         |   43 +
 docs/system/license.rst                       |   11 +
 docs/system/license.texi                      |    9 +
 docs/system/linuxboot.rst                     |   30 +
 docs/system/linuxboot.texi                    |   27 +
 docs/system/managed-startup.rst               |   35 +
 docs/system/managed-startup.texi              |   35 +
 docs/system/monitor.rst                       |   25 +
 docs/system/monitor.texi                      |   34 +
 docs/system/mux-chardev.rst                   |   32 +
 docs/system/mux-chardev.texi                  |   44 +
 docs/system/net.rst                           |  100 +
 docs/system/net.texi                          |   96 +
 docs/system/qemu-block-drivers.rst            |  989 +-----
 docs/system/qemu-block-drivers.rst.inc        |  954 ++++++
 docs/system/qemu-cpu-models.rst               |   20 +
 .../system/qemu-option-trace.texi             |    0
 docs/system/quickstart.rst                    |   13 +
 docs/system/quickstart.texi                   |   12 +
 docs/system/security.rst                      |  173 +
 docs/{ => system}/security.texi               |    0
 docs/system/target-arm.rst                    |  227 ++
 docs/system/target-arm.texi                   |  263 ++
 docs/system/target-i386.rst                   |   84 +
 docs/system/target-i386.texi                  |   91 +
 docs/system/target-m68k.rst                   |   32 +
 docs/system/target-m68k.texi                  |   44 +
 docs/system/target-mips.rst                   |  120 +
 docs/system/target-mips.texi                  |  150 +
 docs/system/target-ppc.rst                    |   61 +
 docs/system/target-ppc.texi                   |   77 +
 docs/system/target-sparc.rst                  |   81 +
 docs/system/target-sparc.texi                 |   95 +
 docs/system/target-sparc64.rst                |   49 +
 docs/system/target-sparc64.texi               |   60 +
 docs/system/target-xtensa.rst                 |   39 +
 docs/system/target-xtensa.texi                |   55 +
 docs/system/targets.rst                       |   19 +
 docs/system/tls.rst                           |  328 ++
 docs/system/tls.texi                          |  329 ++
 docs/system/usb.rst                           |  137 +
 docs/system/usb.texi                          |  115 +
 docs/system/vnc-security.rst                  |  202 ++
 docs/system/vnc-security.texi                 |  196 ++
 docs/user/conf.py                             |   18 +
 docs/user/index.rst                           |   16 +
 docs/user/main.rst                            |  295 ++
 qemu-doc.texi                                 | 2868 +----------------
 qemu-options.hx                               |    2 +-
 qemu-tech.texi                                |  195 --
 scripts/texi2pod.pl                           |   36 +-
 74 files changed, 7229 insertions(+), 4232 deletions(-)
 create mode 100644 docs/system/build-platforms.rst
 create mode 100644 docs/system/build-platforms.texi
 create mode 100644 docs/system/cpu-models-mips.rst.inc
 create mode 100644 docs/system/cpu-models-mips.texi
 create mode 100644 docs/system/cpu-models-x86.rst.inc
 rename docs/{qemu-cpu-models.texi => system/cpu-models-x86.texi} (71%)
 create mode 100644 docs/system/defs.rst.inc
 create mode 100644 docs/system/deprecated.rst
 rename qemu-deprecated.texi => docs/system/deprecated.texi (100%)
 create mode 100644 docs/system/gdb.rst
 create mode 100644 docs/system/gdb.texi
 create mode 100644 docs/system/images.rst
 create mode 100644 docs/system/images.texi
 create mode 100644 docs/system/invocation.rst
 create mode 100644 docs/system/invocation.texi
 create mode 100644 docs/system/ivshmem.rst
 create mode 100644 docs/system/ivshmem.texi
 create mode 100644 docs/system/keys.rst
 create mode 100644 docs/system/keys.texi
 create mode 100644 docs/system/license.rst
 create mode 100644 docs/system/license.texi
 create mode 100644 docs/system/linuxboot.rst
 create mode 100644 docs/system/linuxboot.texi
 create mode 100644 docs/system/managed-startup.rst
 create mode 100644 docs/system/managed-startup.texi
 create mode 100644 docs/system/monitor.rst
 create mode 100644 docs/system/monitor.texi
 create mode 100644 docs/system/mux-chardev.rst
 create mode 100644 docs/system/mux-chardev.texi
 create mode 100644 docs/system/net.rst
 create mode 100644 docs/system/net.texi
 create mode 100644 docs/system/qemu-block-drivers.rst.inc
 create mode 100644 docs/system/qemu-cpu-models.rst
 rename qemu-option-trace.texi => docs/system/qemu-option-trace.texi (100%)
 create mode 100644 docs/system/quickstart.rst
 create mode 100644 docs/system/quickstart.texi
 create mode 100644 docs/system/security.rst
 rename docs/{ => system}/security.texi (100%)
 create mode 100644 docs/system/target-arm.rst
 create mode 100644 docs/system/target-arm.texi
 create mode 100644 docs/system/target-i386.rst
 create mode 100644 docs/system/target-i386.texi
 create mode 100644 docs/system/target-m68k.rst
 create mode 100644 docs/system/target-m68k.texi
 create mode 100644 docs/system/target-mips.rst
 create mode 100644 docs/system/target-mips.texi
 create mode 100644 docs/system/target-ppc.rst
 create mode 100644 docs/system/target-ppc.texi
 create mode 100644 docs/system/target-sparc.rst
 create mode 100644 docs/system/target-sparc.texi
 create mode 100644 docs/system/target-sparc64.rst
 create mode 100644 docs/system/target-sparc64.texi
 create mode 100644 docs/system/target-xtensa.rst
 create mode 100644 docs/system/target-xtensa.texi
 create mode 100644 docs/system/targets.rst
 create mode 100644 docs/system/tls.rst
 create mode 100644 docs/system/tls.texi
 create mode 100644 docs/system/usb.rst
 create mode 100644 docs/system/usb.texi
 create mode 100644 docs/system/vnc-security.rst
 create mode 100644 docs/system/vnc-security.texi
 create mode 100644 docs/user/conf.py
 create mode 100644 docs/user/index.rst
 create mode 100644 docs/user/main.rst
 delete mode 100644 qemu-tech.texi

-- 
2.21.1


