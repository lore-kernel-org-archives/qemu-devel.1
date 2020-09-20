Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BFDC43469
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 17:15:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C2A20758
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 17:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C2A20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK2wP-0003M3-7n
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 13:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1kK2v3-0002u4-GU
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 13:14:33 -0400
Received: from mailout03.t-online.de ([194.25.134.81]:37248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1kK2uw-0005pi-RU
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 13:14:29 -0400
Received: from fwd24.aul.t-online.de (fwd24.aul.t-online.de [172.20.26.129])
 by mailout03.t-online.de (Postfix) with SMTP id C54B8420D4D6;
 Sun, 20 Sep 2020 19:14:21 +0200 (CEST)
Received: from [192.168.211.200]
 (SrA-u6ZCghxfMxjS3TqHbknMfY4x+Nbh-n0O0XPDVcwl7QprKYwOXc04uGQ1rTgZfQ@[93.236.144.216])
 by fwd24.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kK2ui-2EGIdc0; Sun, 20 Sep 2020 19:14:12 +0200
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: [PATCH 0/9] Audio fixes and improvements
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <84f1c61a-8399-c75e-96c2-febfc2dd5fab@t-online.de>
Date: Sun, 20 Sep 2020 19:14:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ID: SrA-u6ZCghxfMxjS3TqHbknMfY4x+Nbh-n0O0XPDVcwl7QprKYwOXc04uGQ1rTgZfQ
X-TOI-EXPURGATEID: 150726::1600622052-00005513-81399ACB/0/0 CLEAN NORMAL
X-TOI-MSGID: 1ccc9b02-48f4-4560-9a1f-6dfef136a9dc
Received-SPF: none client-ip=194.25.134.81; envelope-from=vr_qemu@t-online.de;
 helo=mailout03.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 13:14:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 SPOOFED_FREEMAIL=1.652 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A few fixes and improvements from my audio patch queue.

It's currently still not possible to reach the function
audio_generic_read(). I tested the patch
 
audio: align audio_generic_read with audio_pcm_hw_run_in

with a modified audio/paaudio.c version. If someone wants
to reproduce the test, replace .read = qpa_read with
.read = audio_generic_read in the audio/paaudio.c pcm_ops
table and start qemu with
-audiodev pa,id=audio0,in.mixing-engine=off.

With best regards,
Volker

Volker Rümelin (9):
  audio: handle buf == NULL in put_buffer_out()
  audio/audio: fix video playback slowdown with spiceaudio
  audio/spiceaudio: always rate limit playback stream
  audio: align audio_generic_read with audio_pcm_hw_run_in
  audio: remove unnecessary calls to put_buffer_in
  audio: align audio_generic_write with audio_pcm_hw_run_out
  audio: run downstream playback queue unconditionally
  audio: restore mixing-engine playback buffer size
  audio: revert tests for pcm_ops table

 audio/alsaaudio.c   |   1 +
 audio/audio.c       | 136 +++++++++++++++++++++++++++++++++-----------
 audio/audio_int.h   |   7 ++-
 audio/coreaudio.c   |   3 +
 audio/dsoundaudio.c |   6 ++
 audio/jackaudio.c   |   1 +
 audio/noaudio.c     |   1 +
 audio/ossaudio.c    |  12 ++++
 audio/paaudio.c     |   6 ++
 audio/sdlaudio.c    |   3 +
 audio/spiceaudio.c  |  27 +++++----
 audio/wavaudio.c    |   1 +
 12 files changed, 161 insertions(+), 43 deletions(-)

-- 
2.26.2


