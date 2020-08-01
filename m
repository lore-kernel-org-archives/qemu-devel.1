Return-Path: <SRS0=xT3E=BL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5074C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 13:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688C82063A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 13:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="i+qlvSRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688C82063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1rRN-0001l0-EZ
	for qemu-devel@archiver.kernel.org; Sat, 01 Aug 2020 09:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k1rKw-00069a-KH
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 09:14:06 -0400
Received: from mout.gmx.net ([212.227.15.15]:39447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k1rKu-0003u7-SF
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 09:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596287638;
 bh=Mm8qMGwh1dGuddDLAMEqesdKEnu4d3WVPQj5bj5MUkk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=i+qlvSRGXq9MeoSa0WzWqBwfiG393JWq5GCBvwkMbTIuHxDFFd6VcgBIGy9yKug6n
 lHJc3FAIEcT+BDeVoLaxLuqHope8nshwPfXSd0qky/H3Z9iqFrf37Tabch7bvl3VAE
 e/uZCXYniytvUFK+6STV8o4z2QU2Sy2IjLBqw5gI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.162.176]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjjCL-1kUpEz1PgZ-00lCdN; Sat, 01
 Aug 2020 15:13:58 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 0/4] target-hppa fixes
Date: Sat,  1 Aug 2020 15:13:53 +0200
Message-Id: <20200801131357.17379-1-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oTK1HuT2jVLFZlmSW+diTUhN1i/Pe72+wTiPy+2N1JUDWCeQZAa
 qEWFEcULyqn+QZR3GTsWiakCzLEOh9EvbTWUcm6NmdUMnkxrNfCGXjzlPhJ0S1aEcvC2fLb
 8Err7KqrHj9A9EeqZUQWMi4V525gQwQ5grnyIiB1kyXSlptuMVgIaO/SkcQnCipPB47TW4s
 17LFzgWufxPDW/1yOXWEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zSNUCELdGkw=:sopmhn1DS0aZ3erqKf1sGo
 dG0HJzuT1iFIhNvyELvZ3oeQKRBHnUSfwkUqu6AqjdFbJ09zz1lUjGmSpx2S9grc4NxMGb3iB
 Auq3/AgiO7SWcExX0+iBWJEDOl/oKvvrDD3CQzC5l9FA08rqjhNEhn0pWNqYveQ6IZ0NWkVqu
 4cp9PJU196LDC4cBbuDS2tupJ7W2grX5uZEsofOp6bGMJMiJFqq0GErSFdNysgCWqwULGPCb9
 fVHFarlYqt9UP78mIf7AbTbzYXhC9nkxAV23g/yO/wG5emzc5IA/CQUKcAQuZBgmnj2Ns4bAl
 Y3oymIC+SAgwEgX8LYK9x+0dlRA41SI5LMLBln9BZ89x32szXCG27VF7FyvBWBnAy0CElZ6tx
 0ZkDEfgtiSHabLeYrp8ophamTVSQF5dfv+2HOiRO3u7PNtDLYykEN+SodKtE7uusqRJNi/hnn
 YWKiPpc3MVAKqk1RkpR3Xz2X/VvAboixs+I2h0nVpP35Pth6LEmKRRzZvyhdOk6ElLnSkF00l
 cpLwmi7vFMEm7TzBa9s9ukX5sIJD+EhsVdVQMdGBaL5I/8cyFBbXor42BdCtH33TA4Bse/ulM
 t1IusZsKD2BYPinFL4UF6GWlS5/K1CIbUbjYgYFWJAM8OBRIOUUH6/AaDWBW3EVY5Gj49oZRE
 eQFMlqeqJbKVmMMGG9yuDeF5yypXbXUF3L/9I+DZm6ZoMp/jf2/KYCjTZqgyKNWLTzxTipQND
 wFKv6hWD3CavCEMOonoeIel8ggLHT3jICBaoIv7CQtyUga5fdgbmKIlhoCLgveaa5FC7SMZQA
 ZIvfrZRBiuZf8sJR6mY04y/3Uy5Ohc6fPexrXp++kSTq7nUMG1JRoHc92xt3UvDD67S0Dal34
 s9jD8J8pUSqggSsG8Rhk+53K59G4VAvzkkM41LZAs8GvSLZNNjcdEfLVDS2Q2y3VCkphnq1C8
 RDR3DTRq+r7vyFeQZuBcHXQ0Dq8Id1DfYJTxfKBANoC5+LduTUSRNcHi2q0HWQuceh5tdzvum
 gIoPP4576Qzgy2K4sa/NWoFlzKzxczcQAqk15gYDYlVtxl06VDH4mDks5BE6wwtvqJ9d0fL1Z
 XepneK7o15PsUExn+EAZ6PA7trk77z4LZIruO1zyuJDjD1EtccEmYJuC9Okair4kc2RKYim1E
 uptPvEp0AcQV73n5Jx5bvLcCHHGZCZ/Cq8n8gOdb4qFEfzmswcIDaEvxdk44X+PQYGqMspytN
 eUPaz6etz2fY2Hco+
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/01 09:14:03
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

* Fix the following runtime warning with artist framebuffer:
  "write outside bounds: wants 1256x1023, max size 1280x1024"

in addition the SeaBIOS-hppa firmware now includes a version check to prev=
ent
starting when it's incompatible to the emulated qemu hardware.

Helge

=2D---------------------------------------------------------------
Changes to v1:
* added Ack by Richard Henderson for the first patch
* revised out of bounds check based on Richards feedback

=2D---------------------------------------------------------------

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

Helge Deller (3):
  hw/hppa: Sync hppa_hardware.h file with SeaBIOS sources
  seabios-hppa: Update to SeaBIOS hppa version 1
  hw/hppa: Implement proper SeaBIOS version check

Sven Schnelle (1):
  hw/display/artist.c: fix out of bounds check

 hw/display/artist.c       |  24 +++++++++++-------------
 hw/hppa/hppa_hardware.h   |   6 ++++++
 hw/hppa/lasi.c            |   2 --
 hw/hppa/machine.c         |  22 ++++++++++++++++++++++
 pc-bios/hppa-firmware.img | Bin 766136 -> 783144 bytes
 roms/seabios-hppa         |   2 +-
 6 files changed, 40 insertions(+), 16 deletions(-)

=2D-
2.21.3


