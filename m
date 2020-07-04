Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEED8C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:27:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2287206B6
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2287206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrl0W-0007Vd-TJ
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzH-00051n-M3
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:25:59 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:35905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzF-0002NS-Ie
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:25:59 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Ml6du-1kcrvA3sOS-00lVVF; Sat, 04 Jul 2020 18:25:53 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] Linux user for 5.1 patches
Date: Sat,  4 Jul 2020 18:25:33 +0200
Message-Id: <20200704162545.311133-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DyAl4jXY7pcs43sR5xil5cMxatHIJcMNTpbbIMUdN5uXgPOpE/X
 JIvrNAzcSxE4FWpXcVsi5zQoiF1EkxSx81zX+rJGVyx4PAGpa3ymb2uSgNma+IhY72NZ5AW
 90Ir2ZUhUCjEpJJBV8q7e7irZf1ckiE9jqWRPRI32Mt7LJvEt8+CCWqjDcTIELMDRT6aqaT
 BBnnd7i5U8TFV6TbLL/8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6bOnKVBOyTk=:+ahR54q1o07kjkMxGcN+YZ
 qx/9lzuUu3fMSd5Ez5Kz5Kn9e/YpcAvtPvis0jgo/x6GUvDu8skqgaxyi98VSyzmpLqxFTNxu
 c6cL5pZza1x6Cx3w1MQ/eIf4SlCBq/HNXp+90Uc94iSoeEwjkQ6zCa/Oysj1EOZHkaAtx340B
 SMVeNYjplXJa/tAgVmzyrYM8MMr9Iif5p2/KoxyaFYOh7GOxNrqEeTDsq5gLHRKVzmYrXG6Cz
 651B7bniAbf+JzM0hB5fekHeKVF03t68NrXpVay63VV1qkerO5B93qiLdBRoNkRq+iDgwsX06
 kBpOAmmdyoBLsPHI4fFPbyCckcxu1qfUgFnx0OwdnnMvpa+iA0wEFJ05SBptoorcjtjtrIE9x
 PHRMLz4+Jh97uvbdU6IKRBz71zq+qWsQUjkxm2zMdDxGqJn2h1WgR3Ny9aY7QbgQF6BOs01JP
 vUISOpjUvNsS/ZHwTkbHe9UjiW9OJJcPssiL3al0C5B1zc3jc1CGuc35ZzeeRrGL1rUjwxKIC
 WPZvm1y/VD3fi0ceWw998itp0r9xZFXMCARvz3SKMzBibExrPr3FXiMcuaQS2NrseYAd4lH74
 wJMIHe6AE0fOk3lE9yo+IEGga+TDTXyXYX2EM40U545G0zlqpMvJB5TcxxirfnlrMXCgVovyZ
 glxNwFgNytn/A+o7jB9s+r+WTPcdEBYboQfEYGXJ99rZmHvq3/+vY4N4lQsHisMwmlJQhMCjp
 PRpO72C9rP/sY9MXGP1bTHeUzkUU1LvyTwNc+mn2wzXBp0i0ICdUaOSXgAExgnCmvNKevY6Qs
 hX0hrh1Q9evy7i6KGcvVj3TeEBRjtHeNyhVYRlkZPqAi/uOKn0=
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 12:25:54
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
for you to fetch changes up to 8f902c540eccd72086e8f67d977e30e05659783f:=0D
=0D
  MAINTAINERS: update linux-user maintainer (2020-07-04 18:09:29 +0200)=0D
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

