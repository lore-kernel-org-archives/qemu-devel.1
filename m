Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BBEC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A275720842
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A275720842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8qT8-0005HQ-PI
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 14:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1j8qSD-0003uG-Ky
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1j8qSC-0005Bn-Mu
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:10:13 -0500
Received: from mailout07.t-online.de ([194.25.134.83]:44184)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1j8qSC-0005AY-Go
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:10:12 -0500
Received: from fwd23.aul.t-online.de (fwd23.aul.t-online.de [172.20.26.128])
 by mailout07.t-online.de (Postfix) with SMTP id 767C8427E86E;
 Mon,  2 Mar 2020 20:10:11 +0100 (CET)
Received: from linpower.localnet
 (Xdk530ZQoh8p3nyv3xgLOkINTMMFTH42yTQ-rNBGAz1auuFzwm2tdirH8FYbegQZML@[79.208.28.226])
 by fwd23.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1j8qS5-2DuZm40; Mon, 2 Mar 2020 20:10:05 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 8D56D21159C; Mon,  2 Mar 2020 20:10:04 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 1/5] qapi/audio: add documentation for AudioFormat
Date: Mon,  2 Mar 2020 20:10:00 +0100
Message-Id: <20200302191004.5991-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <417bfe2f-e3c1-d83d-b437-47859daf524d@t-online.de>
References: <417bfe2f-e3c1-d83d-b437-47859daf524d@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: Xdk530ZQoh8p3nyv3xgLOkINTMMFTH42yTQ-rNBGAz1auuFzwm2tdirH8FYbegQZML
X-TOI-MSGID: 8435a86c-6486-416a-827f-2ae85c1f8bb7
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: John Arbuckle <programmingkidx@gmail.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?q?Zolt=C3=A1n=20K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The review for patch ed2a4a7941 "audio: proper support for
float samples in mixeng" suggested this would be a good idea.

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 qapi/audio.json | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/qapi/audio.json b/qapi/audio.json
index d8c507cced..07e7b05516 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -273,6 +273,20 @@
 #
 # An enumeration of possible audio formats.
 #
+# @u8: unsigned 8 bit integer
+#
+# @s8: signed 8 bit integer
+#
+# @u16: unsigned 16 bit integer
+#
+# @s16: signed 16 bit integer
+#
+# @u32: unsigned 32 bit integer
+#
+# @s32: signed 32 bit integer
+#
+# @f32: single precision floating point (since 5.0)
+#
 # Since: 4.0
 ##
 { 'enum': 'AudioFormat',
--=20
2.16.4


