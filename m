Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3634C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C7A20661
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpXkX2LE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C7A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxbG-00072E-GP
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVxaK-0005rp-JD
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:26:08 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVxaJ-0001d0-R2
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:26:08 -0400
Received: by mail-wr1-x442.google.com with SMTP id y3so2779594wrt.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 06:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RhuigcuuuzfTeW4C8VTuUSwwtFMoBUgfBiSdaUwZ7yQ=;
 b=WpXkX2LEJ7wxUYSRQ4OJW/XYTJu1UZaGGWY11/CuRuI891phsxrmqi1kmb5whdZ8S/
 DkZI2/57JGs94O0ZjI3DJ3xixm9eeJfD24zExsbUMnS/isYolDPvjmWhS2DHnjElUa8P
 1O6hfTJBnfjg76S9PTup74UquCKZh2Y7qwsTeTKwR9xg6SvpDWW8uHeMTjr6J/Oye6IR
 C0tStGrZta4XqHuWapn8vDgs5BEvgP381P8Hh8fgUDI26e/RydaKEQgRWvwEqjPExESY
 kEncaOpzypQqfVZLJaoSXR2BCacont6hOTcAj5cJOV+I9SltRjzsvf+Z1NsY/UFyMKP8
 erDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=RhuigcuuuzfTeW4C8VTuUSwwtFMoBUgfBiSdaUwZ7yQ=;
 b=hi4UR67oZ/Zpuxey+Op5U2tH93whCa8FiHebmzWfYSH0gr0mi+N3o/Slr+DYuEDR74
 PqXkEDCGaFZG1tQQ2TKRq6tlawtLsnPNiiAci0E0C0JgQrrRlDDJRolj8zuWfvD0fAXT
 /NM5Ri/avMVg4RG0YzFmLHsfWFvFRYoEzphxTzQTf/tPF4dSeUM253YjBJLBsnoW0GRX
 XAw4s2PvlxL8CavvgqJSYLFxCVDXPmVCe2Y0zBa+PmpvvhEcZ+01aYuJUWD1NiBVoruj
 ERQOK5+I+AgNQiBMV3eRFHJQ0MoBd8WfONOBdTWXff3rYtqmVDa2Q+BE9UGwzZPClu7d
 idog==
X-Gm-Message-State: AGi0PubDTiizn/9SZVR0pW3zRD17tW9M01kh1GxrG7DBwr/U/MSfXWcM
 E0FOZJroidoG6siDR76o9byGD12l
X-Google-Smtp-Source: APiQypLIjHnZGPef5V3czX4sg0JOtFb+fQ5w4QCiCQh0OJBJAHyu45R97dq4N1eOuVroeTdiNs6SNQ==
X-Received: by 2002:adf:9793:: with SMTP id s19mr3446251wrb.147.1588685165704; 
 Tue, 05 May 2020 06:26:05 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id n6sm3427424wrs.81.2020.05.05.06.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 06:26:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] audio: Spring cleaning
Date: Tue,  5 May 2020 15:25:56 +0200
Message-Id: <20200505132603.8575-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Cleaning old branches, salvaging what seems worthwhile...
This series is from the time I wanted cleaner buffer handling
to avoid abuses, started with chardev/ but got lost with reviews.
audio/ is smaller, so easier.

- Convert various prototypes to use const buffers
- Expose 'audio/audio.h' via public include directory.

Philippe Mathieu-Daudé (7):
  audio: Let audio_sample_to_uint64() use const samples argument
  audio: Let capture_callback handler use const buffer argument
  audio: Move advance() helper to 'audio_int.h'
  audio: Split advance() helper as in() and out()
  audio: Let HWVoice write() handlers take a const buffer
  audio: Let AUD_write() use a const buffer argument
  audio: Expose 'audio/audio.h' under the include/ directory

 audio/audio_int.h                | 25 +++++++++++++++++++------
 {audio => include/audio}/audio.h | 14 ++++----------
 audio/alsaaudio.c                |  8 ++++----
 audio/audio.c                    | 19 ++++++++++---------
 audio/audio_legacy.c             |  2 +-
 audio/audio_win_int.c            |  2 +-
 audio/coreaudio.c                |  7 ++++---
 audio/dsoundaudio.c              |  4 ++--
 audio/mixeng.c                   |  6 +++---
 audio/noaudio.c                  |  4 ++--
 audio/ossaudio.c                 | 10 +++++-----
 audio/paaudio.c                  |  6 +++---
 audio/sdlaudio.c                 |  8 +++++---
 audio/spiceaudio.c               |  4 ++--
 audio/wavaudio.c                 |  4 ++--
 audio/wavcapture.c               |  4 ++--
 ui/vnc.c                         |  2 +-
 MAINTAINERS                      |  1 +
 18 files changed, 71 insertions(+), 59 deletions(-)
 rename {audio => include/audio}/audio.h (95%)

-- 
2.21.3


