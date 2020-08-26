Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6F2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22CD520737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Jg6dOLS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CD520737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB2od-0001ra-32
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 17:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k4-0008NE-Ox
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:48409)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2jz-0002Ti-3h
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598476427;
 bh=iKjSkTPk4LGcfEZjkk0WTAuoJDQbRPyjoY5LLiMiZA8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=Jg6dOLS2LbCPln23sRxXcBdPj4PZ0aT22iPD6RPhu4xpFUQknRYJIcfE7h1QkRTWG
 FSOSSwJ2FsvpBSPHWR95NC8WBXUD831o98PbtfR7BwM7OfTph3P8r758rs/X/ecIR0
 ItY96HqNCzrqq2lceCVmpJ9oAiVDnTfQVHrW9cSs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.186.77]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXtY-1k2D4E3jBQ-00QT8d; Wed, 26
 Aug 2020 23:13:47 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v5 00/12] The following changes since commit
 3461487523b897d324e8d91f3fd20ed55f849544:
Date: Wed, 26 Aug 2020 23:13:33 +0200
Message-Id: <20200826211345.14295-1-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9KmOppvphL87rO/JT6AxFILZp2u85BeB3MtRI+I8I6WerRybOR+
 lgqVQL2IhamWyQzsChTfyWWDtx4GYKUoYAYHvKz7DAEvPpDTHU0hKxjPHW+WTDu0dH+I+2b
 m6l1JLfbdj3Qlipztc/8Dmgbe7OMMtMEUpvM+0RfyFnyReSPXRk+jYvxwwYvsLtiG3L83XB
 ATZ6DaSRwjpuU+LzcHC5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VszkhQfOxhA=:gvdr2eZmb59VZS6NuJEauo
 7KX3o02SqF4Zk13oAvIXvKp6UO2u8ppQsAjA4DGYJzJTHNJaXKBcALkedBdQp6HUFuvXudC4s
 dfPb3v/lEDIjJH3q956ppCmD1hLTlPxFW5kVHYceDZsbzYJGA9PefIKjGyUfWtUNr8mRAUSDg
 8oIC0YoeWvt2fPBUh3+vYkSlj2PC8uyff9kws9G/5J/8kDaBNlq34OLpKrJihiVHeWmYF43p4
 4AvP40d4f2tUn5KNDylbCLUDWIgb5/4BwsmzRjpq/nKTo/etiWzBaGecPFlgVRZVprrd4BtUb
 W6eXAb4lXETNhkUBo+fZgBWs4nkHFw3RQ3TyEPvIjamDAkkGw+HtLBsP7WkRUOFAQ0wIfNXRm
 IIjTtIgVS6lgqQ1xLGr8fOp3dpF86firXk3tvdnq+IbzvIxM4S4ePRH/QUr0S795z+ay5tdUm
 RwNeanR1LqAb+9XK+x8UF4+GgTcJE7dtpIX3iggpDlzGqmMBGAgS99sinzo9pS3ioOinorYMc
 irCL2+KwLYgax+ACCaxNcDYytpQk4VFVAyxlbDh9Ppb0X9kFtLHQVPwx8dIatu6ynLHzsDQTs
 hPu8VerHaQwvHknr2VMS3/xJLoUDd5UQI4Qaa4OuudjtVc/8kqZMdX/LDZCkhX3AqN+zDd9xr
 Ub6ZDRcuO5+GWMiXDsgzeSdCiGrysd8gxghBiAA9C5ck43tnSRsv017fvYkj6up1cKmjAFRGg
 /xIMhTs2+Uc6lMaWd9nDjuWouYY+FApk+8grdkWxCyir1IECU9Q6zr2BOyMRoWd0WF/fAMwIr
 D/JKz7nVdqCrOUMAtQ5G93r0iDSHi1U1YO4T7ibjthEDst5Zt1z6u3phTsE7zVqj4KxPBcKOM
 wOnOoNLcirw78v+cJ82nttIc4pvxOmNC/In9byEodXBIczB2SJxh97wEC3PsQ0k12FR1+w7j2
 Sb26yV41JHchW62A9KWRPNjYWumZsbj/hxhY4XZ+3FVxrNVxFJPsh3toUJB0R+fCISPTNedqE
 nLdqiAjY/l+l7nCsQYTFXJ9dULErPRMQexKhx5rK4eHj9OWNZ8iaXT/EBbKDnq/U5VJm/b0OS
 J0QbDdXiLe709teSmCDJY9scA96eMNTZKC4YVGiAdnT1A6QRF52rK4KBwuZYJ4nrjhPJt3fqy
 il3nN3sfBwHsRcCf9w5zIQR3frRa75F5f33Jd5TqNV0vW6O4ZtKGu7IONd7yKAbP61nS22xv0
 s+QFWhUOOhNZ8Mbk8
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 17:13:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-2020=
0727' into staging (2020-07-28 18:43:48 +0100)

are available in the Git repository at:

  git@github.com:hdeller/qemu-hppa.git tags/target-hppa-v3-pull-request

for you to fetch changes up to 2f8cd515477edab1cbf38ecbdbfa2cac13ce1550:

  hw/display/artist: Fix invalidation of lines near screen border (2020-08=
-26 23:04:00 +0200)

=2D---------------------------------------------------------------
artist out of bounds fixes

=2D---------------------------------------------------------------
Helge Deller (7):
      hw/hppa: Sync hppa_hardware.h file with SeaBIOS sources
      seabios-hppa: Update to SeaBIOS hppa version 1
      hw/hppa: Implement proper SeaBIOS version check
      hw/hppa/lasi: Don't abort on invalid IMR value
      Revert "hw/display/artist: Avoid drawing line when nothing to displa=
y"
      hw/display/artist: Prevent out of VRAM buffer accesses
      hw/display/artist: Unbreak size mismatch memory accesses

Philippe Mathieu-Daud=C3=A9 (2):
      hw/display/artist: Check offset in draw_line to avoid buffer over-ru=
n
      hw/display/artist: Refactor artist_rop8() to avoid buffer over-run

Sven Schnelle (3):
      hw/display/artist.c: fix out of bounds check
      hw/display/artist: Fix invalidation of lines in artist_draw_line()
      hw/display/artist: Fix invalidation of lines near screen border

 hw/display/artist.c       | 186 ++++++++++++++++++++++++++++-------------=
-----
 hw/hppa/hppa_hardware.h   |   6 ++
 hw/hppa/lasi.c            |  10 ++-
 hw/hppa/machine.c         |  22 ++++++
 pc-bios/hppa-firmware.img | Bin 766136 -> 783192 bytes
 roms/seabios-hppa         |   2 +-
 6 files changed, 149 insertions(+), 77 deletions(-)
=2D------------

target-hppa fixes v4

A few fixes for target-hppa:

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
* Fix format string error in lasi on Win32
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

 hw/display/artist.c       | 186 +++++++++++++++++++++++---------------
 hw/hppa/hppa_hardware.h   |   6 ++
 hw/hppa/lasi.c            |  10 +-
 hw/hppa/machine.c         |  22 +++++
 pc-bios/hppa-firmware.img | Bin 766136 -> 783192 bytes
 roms/seabios-hppa         |   2 +-
 6 files changed, 149 insertions(+), 77 deletions(-)

=2D-
2.21.3


