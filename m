Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00087C433EF
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD04216C8
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxRqOsJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD04216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i74gA-00073x-BS
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 17:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74do-0005OK-Ey
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74dl-0005l1-B1
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:34 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c]:32922)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i74dh-0005j2-TL
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:31 -0400
Received: by mail-qk1-x72c.google.com with SMTP id x134so11155733qkb.0
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2019 14:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fyZGhiKEUGgbY5xS1A2Merr8hk8W0hJ0+MbnsIX166o=;
 b=bxRqOsJiGJCvF6mYXyNuNgszx3K9g9aA2Kq3B3Jz2ae06svL7g5khJpY0Fz0GwzDGg
 WverXn278E29JvHmdcsAPQYzm4DENOUkIQoVfKPC2I1wkhpahhn7kAoAu49bQKszckRl
 Ppo0rfx2a5FjsFAL5ZhurLujvHQ+P6a3Sl1QrDdtJ10jO/pVpL2L4eGSQ3yl+55fDDPF
 rFQjuiBzhvECnda3r4J0ffhjZa21Rv2Gs5qf+wsZjejm4ATf1/Lqi+6qzQ6dph1kApZv
 1YcICP12Ac+84htHp8SFC3WfsD8QwTc78Ft6koMYJYPZ+/S9LZF77cIkurMXMHrNVndh
 0paA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fyZGhiKEUGgbY5xS1A2Merr8hk8W0hJ0+MbnsIX166o=;
 b=iMOXy/AYXJhthxu3ckoLP5Keiv1T4c985g5GXw+b10NFHW7+/B/v/FjZe5by7T+iJH
 Hu62pKS1b8hDZcxJlutsduG3f/lwKJm6FtbVhGtF7tIlkC27yUq3pGa7bKmLQBpAdxyk
 RCNbq/t5s/08hfnQ5QGCuvfK3Nt23duZzEWw30xcO5l9S6uGwbpq1PyT4DhuHnTh+7cL
 AZ5XGGCpth2MxlpQtesgXvNImVwhHuhVaFivRHAp5cVXJX1yBruBhHbyFek7xWy1fzjB
 4yyb3xA2ZS3saOnbBVR2vaI1l5GBzfUetrWuElc6j8YRgpH2oIMmoRqkEJoSyo6BO9dH
 9ZLg==
X-Gm-Message-State: APjAAAXvPkXtkl/UXcZvDkD8q+RrQJPeMdKAq8aA1AiJZrIlS7lZ6a4H
 +lH6JSnVmI9OPzbw0AeR6p171rTw
X-Google-Smtp-Source: APXvYqz1zwxf6/rcB32cy2n/f85/HP7e5XQl+/pZA4jwIEHO6iOS5d0HIzVFNHXJZwX9NhlRWUSJKw==
X-Received: by 2002:a37:c0f:: with SMTP id 15mr14079912qkm.73.1567977748029;
 Sun, 08 Sep 2019 14:22:28 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6ea8-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6ea8::5])
 by smtp.gmail.com with ESMTPSA id e2sm5488112qkg.38.2019.09.08.14.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2019 14:22:27 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 23:22:00 +0200
Message-Id: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::72c
Subject: [Qemu-devel] [PATCH v2 00/24] Audio: Mixeng-free 5.1/7.1 audio
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

This is the v2 of my patch series that makes mixeng optional and enables
more than two audio channels.

Changes from v1:

* renamed "mixeng" option to "mixing-engine"
* dropped patch "audio: remove hw->samples, buffer_size_in/out pcm_ops"


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
 audio/audio.c           | 522 ++++++++++++++++++++++++++++--------
 audio/audio.h           |  10 +
 audio/audio_int.h       |  81 ++++--
 audio/audio_pt_int.c    | 173 ------------
 audio/audio_pt_int.h    |  22 --
 audio/audio_template.h  |  31 ++-
 audio/coreaudio.c       | 143 +++++-----
 audio/dsound_template.h |  53 ++--
 audio/dsoundaudio.c     | 361 +++++++------------------
 audio/noaudio.c         |  78 +++---
 audio/ossaudio.c        | 360 ++++++++++---------------
 audio/paaudio.c         | 566 +++++++++++++---------------------------
 audio/sdlaudio.c        | 104 ++++----
 audio/spiceaudio.c      | 252 ++++++------------
 audio/wavaudio.c        |  78 ++----
 configure               |   5 -
 hw/usb/dev-audio.c      | 459 +++++++++++++++++++++++++++-----
 qapi/audio.json         |  12 +-
 qemu-options.hx         |  15 ++
 21 files changed, 1689 insertions(+), 2009 deletions(-)
 delete mode 100644 audio/audio_pt_int.c
 delete mode 100644 audio/audio_pt_int.h

-- 
2.23.0


