Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF32C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D956A20781
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D956A20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1Af-0005UG-3f
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr17U-0000RR-NB
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:27:24 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:54173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr17R-0006IC-82
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:27:24 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MrPyJ-1j3bYG3rrb-00oSfu; Thu, 02 Jul 2020 17:27:12 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/12] Linux user for 5.1 patches
Date: Thu,  2 Jul 2020 17:26:58 +0200
Message-Id: <20200702152710.84602-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QXIV01cwCKn3L4sWhzPTn4vg9jKER70zdQx39UEbfg78t5c53yj
 eu8NmulDVGuE+9fYZefK1VW1BL6rvPC0XO5SBsQ1mG0OMuVm1HmWADJ7f4WiMv1N4chhIsl
 vgD365D1Dcbj/tk7+NwQJNmBuZegf7IfpKR3iGtNmF98pTO5HpXqqI4j3mdQEZR6H4Tb4Ty
 +d1tYYgqYgQFuZ6U6TG2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jC9KjWXEuLk=:UySvZaqej4GITxVfTiGpdo
 1jZOw4pg7jQAdLtNbVq3YOe7HP9n5U0q+z4n1nAU8zRAW8hPus0bwBktehKEyFa132PacAd53
 2FZNOsPufr2dslFbKchAk64rB84uqun043d0G76AnfW5bqEHxsWT6ZkkZBK+d/xgzojH9CKaL
 yvJmcxx1agHchd3Y/X0OUBCoX+tVJUOiDonJWYZZFe2sYLGmgr+BfQ0HiSPZunyP5ClVxW9eg
 lzxHnZi9JYQM58ygVTIDozTyx4m64bm5CHtoTCFiNg17ZFnxmQBhlkykTpmANEHa6hfSNSCty
 LRE+FhkrcViIeA5rEPtmOSw6kvje+iuc5MAhzls4WNw8HbS76p3WSfo9d26YaPOmkK8J9ySix
 7DoImwhZrVUJ0EwHUoCuVLJdh1d4nysYH8hb9lPEeL9UFFpdZbkTKhfSGSqUhsxb5Avr64Ibe
 rDiIE34dS16xMDSOHI4ApRBaZiCQVRlJnPSv9fYPD7ikt35C+uPrSV55Q3huF3Fj7UkTnqYRH
 ldTRNRd5XhMWecGoY93AQqb6/smKZ5/1WWWFGswyri0B1cVIP7UdC8aqejhdI2a3UET8BYzCC
 /8YqKflQT06w6rf74C0CFxwl2jw5IITOs/gAB9j7lZ91GYK46/Tv/8aZ+xi6fyFV8Dmk2PiZS
 wO4HpNczZNhoOmRYLiShU+TyUlUaKXpuoUpeptv+Sx6clCbeEWDY1HAiu0KlepuvAADHTdv6O
 pgVbwStIWlwvfUI5thqgRM7sridi22PWFQaMJYaVTvt7SSBn2WJlLRdGS20e7plDr3vJ3mKDJ
 h3oANb13KHRPNdwpdbBrZpgZbFXm+eE9yqsG+c7vzyZXEKrHV4=
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 11:27:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit e7651153a8801dad6805d450ea8bef9b46c1adf5=
:=0D
=0D
  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-gsoc-queue-jun-=
27-2020' into staging (2020-06-27 22:57:36 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/linux-user-for-5.1-pull-request=0D
=0D
for you to fetch changes up to 89ddeec7f060a9f403aead414bb883a52f2b5024:=0D
=0D
  MAINTAINERS: update linux-user maintainer (2020-07-02 16:55:16 +0200)=0D
=0D
----------------------------------------------------------------=0D
linux-user pull request 2020-07-02=0D
=0D
Update linux-user maintainer=0D
Improve strace output for some syscalls=0D
Display contents of ioctl() parameters=0D
Fix sparc64 flushw operation=0D
=0D
----------------------------------------------------------------=0D
=0D
Chen Gang (1):=0D
  linux-user: syscall: ioctls: support DRM_IOCTL_VERSION=0D
=0D
Filip Bozuta (8):=0D
  linux-user: Extend strace support to enable argument printing after=0D
    syscall execution=0D
  linux-user: Add strace support for a group of syscalls=0D
  linux-user: Add strace support for printing argument of syscalls used=0D
    for extended attributes=0D
  linux-user: Add strace support for printing arguments of lseek()=0D
  linux-user: Add strace support for printing arguments of=0D
    chown()/lchown()=0D
  linux-user: Add strace support for printing arguments of fallocate()=0D
  linux-user: Add thunk argument types for SIOCGSTAMP and SIOCGSTAMPNS=0D
  linux-user: Add strace support for printing arguments of ioctl()=0D
=0D
Giuseppe Musacchio (2):=0D
  target/sparc: Translate flushw opcode=0D
  linux-user/sparc64: Fix the handling of window spill trap=0D
=0D
Riku Voipio (1):=0D
  MAINTAINERS: update linux-user maintainer=0D
=0D
 MAINTAINERS                 |   3 +-=0D
 bsd-user/main.c             |   6 +-=0D
 configure                   |  10 +=0D
 include/exec/user/thunk.h   |   1 +=0D
 linux-user/ioctls.h         |  17 +-=0D
 linux-user/qemu.h           |  40 +++-=0D
 linux-user/sparc/cpu_loop.c |   6 +-=0D
 linux-user/strace.c         | 435 +++++++++++++++++++++++++++++++-----=0D
 linux-user/strace.list      |  40 ++--=0D
 linux-user/syscall.c        | 136 ++++++++---=0D
 linux-user/syscall_defs.h   |  15 ++=0D
 linux-user/syscall_types.h  |  33 +++=0D
 target/sparc/translate.c    |   2 +=0D
 thunk.c                     | 154 +++++++++++++=0D
 14 files changed, 782 insertions(+), 116 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

