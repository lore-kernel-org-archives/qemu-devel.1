Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1587C2BB85
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 15:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 893D821927
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 15:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893D821927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP6S8-00074S-Lt
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 11:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jP6RY-0006dF-7B
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jP6RX-00069O-7n
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:28:44 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:39025)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jP6RW-00068Q-Vb
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:28:43 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MXGSU-1jkQgB2yEw-00YkAe; Thu, 16 Apr 2020 17:28:33 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] Linux user for 5.0 patches
Date: Thu, 16 Apr 2020 17:28:28 +0200
Message-Id: <20200416152829.790561-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L5N5fAjZZexbTlQvvbilRSIrNk3Mpm5D0dBO1gbZQHcarvOvJZA
 WtGXAP8DNQn5sMNH3sVIlH1u5SkDU7PWWmpoxxgZUepHJoItHQ+iuBIIgWPwZL1MgUW/NxI
 oi3gXPmq/zoDOZ+dToS+a1WOT8HiuR4y967kQV4SprTRaVdA2TT9FNzyshu7+MvK3LE752R
 9uio2VQBIiem9n6VcLf7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mLLx7gSd3Yg=:kdHTFgZKoSqoOX5lrbYn5p
 gHvx0QCOxalIPfmdCZcbNzQ1+TnOq774xb7MwhH6uz089uPIA/TyKHte91W35Kh5lzEdt07wy
 WsHJWSYZp32e6akUc2prQnzoRJ211b1yqYBDEnvg1lt+PMHt78l/n9NoXnw/cPfheTIDHVWBJ
 CY8ikmSEOiD7g+JkSau1U8TeUiij77ZqgUu5GHBRq8wSQWSmO0RYoG80hKC9OlST5u7POkSp3
 8sMRJaFrrX53EBKHbOpDHa22AkO+6XKWm/fuLZQeS11NWb3W+EQCVV1goeRCri20vqqZ89vNN
 7M/1zQq0uErCxM5ioseqZjYDIy767mnucc5ApM/5owv5baHyxhcNJxXbaXVvy7owGTRsdGvvE
 nrLjZsPSf/a4nnm83xghnn6PAHk/AlRbi1ebY10RCzyZRIruS62RE7LoxJcysHoIKxnz8pbUG
 b8SCFacx2pVAzF7kUA63e19uPSSJ5En4MpUQzeg5CxsbiydrwCg3OYmZ4N13OAvPymrz3l5FT
 G46kVKJyfapwBHVeFyHIz7D9WDfF1r6mF6pw047A6puTh8E6gC0NtNZOyT7/+Xlz/bQSJjz6R
 N4MVxjMJM582xxYmTSW5c9/pLqqoDINxIUlmSVGAa/mhF6TYUmbGxXzB8XfIBvDqMYRIqvOW4
 RoGTcmQneXx8mHkgtmynKIeZpJkKVzH4Lz7NhnFDNXRuMKJaqy7dZpOqu0Dt0XcTfiPhn6Gfv
 M9ezyIeypcdrdNlg9gOrDe835h4FLV9YA/l2qxuAtJu6SFvdb5N8DR5vEv565xH9tCUeVOChs
 Aq9C4E3P23gbh7MEPLe1LNHdqiq266HTbQPwzVS1LzWjbtcPO3/x4pionNgDfidP0p/hWzy
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 20038cd7a8412feeb49c01f6ede89e36c8995472=
:=0D
=0D
  Update version for v5.0.0-rc3 release (2020-04-15 20:51:54 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request=0D
=0D
for you to fetch changes up to 386d38656889a40d29b514ee6f34997ca18f741e:=0D
=0D
  linux-user/syscall.c: add target-to-host mapping for epoll_create1() (202=
0-04-16 09:24:22 +0200)=0D
=0D
----------------------------------------------------------------=0D
Fix epoll_create1() for qemu-alpha=0D
=0D
----------------------------------------------------------------=0D
=0D
Sergei Trofimovich (1):=0D
  linux-user/syscall.c: add target-to-host mapping for epoll_create1()=0D
=0D
 linux-user/syscall.c | 2 +-=0D
 1 file changed, 1 insertion(+), 1 deletion(-)=0D
=0D
-- =0D
2.25.2=0D
=0D

