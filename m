Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C16C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 19:37:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32BD320675
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 19:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BD320675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jB1ji-0006fh-CX
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 15:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jB1gF-0002b1-SY
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 15:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jB1gD-00074I-VI
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 15:33:43 -0400
Received: from mailout04.t-online.de ([194.25.134.18]:59386)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jB1gD-00073f-PT
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 15:33:41 -0400
Received: from fwd23.aul.t-online.de (fwd23.aul.t-online.de [172.20.26.128])
 by mailout04.t-online.de (Postfix) with SMTP id 7A76241FBAE9;
 Sun,  8 Mar 2020 20:33:40 +0100 (CET)
Received: from linpower.localnet
 (ZGIpCEZfYhOFuRT-iXyhPwadEndrGEIus5q6UampyI1dAeVKSKH820GPUD2w-jhZUD@[79.208.31.100])
 by fwd23.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jB1g7-4CbgkS0; Sun, 8 Mar 2020 20:33:35 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 9BC152006D1; Sun,  8 Mar 2020 20:33:21 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 6/6] audio: add audiodev format=f32 option documentation
Date: Sun,  8 Mar 2020 20:33:21 +0100
Message-Id: <20200308193321.20668-6-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <2a4ade5f-d39b-3094-578f-6cced4650720@t-online.de>
References: <2a4ade5f-d39b-3094-578f-6cced4650720@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: ZGIpCEZfYhOFuRT-iXyhPwadEndrGEIus5q6UampyI1dAeVKSKH820GPUD2w-jhZUD
X-TOI-MSGID: d23c3cc6-9297-41cf-8435-c13075e488a8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.18
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
Cc: John Arbuckle <programmingkidx@gmail.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?q?Zolt=C3=A1n=20K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The documentaion for -audiodev format=3Df32 option was missing.

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 qemu-options.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index f9fefd43be..2919eddf4d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -551,7 +551,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
     "                in|out.frequency=3D frequency to use with fixed set=
tings\n"
     "                in|out.channels=3D number of channels to use with f=
ixed settings\n"
     "                in|out.format=3D sample format to use with fixed se=
ttings\n"
-    "                valid values: s8, s16, s32, u8, u16, u32\n"
+    "                valid values: s8, s16, s32, u8, u16, u32, f32\n"
     "                in|out.voices=3D number of voices to use\n"
     "                in|out.buffer-length=3D length of buffer in microse=
conds\n"
     "-audiodev none,id=3Did,[,prop[=3Dvalue][,...]]\n"
@@ -647,7 +647,7 @@ SRST
     ``in|out.format=3Dformat``
         Specify the sample format to use when using fixed-settings.
         Valid values are: ``s8``, ``s16``, ``s32``, ``u8``, ``u16``,
-        ``u32``. Default is ``s16``.
+        ``u32``, ``f32``. Default is ``s16``.
=20
     ``in|out.voices=3Dvoices``
         Specify the number of voices to use. Default is 1.
--=20
2.16.4


