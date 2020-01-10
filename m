Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF425C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 11:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D11E20848
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 11:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=online.net header.i=@online.net header.b="QP3T7Xpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D11E20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=online.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipsHM-0000Ir-Jv
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 06:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fflorensa@online.net>) id 1ipsGR-0007oI-O0
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 06:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fflorensa@online.net>) id 1ipsGP-0006eE-8R
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 06:15:38 -0500
Received: from mail.online.net ([62.210.16.11]:52136)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fflorensa@online.net>)
 id 1ipsGO-00065J-PC
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 06:15:37 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.online.net (Postfix) with ESMTP id E6063F2B89C0;
 Fri, 10 Jan 2020 12:15:28 +0100 (CET)
Received: from mail.online.net ([127.0.0.1])
 by localhost (mail.online.net [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id rPE9V1Ld0uyC; Fri, 10 Jan 2020 12:15:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.online.net (Postfix) with ESMTP id C2ECBF2B89C2;
 Fri, 10 Jan 2020 12:15:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.online.net C2ECBF2B89C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.net;
 s=4EC61654-9574-11E8-870F-3D38CA7095BF; t=1578654928;
 bh=2JtA7JP84nzbWJmcLB4wX9itp7d/x5FwCWCQpowUoGo=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=QP3T7XpmGBf3kS/bmqecwL+TyHSGq4SVsZJpKTyBR6BvhHU1nUzniFhNs0KZb/whJ
 ldtJ43AB4sWYBJYd4g4OTY1qpFwvLWZyBcS+imolckKdvpx9RexKPHvSE4/j2YuGxg
 izSBuGOhSwcFWRomRJd6K69MEpuwnJbAFI/N3RXEHBYQReI4qcv22wmGo8e6TAT2Em
 MeI2Xzto0Quwp127jM/aRFyK589m9KV1WSWiq40BADSPNa1Zw2/YHNaYKwZnJ0q0eV
 mGuLpHEs/2wuTNCEvHloxj+j4A5xNFl3HgtGw9heE5lIdGhrwWMTgn3Zo2bH2/uBCC
 s3PGPk+h+zLdQ==
X-Virus-Scanned: amavisd-new at mail.online.net
Received: from mail.online.net ([127.0.0.1])
 by localhost (mail.online.net [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id VsA9uYHIgYXB; Fri, 10 Jan 2020 12:15:28 +0100 (CET)
Received: from flash.online.net (unknown [195.154.229.35])
 by mail.online.net (Postfix) with ESMTPSA id 9FCEDF2B89C0;
 Fri, 10 Jan 2020 12:15:28 +0100 (CET)
From: Florian Florensa <fflorensa@online.net>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/1] block/rbd: Add support for ceph namespaces
Date: Fri, 10 Jan 2020 12:15:12 +0100
Message-Id: <20200110111513.321728-1-fflorensa@online.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 62.210.16.11
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
Cc: kwolf@redhat.com, dillaman@redhat.com, armbru@redhat.com, mreitz@redhat.com,
 sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixed the white space issue, no changes other than that.

Florian Florensa (1):
  block/rbd: Add support for ceph namespaces

 block/rbd.c          | 44 +++++++++++++++++++++++++++++++-------------
 qapi/block-core.json |  4 ++++
 2 files changed, 35 insertions(+), 13 deletions(-)

--=20
2.24.1


