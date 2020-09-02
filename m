Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0462C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E3D220C56
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="I9qRaalW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3D220C56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDYag-0008E0-Eo
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 15:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDYXM-00060E-Ol
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:35:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:52429)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDYXG-0002mv-OS
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599075299;
 bh=AT/VFGFerYkGtMsVFEm0mYFBBfJA9/85DRiOtKqXMK0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=I9qRaalWm2TyPL9rMqjPtuz4wUraigZI6vFCjDPNVR7eA6K9TLFNe59gTcCv8eDGE
 mYHsCPjE39UWAbLzU7UEpBJC3kmsQOc/b49bjJfAzrjd52BvPOiT2m2iWFZQvpf4f2
 LisRnKnPwmcL8xxLw8+GKQL5CMbUtYUBkWD8R7RM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.155.63]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma24s-1k7wLH0UKa-00VurO; Wed, 02
 Sep 2020 21:34:59 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/8] hppa: power button support, artist graphics fixes,
 firmware fixes, ...
Date: Wed,  2 Sep 2020 21:34:48 +0200
Message-Id: <20200902193456.29844-1-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0gpzV0XMIPD+elR5UZDI87SWS6Dl1HpFSpMDShfAhJTl8kUomul
 mkLW7MmSdDnwpvolYjbj0vZzqogK2Q9Vf1uVK/LeNHm8kkS31p2Yv+Y1UEUVG5/f9ZAEXME
 sPIUL0U5Z0Wa6mnuPLCHmDmPcwLamEb2rqhP8pD8EHL8Xw0YybuSKHkoBpBTPhWi5HzCTx/
 E+t02D94D9SwpKPBbIZng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FptaSqa9y+Q=:9b1CoSWFxsZRZEWmGyMXWj
 gBNS32/vUdQY51g2cWqbLrpNpJ42ryl6ytnY1UT3lTfdWxp5x5p34VwWFQ9AYSdTeB4/h17ny
 p81ri/Xew9avgQhcrn/pIhbRBc7GFPC3dWfeOh/k+k+u58pkZ1k8k/4J0iS1AcfXhKsVtsaoD
 1QGqVq9T+5VJNwZEDfcmRWXQcjlWjFCqsFrNvTyfzZvB/rqoAd0PT/DEzYqM5OHhZZ6dGDRJB
 XjIySpjSS+9rDA7cv+myvPVDzohF6gdrC+mquFHk8gpDeG9awYxUv+Jzz8t4t73CB7vdR8i9e
 /e5+N0qaCMf0aHz8YJbkbUVZqyF2YTcr3ZnqJa9nzHM5uyvIh1QwabmjOZ20z1h99ed9NFdmb
 mMpFt9zX4+kG8PQM+KP+9qh7Kq9Z8uDYoQXTaB9ArFHf1sUBFcUk7WAzF86Hbc7nrF9jJPn4h
 kEqnUF9+hCqFr7djAc5FFcIqSjz17ggcjDmd4kEB/tdZNBaiY5ap3YdWTb9sLrzvntbHrUKPc
 yUnf77tuY0HMBgmXh4PMr8HY4/onnNGv57Jds2g8kAr8kfmTUn6ujlkVXzwLFVHbg3F0CxZb2
 E7AIwdrjO+iCKiWHbfYCDmIrleGpTStpqDzdMtm0c0fogo1SE+sun6J5Ayq3HGal0wawW1vfc
 oysv6xSQrgwapZKyJkqqJuIs54A7EXbwGiwrIzKYp4GzhYGAHYBaxBBeH/3EnkZKtC9+5Uj27
 +ZHv5sW1rMln/SaDX11LfemH2iOT2ebvSpfJ5v9hnUWbDH5ajGeo/l+gpxJ+arch+vMAQo5TK
 8I3z1A3Ekg1FCzRvDGkds3D9BDaz5ed8JBwlcFYEM3N0ruyDnXR+mV9tm6SC5kc3B4Rvp4PMT
 T26mKPrTeCuFAM1likv1PuB7yp6mxtGfA6lFKFDFD+kGZdGHQQMCFUezpeK1bI1GKbip+jYP/
 EDF2rf+Czavy6OfFPcB7xaCp5hE/icd9nryv9v0KvgbEKLrxJn3kYtG+H0/yRxH2hqzBZcysR
 /ymcsh29V3TE2tSZYxdpMuQw2q01060SskC22Jji+elPSkvmuXePiKqtp3CCwV2kEKHquYYda
 Mev6roDsdkmDPnyWa1l+JVjyS7DDvOXx1j1xpB5LJ6oY7njDOgbbvPTDm8dRKwawmF+xe/ew9
 TPI6VhMA7wWSAwN51fpgNWlHQ1kbCK8Ft3q83w7JyHCarwcn+QszcjKIrkvMxHoV2nCebNxcu
 GSxqXU5P6dLFQd3R2
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 15:35:08
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
fix quite some bugs in seabios-hppa firmware for artist graphics card,
fix boot with old Linux installation CDs,
TLB preparation patches and fw_cfg port addresss handover to SeaBIOS.

The git tree can be pulled from here:
git://github.com/hdeller/qemu-hppa.git  target-hppa

Helge Deller (8):
  seabios-hppa: Update SeaBIOS to hppa-qemu-5.2-2 tag
  hw/hppa: Make number of TLB and BTLB entries configurable
  hw/hppa: Store boot device in fw_cfg section
  hw/hppa: Change fw_cfg port address
  hw/hppa: Tell SeaBIOS port address of fw_cfg
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


