Return-Path: <SRS0=5wN1=WA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD0CC433FF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 17:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F3820880
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 17:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwaRG2qY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F3820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huJy5-0007B5-84
	for qemu-devel@archiver.kernel.org; Sun, 04 Aug 2019 13:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56684)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1huJw4-0002O6-Ox
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1huJw2-00048S-M8
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:44 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1huJw1-00043e-GY
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:42 -0400
Received: by mail-wm1-x343.google.com with SMTP id x15so72600648wmj.3
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2019 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KkJvtrc3QrV2I7WYyibxflgUNfu3hfn3RhzurnFS0ws=;
 b=RwaRG2qYtLUixMlm3Jqs8/v9h39o2jombLpO7EJyAOtGYkEYJTBFR9izb6KIILBGb/
 NmjjPb4ckSxcYwBj43RngO+NY68rScNlpqsAoBI7UXv3CbzfWz1gRjqRzDwzuXLgJMkj
 QDaja65cGjpXdzVQLZ4zH2aZgZbKUlVe5Imd4dT7OLM3b8aUoZ4sUd31Nv9ldxktwA4z
 26tmA47Ft72xe9oWDeeBgApFajofK27uEJ9g/JxUU37M/cOqE28+m0s63DyITJlDiFWf
 1eJfv/00ZjkGQHH65Bnh/JvbG68Q/0u7kcaxLGGykd3V37ajb23iJpe85ymovEqkxKU8
 DZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KkJvtrc3QrV2I7WYyibxflgUNfu3hfn3RhzurnFS0ws=;
 b=YCtZx4DHP+MHSYTKql9/lq+ypa+aR0k+0tR7grRoDtOf0j5RRgudbF/bR1peaYmEAZ
 vRnJZYhtHaFLC9AYUCgIoms4Jt9nClKPd16tp4UQ+zEwLi1dgLJZHE0dhOYYeKeQoAIQ
 d19KAL+tBw+oybxwShDmh7Yw0smNvtirulcbTU/LdNPsiZrluktWWSu1oNPrS7uurPBx
 19D97LWFxzbpRwpKtGwFS5vVPRlEh6E76a7YzoxXxHEQvSAih6nX7sdaYJv4ScQn4A9V
 qqW6jzTul1tw65dPjjgAa1fAi1+4eWF5Lw2P/LOZ/YhcXuwjCUc5GYourxh1NXCWbMM1
 Hwuw==
X-Gm-Message-State: APjAAAWaaMhxXfXTPQROLzdyd3BqIF6+o/ph3RxH5ut5V/f+tiGKRo0C
 tKw6q+4udvrbN9oO/bnK5DTHx/MJ06A=
X-Google-Smtp-Source: APXvYqxbrm+Lihzs2eQqqNmnTyIKlxALZO4wN0FVs/00BTOh7PgjY26zDf3a2H5+8oiRSqaPCCbbYg==
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr14084735wmm.62.1564938278038; 
 Sun, 04 Aug 2019 10:04:38 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-632c-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:632c::5])
 by smtp.gmail.com with ESMTPSA id s10sm104876106wmf.8.2019.08.04.10.04.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 04 Aug 2019 10:04:37 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  4 Aug 2019 19:04:23 +0200
Message-Id: <c32779a94edfb7a61a41028f154ecc7cf2f69ef1.1564925486.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564925486.git.DirtY.iCE.hu@gmail.com>
References: <cover.1564925486.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v3 11/14] paaudio: fix playback glitches
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pulseaudio normally assumes that when the server wants it, the client
can generate the audio samples and send it right away.  Unfortunately
this is not the case with QEMU -- it's up to the emulated system when
does it generate the samples.  Buffering the samples and sending them
from a background thread is just a workaround, that doesn't work too
well.  Instead enable pa's compatibility support and let pa worry about
the details.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/paaudio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index f3864e1d50..c8ae1a6eca 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -512,10 +512,8 @@ static pa_stream *qpa_simple_new (
 
     flags =
         PA_STREAM_INTERPOLATE_TIMING
-#ifdef PA_STREAM_ADJUST_LATENCY
-        | PA_STREAM_ADJUST_LATENCY
-#endif
-        | PA_STREAM_AUTO_TIMING_UPDATE;
+        | PA_STREAM_AUTO_TIMING_UPDATE
+        | PA_STREAM_EARLY_REQUESTS;
 
     if (dev) {
         /* don't move the stream if the user specified a sink/source */
-- 
2.22.0


