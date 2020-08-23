Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B51C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 15:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C238D20724
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 15:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C238D20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9rTY-0006Kz-0E
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 11:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k9rSp-0004pt-64
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 10:59:19 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:37717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k9rSn-0006de-D6
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 10:59:18 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MGyl3-1kMqAb2NKF-00E9bb; Sun, 23 Aug 2020 16:59:14 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] Linux user for 5.2 patches
Date: Sun, 23 Aug 2020 16:59:06 +0200
Message-Id: <20200823145912.1171738-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UfAKPrbmwVw2ZPfXHiunNMVXhBhAMJnMGRB27sZX9o7MoaSmx8z
 hTxQVweUAcrFVhn872tT6Ef9kS407d/L0CzyFrOAQ0tIPDmPnZY57dkYSZLHIww4JhZNtVs
 gecnPGpqZeKfzXMoI/PKk+vHe47qJSVpehfhqZIqRiVDvAHs2orLofT/hh1b7R8bak8vjOf
 YuhquKZEIspLZ/FpcSTrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YX+7VyBlr6g=:dU+NYvwX2ro/axRO+bDj8X
 Qfp94FIWHffklxa/2VgFnq6hCeb37s/5kfKRpRbov8qmmLIUU8hRS4TQcZaC3tyOmvU/TyPBA
 AWYH7NF5oCFP+GDb+ht2ElxNGHBR0hTTPIpi7bAqNuR+DghGOm1ISnVvWivFUTFtcx0D3NXe0
 KkSMY7oaStVg6IvQCLPN655w+goTtsBhDbHRmtjYb8kq3HypaYFt/jpKdo/sFRUMrBtfO1zcj
 0KnfocUzTiyckrpMNA47aHeB3gfw8WOuTPGZrt5LBHHpmpaB+/d+nR7wA/PBIjMFi/HZB2dLl
 E1IC1HkUcx3zndWicGkc8UtSjfmCbWTWsoGKncCPjEfhEA4wRoeihZLu58vwj8MHJ1pj3+c0E
 WPTCcvgHPgiFjZ3wWVyeaDT7YqmzAq4OOimPhf3LqV0XZK4t6BZo7fFM+GkQ8nwt9hAVYAwT8
 zpPYG6qB65CJfLEwtop3Tqy5dibTomygsvB3V9pmDpGZLClcoAQWESHLcH1svZbVX9K1/83Wb
 ZRpbt2D2YvYUHk+/rtQkDnQrVLkcA6nk2Q7lqqoskHVZSvCRnDJQWAHq3siXONSJa7zmI8emM
 IjNFGaMcl9jGtOO/2K1BhrOFPXmOMBLrYdFiWnsTGKLcPSUGs9dap7bczHoM5+8neKV2MeaFp
 /KQsAUrdwipFjbcKITyAK1cI+sxxRNiAkiB9YK+utpc715LkYKHpoM6TphOEUGXESmejv/h7F
 bpcasM2l2mYGWjoNEWpMCzX7WDZhInLYmPxkH0hHIuMzv4juvX7p96RfGT75MY51VlAdyuQX+
 ICn4DNgdtcPMrGYWycDvOsEM/WzrCtHpt4ILPWQ/PApIdWR+HKuSgXl8p9xnZclr4eKcVRD
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 10:59:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d7df0ceee0fd2e512cd214a9074ebeeb40da3099=
:=0D
=0D
  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sd-next-20200821=
' =3D=0D
into staging (2020-08-22 23:53:08 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/linux-user-for-5.2-pull-request=0D
=0D
for you to fetch changes up to b3a3af70c377a3e67d43f3be39a333228487b50c:=0D
=0D
  linux-user: Fix 'utimensat()' implementation (2020-08-23 16:57:58 +0200)=
=0D
=0D
----------------------------------------------------------------=0D
Add clock_getres_time64, timer_gettime64, timer_settime64,=0D
    timerfd_gettime64, timerfd_settime64=0D
Some fixes (page protection, print_fdset, timerspec, itimerspec)=0D
=0D
----------------------------------------------------------------=0D
=0D
Filip Bozuta (4):=0D
  linux-user: Fix "print_fdset()" in "strace.c" to not print ", " after=0D
    last value=0D
  linux-user: Modify 'target_to_host/host_to_target_itimerspec()'=0D
  linux-user: Add support for a group of 2038 safe syscalls=0D
  linux-user: Fix 'utimensat()' implementation=0D
=0D
Richard Henderson (2):=0D
  linux-user: Validate mmap/mprotect prot value=0D
  linux-user: Adjust guest page protection for the host=0D
=0D
 linux-user/mmap.c         | 110 +++++++++++++++-------=0D
 linux-user/strace.c       |   8 +-=0D
 linux-user/syscall.c      | 190 ++++++++++++++++++++++++++++++++------=0D
 linux-user/syscall_defs.h |   5 +=0D
 4 files changed, 250 insertions(+), 63 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

