Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9E5C43466
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 17:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A84B20866
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 17:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A84B20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK32O-0008QF-H2
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 13:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1kK2yN-00043K-Fy
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 13:18:00 -0400
Received: from mailout11.t-online.de ([194.25.134.85]:51116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1kK2yL-0006HF-SA
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 13:17:59 -0400
Received: from fwd40.aul.t-online.de (fwd40.aul.t-online.de [172.20.26.139])
 by mailout11.t-online.de (Postfix) with SMTP id 9C2864256C51;
 Sun, 20 Sep 2020 19:17:56 +0200 (CEST)
Received: from linpower.localnet
 (G-LqO6ZFQhtVJ4wGXZSDSgM57BRmZT9PIPGCSOpjRa-ikfuzLDr7U2cPpbnkf3YQ6z@[93.236.144.216])
 by fwd40.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kK2yF-3uB8XQ0; Sun, 20 Sep 2020 19:17:51 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 07EFC33550C; Sun, 20 Sep 2020 19:17:30 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 9/9] audio: revert tests for pcm_ops table
Date: Sun, 20 Sep 2020 19:17:29 +0200
Message-Id: <20200920171729.15861-9-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <84f1c61a-8399-c75e-96c2-febfc2dd5fab@t-online.de>
References: <84f1c61a-8399-c75e-96c2-febfc2dd5fab@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: G-LqO6ZFQhtVJ4wGXZSDSgM57BRmZT9PIPGCSOpjRa-ikfuzLDr7U2cPpbnkf3YQ6z
X-TOI-EXPURGATEID: 150726::1600622271-00001797-BE7FCD5B/0/0 CLEAN NORMAL
X-TOI-MSGID: fb6186ab-3716-4ad8-81f2-02470f0e43e6
Received-SPF: none client-ip=194.25.134.85;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout11.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 13:17:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?q?Zolt=C3=A1n=20K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With previous commit every audio backend has a pcm_ops function
table. It's no longer necessary to test if the table is
available. This reverts commit cbaf25d1f5: "audio: fix
wavcapture segfault"

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 audio/audio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index b908e041dd..f63781b4db 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -649,7 +649,7 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *buf, size_t size)
         total += isamp;
     }
 
-    if (hw->pcm_ops && !hw->pcm_ops->volume_in) {
+    if (!hw->pcm_ops->volume_in) {
         mixeng_volume (sw->buf, ret, &sw->vol);
     }
 
@@ -743,7 +743,7 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t size)
     if (samples) {
         sw->conv(sw->buf, buf, samples);
 
-        if (sw->hw->pcm_ops && !sw->hw->pcm_ops->volume_out) {
+        if (!sw->hw->pcm_ops->volume_out) {
             mixeng_volume(sw->buf, samples, &sw->vol);
         }
     }
-- 
2.26.2


