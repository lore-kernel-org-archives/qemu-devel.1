Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32CEC73C53
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 18:44:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88D32080C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 18:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjFtnazP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88D32080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkv5s-0000BL-Vk
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 14:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36766)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hkuyK-00049s-O8
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hkuyJ-0003cd-GQ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:53984)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hkuyH-0003Tq-Gq
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:09 -0400
Received: by mail-wm1-x331.google.com with SMTP id x15so4077013wmj.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 11:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UN88soTqDXWMilLS8+rHm39Nzkk1tFEA+2aP3h8swUY=;
 b=mjFtnazPAgrPfJfz8EPfRiEsWGqT+WGGvjh0K5hNnMWuALb9PyqAE/2lWbNk2IUf/J
 ifq0PmRqdpyzf8zHEY0lnVtUqYIBiwfgdPoK0uiTdc6DpEDkYvv5FUYtzq91U3Gx+iGc
 uP3aVTbRbnDGceD92kzeWH2YdvUi7d/YNf9r+1nn1WW3KtcghhXiF9Fk3VzTTisb4QUu
 8T/Y+t8aRPB1sidzgjmXc6bgJVzZbEUGVsxu57cWNvDyh+BoZIcpHbCUKp4kBGn8FSq3
 fekv8kmUr6oBatCxFpixioQMGtSvU28HDXjBK2kZVElyd+WJ0gyha0UeRvKzge17+D8x
 +lmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UN88soTqDXWMilLS8+rHm39Nzkk1tFEA+2aP3h8swUY=;
 b=sFvwrwZbzJLvTR+438R28ysZlTug4lLPi892PWmfUGgy/VAlqPIXSOc2wOuJvOXW5n
 vhh+D6mniVZW/BKxneQ7cibHOAbuL1FTXRVmbKErJtpiZAqljv9cI+biJwFNLTZys8wc
 BaP7rHsU1sCH+J0EFp/tx9gkx0pXy+kbZY6t+KLdyAi81uFMUvYJPPun1kcTi92fX29R
 5LA0wFLXAPGnw8FKjge0Yq99FvT4VXodYOr9SKPKmGNTcY8UUPozJ3YR02pbCKC9NY9X
 vLVEuY6xGc+dNPkGL82H1dtnSKpFAyPxiBdW7atmFy8WsSK2r+9cAx7AvVgaKeYDEECW
 OT9w==
X-Gm-Message-State: APjAAAX+L6YZK3uihGnTPx8F4up1Iqd+AkmP70vOhj/U4UtjT0MfHkpL
 tlIKzKK8sgE6OeoC+MHlPbyHlnaQ
X-Google-Smtp-Source: APXvYqzTyiEmmksu1Vd/UWshFANR0I4gZ5m/sr1Rr2FkqfNc0LPDEA91zlyUqFeP6wyhvQl/cZbQGw==
X-Received: by 2002:a1c:cf0b:: with SMTP id f11mr1087442wmg.138.1562697352958; 
 Tue, 09 Jul 2019 11:35:52 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6e3f-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6e3f::5])
 by smtp.gmail.com with ESMTPSA id c12sm20565042wrd.21.2019.07.09.11.35.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 11:35:52 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 20:35:40 +0200
Message-Id: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
Subject: [Qemu-devel] [PATCH 00/11] Multiple simultaneous audio backends
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

This is my next set of audio patches. This series makes it possible to use
multiple audio backends in a single qemu instance, and contains a few random
cleanup/fix patches.

Regards,
Zoltan

Kővágó, Zoltán (11):
  audio: reduce glob_audio_state usage
  audio: basic support for multi backend audio
  audio: add audiodev properties to frontends
  audio: audiodev= parameters no longer optional when -audiodev present
  paaudio: do not move stream when sink/source name is specified
  paaudio: properly disconnect streams in fini_*
  audio: remove audio_MIN, audio_MAX
  audio: do not run each backend in audio_run
  paaudio: fix playback glitches
  audio: remove read and write pcm_ops
  audio: use size_t where makes sense

 audio/audio.h                    |  36 +--
 audio/audio_int.h                |  43 ++--
 audio/audio_template.h           |  62 +++--
 audio/mixeng.h                   |   9 +-
 audio/rate_template.h            |   2 +-
 include/hw/qdev-properties.h     |   3 +
 include/sysemu/replay.h          |   4 +-
 ui/vnc.h                         |   2 +
 audio/alsaaudio.c                |  49 ++--
 audio/audio.c                    | 339 ++++++++++++++-----------
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
 monitor/misc.c                   |  12 +-
 replay/replay-audio.c            |  16 +-
 replay/replay.c                  |   2 +-
 ui/vnc.c                         |  15 +-
 hmp-commands.hx                  |  11 +-
 qemu-options.hx                  |   5 +
 38 files changed, 781 insertions(+), 642 deletions(-)

-- 
2.22.0


