Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C96C3524A
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 14:04:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B604120679
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 14:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B604120679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyFrf-0003DN-W6
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 09:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vr_qemu@t-online.de>) id 1iyFqq-0002kf-Nf
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 09:03:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vr_qemu@t-online.de>) id 1iyFqp-0003W8-J3
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 09:03:52 -0500
Received: from mailout10.t-online.de ([194.25.134.21]:57614)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vr_qemu@t-online.de>) id 1iyFqp-0003VO-Co
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 09:03:51 -0500
Received: from fwd29.aul.t-online.de (fwd29.aul.t-online.de [172.20.26.134])
 by mailout10.t-online.de (Postfix) with SMTP id 600AC4169294;
 Sun,  2 Feb 2020 15:03:48 +0100 (CET)
Received: from [192.168.211.200]
 (bLF3D4ZBYh4LOByp52kgkgnv8FfJbHK6S+8NwEqIMIZ-iYzugFwLDi5ijaSEI4swqA@[93.236.154.40])
 by fwd29.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1iyFqi-1KYWMS0; Sun, 2 Feb 2020 15:03:44 +0100
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: [PATCH 0/1] coreaudio: fix coreaudio playback
To: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <dirty.ice.hu@gmail.com>, Howard Spoelstra <hsp.cat7@gmail.com>,
 Programmingkid <programmingkidx@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <30c8b9e6-484c-5785-b178-bef01628db49@t-online.de>
Date: Sun, 2 Feb 2020 15:03:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-ID: bLF3D4ZBYh4LOByp52kgkgnv8FfJbHK6S+8NwEqIMIZ-iYzugFwLDi5ijaSEI4swqA
X-TOI-MSGID: 7edc1606-c20f-4528-a73f-addf3975737f
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.21
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
Cc: qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

here is a new patch for the CoreAudio playback problem. This patch
is Zolt=C3=A1n's patch from
https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg02142.html
and a improved version of my patch squashed together.

I actually tested the changes in audio/audio_template.h,
audio/mixeng.c and audio/mixeng.h with all useful permutations of
FLOAT_MIXENG and RECIPROCAL defined/undefined.

@Howard and John
Can you please test this patch? Compared to the patches you tested
this patch is quite different.

@John
'git am exported_mail.eml' knows how to handle
Content-Transfer-Encoding: in a mail file. It's not necessary to
apply this patch by hand.

Volker R=C3=BCmelin (1):
  coreaudio: fix coreaudio playback

 audio/audio_template.h |  7 +++++++
 audio/coreaudio.c      | 32 +++++++++-----------------------
 audio/mixeng.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 audio/mixeng.h         |  5 +++++
 4 files changed, 69 insertions(+), 23 deletions(-)

--=20
2.16.4


