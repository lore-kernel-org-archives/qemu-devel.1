Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE01BC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 12:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E1020693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 12:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWgqvSPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E1020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsRPB-0006B9-WA
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 08:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37234)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hsROG-0004tb-Lh
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hsROF-0006fR-Gs
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:38:04 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36409)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hsROF-0006ep-BC
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:38:03 -0400
Received: by mail-wr1-x444.google.com with SMTP id n4so65676474wrs.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 05:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XJoQV/ERfOV3Qg5NkF0rbE6HQd2X6ZRZOmlI3aw8h1I=;
 b=sWgqvSPc8iqZLq//IPzVp20TKkZ1ZPzhv5sgZ9iwxs44d0A8c7YCea6hhCArSf4g6G
 vmeQTXOfCAh0YBGKsuuJQ/osVmMhtR6chZZ0QQlNjNGdy7U3lp7odOSOmmq4EzU4dzmG
 OTB2CxPJEHzM+P2K/OkhSknf/Z3APT/kzUOZpVk1O6UA7txdUrpH++8QqOWkhwJg5QId
 hjKJ3vLkCIJabtZRs8oiU1OUYbRNuYL59vO9/yHuVHB0uF2NrJJMFE49dKd90cBk0zrz
 hRpNa9mb8SfGUXBMr/u/vYKWNc2gVwtPdJrzQNc4aht/mUfURrAklX5i/GPpNU2VPQEM
 tP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=XJoQV/ERfOV3Qg5NkF0rbE6HQd2X6ZRZOmlI3aw8h1I=;
 b=TfNrRhZy20CBjnXLgtkvPXMBMK4RMm5aLVvIcqAuRK6+eKXk+OlBD6deSkHILCEspP
 0kSuf8hFR5FzwnKvGfLS/H3QRPCXIEe7wFbqMQyMcCxDIQmIM9wXxTGu+2zw0BNRdSZk
 VPl1SXOmo6bUko/hK6ADoHb24JBuzGyFkhAvRWsOSlnIkajSpTn7VQWJcChks3dLikyd
 gF7/dbVjjZGTPuB3FDSs3SFzZJNhpfZdx8itXrTooSm1xhs8r2mNVUgOguNipIXuRGeU
 zUPDZdo+PiPAcGUkSj+AvTib9XTef7AtRmK/3n03jifWijBcVbQyosa1GAFiXLg+KleQ
 GrYQ==
X-Gm-Message-State: APjAAAVC3sXF+psdZNljGeWxBtaqdAa6vPHLweyBPp5QWQekcmWd3/bq
 1k/aYU2nDF0UwSaSf9tVhN3iZqqVBLs=
X-Google-Smtp-Source: APXvYqylZdY091dsklEZxpncFDj1LIAvHgepJO856+SdpYBCRvQ7lU3qGfli/9jetCTIXiV+d+vKGQ==
X-Received: by 2002:a5d:5644:: with SMTP id j4mr46541301wrw.144.1564490281444; 
 Tue, 30 Jul 2019 05:38:01 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
 by smtp.gmail.com with ESMTPSA id
 j6sm90847995wrx.46.2019.07.30.05.38.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 05:38:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 30 Jul 2019 14:37:56 +0200
Message-Id: <20190730123759.21723-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 0/3] tests/tcg: disentangle makefiles
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

Paolo Bonzini (3):
  tests/tcg: use EXTRA_CFLAGS everywhere
  tests/tcg: cleanup Makefile inclusions
  tests/tcg: move configuration to a sub-shell script

 Makefile                                  |   1 +
 Makefile.target                           |   3 -
 configure                                 | 155 ++------------------
 tests/Makefile.include                    |  25 ++--
 tests/tcg/Makefile.include                |  88 ------------
 tests/tcg/Makefile.prereqs                |  18 +++
 tests/tcg/Makefile.probe                  |  31 ----
 tests/tcg/Makefile.qemu                   |  95 +++++++++++++
 tests/tcg/{Makefile => Makefile.target}   |  15 +-
 tests/tcg/aarch64/Makefile.include        |   8 --
 tests/tcg/aarch64/Makefile.softmmu-target |   4 +-
 tests/tcg/aarch64/Makefile.target         |  12 +-
 tests/tcg/alpha/Makefile.include          |   2 -
 tests/tcg/alpha/Makefile.softmmu-target   |   4 +-
 tests/tcg/arm/Makefile.include            |   8 --
 tests/tcg/arm/Makefile.softmmu-target     |   6 +-
 tests/tcg/configure.sh                    | 228 ++++++++++++++++++++++++++++++
 tests/tcg/cris/Makefile.include           |   6 -
 tests/tcg/hppa/Makefile.include           |   2 -
 tests/tcg/i386/Makefile.include           |   9 --
 tests/tcg/i386/Makefile.softmmu-target    |  12 +-
 tests/tcg/i386/Makefile.target            |  13 +-
 tests/tcg/m68k/Makefile.include           |   2 -
 tests/tcg/minilib/Makefile.target         |   2 +-
 tests/tcg/mips/Makefile.include           |  20 ---
 tests/tcg/ppc/Makefile.include            |  10 --
 tests/tcg/riscv/Makefile.include          |  10 --
 tests/tcg/s390x/Makefile.include          |   2 -
 tests/tcg/sh4/Makefile.include            |   4 -
 tests/tcg/sparc64/Makefile.include        |   2 -
 tests/tcg/x86_64/Makefile.softmmu-target  |  36 +++++
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
1.8.3.1


