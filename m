Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D54C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 23:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4202621852
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 23:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG/m8IfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4202621852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43527 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzUK4-0001Rj-9o
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 19:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hzUGO-0006LB-70
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hzUGN-0005FP-0V
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:04 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52755)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hzUGM-0005Ds-Qv
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:02 -0400
Received: by mail-wm1-x344.google.com with SMTP id o4so9403wmh.2
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 16:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KHcZ3fx/GcsjWy2sAyP2rYu1Fwyr0HOHzikvr8kGlrk=;
 b=HG/m8IfQ/JvGpOVVUj/BFINGhmpEeWnNV0cmIp7mPqjSdjVlguCD+lbBnObVcrRSGy
 Ufkps5E94fl2TW1H/PfV+/AmnrGoXf/BqEymCuM/qdPG6GalJnRLoEadUXILPk9MA+K7
 Zbxtl3EXAmAKKECcmbUrlgx52P51vMCdJPGypL+xAEN3VO8JXdUkBcqaxFlbBD8uOcpJ
 z3JIjwj9iC8kHo71l3B1IjKdjfoJAbznlyrAogifT4XYR5FoIgN705xhGZvEunx0O7eS
 38fP8OgJ+exjKV7S9hUi08PZDptH5c96PTCzeNURpw1ZOyCZRo+4Oc/+VEP/UTTjlvpH
 aWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KHcZ3fx/GcsjWy2sAyP2rYu1Fwyr0HOHzikvr8kGlrk=;
 b=llSXUHbc4uz/Hnbcoce5VbgcHyG7agDbzabPd3flPUjPh5cS/Y0XpRcJLlPe/lXmEK
 G7c/XxUvbeq3P6L8pQYSCGbksU7q6Uk4xufw58xL/XLQhWHaCpuIAkUqSA9fZYNP7yRr
 iuoJYHJ4Bv668ZfwxCmSwWa4fafrykBv/Oxd6lOU53DFlVrCGSsalUep2JBtSik/9KTT
 APhfbo3/vEHAwdvtnm8cR+5oGy+3o2OZSPSdAyaY+LXRTbkYjOKX2mAj3dgRon4MjZie
 DYPFi0nn4hS0mF470/T2NG1+5/OpUdjw9H1lYlwwIVybz5/HzcvZnhvLKF5aHEkVC3ks
 7DLA==
X-Gm-Message-State: APjAAAXvxXhu/r288nQUovFTmT8f+yL348OLjLTm4U3WpETKKOnhT0Gd
 lgK2Sz/NWWDqZnAZybhsJyBUAR0p
X-Google-Smtp-Source: APXvYqwOIWR96sLCk9JB74Q/tBnPtzk8TR2sC0559u7Hq9b4LyQDAVWKdnFOO6v1oAJIn4c4JBMyrA==
X-Received: by 2002:a05:600c:2192:: with SMTP id
 e18mr16732742wme.83.1566169620465; 
 Sun, 18 Aug 2019 16:07:00 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-49c9-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:49c9::5])
 by smtp.gmail.com with ESMTPSA id c15sm33657152wrb.80.2019.08.18.16.06.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Aug 2019 16:07:00 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 01:06:45 +0200
Message-Id: <cover.1566168923.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v4 00/14] Multiple simultaneous audio backends
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

Hello,

This is the v4 of my audio patches.  This is a compile-fix revision, hopefully
fixing windows compile errors in "audio: use size_t where makes sense" and
compile errors introduced by changes on master in "audio: add audiodev
properties to frontends".

Regards,
Zoltan

Kővágó, Zoltán (14):
  audio: reduce glob_audio_state usage
  audio: basic support for multi backend audio
  audio: add audiodev property to vnc and wav_capture
  audio: add audiodev properties to frontends
  paaudio: prepare for multiple audiodev
  audio: audiodev= parameters no longer optional when -audiodev present
  paaudio: do not move stream when sink/source name is specified
  paaudio: properly disconnect streams in fini_*
  audio: remove audio_MIN, audio_MAX
  audio: do not run each backend in audio_run
  paaudio: fix playback glitches
  audio: remove read and write pcm_ops
  audio: use size_t where makes sense
  audio: fix memory leak reported by ASAN

 audio/audio.h                    |  37 ++-
 audio/audio_int.h                |  43 ++--
 audio/audio_template.h           |  62 +++--
 audio/mixeng.h                   |   9 +-
 audio/rate_template.h            |   2 +-
 include/hw/qdev-properties.h     |   3 +
 include/sysemu/replay.h          |   4 +-
 ui/vnc.h                         |   2 +
 audio/alsaaudio.c                |  49 ++--
 audio/audio.c                    | 345 ++++++++++++++-----------
 audio/coreaudio.c                |  18 +-
 audio/dsoundaudio.c              |  31 +--
 audio/noaudio.c                  |  39 +--
 audio/ossaudio.c                 |  75 +++---
 audio/paaudio.c                  | 421 ++++++++++++++++++-------------
 audio/sdlaudio.c                 |  30 +--
 audio/spiceaudio.c               |  34 +--
 audio/wavaudio.c                 |  18 +-
 audio/wavcapture.c               |   6 +-
 hw/audio/ac97.c                  |  11 +-
 hw/audio/adlib.c                 |   5 +-
 hw/audio/cs4231a.c               |   5 +-
 hw/audio/es1370.c                |  13 +-
 hw/audio/gus.c                   |   7 +-
 hw/audio/hda-codec.c             |  17 +-
 hw/audio/milkymist-ac97.c        |  14 +-
 hw/audio/pcspk.c                 |   3 +-
 hw/audio/pl041.c                 |   1 +
 hw/audio/sb16.c                  |   3 +-
 hw/audio/wm8750.c                |  10 +-
 hw/core/qdev-properties-system.c |  57 +++++
 hw/usb/dev-audio.c               |   1 +
 monitor/misc.c                   |  22 +-
 replay/replay-audio.c            |  16 +-
 replay/replay.c                  |   2 +-
 ui/vnc.c                         |  15 +-
 hmp-commands.hx                  |  11 +-
 qemu-options.hx                  |   6 +
 38 files changed, 792 insertions(+), 655 deletions(-)

-- 
2.22.0


