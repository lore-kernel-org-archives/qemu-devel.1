Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B458C4CEC7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC06B20830
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsQg6kKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC06B20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9aJv-00015Q-Kb
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 15:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7a-0005wG-FL
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7Z-0001wf-8p
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:42 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:37071)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i9a7Z-0001wZ-3K
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:41 -0400
Received: by mail-ed1-x543.google.com with SMTP id i1so31286544edv.4
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 12:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZTU5jLClRXmm07p3hBrUPaHvGbZyzECyrX2o1d804so=;
 b=ZsQg6kKhFgzcJWhnO+0Lww8qmbdQZhq0HkQoYFHmvMkfE3mP1aDE2ISMhxfNKIAuKj
 YLv9XweAGB5r5PllTyn+F/325gHhRH/gNBIGd9eT7tW4WisKWCsdNQbaJT534yKGA2Wq
 71RiVt3c6mWlUxvZAtGvbzcq5+spW5oiaZWr36zsJPgJIe0t1+sYW3klerL4+0k3Zt/u
 zzhEqXpQxMygKvKNb1XKi1O1TCBPwBOOng28qwNx5/0qH4rPNVikc1brcQnf0nRRpjTe
 Di5/qC/gXKXLodOfYW10zv4scy55y5G6BAN1ylhvfWBk8WuuJ11hcoDYXyaXEXbt8AjU
 No+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZTU5jLClRXmm07p3hBrUPaHvGbZyzECyrX2o1d804so=;
 b=OHFmq4yt9xbyIdEivlqe1fUIeTHzf14qlkc2hK88adXCSynfjxE+3Fe2/5if82BjMz
 /+IM12TPufojUqojhVcZeIbsCpTk4cgVL2npNXaRhUPAlRqkO4uVIBltpvZWrOQ8Dg9F
 v6HlVUfVi4DVMV5nY15LIYhUdkqtsPFzEpu/ZFXVbHBD9HQADvrrtA+tk7rouWaz7R85
 8P9H8y7eSb38ju1g3WF9zc1RGoMNxGSZdJzOhivY/TS7jTLaP2XGVSn7PWSXa0jSmZvh
 YD3aIgFoWh/Frv3Ch4NCJ1Opjt2TSXaWYn3kEBbQFKcPJg3VsPEGM31N7g2DEPGELg8i
 iilQ==
X-Gm-Message-State: APjAAAXbUTHzIGYur/6PPzOklqlWAoz4qGoeKFlBLIH9YMaF0e0JzkwG
 tq16HSaN2X6ySZzo7Q+fl2mXqGLq
X-Google-Smtp-Source: APXvYqxTxA9gm0UJSNCGdSAoD5oOnPkr2cLML4fuxMy3gejzWwGe9Z/Hzupk6KP3u3RpXLzwJF/RUQ==
X-Received: by 2002:a17:906:5a8d:: with SMTP id
 l13mr48851078ejq.219.1568575419238; 
 Sun, 15 Sep 2019 12:23:39 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.gmail.com with ESMTPSA id j20sm6480562edy.95.2019.09.15.12.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 12:23:38 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 21:23:16 +0200
Message-Id: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: [Qemu-devel] [PATCH v3 00/24] Audio: Mixeng-free 5.1/7.1 audio
 support
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

Hi,

I've updated my patch series, fixing some bugs related to spice audio.
This should now work with all supported backends on linux, dsound and
coreaudio remain untested.

Regards,
Zoltan

Kővágó, Zoltán (24):
  audio: api for mixeng code free backends
  alsaaudio: port to the new audio backend api
  coreaudio: port to the new audio backend api
  dsoundaudio: port to the new audio backend api
  noaudio: port to the new audio backend api
  ossaudio: port to the new audio backend api
  paaudio: port to the new audio backend api
  sdlaudio: port to the new audio backend api
  spiceaudio: port to the new audio backend api
  wavaudio: port to the new audio backend api
  audio: remove remains of the old backend api
  audio: unify input and output mixeng buffer management
  audio: common rate control code for timer based outputs
  audio: split ctl_* functions into enable_* and volume_*
  audio: add mixeng option (documentation)
  audio: make mixeng optional
  paaudio: get/put_buffer functions
  audio: support more than two channels in volume setting
  audio: replace shift in audio_pcm_info with bytes_per_frame
  audio: basic support for multichannel audio
  paaudio: channel-map option
  usb-audio: do not count on avail bytes actually available
  usb-audio: support more than two channels of audio
  usbaudio: change playback counters to 64 bit

 audio/Makefile.objs     |   1 -
 audio/alsaaudio.c       | 372 ++++++++------------------
 audio/audio.c           | 527 +++++++++++++++++++++++++++++--------
 audio/audio.h           |  10 +
 audio/audio_int.h       |  81 ++++--
 audio/audio_pt_int.c    | 173 ------------
 audio/audio_pt_int.h    |  22 --
 audio/audio_template.h  |  31 ++-
 audio/coreaudio.c       | 143 +++++-----
 audio/dsound_template.h |  53 ++--
 audio/dsoundaudio.c     | 359 +++++++------------------
 audio/noaudio.c         |  78 +++---
 audio/ossaudio.c        | 360 ++++++++++---------------
 audio/paaudio.c         | 566 +++++++++++++---------------------------
 audio/sdlaudio.c        | 104 ++++----
 audio/spiceaudio.c      | 256 +++++++-----------
 audio/wavaudio.c        |  78 ++----
 configure               |   5 -
 hw/usb/dev-audio.c      | 459 +++++++++++++++++++++++++++-----
 qapi/audio.json         |  12 +-
 qemu-options.hx         |  15 ++
 21 files changed, 1697 insertions(+), 2008 deletions(-)
 delete mode 100644 audio/audio_pt_int.c
 delete mode 100644 audio/audio_pt_int.h

-- 
2.23.0


