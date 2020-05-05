Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF7BC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F7A20661
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs3isSMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F7A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxck-0000QU-ML
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVxaQ-00061v-UT
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:26:14 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVxaQ-0002Ok-7W
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:26:14 -0400
Received: by mail-wm1-x341.google.com with SMTP id x25so2306115wmc.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 06:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3L18rNpXpkfeoHL8SK4N5mRbwiSg/mgs7+xst3LggJg=;
 b=Hs3isSMq3dMVH/b+DXr6sBt+9a4lpLQkB5MraOL6g47/ItAQSsEqqhHE48EDMHBB4g
 1enwXkIqnkjLgIbLSTGuLGJsuNkv/QXCFRGCgCQEDqTHxE/OrfqbVgLA0CQLYkLMXalS
 rXO2KgEBY0m6NBIysYkoAezCEyCSUPAyk9ZvIqrFJmWqA+HR+Ag1APk0eGrvavHRj/Tg
 Ag1jqchT23kfA0FpjHNoWi1pHy/nd5t3KHJyvw18t3f6Hk3llzHmHzM2S5n6FB2woDgL
 sEqiV6q3r+FDXSDN09tC0pz83N6yju/v9a8TY7ouPRnNf0lOPBiPy+Yv9aZPulbDLzlF
 GPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3L18rNpXpkfeoHL8SK4N5mRbwiSg/mgs7+xst3LggJg=;
 b=D9mFJ5fakGGfK/Eha1mU6QaHGXxPHHofngfZ/4+rDEGERAxfrq/DWsstw7wHah9PSz
 kmNW0Miwo902Dd4UiR6sYBeF9wi1sG3+MUUyiwrVaKaB20nfYoDPiHoCbroWJgbsARuB
 0lpV1WffxVbNCNAW02UD1Gx8scjvFNOG+T4wMvkPrRleDeryO2RboQ8zwUaf2VHv6OLL
 5pvLUXnR0NWQJTDeVOCND1stWic6D+4gYCXaMkEtlwjh6lHyCZsJ53LdcI1+EFWppugC
 Dqhd8VtZsU8K4tE8AOuYtA6Vb/4LX+/X8bwbUp+nhSMHzHfVLmpMA7MVOphJclHP9qQZ
 guXw==
X-Gm-Message-State: AGi0PuZYzCtuxLrn6UeU8mj1M8nek4D/dDq2izTyg6zBvopr4smjrsQK
 l7RVKZ7VOmBYx6jteGMSZJo1snPG
X-Google-Smtp-Source: APiQypJwi/rICiXWjPLNKnqBmpDv80bjzKZ0KGYRd/kaNmHbQbFW1FCMGkKXkOlDVEYaYabA48HfYA==
X-Received: by 2002:a1c:bd54:: with SMTP id n81mr3228626wmf.141.1588685172745; 
 Tue, 05 May 2020 06:26:12 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id n6sm3427424wrs.81.2020.05.05.06.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 06:26:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] audio: Let AUD_write() use a const buffer argument
Date: Tue,  5 May 2020 15:26:02 +0200
Message-Id: <20200505132603.8575-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200505132603.8575-1-f4bug@amsat.org>
References: <20200505132603.8575-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=20Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

AUD_write() is to let backends process an existing data.
As we are not supposed to modify this buffer, make the
argument const.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 audio/audio.h | 2 +-
 audio/audio.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index 9d759d644b..7956b32d0a 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -113,7 +113,7 @@ SWVoiceOut *AUD_open_out (
     );
 
 void AUD_close_out (QEMUSoundCard *card, SWVoiceOut *sw);
-size_t AUD_write (SWVoiceOut *sw, void *pcm_buf, size_t size);
+size_t AUD_write (SWVoiceOut *sw, const void *pcm_buf, size_t size);
 int  AUD_get_buffer_size_out (SWVoiceOut *sw);
 void AUD_set_active_out (SWVoiceOut *sw, int on);
 int  AUD_is_active_out (SWVoiceOut *sw);
diff --git a/audio/audio.c b/audio/audio.c
index e2932da4f0..2672cf0885 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -703,7 +703,7 @@ static size_t audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
 /*
  * Soft voice (playback)
  */
-static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t size)
+static size_t audio_pcm_sw_write(SWVoiceOut *sw, const void *buf, size_t size)
 {
     size_t hwsamples, samples, isamp, osamp, wpos, live, dead, left, swlim, blck;
     size_t ret = 0, pos = 0, total = 0;
@@ -850,7 +850,7 @@ static void audio_timer (void *opaque)
 /*
  * Public API
  */
-size_t AUD_write(SWVoiceOut *sw, void *buf, size_t size)
+size_t AUD_write(SWVoiceOut *sw, const void *buf, size_t size)
 {
     HWVoiceOut *hw;
 
-- 
2.21.3


