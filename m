Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476FEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0070A20729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AKWZIfXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0070A20729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0B0N-00026H-41
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 17:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k0Aws-0000RA-OM
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 17:46:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:42935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k0Awq-0002mt-L4
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 17:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1595886370;
 bh=yBixY+k/FDbsx8bdN6iEXvCmESz5s1hyDi2VuQsCTiI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=AKWZIfXgX3+oNQqrfSmCdvEpt5pVRjeS7Z1aKdRmd12hwayPC2TvKU9RQtk0/aWfs
 XiZJbrU5V4wSxq6+04nb8I5j4LT0+/MBtkUOXA1TZHif8MDPfnkGdODD0yupJ7/UiV
 C5jtuBdek4j5i/yvLHBp0M7s+e6xF5qWR+GgNB5M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.179.161]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mw9Q6-1kpwik17e0-00s2I9; Mon, 27
 Jul 2020 23:46:10 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] Various fixes for hppa architecture
Date: Mon, 27 Jul 2020 23:46:04 +0200
Message-Id: <20200727214608.32710-1-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HBZqu5+FFQRYSkrnewznMDB2eNYfKZiQURAGYmN55XBhyCd+xx0
 CuqTochANGpf5Yr3e+exVit6ZBaYzc27FR+RxNgEfGwprTSHlmWMu1RkQ1pkOlU0D9ANdhR
 VHJcGo2imklcLrUp4uVF3cn8WKEyi7+wgXGImbI7CAiLFsAjC60ayMZ8MCFiBFEa876EGHY
 Gy76yiEG/UWaNUroI3fDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kVkKLIA87r4=:jc9hPWkL9zqXIXU1TyXqAl
 Sj1fmnONIgzHs6nEtxH++Ew3fnuBJkzMsa05+hq1r+EbU3Xyf6R/PnsTyHt7AHGpJuMRu09tl
 RtNx8AofAGjMtNpxAiinT3gtZw7HxKik4IiJRjcWh+LOhtws/pTpKDcNnCXS/fY0xQ9cAhwne
 G34rHhlORS7yaf79b5SMY5SR4H5Mk019PxnyNxdyHCSBYwlDQ36rQ+8F/WYG5YFmvCnauvVHq
 /GiwuW65k1zLPYXoZnqxoUn5oqLmZyp8VRIO9UtFL6IPLyJPGlKFdUGqXyICkPDzQfhQvf4xw
 eTRYPYCDNLgRdIGKcR4a6fx128eHBCwGR68g6mH4X2u3hN4fnl3e45xk4IX3/STOY8LMH3w88
 uSK96fEGmZBoOYvhSwDkG4CkZU7/x4taPyAK2NEN3u9Owya0i7HG46e9vdnDnLlvr+NxdcHtu
 pxTnYzG2bn5en1ZyzNO4a0CQBsl6V2a3ycbDhIAmUg/FSDEk2hoi2Mxrm05GDFNN0UyQ9gcd9
 KLoHuYRZ9fA+2f7FbBjjMtKGwEAO0bl+P3WTJDGP/I8IUuHs/tRiHYseJEKHnOPOiD6JlvZL8
 Pz7RJ72rsLcT0p2vZRDV/+OqMVDmnah28s+qK7RBwmsYAC9LopU1riQYsJKDQAYpXTFzxh56D
 d/RhUOUL7+WUFqK9w45whRhMcsb+z7Hx9Ghd7vKI0fWws6zSl3kEmqJ/N6oyJYAMqS92M8CkM
 jbPOTSkA5oN1/yLrjhTutlQUpaeQSD+cPRoWvsLekxWdlW0UWNgarj6EYA3flyTZSYiS91v48
 OoYgJ/RJZ8VIRxHD07Gr0YZDdZsRqmJj7/+p5b8INHMDhD+aShWi8gNYuw61XA46hmX8OkXOd
 x2BOPSY/YJhw7Y0ntFkUzSHE/4c3ufF6LJOs/MCMoFXbKfB/7FmxcfdK+RMhTPkEbRFWwuwyY
 1M6R+3odmQTAtcRd/TU+gD34jXruQzV0xAQS/cOwRIkOb8JLl7W0B5i47fIVemvLFVYJjy7PY
 cB2H4qRPr+E+2j53g0yo9BvH1spb7tJEy8zWSFcNP7w4J5mbKEMdOlGaAx3qIid6/FYnSYgYg
 NoWLg1VNMztEq+rGMcieXRCjui8+Ko+d3ofzJ7o4qYxjvxOKRRiaBYS6cFaxOqW/pkzJUNKbL
 rNMe/GzwhsE5Eo3XLpAoO07f5BT8Ep2Bf4dsnOucqx9SBdvyszyUYVK6ljOild/vQtdOLt43W
 c5adWBi5uXS7e4Fxb
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 17:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

This patch series fixes a few issues with the hppa emulation:

* The artist framebuffer emulation reports:
  "write outside bounds: wants 1256x1023, max size 1280x1024"
  This is fixed by a patch from Sven Schnelle.

* Fix a SeaBIOS hppa compilation issue with gcc-10.

* Implement a proper SeaBIOS firmware version check to prevent
  incompatibility issues between emulation and firmware.

* The hppa_hardware.h file is shared with SeaBIOS. Sync it.

The series can be pulled from the fw_cfg-3 branch at:
https://github.com/hdeller/qemu-hppa.git  fw_cfg-3

Helge

Helge Deller (3):
  hw/hppa: Sync hppa_hardware.h file with SeaBIOS sources
  seabios-hppa: Update to SeaBIOS hppa version 1
  hw/hppa: Implement proper SeaBIOS version check

Sven Schnelle (1):
  hw/display/artist.c: fix out of bounds check

 hw/display/artist.c       |  18 ++++++------------
 hw/hppa/hppa_hardware.h   |   6 ++++++
 hw/hppa/lasi.c            |   2 --
 hw/hppa/machine.c         |  22 ++++++++++++++++++++++
 pc-bios/hppa-firmware.img | Bin 766136 -> 783144 bytes
 roms/seabios-hppa         |   2 +-
 6 files changed, 35 insertions(+), 15 deletions(-)

=2D-
2.21.3


