Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226BFC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA97B24655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA97B24655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXHL-0007vp-OR
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:51:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1iuXFd-00061L-Lc
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:50:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1iuXFb-0004iV-NC
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:50:05 -0500
Received: from mailout07.t-online.de ([194.25.134.83]:56294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1iuXFb-0004hB-HP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:50:03 -0500
Received: from fwd35.aul.t-online.de (fwd35.aul.t-online.de [172.20.27.145])
 by mailout07.t-online.de (Postfix) with SMTP id 0D7E6420C3D4;
 Thu, 23 Jan 2020 08:50:02 +0100 (CET)
Received: from linpower.localnet
 (EG4kSMZfQh937Ei9W3xhVB+UPLFVHknNBDFVSK8dnWKC+wMwWpejyJtib4H-JrwQfY@[46.86.62.122])
 by fwd35.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1iuXFZ-32WwxE0; Thu, 23 Jan 2020 08:50:01 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 60EF9200F7D; Thu, 23 Jan 2020 08:49:43 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 8/9] ossaudio: disable poll mode can't be reached
Date: Thu, 23 Jan 2020 08:49:42 +0100
Message-Id: <20200123074943.6699-8-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <1e29e1d3-b59b-fcd6-cdff-a680bcdbffa4@t-online.de>
References: <1e29e1d3-b59b-fcd6-cdff-a680bcdbffa4@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: EG4kSMZfQh937Ei9W3xhVB+UPLFVHknNBDFVSK8dnWKC+wMwWpejyJtib4H-JrwQfY
X-TOI-MSGID: 98d184ff-a104-44b3-b651-0d2090ea5e6b
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 194.25.134.83
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
Cc: QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?q?Zolt=C3=A1n=20K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently there is no way to disable poll mode in
oss_enable_out and oss_enable_in when it was enabled before.
The enable code path always resets the poll mode state variable.

Fixes: b027a538c6 "oss: Remove unused error handling of
qemu_set_fd_handler"

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 audio/ossaudio.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 39a6fc09e5..f88d076ec2 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -579,14 +579,12 @@ static void oss_enable_out(HWVoiceOut *hw, bool ena=
ble)
     AudiodevOssPerDirectionOptions *opdo =3D oss->dev->u.oss.out;
=20
     if (enable) {
-        bool poll_mode =3D opdo->try_poll;
+        hw->poll_mode =3D opdo->try_poll;
=20
         ldebug("enabling voice\n");
-        if (poll_mode) {
+        if (hw->poll_mode) {
             oss_poll_out(hw);
-            poll_mode =3D 0;
         }
-        hw->poll_mode =3D poll_mode;
=20
         if (!oss->mmapped) {
             return;
@@ -708,17 +706,15 @@ static void oss_enable_in(HWVoiceIn *hw, bool enabl=
e)
     AudiodevOssPerDirectionOptions *opdo =3D oss->dev->u.oss.out;
=20
     if (enable) {
-        bool poll_mode =3D opdo->try_poll;
+        hw->poll_mode =3D opdo->try_poll;
=20
-        if (poll_mode) {
+        if (hw->poll_mode) {
             oss_poll_in(hw);
-            poll_mode =3D 0;
         }
-        hw->poll_mode =3D poll_mode;
     } else {
         if (hw->poll_mode) {
-            hw->poll_mode =3D 0;
             qemu_set_fd_handler (oss->fd, NULL, NULL, NULL);
+            hw->poll_mode =3D 0;
         }
     }
 }
--=20
2.16.4


