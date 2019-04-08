Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7B3C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 02:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810BF20883
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 02:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=me.com header.i=@me.com header.b="LIK2c7+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810BF20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46149 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDJv6-0007nB-FW
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 22:22:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hDJtq-0007Ag-Gn
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hDJjK-0007mE-7r
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:09:51 -0400
Received: from pv50p00im-ztdg10011301.me.com ([17.58.6.40]:50197)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1hDJjI-0007eD-46
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=04042017;
	t=1554689386; bh=r85ECKuF67mUDGh7vOGs3TQEScqrAFCmVVoxZZgaGic=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=LIK2c7+caX6JfgEPxeUt5kAJLr55wmpFfwrg++YRp626e52CUOezYLaZMKFSO2Qz5
	6MhsEpeDOkHOLsg66DtSkORvtBH/JKck44kZzGq+hNEdgjKlTHoClkrcLWocHXkiM8
	OMlWNbOrRy1ism+WsYlDhhDjhtOSXxILHdIw8qhiLa5KT4fdyMBgGFcQnWfWsri1cv
	/cwWgesGL8xwNZZKQiJWcVMcGN6E0UdSwJg64npGoxTU+DVSViXHXAbpa0iHXumdfq
	UY+9hYawnSln2C9NauC3gViExU0HkMp2lfWf5duLnIzRWk/83WS5VaiTWK35AMPjYC
	kj5EQyymxmnUA==
Received: from [172.18.2.102] (unknown [36.106.167.87])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id C526964014E; 
	Mon,  8 Apr 2019 02:09:43 +0000 (UTC)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
In-Reply-To: <B786F00D-5518-405B-B0AC-C5BF2D7283F5@me.com>
Date: Mon, 8 Apr 2019 10:09:42 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <91053E16-BF23-405F-971F-8042EEA50408@me.com>
References: <B786F00D-5518-405B-B0AC-C5BF2D7283F5@me.com>
To: QEMU Developers <qemu-devel@nongnu.org>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-08_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
	mlxlogscore=679 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1812120000 definitions=main-1904080018
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 17.58.6.40
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408020942.-NgqGwebxE6uiuv4OAO03sycuqfDHDEMPucTItjsZrs@z>

In fullscreen mode, the window property of cocoaView may not be the key
window, and the current implementation would not grab mouse in =
fullscreen
mode after user ungrabs cursor in fullscreen mode with hot-key, and left
clicks the relative input devices to re-grab it.

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
2.19.2


