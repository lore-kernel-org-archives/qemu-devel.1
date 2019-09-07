Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C558FC43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 15:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC01218AC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 15:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC01218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6cyU-0005MK-S7
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 11:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@gmail.com>) id 1i6cwM-0003jV-Ux
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 11:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1i6cwL-0007fz-Q0
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 11:47:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1i6cwL-0007fM-JS
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 11:47:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id k2so9330631wmj.4
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 08:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3PRRy+93WxfHaQJCtrc6wew/EOGYsekYADtPqRAogEc=;
 b=gUXz7LGhgzI0hwkqSyoplXKM1PHmlMsm5ltt/9biX0gMxbQ/xfNvj2S9W+rXvvmkcP
 U2vdag/Arz6j99YuudakCGmmrdf+rINGVWBVBwx8fMeGTbkakvLOD0ZU35Ria3Na/xJn
 akDK7GIltZ6Mjx9AwaGCzXHfiKk/vrcFhHbM9HGREE4jX7NfNL2+WKpPHRBH8ZgwaQKI
 HONCVUeeWdga1X3OpbQ3TL2jv52Sd6bebX6l9retbrF/bRYqn/45C0WkbQVRHkuOaZmV
 vmgMIcru01jw27z1YbQSGMOl+0KFE3kD1B5A+2T9NBentUotSgPyNqljSr7AjOJBEFic
 BWfg==
X-Gm-Message-State: APjAAAU0MIqZ3UFNn1qpf7esFXVFPQZrnGu2mdtTpxiwO+yEhQ/1wzIE
 hp6eAmdX3xmV7L2h5tpABc4=
X-Google-Smtp-Source: APXvYqxMtJNIyyFmmBcHfGdm3B+D6g+45Yy5rbvf59PRkBiW52jRp4Nwu3Rz0G+CnAqfmlJ8x1PrGA==
X-Received: by 2002:a1c:1f89:: with SMTP id
 f131mr11963536wmf.140.1567871272409; 
 Sat, 07 Sep 2019 08:47:52 -0700 (PDT)
Received: from thl530.multi.box (pD9E8385F.dip0.t-ipconnect.de.
 [217.232.56.95])
 by smtp.gmail.com with ESMTPSA id s19sm17173418wrb.14.2019.09.07.08.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2019 08:47:51 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Sat,  7 Sep 2019 17:47:36 +0200
Message-Id: <20190907154744.4136-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: [Qemu-devel] [PULL 0/8] Add the m68k next-cube machine
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

 Hi Peter,

the following changes since commit 90b1e3afd33226b6078fec6d77a18373712a975c:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-09-05-v2' into staging (2019-09-05 17:09:13 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/m68k-pull-2019-09-07

for you to fetch changes up to 25311649592f5584b1e1012d69c7327ef87473f4:

  .travis.yml: Let the avocado job run the NeXTcube tests (2019-09-07 08:35:41 +0200)

----------------------------------------------------------------
Add the m68k next-cube machine
----------------------------------------------------------------

Laurent Vivier (1):
      escc: introduce a selector for the register bit

Philippe Mathieu-Daudé (2):
      tests/acceptance: Add test of NeXTcube framebuffer using OCR
      .travis.yml: Let the avocado job run the NeXTcube tests

Thomas Huth (5):
      m68k: Add NeXTcube framebuffer device emulation
      m68k: Add NeXTcube keyboard device
      m68k: Add NeXTcube machine
      m68k: Add serial controller to the NeXTcube machine
      m68k: Add an entry for the NeXTcube machine to the MAINTAINERS file

 .travis.yml                               |   7 +-
 MAINTAINERS                               |   7 +
 default-configs/m68k-softmmu.mak          |   1 +
 hw/char/escc.c                            |  30 +-
 hw/display/Makefile.objs                  |   1 +
 hw/display/next-fb.c                      | 146 +++++
 hw/m68k/Kconfig                           |   5 +
 hw/m68k/Makefile.objs                     |   1 +
 hw/m68k/next-cube.c                       | 978 ++++++++++++++++++++++++++++++
 hw/m68k/next-kbd.c                        | 291 +++++++++
 include/hw/char/escc.h                    |   1 +
 include/hw/m68k/next-cube.h               |  47 ++
 tests/acceptance/machine_m68k_nextcube.py | 121 ++++
 tests/boot-serial-test.c                  |  12 +
 14 files changed, 1641 insertions(+), 7 deletions(-)
 create mode 100644 hw/display/next-fb.c
 create mode 100644 hw/m68k/next-cube.c
 create mode 100644 hw/m68k/next-kbd.c
 create mode 100644 include/hw/m68k/next-cube.h
 create mode 100644 tests/acceptance/machine_m68k_nextcube.py

