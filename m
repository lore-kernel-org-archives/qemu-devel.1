Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23B1C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 12:48:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA442077C
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 12:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ix2zAoVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA442077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37001 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIYN1-00073w-PF
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 08:48:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hIYK0-0004eN-H2
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 08:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hIY9R-0005Jc-SC
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 08:34:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:36203)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nick.hudson@gmx.co.uk>)
	id 1hIY9R-0005DG-JA
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 08:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1555936459;
	bh=gSHlHWtWxJtFqF8i6+ze9K7YB0TmJyPy/nbEKqikGyk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ix2zAoVwC9iOYIUHQXIBuZcGh7a2C/wZHSaRB8aghveEIXZgtOe/2Yp2qb39mORq/
	fAftulV4NTPVwwKDDSm4eY2y2UpaDeoY1xaDj8slA4zC6y+/yV66vwAXq1Qr0MaBT0
	ZzcbYjw/42CVsOxa2KEXtzkQNXhcvAunBOmyJnjg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from zoom.local ([2.122.11.66]) by mail.gmx.com (mrgmx005
	[212.227.17.184]) with ESMTPSA (Nemesis) id 1M3DJv-1hEyqU0Ja9-003ctY;
	Mon, 22 Apr 2019 14:34:19 +0200
Received: by zoom.local (Postfix, from userid 1000)
	id A12A99C5572; Mon, 22 Apr 2019 13:34:15 +0100 (BST)
From: Nick Hudson <nick.hudson@gmx.co.uk>
To: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 Apr 2019 13:34:11 +0100
Message-Id: <20190422123411.5178-3-nick.hudson@gmx.co.uk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190422123411.5178-1-nick.hudson@gmx.co.uk>
References: <20190422123411.5178-1-nick.hudson@gmx.co.uk>
X-Provags-ID: V03:K1:C2aqp+Sd53buq8L5KG1XQHvr5fGKIwLbPyWgmBuaJPMvfPV+uMr
	T2i9Yj4P+tn4MpxkfQpcmsEnt+khxKhfOhOIlcJEcWx52wmaDIhDh3IKV9+vuosmHUJ6Vxy
	PwoSvsXWj6wcv+ZSdXdz7lRrGhK1HWx1JH3J5vWoLPBq1Uz7IA1v/CfRwWqJuUz4TuIney6
	W5zyw6uWwKr8yGebuVBgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZvykdYrwmQc=:XMSEe50MEIzhRypbcshKQZ
	9t2id20c0bCTASqimFlwJ9ydRwbLrcW6V/fKWNHVWgUGwORnDADua9NJdYLRlsZPaaDzeW0w+
	+qmOukwxs+nh+IeHYFSaCK13tKBhU4FxDgaFIxvIrDF8KTeimQT8dpTvdmEOYEEejBDPJygj+
	u+CTawhafweH/mP5h6knQwe5eS0xx9vVX/jhE5IF29mIxJDVkWH8/8IQr6fq2exwvs706Wzj1
	ib1oN+o7T5J8AmSGo7oYx/ixEi5uDmDlZOEj1dV2aeXBErbV8euniv2UzO8CSgC/fdVbeib/k
	LTwumjHzQESh5afG5J+nJS3euDV/7VW0t0/Gq2jGdxV1BwmjYuGYJ5bP0pwCQgbNPeAffC+jc
	amKJrNyW5/yg5vemuZEO+wguu9dGYM/bCmn//L/PlM1kPnB6+er4VO6KBGoT3TrWK5eY+lHvY
	7rZ57G+bGDA0kjjJ8JTy7/jyOwzqfA3p+6QxYQzuW6Uj09vUJOt8R3YQQHor0Jljy+29KQkfL
	qUmtwmpvJJUcIZpOXlAnr1kooC0ml+YLpmscrzkpnIJhWszo2EA2L6cN4TAY3RfVMVgjGzNNk
	a4gjcfuKbPFOvUR0Ujg4oycMbmbMGaD9fMyZ/m7MbJfIJedahIBQQUqFlqPI8sWvUrUW1dXmL
	nhPOX+xngKVv25OPL6xz9PyG2Fk4XaIu/3H3DcH8ANF/kf+r0XTBvcDueookZ5PObQSq+nj3j
	3dFmgY72J9exUIPRmrp7W9J9i0NRJ2Wbscqhrun1VgdbHUC47rYTZyQsC8W4coxGiCNOlghrY
	Yir24zcL4DhXB7Tp5UpZzNhlfEPxzKP85xeL1yrLGxUIJJIpjmfaMiE2U9OCv1V6yCgFVAzca
	GAt291QmhFPQODh0s5/OpfbAlmyKXBE9Z9hwGaVskSo/pl3c92MXgJSuhnEQHz
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.18
Subject: [Qemu-devel] [PATCH v2 2/2] Always return EXCP_DMAR for protection
 id trap as EXCP_DMP is considered legacy.
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
Cc: Nick Hudson <skrll@netbsd.org>,
	"open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422123411.2PUsY_Mf2KHwztEkqZ1Lv0RAgIZVZeXU_QGkv3axE8s@z>

From: Nick Hudson <skrll@netbsd.org>

"In PA-RISC 1.1 (Second Edition) and later revisions, processors must use
traps 26, 27,and 28 which provide equivalent functionality"

Signed-off-by: Nick Hudson <skrll@netbsd.org>
=2D--
 target/hppa/mem_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index c9b57d07c3..77fb544838 100644
=2D-- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -154,8 +154,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr=
 addr, int mmu_idx,

     if (unlikely(!(prot & type))) {
         /* The access isn't allowed -- Inst/Data Memory Protection Fault.=
  */
-        ret =3D (type & PAGE_EXEC ? EXCP_IMP :
-               prot & PAGE_READ ? EXCP_DMP : EXCP_DMAR);
+        ret =3D (type & PAGE_EXEC) ? EXCP_IMP : EXCP_DMAR;
         goto egress;
     }

=2D-
2.17.1


