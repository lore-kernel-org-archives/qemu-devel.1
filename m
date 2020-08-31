Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA15EC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8F02054F
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8F02054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kChfX-0008TB-Go
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 07:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kChen-0006rw-J7
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:07:25 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:35781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kChel-0000QP-NS
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:07:25 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N4yJ8-1kbpi10aou-010sl1; Mon, 31 Aug 2020 13:07:21 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] Linux user for 5.2 patches
Date: Mon, 31 Aug 2020 13:07:08 +0200
Message-Id: <20200831110716.536808-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZCkkQ+8a99l2SyMSjuAXJnwbXdqeOanhZ6/FvN6ExlHOOZQuGY+
 iVc+3KuoWmeuhr7GgWl57uB9u48tn3vObU/53NOjjCxS9ze4++r+kB22IDizFxFP4/YfniA
 XDJsuU7faOC03MXV8LpCd+L3JKVmXG3MftpSxNk/GYeV0kGEs6xn/g6Kdh7+ow1GvOokcei
 J8M8rNBqHZKDvJrjST2LQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lTaZAn7tHY4=:uYRK7CheEi+MnCq8jby6HS
 5xTV0rUwsIQxsb+lDmG8BaXh/UNHrKH7D/d4KYFNHfPAO01tVn3eCvnwUdv0oPjegDuynh3V6
 4xejhr33icmpy0wZ7bw86uxKd7TgV/4MnQAK1+96udUeLbIypF0Xv6vzcigBAHugoY0f/tizL
 pKzTzOT8bm7SojWiBI/GE9bbLg/3q+LquBBcGiL2Rw7ZIMg1ez9/gs0EGtbRjX7ODP7xewevQ
 5qMa6KmyVTXF0Z/QZ/El+GNzynIUNbCai4w2rUQxYRju5rANpkQDetOe6XRebUBnzSxMF2nco
 weOho47WwR7t3Ta4x8pA7Oec+UrzfDQh7HZ3fG1LnI3AXzt8YjRYZTyf0lUepV0LfguiciSp2
 5U9QbUreS0HhfYA8hDwU7iZv2/JmHu50DWNHxCWR/G+0Vh8cf422wXdiZAWlK/eVlNsZXkGvU
 ro575J/QXIP8gGFlmE2J42SQJ2ZWdtlczX3yZ61+mCgsWk21ILrYl13/A0Hacglegz+djgcX6
 CfBD+9wagul4NzGYzPk3QL6DVRfn+NX6Oxs+rSxV4r+HZih/sSxKraPCPMDjPManLyMU2PgWS
 lz/Rw4aImXeQZwN+xGF+kQMits0EGq28QtBhe1XAUUzl+hjYBtaqnlW5qyZWG23hBBfD2f1+u
 MqRz5qMhKNx/ttfREnzNeJ8bvBH5NQS4MUpgzxg0n2E2lp01CDNoa3cKD5VdzCaOS35m0xE+N
 7gwudTUpKCC6v6oxmq8WJEAseTvgoppqd3vYZ0eOjLG5ImNl9mDmwQFwqiqju58RC1LC2g5/f
 cRvlhAQQ3kbGETifNgKzsiAu3zKosF9zINgWorzMm9ujGbFopf8kECH1sQkmxtAdNe+IuP8
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 07:07:21
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

The following changes since commit 39335fab59e11cfda9b7cf63929825db2dd3a3e0=
:=0D
=0D
  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.2-pul=
l-=3D=0D
request' into staging (2020-08-28 22:30:11 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/linux-user-for-5.2-pull-request=0D
=0D
for you to fetch changes up to d6676fc62a52e020df32abf927c2e7183781a2e3:=0D
=0D
  linux-user: Add support for btrfs ioctls used to scrub a filesystem (2020=
-0=3D=0D
8-29 10:14:52 +0200)=0D
=0D
----------------------------------------------------------------=0D
Add btrfs support=0D
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
 configure                  |   9 ++=0D
 linux-user/ioctls.h        | 124 ++++++++++++++++++++++++++++=0D
 linux-user/syscall.c       |   3 +=0D
 linux-user/syscall_defs.h  |  37 +++++++++=0D
 linux-user/syscall_types.h | 163 +++++++++++++++++++++++++++++++++++++=0D
 5 files changed, 336 insertions(+)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

