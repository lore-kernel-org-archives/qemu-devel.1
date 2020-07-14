Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B04C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E386F204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E386F204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvFS0-00031N-0g
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 03:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jvFR6-0001UL-AH
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:33:08 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:34949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jvFR4-00024J-ML
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:33:08 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N5n3t-1kxOOp2VdT-017Dp6; Tue, 14 Jul 2020 09:33:04 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] Linux user for 5.1 patches
Date: Tue, 14 Jul 2020 09:32:52 +0200
Message-Id: <20200714073259.1464675-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8iARLibwnOCE2IzWJI8+pfFK4u0ofKleuS1wcagtTaXyftRsIcI
 1sM3lKCXIwRkP90vZGs3Rnah2GhzEuZiwTwRviWY28FsqO5kEDSaqZHnIPLxoNcOM9LWmFu
 YaBZe7mdOjfL758jP/8izK8638e7yc5Ik8HzGi85HRIrjsalIsXJkG5VnEPVia/3v52IVWi
 TG4lFmeBP6dUK1u+Dj19A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y7+Zg01Ds8k=:k+tD5dZXa2dSrlk93lbD33
 VveughvIx5gPSFabPiO+wPBqkW5g1GR1EdpacXCBhnLoyIE0vY9JkDwPEQED7X5iZCklefN6d
 NbvvkbHAeFc/IH0D1TnZsWXiE3vb5W1Pmc7/1BD1vF5Wi/fqmt35beIsdSYhMuZbzvufmBGBp
 eNxYU91LMa5v3ACqYxgM14n41tx9Zd9j6TRU0H1OUT08ft6d9NsmHKiC1cv5lPTp5h1miet5w
 A2PASwrj4so8MqNz4rk9VJCIvqSX8oGuo9NagOP30Je0AQotfNhu4DffP55bKYo+8/0rRuOb3
 QenS4Fp/4S2ktu44cRtMxf4tDCBH22yRHMj5O/rJG90sCpfhCq1F6o7lbYGnfwz4npwT/ufD9
 0ujirEvPPM5N06au3HE2emF9kksXmY/bTi84JjVk+CojVfHLJkQYcxYKhCvnM9AIro3cHgs9w
 5AUcv9GHfB/ZSLSX2eDBkvXJgD/xLM35s9gvr4IiT/7+0t2G4XzDEaPp9m88rZe/2vIeg74+z
 Hy/P4WQyGkZ+sGpExLJwNLPBANrSOyNAcpLOpo7z8wGuOWSecsUJtFawJxDnMpUCtQxdIh8mn
 B5znmuZxZcC2L1+aQEppY+uEqw7KklDToxl+30YSYRBtEYRpf0ZfPgMALr3r6ZibLq8tEqg1D
 5Gwf88ws73hhn2xIDGR0r7xD31mVqWR0QndTknxoB4tBtKOM0+krSZh6051vRGbDQT0Nh28QV
 rfrJEcR13UiyipnuGPvnViMoJaFtczDhd3pfUEs/Blyh87Zf9lKOx+DbPRhcN+Wg2eEDJUaAo
 hE1V0oaA2Q5QyoncLwjtrDr4yF3zAK5sQ+Im1IVtZqvCQxknaITc85wfpBTVV24jbbftgTV
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:33:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

The following changes since commit 5c65b1f135ff09d24827fa3a17e56a4f8a032cd5=
:=0D
=0D
  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200=
713' into staging (2020-07-13 15:14:48 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/linux-user-for-5.1-pull-request=0D
=0D
for you to fetch changes up to 42b16184d016d48d167229a1ddb89b3671c77440:=0D
=0D
  linux-user: fix print_syscall_err() when syscall returned value is negati=
ve (2020-07-14 09:29:14 +0200)=0D
=0D
----------------------------------------------------------------=0D
linux-user branch 20200714=0D
=0D
Fix strace errno management=0D
Fix Coverity erros in ioctl straces=0D
Fix some netlinks errors=0D
Fix semtimedop=0D
=0D
----------------------------------------------------------------=0D
=0D
Josh Kunz (1):=0D
  linux-user: Use EPROTONOSUPPORT for unimplemented netlink protocols=0D
=0D
Laurent Vivier (5):=0D
  linux-user: Fix Coverity CID 1430271 / CID 1430272=0D
  linux-user: add new netlink types=0D
  linux-user: add netlink RTM_SETLINK command=0D
  linux-user: fix the errno value in print_syscall_err()=0D
  linux-user: fix print_syscall_err() when syscall returned value is=0D
    negative=0D
=0D
Matus Kysel (1):=0D
  linux-user: refactor ipc syscall and support of semtimedop syscall=0D
=0D
 linux-user/fd-trans.c |  5 +++=0D
 linux-user/strace.c   | 52 +++++++++++++-------------=0D
 linux-user/syscall.c  | 86 +++++++++++++++++++++++++++++++++++++++----=0D
 3 files changed, 108 insertions(+), 35 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

