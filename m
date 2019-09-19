Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C198C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3EB21920
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e62EpKiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3EB21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB3xi-0004og-Uz
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 17:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iB3ub-0002br-CB
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iB3ua-0000Vt-0z
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:25 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iB3uZ-0000VS-RO
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:23 -0400
Received: by mail-wr1-x444.google.com with SMTP id r5so4573992wrm.12
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iNs6eWt27MaIpb40H1K4tAhbXFDvNNI6le6zoh48hB4=;
 b=e62EpKiRxju08VS+aSD3PFQV5caaMjrLbSd6LYtFBmDmSiHqSmuNOwAdgUu8RrEttV
 EnjLXOObObDetJC4cuGDPyEBbWVU7B6pvLTr1N1m+GZLe4EziZ0jmVmAOWZfkza2UL35
 m52jBxbSfvvmnFNOIFVwpqqpK6xUrtR2L80vDXMk+c0eq5T74vHaopgaOQwpZyK9/7mG
 epX/ldz+xMGAoxGPjC7cRfFzYOt1UeHrrQsErsQkepSEfl07mlSvYok6JT8AEQrPfia2
 cRI8BhFkmNXJ/lb1Xq96O+1xT9KzNfsImq+ynCcgTi+vsv75LFlz1EvLEvV2+O+GBLtJ
 m8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iNs6eWt27MaIpb40H1K4tAhbXFDvNNI6le6zoh48hB4=;
 b=cC7+Nt/7xQ/td/+/hVXjP3Hw3sln9SEKYxk/YPoWWdthAFKE6UzyMQGXVjuVOS0X5f
 PK57893Pgrk5tAs4vFFnuSiMovHQmfREM9o4vCQoFDU+jKtOMFAjdn0eEhsOi6SeIBTJ
 omMpfbrI8lkfRJIXpwawKoZ199n5fHyjPzAqIdZRvHOts2aUJJQKWlSWNKzPcW22utXZ
 f6vSFcIsXVUzNndCx08WVObOUsSLhxnEdOmGxG91zEQ0o02CAp7KMN18qq4A856f+0AU
 /3sDZFuikZqP4DEk1v4nce0Pp053tgSdqtDMLdkzGZOJClC1kmldzlFFPmg/YY2Qy5l9
 PTbQ==
X-Gm-Message-State: APjAAAUavTkONAKOTHUSJR7Y8ntqEFGOgXMNCTQ2HCe0nHWMUGvZdHhG
 U+Bf7Mxbqai2KeDvNkyQSn+pp2AH
X-Google-Smtp-Source: APXvYqwOTLd8msQlrkN8nANBKVH+X0dzOMORdlf1JF+xlk4eYIZTXOeaFDriV+5cvZyRLaaymfbZmg==
X-Received: by 2002:a5d:5692:: with SMTP id f18mr8310530wrv.68.1568928262082; 
 Thu, 19 Sep 2019 14:24:22 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.gmail.com with ESMTPSA id w125sm13191292wmg.32.2019.09.19.14.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:24:21 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/24] Audio: Mixeng-free 5.1/7.1 audio support
Date: Thu, 19 Sep 2019 23:24:08 +0200
Message-Id: <cover.1568927990.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

This is the newest iteration of my mixeng-free audio patches.

Changes from v3:

* fixed typo in documentation
* fix wavaudio format-string error on 32-bit targets.

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
  audio: add mixing-engine option (documentation)
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


