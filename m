Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EBFC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 18:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB88218A1
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 18:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB88218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53955 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG611-0008PP-Sb
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 14:07:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hG5zt-0007nq-KY
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hG5zs-0004Jv-LU
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:06:25 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:35356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hG5zs-0004Io-Cl
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:06:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by hera.aquilenet.fr (Postfix) with ESMTP id 01790BEEB;
	Mon, 15 Apr 2019 20:06:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
	by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0wTGmT86aHss; Mon, 15 Apr 2019 20:06:20 +0200 (CEST)
Received: from function (105.251.129.77.rev.sfr.net [77.129.251.105])
	by hera.aquilenet.fr (Postfix) with ESMTPSA id 07CFFBEEA;
	Mon, 15 Apr 2019 20:06:19 +0200 (CEST)
Received: from samy by function with local (Exim 4.92)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hG5zm-0000O7-PM; Mon, 15 Apr 2019 20:06:18 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Mon, 15 Apr 2019 20:06:17 +0200
Message-Id: <20190415180618.1450-1-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.233.100.1
Subject: [Qemu-devel] [PULL 0/1] slirp gcc9 build fix
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com,
	jan.kiszka@siemens.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415180617.wYCKBU-oh-M9vOQ6ksJ2AZQFg7GSaoCMdfgVRJuGuYc@z>

The following changes since commit afccfc0c4c6134a7bc9da6375996b3b91d291d=
e4:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2019-04-12 17:06:49 +0100)

are available in the Git repository at:

  https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 6fabae61a9393fd2bc703837e464b9c34ec5ef25:

  slirp: Gcc 9 -O3 fix (2019-04-15 20:01:18 +0200)

----------------------------------------------------------------
Slirp updates

Dr. David Alan Gilbert (1):
  slirp: Gcc 9 -O3 fix

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      slirp: Gcc 9 -O3 fix

 slirp/src/socket.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

