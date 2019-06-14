Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F80C46477
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 20:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5635217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 20:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5635217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55086 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbslp-00005y-MT
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 16:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56231)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hbsjg-0006hs-2w
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 16:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hbsjf-0006sy-1R
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 16:23:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34762)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hbsje-0006sJ-Sg
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 16:23:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 78C5A3091782
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 20:23:36 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-141.ams2.redhat.com
 [10.36.116.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E94991802F
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 20:23:35 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 22:23:27 +0200
Message-Id: <20190614202333.19355-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 14 Jun 2019 20:23:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/6] update edk2 submodule & binaries to
 edk2-stable201905
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit f3d0bec9f80e4ed7796fffa834ba0a53f2094f=
7f:

  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-06-=
14' into staging (2019-06-14 14:46:13 +0100)

are available in the Git repository at:

  https://github.com/lersek/qemu.git tags/edk2-pull-2019-06-14

for you to fetch changes up to 541617cad3445fdc6735e9e5752e1f698e337737:

  pc-bios: update the README file with edk2-stable201905 information (201=
9-06-14 21:48:00 +0200)

----------------------------------------------------------------
edk2-stable201905 was released on 2019-06-06:

  https://github.com/tianocore/edk2/releases/tag/edk2-stable201905

Advance QEMU's edk2 submodule to edk2-stable201905, and rebuild the
firmware binaries. This should be the edk2 release that goes into QEMU
4.1.

Launchpad: https://bugs.launchpad.net/qemu/+bug/1831477

----------------------------------------------------------------
Laszlo Ersek (6):
      roms/Makefile.edk2: define edk2-stable201905 network feature test m=
acros
      roms/edk2: update submodule from edk2-stable201903 to edk2-stable20=
1905
      roms/Makefile.edk2: remove edk2-stable201903 network feature test m=
acros
      roms/Makefile.edk2: update input file list for "pc-bios/edk2-licens=
es.txt"
      pc-bios: refresh edk2 build artifacts for edk2-stable201905
      pc-bios: update the README file with edk2-stable201905 information

 pc-bios/README                         |  14 +-
 pc-bios/edk2-aarch64-code.fd.bz2       | Bin 1177603 -> 1178070 bytes
 pc-bios/edk2-arm-code.fd.bz2           | Bin 1173662 -> 1172752 bytes
 pc-bios/edk2-i386-code.fd.bz2          | Bin 1688659 -> 1736199 bytes
 pc-bios/edk2-i386-secure-code.fd.bz2   | Bin 1881979 -> 1943949 bytes
 pc-bios/edk2-licenses.txt              | 752 +++++++++++++++++++++++++++=
+++---
 pc-bios/edk2-x86_64-code.fd.bz2        | Bin 1669280 -> 1717094 bytes
 pc-bios/edk2-x86_64-secure-code.fd.bz2 | Bin 1901210 -> 1958037 bytes
 roms/Makefile.edk2                     |  22 +-
 roms/edk2                              |   2 +-
 10 files changed, 714 insertions(+), 76 deletions(-)

--=20
2.19.1.3.g30247aa5d201


