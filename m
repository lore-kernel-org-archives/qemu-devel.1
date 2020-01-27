Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A70EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 20:41:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DE4E24681
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 20:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE4E24681
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwBCP-0007Qs-BH
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 15:41:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vr_qemu@t-online.de>) id 1iwBBN-0006pw-PC
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 15:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vr_qemu@t-online.de>) id 1iwBBM-00070b-Ec
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 15:40:29 -0500
Received: from mailout04.t-online.de ([194.25.134.18]:46896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vr_qemu@t-online.de>) id 1iwBBM-0006zl-8P
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 15:40:28 -0500
Received: from fwd40.aul.t-online.de (fwd40.aul.t-online.de [172.20.26.139])
 by mailout04.t-online.de (Postfix) with SMTP id 31E7341B73F7;
 Mon, 27 Jan 2020 21:40:25 +0100 (CET)
Received: from [192.168.211.200]
 (X7--QsZBghttnuwLOOdDCWlSFnbRYcpV7Jr2uK+TaN-QJbEXf7Uq+MFj8ZZjxs3Z8B@[46.86.62.122])
 by fwd40.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1iwBBI-2D6FpA0; Mon, 27 Jan 2020 21:40:24 +0100
Subject: Re: [PATCH 0/9] more audio fixes and improvements
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <1e29e1d3-b59b-fcd6-cdff-a680bcdbffa4@t-online.de>
 <082c8009-9bd4-3e2e-4846-359e637895b8@ilande.co.uk>
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Message-ID: <ace44536-837f-b1aa-b229-7757c111dee1@t-online.de>
Date: Mon, 27 Jan 2020 21:40:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <082c8009-9bd4-3e2e-4846-359e637895b8@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-ID: X7--QsZBghttnuwLOOdDCWlSFnbRYcpV7Jr2uK+TaN-QJbEXf7Uq+MFj8ZZjxs3Z8B
X-TOI-MSGID: 91de2f02-c3ee-4972-aeb6-e6777df8629a
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 194.25.134.18
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>, QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> On 23/01/2020 07:41, Volker R=C3=BCmelin wrote:
>
>> The first two patches "audio: fix audio_generic_write" and
>> "audio: fix audio_generic_read" are only compile tested. The
>> code is only reachable from the DirectSound backend with the
>> mixing-engine off. I don't know if it is reachable at all.
>> I can't test because I don't have a Windows computer.
>>
>> Volker R=C3=BCmelin (9):
>>   audio: fix audio_generic_write
>>   audio: fix audio_generic_read
>>   paaudio: remove unused variables
>>   audio: prevent SIGSEGV in AUD_get_buffer_size_out
>>   audio: fix bug 1858488
>>   ossaudio: prevent SIGSEGV in oss_enable_out
>>   ossaudio: prevent SIGPFE in oss_write
>>   ossaudio: disable poll mode can't be reached
>>   audio: audio_generic_get_buffer_in should honor *size
>>
>>  audio/alsaaudio.c |  1 +
>>  audio/audio.c     | 77 ++++++++++++++++++++++++++--------------------=
---------
>>  audio/audio_int.h |  4 +--
>>  audio/coreaudio.c |  7 +++--
>>  audio/noaudio.c   |  1 +
>>  audio/ossaudio.c  | 28 ++++++++++++--------
>>  audio/paaudio.c   |  6 ++---
>>  audio/sdlaudio.c  |  7 +++--
>>  audio/wavaudio.c  |  1 +
>>  9 files changed, 71 insertions(+), 61 deletions(-)
> Thanks for your patches! I've had reports from some of the PPC emulatio=
n guys that
> the switch to the new audio API broke the coreaudio backend on Macs (se=
e
> https://bugs.launchpad.net/qemu/+bug/1859916) and I've pointed them tow=
ards this
> patchset, but sadly it still doesn't appear to fix the issue.
>
> Have you seen any issues with the coreaudio backend during your testing=
?

Hi Mark,

I didn't test coreaudio. I don't have a Mac. One of my patches changes co=
reaudio.c=20
because I renamed a function.

With best regards,
Volker

> ATB,
>
> Mark.


