Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1093C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB6820842
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB6820842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8qRE-0003MT-TK
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 14:09:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vr_qemu@t-online.de>) id 1j8qQd-0002uk-LZ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:08:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vr_qemu@t-online.de>) id 1j8qQc-0003kE-C9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:08:35 -0500
Received: from mailout01.t-online.de ([194.25.134.80]:46288)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vr_qemu@t-online.de>) id 1j8qQc-0003j9-6K
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:08:34 -0500
Received: from fwd15.aul.t-online.de (fwd15.aul.t-online.de [172.20.27.63])
 by mailout01.t-online.de (Postfix) with SMTP id 30A2942E105E;
 Mon,  2 Mar 2020 20:08:31 +0100 (CET)
Received: from [192.168.211.200]
 (JT5870ZSYh137EF-PB8lqZxgZXyWvPjg3EPbY7fK68QIcbfWzHTl2ZGs7s+2DXXZ74@[79.208.28.226])
 by fwd15.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1j8qQY-24ZBj60; Mon, 2 Mar 2020 20:08:30 +0100
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: [PATCH 0/5] mostly changes related to audio float samples
To: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <417bfe2f-e3c1-d83d-b437-47859daf524d@t-online.de>
Date: Mon, 2 Mar 2020 20:08:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-ID: JT5870ZSYh137EF-PB8lqZxgZXyWvPjg3EPbY7fK68QIcbfWzHTl2ZGs7s+2DXXZ74
X-TOI-MSGID: 398b4faf-ad5c-4a72-a68e-1337d81451aa
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.80
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
Cc: John Arbuckle <programmingkidx@gmail.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch "audio: change naming scheme of FLOAT_CONV macros" and
patch "audio: consistency changes" should have been a review
for ed2a4a7941 "audio: proper support for float samples in
mixeng", but I was too slow.

Patch "audio: change mixing engine float range to [-1.f, 1.f]"
definitely needs to be tested by macOS users. I verified
PulseAudio, SDL2 and ALSA (actually libasound) work, but I
don't want to introduce a regression for CoreAudio. I spent
some time on https://developer.apple.com but I couldn't find
the answer if CoreAudio uses the [-1.f, 1.f] range too. The
results from my favorite search engine suggest the answer is
yes.

@Howard:
I need your help once again. Can you please test if you can
hear (or see) clipping with my patches? Don't forget to set all
volume controls in the guest and on the host to 100% or 0dB to
get a reliable result. Compared to qemu without these patches I
expect the playback volume is a bit louder, but there's still
no clipping.

Volker R=C3=BCmelin (5):
  qapi/audio: add documentation for AudioFormat
  audio: change naming scheme of FLOAT_CONV macros
  audio: consistency changes
  audio: change mixing engine float range to [-1.f, 1.f]
  audio: fix saturation nonlinearity in clip_* functions

 audio/mixeng.c          | 26 +++++++++++++-------------
 audio/mixeng_template.h | 22 ++++++++++------------
 qapi/audio.json         | 14 ++++++++++++++
 3 files changed, 37 insertions(+), 25 deletions(-)

--=20
2.16.4


