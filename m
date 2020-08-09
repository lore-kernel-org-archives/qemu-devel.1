Return-Path: <SRS0=L55N=BT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72591C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358C220709
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="estv04DX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358C220709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4dro-0007sU-8l
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 01:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4doi-0006CO-Gd
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:24:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:59179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4dog-0002oR-5k
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596950644;
 bh=2z2xU5K9vJCwon/1dQXqk4D9y2c8lzHUlQQ9EfrXvoo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=estv04DXCEkus1suIghNOg2I8Evg322wwGO/OW9MZgTFtFzKz6LqyNAT3jhA3XMRa
 ZfA+Q76W6IAmO0Fynvt4XXeLJJ4vWG9bWJuVr1yfGwpdk5NL2SQiCqRq0p3cHdY+UD
 ZVqi+XhXpl5TaAMK2drPZEFezLdU/mLX70thOce4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.185.161]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHEJ-1kf5YW3max-00grEt; Sun, 09
 Aug 2020 07:24:03 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v4 00/12] target-hppa fixes v4
Date: Sun,  9 Aug 2020 07:23:50 +0200
Message-Id: <20200809052402.31641-1-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qmXz9c1NjVp2CCmOjohUMDKbOICmtGj+ePEz0JgiEQ3QsV2dh6z
 P/5RTm+7wxSgVBAhfcha7fF0VFJHsxsId15mSF1wzMuJO5LsbPa+v05X1Xi14fC527hg3nr
 BxpeYQ4yyZFVZrIIvYSUZVSkWagYD9sNlPwWhWC2DChNXbvwtc3FCD7SVDwu6oqdnWT9LAF
 cqauER8D6Fd/TVMB+ofwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fVhNy0zsfto=:qj6EVTFnoHafpBS6cY24rC
 WqIiQjBGBNdRgz41pTXURf5Cl4FcRAHoLH+G2AaRrtnnOzOOvwvTqRJBmf/wFFgLek2E14DTr
 kIg1fyproF06DJ1ND5Gzn50U8YF8DUGWIZt2PFh47pq922T8LY64lqoe660Zo+VsOvYpmji5D
 RIHOtLNgBftKzQcU4SI0WCSXq3mU9TJSRNBuYNVlBZlR2jHsyAIhGFrPYxfK4U1vMnoeamfV2
 Kwdm1kH801VTlLoDEtTqnWFoqmLS7uKs2c8j6EvI9ydcCG85twlKHwTmoTa9u8iuILRSJk/n1
 ke5r6m0L0PoWXAmhYtb5dos6Ekkkz6Z9R3GSRd4OI+QsI8KIgiSrQoKf3OSdNQVwefN4Ov3+y
 loxPkTmpf1x5r7Nl/SIXo1co3ijBsdfqMynqjFLo6HX7MwoSkos5NagCVSoRHQ2CE2AQySweX
 Fc/cRnI/3giJj4TVitjpOxZweTO8hWjUf/8A0T7oPX2iVVrhiL0G+x5ToXRYUpPFbnAKn7tHP
 Y51CBOV1ej/ACeMeFLO8O+mJjUm9wz7rKZiNbih0R/fVJE8NHhxq89hV9S4zGam4Xh0BVyn8h
 mc9PC1aV4Y3Z0JSNPevp3meDdr1ARRpUE3Y3uAXjYT8MLZ1GyDoMO13Pp9jyD5sYLQcrGI018
 89J2uuJ9yxZ4+lKlQNdVSdxInIeJyZ/JYhqXNbqq48dUkz/C9qhP0NcJ2VQ8qad1d++jHUgxf
 /5Bi4s/UEBJr2HJk9HJlepErW514ERxuZOW5YEYDcalPwD0acEfL8a/c92Z5RlaW/l4tn6kcn
 89UTYAMST0yMBXzplxfTdf/mR+srhQ1gZNUlZ1bQSua+uHvMDwahCTiAte4iStEFblqglTk5G
 dyX3qMTrLRmhjnsTasXVP70hTFLwnmPJJzICQxeeJJxATcRl9s+QVqYhD15GLY6Y/jfweCjMj
 tgcjq977Mw2CUFAWPco8CG/CWxdacFiZjVsI+gd8UCPHHsEhahlfHQDemWrBve8UZWa0GIZS+
 Pklxl6Z2nNEfAZybvTFtji57bmokfFeBsGSUCpPCxs9Kp7HivBvrQFiKLKYOHAasgivYFH5T6
 z7gcnUA8TOB+od+sNKLGULdQJZVOgqtiOy/NO0UqOfB/DOmNSjE+eVEkQUOMEkN8/H9KJ/ubK
 vw3eQK2FfiP9IKKAyVY2QhJ1fnMpE48j6j0E0SjUVtqfyGEufpeiwBow6a8QVKpYRiGCS7qJR
 vzYbdC81vjQqZR3h1
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/09 01:17:21
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

A few late fixes for target-hppa:

* Fix the SeaBIOS-hppa firmware build with gcc-10 on Debian

* Fix the SeaBIOS-hppa firmware to boot NetBSD again

* Fix many artist framebuffer out-of-bounds accesses as found by Alexander=
 Bulekov

* Fix artist memory access bugs due to commit 5d971f9e6725 ("memory: Rever=
t
  "memory: accept mismatching sizes in memory_region_access_valid")

* Fix various artist screen updates when running dtwm on HP-UX

In addition the SeaBIOS-hppa firmware now includes a version check to prev=
ent
starting when it's incompatible to the emulated qemu hardware.

The patchset can be pulled from
https://github.com/hdeller/qemu-hppa.git target-hppa

Helge

=2D---------------------------------------------------------------
Changes to v3:
* Fix memory fallouts due to commit 5d971f9e6725
* Fix graphic rendering bugs and screen refreshes with dtwm on HP-UX

Changes to v2:
* added more Acks by Richard Henderson
* added more artist framebuffer out-of-bounds fixes by
  Philippe Mathieu-Daud=C3=A9 which were reported by Alexander Bulekov
* fix NetBSD boot

Changes to v1:
* added Ack by Richard Henderson for the first patch
* revised out of bounds check based on Richards feedback

Helge Deller (7):
  hw/hppa: Sync hppa_hardware.h file with SeaBIOS sources
  seabios-hppa: Update to SeaBIOS hppa version 1
  hw/hppa: Implement proper SeaBIOS version check
  hw/hppa/lasi: Don't abort on invalid IMR value
  Revert "hw/display/artist: Avoid drawing line when nothing to display"
  hw/display/artist: Prevent out of VRAM buffer accesses
  hw/display/artist: Unbreak size mismatch memory accesses

Philippe Mathieu-Daud=C3=A9 (2):
  hw/display/artist: Check offset in draw_line to avoid buffer over-run
  hw/display/artist: Refactor artist_rop8() to avoid buffer over-run

Sven Schnelle (3):
  hw/display/artist.c: fix out of bounds check
  hw/display/artist: Fix invalidation of lines in artist_draw_line()
  hw/display/artist: Fix invalidation of lines near screen border

 hw/display/artist.c       | 179 +++++++++++++++++++++++---------------
 hw/hppa/hppa_hardware.h   |   6 ++
 hw/hppa/lasi.c            |   9 +-
 hw/hppa/machine.c         |  22 +++++
 pc-bios/hppa-firmware.img | Bin 766136 -> 783192 bytes
 roms/seabios-hppa         |   2 +-
 6 files changed, 143 insertions(+), 75 deletions(-)

=2D-
2.21.3


