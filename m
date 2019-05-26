Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88946C282E5
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 15:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A41F20815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 15:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ao2.it header.i=@ao2.it header.b="UTpCkRUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A41F20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ao2.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56232 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUuet-0002OY-KW
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 11:01:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58201)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <ao2@ao2.it>)
	id 1hUudM-00017c-H0
	for qemu-devel@nongnu.org; Sun, 26 May 2019 11:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ao2@ao2.it>) id 1hUuSA-0003Ew-SW
	for qemu-devel@nongnu.org; Sun, 26 May 2019 10:48:52 -0400
Received: from mail.ao2.it ([2001:4b98:dc0:41:216:3eff:fe7c:639b]:59061
	helo=ao2.it)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ao2@ao2.it>) id 1hUuSA-00039o-Gu
	for qemu-devel@nongnu.org; Sun, 26 May 2019 10:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it;
	s=20180927; 
	h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
	bh=1BraqkuXzLVIFB9aSOjSgu0j8u2G42mjcUldh5w7FS8=; 
	b=UTpCkRUp2EGG6rpVlxuDlipz1A1UnRnxj/0+03o7hDcvxuHpwYZ1o2cPlsUkA4m0yRVoqG+jjRHhMxZJBaP33l1bKfO4KMTonQCnpXMaeQT9KLui/evXOr9T9OXwLkXcSEsyRphqI1/9UXGI1wj+WEMRUj0iUa0h/2PvKwErdU6e449gIpyPB210s2qjZISSjy7BIy/FHyb7SH5dkorIk3stb30kULoDKujQsfIBcRoqQBUNpzbJAWf8mQLZ/vk6TqLYC8uJuP1B//daGuEqTJoGUjISp1bOfInaeaplhIvYGNaTqWtD1G6WVw2GpVwqnOBzEL7hsJBVZ0iddC2fig==;
Received: from localhost ([::1] helo=jcn)
	by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.84_2) (envelope-from <ao2@ao2.it>)
	id 1hUuRf-0001fF-Mr; Sun, 26 May 2019 16:48:19 +0200
Received: from ao2 by jcn with local (Exim 4.92) (envelope-from <ao2@ao2.it>)
	id 1hUuS0-0007ow-RY; Sun, 26 May 2019 16:48:40 +0200
From: Antonio Ospite <ao2@ao2.it>
To: qemu-devel@nongnu.org
Date: Sun, 26 May 2019 16:47:45 +0200
Message-Id: <20190526144747.30019-1-ao2@ao2.it>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H; 1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;
	]yA5<GWI5`6u&+ ; 6b'@y|8w"wB;
	4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG
	!pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2001:4b98:dc0:41:216:3eff:fe7c:639b
Subject: [Qemu-devel] [PATCH v3 0/2] configure: disallow spaces and colons
 in source path and build path
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Antonio Ospite <ao2@ao2.it>,
	Antonio Ospite <antonio.ospite@collabora.com>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Here is a v3 set to address
https://bugs.launchpad.net/qemu/+bug/1817345

CCing Laurent Vivier as the patch is going through the trivial-patches
branch.

The series follows up to:
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00562.html

Changes since v2:
  - Shorten 'if' check as suggested by Eric Blake in
    https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01190.html

  - Added Reviewed-by tags by Eric Blake.


Changes since v1:
  - Add a preparatory patch to set source_path only once and in a more
    robust way.

  - Move the checks in configure after the source_path definition to
    avoid using realpath which is not available everywhere.

  - Cover also the build path in Makefile. An extensive explanation of
    why I think this is needed is here:
    https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg05398.html

Thank you,
   Antonio


Antonio Ospite (2):
  configure: set source_path only once and make its definition more
    robust
  configure: disallow spaces and colons in source path and build path

 Makefile  |  4 ++++
 configure | 11 ++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

