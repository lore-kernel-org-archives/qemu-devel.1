Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5D5C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 09:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1FD524976
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 09:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=me.com header.i=@me.com header.b="zj156XFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FD524976
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49405 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY5tg-0001lb-NW
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 05:38:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hY5sE-0000qP-Sr
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 05:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hY5sC-0004kc-Vw
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 05:36:53 -0400
Received: from pv50p00im-ztdg10021901.me.com ([17.58.6.55]:42933)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1hY5sC-0004hh-Ec
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 05:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=04042017;
	t=1559641010; bh=qDQqvEUK1Ku+l8atD8lNJCpwoCM1Zj4XsvaD6ib62mY=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=zj156XFD8rsQG1Z+eewq9CR9VACWCS15MTcJj5B1tCAwG09fF0JJCJFPkK3x8ONGB
	YYyIaZYWta6+5hwPu6LVIZacDwabzxoDY5W6yfeKeH1M5OiiFIQL7Krs+7GUcfQV8b
	u4u9R4qq+rPTk1xfjObTqqXXATaGJlo+yzKmXMIc1shwqsAEiH3r+5Rln9Slb2ndI/
	2UhHFNBzNFsLHUD1RsYUT8/9B6AEx5j4OelLwRwibezPEvNoCsEo4EG4Sls9cJnXPP
	s0ZraHikpedOPMSSyfHbuT/tA83pgR1iYjnMxGHp+A9ZSQ/deV2T7xhXSku2TPXBLR
	jG2sGzIPX5zpg==
Received: from [172.18.2.102] (unknown [36.106.167.139])
	by pv50p00im-ztdg10021901.me.com (Postfix) with ESMTPSA id 62E2A880A96; 
	Tue,  4 Jun 2019 09:36:49 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
In-Reply-To: <B3540B0C-9A71-4733-8109-11B0DC7A17D2@me.com>
Date: Tue, 4 Jun 2019 17:36:48 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <2D2F1191-E82F-4B54-A6E7-73FFB953DE93@me.com>
References: <B3540B0C-9A71-4733-8109-11B0DC7A17D2@me.com>
To: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-06-04_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
	mlxlogscore=634 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1812120000 definitions=main-1906040064
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 17.58.6.55
Subject: [Qemu-devel] [PATCH 2/2] ui/cocoa: Fix mouse grabbing in fullscreen
 mode for relative input device
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
From: Chen Zhang via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Chen Zhang <tgfbeta@me.com>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In fullscreen mode, the window property of cocoaView may not be the key
window, and the current implementation would not re-grab cursor by left =
click
in fullscreen mode after ungrabbed in fullscreen mode with hot-key =
ctrl-opt-g.

This patch used value of isFullscreen as a short-cirtuit condition for
relative input device grabbing.

Signed-off-by: Chen Zhang <tgfbeta@me.com>
---
 ui/cocoa.m | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 474d44cb9f..aa7cf07368 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -901,7 +901,12 @@ QemuCocoaView *cocoaView;
         case NSEventTypeLeftMouseUp:
             mouse_event =3D true;
             if (!isMouseGrabbed && [self screenContainsPoint:p]) {
-                if([[self window] isKeyWindow]) {
+                /*
+                 * In fullscreen mode, the window of cocoaView may not =
be the
+                 * key window, therefore the position relative to the =
virtual
+                 * screen alone will be sufficient.
+                 */
+                if(isFullscreen || [[self window] isKeyWindow]) {
                     [self grabMouse];
                 }
             }
--=20
2.21.0



