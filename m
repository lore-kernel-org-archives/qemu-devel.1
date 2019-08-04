Return-Path: <SRS0=5wN1=WA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED94C433FF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 17:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628C42070D
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 17:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws7IRkji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628C42070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huJww-00043y-LV
	for qemu-devel@archiver.kernel.org; Sun, 04 Aug 2019 13:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56576)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1huJvz-0002Nh-1K
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1huJvt-000401-Gi
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:38 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1huJvs-0003zD-RG
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:33 -0400
Received: by mail-wm1-x343.google.com with SMTP id u25so60507754wmc.4
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2019 10:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m7LCtTDj0fijAXjIiwnWl0hY+zZ5Dq+vR6Akwfj3lVI=;
 b=Ws7IRkjiTfC1eMJxkncEmh7fIQcjrwLmud4T6/nP8PcwESouk5/xTZ8FpCzjXQwy8Q
 UNzw6Nk59WpQkBVdkQWnbFmxs/dSizGPc4Mc7uKorfX4Ag2iYAv5RmYOtFGwyK39wWqB
 BTylKYOGpSEoABLRW02YKAQGqvreltstBkXkSIBkMPFSWlaYtcQ6Bfsbn9BrxvJ9Lud3
 TqPyzDf3GAKMTVNmZP/LxLj9eGQ7ZO/AGLK3JmY/y56y18yp/nLVVMpWmgXSqtN1r2dR
 oiUVyMBkrRBcHU9AblyjhAWvaWVL1TK5EeFSN6LNtEkmy1OC+Y7GDA67lorgaxKEq66U
 F38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m7LCtTDj0fijAXjIiwnWl0hY+zZ5Dq+vR6Akwfj3lVI=;
 b=lS3YC7eRwkbTPIDBJfauPlQZIFRrMzQmsQBt3ugWKpndgrQijjuPayjmxvIFBWgP+s
 XeReBJjf8w2K/0tLhltqK5NbcvMwXyvyIpGIHOr7YGsPHUIrqHl9nSGt6z/XmufdDSJD
 m9YIZzrQ4zKCtgXPmhfuLBodIQHLYu+CpGOrUX1qzV8oGNYNs3+fMBobHlLRSvngyWwm
 kQCRUPZMRF75yythsnZ4+NnT+A45T2szEM2q7KNVt8zyrp8vj7kNl+zsFAJHeYdKw8p6
 DcHMV3BB2JDoQ2ChICPMQkmlI97KA1X6C30X4otn1mhpL7qUG+x1nbdlKZsM1EwICVoj
 JA2w==
X-Gm-Message-State: APjAAAWHuyYMNwJpaMjNWYXngtidwyXpi5++T/ciM4wb699AwUHKwog4
 ho7+Rc+DlCt4DdHPpm9p+1yHInY6
X-Google-Smtp-Source: APXvYqy+a+fJSXyR6hI5YidT3xAN2WMkwpwuyaAYde5rj6GIAzLg9Wfe8j5EY2l/9JJBL5tL491N5g==
X-Received: by 2002:a7b:c202:: with SMTP id x2mr13848021wmi.49.1564938268635; 
 Sun, 04 Aug 2019 10:04:28 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-632c-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:632c::5])
 by smtp.gmail.com with ESMTPSA id s10sm104876106wmf.8.2019.08.04.10.04.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 04 Aug 2019 10:04:27 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  4 Aug 2019 19:04:12 +0200
Message-Id: <cover.1564925486.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v3 00/14] Multiple simultaneous audio backends
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

This is the v3 of my audio patches.  audiodev argument of wavcapture hmp
is now mandatory.

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

 audio/audio.h                    |  36 +--
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
 audio/dsoundaudio.c              |  25 +-
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
 38 files changed, 788 insertions(+), 652 deletions(-)

-- 
2.22.0


