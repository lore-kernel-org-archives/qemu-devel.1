Return-Path: <SRS0=2u83=X7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82243C4360C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 23:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E722077B
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 23:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E722077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHGOl-0001nU-Ah
	for qemu-devel@archiver.kernel.org; Sun, 06 Oct 2019 19:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <samuel.thibault@ens-lyon.org>) id 1iHGNQ-0000tg-SH
 for qemu-devel@nongnu.org; Sun, 06 Oct 2019 19:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <samuel.thibault@ens-lyon.org>) id 1iHGNP-0008Bs-Tp
 for qemu-devel@nongnu.org; Sun, 06 Oct 2019 19:55:48 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:54132)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1iHGNP-0008Bk-O2
 for qemu-devel@nongnu.org; Sun, 06 Oct 2019 19:55:47 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 230741FD4;
 Mon,  7 Oct 2019 01:55:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 77tFWhywbz32; Mon,  7 Oct 2019 01:55:39 +0200 (CEST)
Received: from function.home (lfbn-bor-1-306-163.w109-215.abo.wanadoo.fr
 [109.215.28.163])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 3285E1E8A;
 Mon,  7 Oct 2019 01:55:39 +0200 (CEST)
Received: from samy by function.home with local (Exim 4.92.2)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1iHGNG-0008L8-7J; Mon, 07 Oct 2019 01:55:38 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 0/1] slirp update
Date: Mon,  7 Oct 2019 01:55:36 +0200
Message-Id: <20191006235537.32016-1-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 185.233.100.1
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 860d9048c78ce59c5903c3d5209df56f384009=
86:

  Merge remote-tracking branch 'remotes/kraxel/tags/audio-20190924-pull-r=
equest' into staging (2019-09-24 13:51:51 +0100)

are available in the Git repository at:

  https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 120b721f5b590393971673a315f02969ec89cccb:

  slirp: Allow non-local DNS address when restrict is off (2019-10-01 19:=
03:08 +0200)

----------------------------------------------------------------
slirp: Allow non-local DNS address when restrict is off

----------------------------------------------------------------
Samuel Thibault (1):
      slirp: Allow non-local DNS address when restrict is off

 net/slirp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

