Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9722C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 19:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80A3C2067C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 19:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A3C2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jB1gt-00037w-Ox
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 15:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jB1g4-0002M1-8L
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 15:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jB1g3-0006yr-5E
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 15:33:32 -0400
Received: from mailout10.t-online.de ([194.25.134.21]:49888)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jB1g2-0006wP-Vk
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 15:33:31 -0400
Received: from fwd06.aul.t-online.de (fwd06.aul.t-online.de [172.20.26.150])
 by mailout10.t-online.de (Postfix) with SMTP id 14FAE4165D96;
 Sun,  8 Mar 2020 20:33:29 +0100 (CET)
Received: from linpower.localnet
 (XReU-mZZQhI6NGU+UoUy87MrAIlOqJbOOXetIVaUTayBZ-aL+q3mTM4XvB0LV+sQpf@[79.208.31.100])
 by fwd06.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jB1fu-1l2zU80; Sun, 8 Mar 2020 20:33:22 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 928792000A6; Sun,  8 Mar 2020 20:33:21 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 1/6] qapi/audio: add documentation for AudioFormat
Date: Sun,  8 Mar 2020 20:33:16 +0100
Message-Id: <20200308193321.20668-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <2a4ade5f-d39b-3094-578f-6cced4650720@t-online.de>
References: <2a4ade5f-d39b-3094-578f-6cced4650720@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: XReU-mZZQhI6NGU+UoUy87MrAIlOqJbOOXetIVaUTayBZ-aL+q3mTM4XvB0LV+sQpf
X-TOI-MSGID: 74427376-a2b6-4fac-85d0-4a967bf350b2
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.21
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

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 qapi/audio.json | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/qapi/audio.json b/qapi/audio.json
index d8c507cced..c31251f45b 100644
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
+# @f32: single precision floating-point (since 5.0)
+#
 # Since: 4.0
 ##
 { 'enum': 'AudioFormat',
--=20
2.16.4


