Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F259C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66DBD2072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66DBD2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopMn-0003xT-1R
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iootG-0001Jg-3z
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:27:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iootE-0003MM-Sz
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:27:21 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:57757)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iootE-0003LV-Jr
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:27:20 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MtwEO-1jgeWv2Npc-00uEe7; Tue, 07 Jan 2020 14:27:17 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] Q800 for 5.0 patches
Date: Tue,  7 Jan 2020 14:27:11 +0100
Message-Id: <20200107132715.722101-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dVLW7cis/7zDypaYSsSzqyh2fjmGDcbwV5fgeMe8RMfAmKnZaoG
 kM+OtDTkgQcRvnK2c1J2jx5k1FxBxD/5Dxu4r+m0hYlex6JvpMAUnc8KbYbbpsViYF6/Gdd
 etlh4ivOuI4mejLEzoC0stSTTkcies+lYi/aLXDzaV5arQ291kXPUAr6kEUZfgERe504LgX
 PBik9RfYNRFFJ4OWSAvuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q1/QsfLiaTs=:7i4IvCW2+zgnJkoA5R0hwy
 AM8aFUM7iBdEeogrQ1z+spgWVreYqb46BEGRrMXa8nY8T703AE9z1AcN3+Quwvthm2bkCKQPm
 /paWdYU+hd68j0NitTaZY/2PwBILbJQoqbjHbIF9X1F9aoiQuys2HlZE/tYNRXikrxDQDccK/
 xumn42r1bENq8K/HoUsXJmlWVlbT9ojCIdxKJKF/wcendBiQEWuoW3nTfGDDOnkZLJw4ZPats
 eNEvHGJl03aYFYUR8pGoG5gAnqr68ZhtABhv4S+IuH7kZiyjJVHmn8IEZg7OMXfOvVhiAdxOZ
 Ak6hAWA7QaMNJ6vuA/qf2u1+nAkVh8gSku87YqDGQO94IxMrrsyzY9X1CVWpJE84WSgcigMHp
 EqPCB0LSugIcW+2y5PuMMF9fDaiukkoRG+kQjdu28l9JWkX6Cz+5NBXZrwXfr/PeFaLWyIJNQ
 4cPysTeuZB49nKN9FkULT+afgM9KhGeyrtVyVUrZUlsTdwhwsf427njgEYerAq/XwaHAoBcY4
 BVbj+QvjV6VnNm2lSV9D4lnKQk1VHGhRoTprJLVQVmSNZpuC/22kRVmDidZPo0gNwcTNpB70Q
 shhpDz4cPfte+rzePqYZa1s1qKIKUuMRM1uUVAQfJDWj94NIb21faoQAejY4+TVnKn88dL+E5
 /Em65XauimihDWZ0fGDcP2PobwAxzuJKyXWxb9ZeUW44G2zmY0MH4p4cXZGUHEbW4sbSzq/dc
 H3bTHfODXoEZgPE8aYPQEa1m/8HXAHvuciz48dRsrHMl4wQ/x4AeakxGtWejg/zaZJB/giRpE
 ixFl8ttRlKYNfqSmlvUSQL7yWPhG3TnQ773IGuBnG/LKbsVMz6zacUU2l9fxyR/fwHbi22KaJ
 XRAerUci055QcYgYMbkQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.130
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit cdbc5c51c8755e4e9ce964fc92ba755e1c71a914:

  Merge remote-tracking branch 'remotes/xtensa/tags/20200106-xtensa' into staging (2020-01-07 10:31:07 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/q800-for-5.0-pull-request

for you to fetch changes up to 18b6102e51bb317d25ee61b49b7b56702b79560c:

  target/m68k: only change valid bits in CACR (2020-01-07 14:21:18 +0100)

----------------------------------------------------------------
m68k: fix CACR valid bits
q800: add a fake mac rom reset (used by linux)
      fix and improve PRAM emulation

----------------------------------------------------------------

Jason A. Donenfeld (1):
  q800: implement mac rom reset function for BIOS-less mode

Laurent Vivier (3):
  q800: fix mac_via RTC PRAM commands
  q800: add a block backend to the PRAM
  target/m68k: only change valid bits in CACR

 hw/m68k/q800.c            |  35 +++-
 hw/misc/mac_via.c         | 339 ++++++++++++++++++++++++++++----------
 hw/misc/trace-events      |  19 +++
 include/hw/misc/mac_via.h |   3 +
 target/m68k/cpu.c         |  28 +++-
 target/m68k/cpu.h         |   5 +-
 target/m68k/helper.c      |  12 +-
 7 files changed, 348 insertions(+), 93 deletions(-)

-- 
2.24.1


