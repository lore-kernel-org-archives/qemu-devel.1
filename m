Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62413C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC4C6207D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VUdisku8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4C6207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDBBZ-0003k4-Io
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 14:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDB7h-0001cV-27
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:35:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:37189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDB7d-0008Cv-Ux
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598985295;
 bh=jH0jBCglOAwCS8gviW/0Z/UDa2wKMHkqvrSxkT315JE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=VUdisku8uHWxxxmi17r69x++boXFYt7Uoqm7mUgZCFG7q873dJAFwo714B63dEx2g
 6j787wawguJZ0yECkGUxhHXSZU1RCNVBHzI4WdcVib+X+Fyu1H+Jbfoj3mWeGqNPlB
 4WjU27hazYVoMtoIU+HdZZDmEKiUIcbYLAsEolSg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.187.2]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72sP-1kDzfN3gR5-008ZJc; Tue, 01
 Sep 2020 20:34:54 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] hppa power button support,
 graphics updates and firmware fixes
Date: Tue,  1 Sep 2020 20:34:45 +0200
Message-Id: <20200901183452.24967-1-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ApKgqiw/b1rHUWmo0haEkkiZbHgOQO35dh3UyKM8py7oM8OpxGQ
 X2KBz3xQMo2IL+YzPCNIIwIy9nxXxJo3AsRHZzbFnnTQX5XnpaAqJ6Vt3xtFv6ag28mFMdu
 1S7OYL/fkn5w6YUkyuCo8xRoWtclAeKkKvlonHnZQQny6laS/oZZj627oThTUdMJ3lS9SPF
 5Mz3jmiSuoKivpIGQRgUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bYbZQ0fcRt8=:r8cnk55Qbkhhb6PpYUio/X
 qiNUqSoApqnstOTs2PbU99AOfFkLArNBWjqvb0U2xH8BEfdMKGGYEEp8pqor3fOi86TLsy0Vl
 GrOWsCOhK9jOjH/7FT4bK0g57X7M3Uccd9BeiDIwcCBDLRg9NGEvzMKpQfvdpo5kDfCmRbBnD
 EgL/Umequ7a4RWhy3SeWABz/+L31LJKAmlHoY6EUwLV2VLrRCwvT5xvrWKEFOxHTtYJ38/45v
 Vbgh+yVeqI5SEWVwqRSGGhMVa5X9+aNcSnUq7lkRJkY4rx3vk8q5K1qg5iwPnZ9JnQV5m78cZ
 l8vcQYIR9WWgZxX60+BFnEAoyX/GfmmTABzv1vtXRXSl3QOfrOaPsM7CbipAzkpOqgFeI4qNG
 tWNSvZ3IW0MhEAhe4869J8TiB70rLfmabcMq4uo6IuSO+OZ2y3AgLCulmbCfzbw3zWnpfcO2x
 bNzKZGkJR7Wd1Bk3CwcH6mW+Y2HwcEwbjdZ3Y+/O2Ra53U4wimi52SbUqyEaO/hWmSj7tX+tb
 0SXQRHqf2EEYoT7oHPZMIdmT2pF1oFdJvp2VEz0QFpLPlw0yudQ4OzGoMT/bUn0pmq0HylpGb
 UbC9vG0eGdunLYXTwOZJA/c5tw+YfKgdeM48fFYlIMjfMsJMa7h0/QJANn56fvFuS+vBz2UG6
 J/Qh0+gChtppJ5kLABY0BBLisyvSiyDlSOj/F1H17NmCR2NWilKOezr7DJPT0AgPxZcsMvoVO
 1FYtpyKPpNuKiwqGQxgzi9tiNXAQZlJnTd0CKcD+RWZFgN3tTrU8F1Qu/Hn3xtLxk2JTzK+P7
 gtR+hLRRMwuwNErgZTmfTCg27VhQtZnehc0uGkLI4pIuh3S9t1kDTQG7ToZRzdtcaRTBPYDnR
 RK0W097cqzFNXfqHulG9k2pf/QYyENZREMhbLAc0RbIwZ6OR3kIWHmY7c/bESrFssJpdGA68p
 9FQMkdgOVzNeacDv6Bde/Kjy6oFNF09nsnKJdhs0Jh/F4QI7OOkQC2Gr3xyaYmfbLyGUQ+wht
 brkpSGBiKV3I0ez79gV6u/5gLQ0Qhi56mPeRhV9zKBwjHy+TP9vBEm7hjabOd6PXoyyWlS9mv
 M7AxhzoDpcjtli3XDeuF3iTtcM5PmJKbxct/feGE14B0p36RFjzdhfbhg7zA3ja462yDoMso5
 xLiYsEGL+KZnIVRSOIaO9O3Vd3YrExRsAApgo4oXEFvkOaqSU0euUSYKm6Ewad9LpqYktEtE4
 lZ+Z9MtyFwc54Zpun
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 13:37:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add emulation for a power button on hppa,
fix quite some bugs in seabios-hppa firmware for artist graphics card
fix boot with old Linux installation CDs.

Helge Deller (7):
  seabios-hppa: Update SeaBIOS to hppa-qemu-5.2-2 tag
  hw/hppa: Make number of TLB and BTLB entries configurable
  hw/hppa: Store boot device in fw_cfg section
  hw/hppa: Inform SeaBIOS about fw_cfg port address
  hw/hppa: Add power button emulation
  hw/display/artist: Fix artist screen resolution
  target/hppa: Fix boot with old Linux installation CDs

 hw/display/artist.c       |  37 +++++++++++++++----------
 hw/hppa/hppa_hardware.h   |   3 +-
 hw/hppa/machine.c         |  56 +++++++++++++++++++++++++++++++++++++-
 pc-bios/hppa-firmware.img | Bin 783192 -> 785696 bytes
 roms/seabios-hppa         |   2 +-
 target/hppa/cpu.h         |   5 +++-
 target/hppa/insns.decode  |  10 +++----
 7 files changed, 89 insertions(+), 24 deletions(-)

=2D-
2.21.3


