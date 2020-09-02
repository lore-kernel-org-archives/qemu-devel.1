Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073F8C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:27:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF3B20758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF3B20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDcAS-00050r-1K
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kDc9k-0003pM-Ra
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 19:27:08 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:54179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kDc9i-0004qR-Gm
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 19:27:08 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MF39S-1kKBkF2I00-00FWdU; Thu, 03 Sep 2020 01:27:03 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] Linux user for 5.2 patches
Date: Thu,  3 Sep 2020 01:26:52 +0200
Message-Id: <20200902232701.13299-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2pjEquMmmsWlBNvpoJOCrFYc43yWRmaHcIirFyDXXG+04LfXj0I
 E/xx8Jugui+jkoKgGP76P+YNUUZiZyQMiCYhVfsSfR3mrAr40SMpmdNaEkFgd81VtFcalqj
 6HXCYjIeg9f2/+EGSoGbq8g/0Wah6NfUcEnUCGDuAgV9wGfdbCii5gfaKpVHVsQkaqWlKDy
 PVSRztP39TfgUgFiM2bmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ihP82OEoS/M=:p0fpX+B35WwQsvFLKE+eJD
 fCVw4Lp+8pQozehG4fsk8UDismZNrpopaA5P2TZMAh1LvzlSgrOs2+YGcc2OdRpEgMqwqsxLK
 Px3WYx3an2ZFf4uMTAka23HcPWXNC0U7tMmm5DJaxSqGuzby6nMgTIxb9ZrrmwjB197/MIeV8
 IHh4ewVnDjfQyZAEmZdFqdpTGJ5Lp+Ts+TehHKBYKuLKLZXxjhPeMUyfLwUFUXwNwogtCJ9oX
 tsjyp7Y5cD3gQHz1GlqTZYEayP4ETEt3YqwCyaj5vq7g56bGoF3c7AVYjvdSvOpL3exqGes1K
 MtgW2jfSNwA+M99uCxgKDvnnRmFX3ISPEdAIq4CHVZ+JWZMlkGqnlkHN9LyXj9qDT7iZIKl+l
 g6uCDVxZxjLQtjX2qtp995hFlVGslReIIN3wyI5wPsmzrezQFzgri0EJfhw1A/s71h/APrT0G
 aPkWBDJ3osxYWfd/Eqiuj+752ALWbmad1y3YasTW+8wms9h75DKQj1yvB7id45H/rUfE1s4/l
 ev5PeCL5zJ6d5mrZb7v22AtOGnlqLuT4KsTIap3jB6d5DhbOLtb/w0BUGUPqVGCYsJT7+fMA8
 NysEeP9pkbPwQAvlYAumEC88h1zsQf9e4eQO9Jk7ahp1H9bZxtoHicZyIEJ+gTxuiu/f3LHID
 KW9pVqxREJqKwUk4JEsv+mbkffqft/GJYUKdHAEywMFNHdMX/1xmk4TDtEmoBYXlPPUDf1T8W
 QXpODq4IZPUDZXgnMMKGR50hCHqQgelHza8a7WYfPjE/hSd8re1mRiks93wA0efgwL9EoNxzf
 UjAR9Gp7VxzvFmlQJcKg32KZB61iThLom4rTsyai+in9vPcO7xppJb0spVihM6oTiMlBfry
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 19:27:04
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

The following changes since commit 887adde81d1f1f3897f1688d37ec6851b4fdad86=
:=0D
=0D
  Merge remote-tracking branch 'remotes/bonzini-gitlab/tags/for-upstream' i=
nt=3D=0D
o staging (2020-09-01 22:50:23 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/linux-user-for-5.2-pull-request=0D
=0D
for you to fetch changes up to 9a5a5a05523651d4c887388a6e0d0e446ffb279d:=0D
=0D
  linux-user: Add support for btrfs ioctls used to scrub a filesystem (2020=
-0=3D=0D
9-03 01:09:35 +0200)=0D
=0D
----------------------------------------------------------------=0D
Add btrfs support=0D
Fix MK_ARRAY()=0D
=0D
----------------------------------------------------------------=0D
=0D
Filip Bozuta (8):=0D
  linux-user: Add support for a group of btrfs ioctls used for=0D
    subvolumes=0D
  linux-user: Add support for a group of btrfs ioctls used for snapshots=0D
  linux-user: Add support for btrfs ioctls used to manipulate with=0D
    devices=0D
  linux-user: Add support for btrfs ioctls used to get/set features=0D
  linux-user: Add support for a group of btrfs inode ioctls=0D
  linux-user: Add support for two btrfs ioctls used for subvolume=0D
  linux-user: Add support for btrfs ioctls used to manage quota=0D
  linux-user: Add support for btrfs ioctls used to scrub a filesystem=0D
=0D
Laurent Vivier (1):=0D
  linux-user: fix implicit conversion from enumeration type error=0D
=0D
 configure                  |   9 ++=0D
 include/exec/user/thunk.h  |   2 +-=0D
 linux-user/ioctls.h        | 124 ++++++++++++++++++++++++++++=0D
 linux-user/syscall.c       |   3 +=0D
 linux-user/syscall_defs.h  |  37 +++++++++=0D
 linux-user/syscall_types.h | 163 +++++++++++++++++++++++++++++++++++++=0D
 6 files changed, 337 insertions(+), 1 deletion(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

