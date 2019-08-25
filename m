Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07081C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 18:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B0120578
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 18:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZheRN21h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B0120578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1xYq-0002e9-Cf
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 14:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xX7-00014y-GQ
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xX6-0004io-6P
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:33 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:39066)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i1xX6-0004iY-0o
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:32 -0400
Received: by mail-qt1-x844.google.com with SMTP id l9so15938167qtu.6
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A6ESYrrk1RHaujtv9bh5UgqxegfLbnO8n/HOQdRhxc0=;
 b=ZheRN21hij3buBR2pU8P44FMoxEehY/WjXbWG/SHq/lYG5cwrrbcmvazfKEVjeano9
 agT/VL7/pSdimxmKk92e22fW8IJ5i5qHopgNvEVy89hF6jzRoUglT02CqbxSz7OWg7YQ
 7AHz9lwBENLrG0uIL+mYPByDjTQ4DCJZAvHpwGisJxtDX+rgqwAy8WaFLP3fgamwLQ51
 lgbnALWKeonrrLT0MECl/5181l8FH5jr1uKBnE3g5SnIRM6EorMEvNDYAga4IjIEUEL/
 d67R4IXVdVwSjKiaFICdWMNL9IlsFHd56OGQsUP6+jUSEo2F9c19pGNv2tQxdzcQwubC
 bx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A6ESYrrk1RHaujtv9bh5UgqxegfLbnO8n/HOQdRhxc0=;
 b=ezDQzxRNyfL5FHDhDAJZ5c83oy1PTmM2qFwjH91k/fQCTyTvh1/kQ8yRkT0smbM/3n
 57VH7Z+nazyzfwaKEPxzRYRU6NDVFS4EC2VVN87X3i8nmd2QNDFpJM4RLAhdT9B3ysMQ
 4A22Wfi7j77txIWYFrdQqDFpu/XnZGBjj/Z40MGHnp67LpDLYBWj6lZMN/TFHLj2+xfR
 o4nk/mG+Tur2sId6l45MlsLM6q6iNbZcGn8f40jtqSJ7sVARFjvx/8yIvqCMr1Pw7U+Y
 VBSKhZEI0ocCoXcFlAYBKFvDB/vrtlx5EvdPipNcNe7SqlzNfHXUacH6toc3ce/JZC71
 lVLw==
X-Gm-Message-State: APjAAAU9D/4NEidcMBqUWPSfe02vuhZMz4n4BP/16W1cd5O+6clx7uVc
 fa/acn16iUM0CXDP3WA5q79Vb0vIcwY=
X-Google-Smtp-Source: APXvYqzvVvScTzfYwJ8eWT5uWwvYn9FZBvYmxchhyaCDmLgdnISuJHch3ZI9JzT2Vah8245HgcieTg==
X-Received: by 2002:a0c:fb07:: with SMTP id c7mr12666778qvp.230.1566758791071; 
 Sun, 25 Aug 2019 11:46:31 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-61b1-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:61b1::5])
 by smtp.gmail.com with ESMTPSA id d3sm5348870qtq.32.2019.08.25.11.46.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 11:46:30 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 25 Aug 2019 20:46:02 +0200
Message-Id: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: [Qemu-devel] [PATCH 00/25] Audio: Mixeng-free 5.1/7.1 audio support
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

This is the final part of my audio patch series that finally makes
mixeng optional and lifts the restriction of only supporting two
channels of audio.

It probably gained a bit of dust in the last few years, I've fixed most
issues reported by checkpatch, but there might be other problems.

Regards,
Zoltan

Kővágó, Zoltán (25):
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
  audio: remove hw->samples, buffer_size_in/out pcm_ops
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

 configure               |   5 -
 qapi/audio.json         |  12 +-
 audio/audio.h           |  10 +
 audio/audio_int.h       |  84 ++++--
 audio/audio_pt_int.h    |  22 --
 audio/audio_template.h  |  55 ++--
 audio/dsound_template.h |  59 +++--
 audio/alsaaudio.c       | 398 +++++++++-------------------
 audio/audio.c           | 524 ++++++++++++++++++++++++++++--------
 audio/audio_pt_int.c    | 173 ------------
 audio/coreaudio.c       | 153 ++++++-----
 audio/dsoundaudio.c     | 387 ++++++++-------------------
 audio/noaudio.c         |  78 +++---
 audio/ossaudio.c        | 392 +++++++++++----------------
 audio/paaudio.c         | 573 +++++++++++++---------------------------
 audio/sdlaudio.c        | 112 ++++----
 audio/spiceaudio.c      | 270 +++++++------------
 audio/wavaudio.c        |  79 ++----
 hw/usb/dev-audio.c      | 461 +++++++++++++++++++++++++++-----
 audio/Makefile.objs     |   1 -
 qemu-options.hx         |  15 ++
 21 files changed, 1815 insertions(+), 2048 deletions(-)
 delete mode 100644 audio/audio_pt_int.h
 delete mode 100644 audio/audio_pt_int.c

-- 
2.22.0


