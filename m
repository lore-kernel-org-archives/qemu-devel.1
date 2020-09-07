Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC73AC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9226F2078E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9226F2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDIS-00071J-Ng
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kFDHk-0005UY-1T
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:18:00 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kFDHi-0002ac-89
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:17:59 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M9qYn-1k9QWt2z0n-005tk9; Mon, 07 Sep 2020 11:17:54 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] Linux user for 5.2 patches
Date: Mon,  7 Sep 2020 11:17:43 +0200
Message-Id: <20200907091748.376101-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hj3MT7MAzht1F5liPIVcMtPMQM2G9Fs85vhr1eXiN4l+5KoFasS
 wmGRnqziuCcS5g22m7HwZCUTrtr1/NALHpmjhW2lN6R0s+3yhPzDfSmnqcABlRFHWI/0jH8
 ank2ZGlo3JcgUJl54VSjPUqiDMe/dZL0e0G0SZ2CSlbSp+d8+zPPfaCSGFRlUy5a4dEq3s5
 inuL3YZdttWDWKZtUTKMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oQq8JiKNZ2c=:czlGsn3R5RWuB9ynR+aaba
 CtPbLv9fbo2suVxXLzdCYJ2l/pmjZEJ17a5j940p/Lm2dsdR/rVCnEMxXkL43rrWtGykF/gAW
 EjO/7zHsJCjuvEwBCSnXsGanAg85tVny1VROm6/s4KCkEL6zo+z7C3jtOSDXarRMDULU24rGH
 8P33gZg91CGFQmFLNBrifLgXpQce/6Cnk0tG1CGMxov2DXuYyJYI5LoGAy+e9lAl6kJsLQQ8V
 I0VeSas0StSHuDwn3PEZdJGxePh1x+daxpRo+hxHV/lk+3woC0fk6TUbCxulh8SegR5OomOUU
 PMa11D4d5c+UU+X1RwTeCMP7lQYAzkNY6e2ELDDkxLTrBsEmGHl1zslgIbJMIysn3YE79Hr7l
 MRnu7S4x4fPHN4Z3NbrG1P5MiFNVNEZZDgbrW5h9EZZECQSVXSMmtJjPWKhxbmtXVbbr+FzNz
 eGAvwLYDpbbk9FDLMGQMUEiIKGTjB6INqFLXhUu/28a0T8HTFZv2z4ukOkjOkBbJ4qs0OiJhw
 Bn4r6B5HWN1HpQfSKna0h+MMQ9FPiuB8j9qu5VlEQn8p/jjKJAoAWuiPQ3SafYndaAdI/GDc5
 fWpFcnJQsk+53teqTgXX6q/be9TZ7ma0p9gUDZEJOPShwDuuwKZL6NdPzyPx2VZvJa3ZOp0zI
 lJMFJtLkmN4zR4R6f98TUiJqVh9TM/mr1qyFJi3xND9YYOjPmfXaCp5lAKObxtSIwyzJjVNR1
 ZUjQPIkuGkD5vjnLgWRhSxJQnSz8V/OzMtd7jU18HegRwmlnii8RSUJDw1KsPxc7Y9PHXz+1V
 yX0lK6Trj2Ka4fWzbdjeo1Rns0LzEjU076Kn+/XbV6NAEmSNtev/xrgjBoxQPokmrJD+opa
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 05:17:55
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

The following changes since commit 8ca019b9c9ff916414371dd13d265bbab308b14a=
:=0D
=0D
  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-09-03' i=
nt=3D=0D
o staging (2020-09-04 23:24:03 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/linux-user-for-5.2-pull-request=0D
=0D
for you to fetch changes up to 5d5d17522f59696d18fdbc51984c7b4ebf191f7c:=0D
=0D
  linux-user: Protect btrfs ioctl target definitions (2020-09-06 12:29:19 +=
02=3D=0D
00)=0D
=0D
----------------------------------------------------------------=0D
Add ppoll_time64() and pselect6_time64()=0D
Some fixes for for elfload, fcntl, termbits and btrfs=0D
=0D
----------------------------------------------------------------=0D
=0D
Filip Bozuta (2):=0D
  linux-user: Add support for ppoll_time64() and pselect6_time64()=0D
  linux-user: Protect btrfs ioctl target definitions=0D
=0D
Laurent Vivier (1):=0D
  linux-user: fix ppc/termbits.h=0D
=0D
Timothy Baldwin (2):=0D
  linux-user: Correctly start brk after executable=0D
  linux-user: Map signal numbers in fcntl=0D
=0D
 linux-user/elfload.c      |   7 +-=0D
 linux-user/ppc/termbits.h |   2 +-=0D
 linux-user/syscall.c      | 470 +++++++++++++++++++++-----------------=0D
 linux-user/syscall_defs.h |   2 +=0D
 4 files changed, 264 insertions(+), 217 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

