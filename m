Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9626EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F25F207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UO5fbSvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F25F207CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdSiD-0006oA-JZ
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 02:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdShJ-0005oD-It
 for qemu-devel@nongnu.org; Tue, 26 May 2020 02:04:22 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdShI-0007hP-TP
 for qemu-devel@nongnu.org; Tue, 26 May 2020 02:04:21 -0400
Received: by mail-wr1-x444.google.com with SMTP id x13so4514205wrv.4
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 23:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Fua+2b0VAES8ouY8gF3U6zKUILyMDJGxAhyMjk/ZVTc=;
 b=UO5fbSvDsbacS4gekjHcgcaHl0pHAGNvfdkd4OrfCHwd0mpjFGh0qwqVlU9YuKGpDJ
 wNxNuxQfPAe7WK7+glFmW8FX1omf7XW0RqdNT75e8raGCWyETB8+CM5JYBTbIkk/sA1L
 kENi6PUPceQZ+MNSjclFz3/fIGPW/bGtisV2ysyzEXbtUJAqT8h1voVu3yC53igNx+36
 HAfGHp+jY7SdQttIVY+M5nKrh/euqqk7r1s7+jvPYbCexT4b+Cn/yV3t7I9UNa7G3qSS
 RK+AmQBzDOJZGwzn5NxUAi4OdTvOeZPSv5r1R3bEmleGK55MWCXVY+3T5oEIVe4iAtra
 GTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fua+2b0VAES8ouY8gF3U6zKUILyMDJGxAhyMjk/ZVTc=;
 b=qQwWbxAC/D6YARhao6OQcAu5wykVCvLddhBB9lkgm7xtRKQDgB2IHh5mpdprVn8HJn
 P6jlsSL4Ya3NruNIu30ksk7hx7UjIC3iHYP5qyPRdi078GyUkWfGJFpgEFREe7H2pDUS
 wFHisrxe/yF+py6ygdmojI8V6gbNbvK6XIN7G5vv9EIA9983UclsTFiC0yvmmLXGMvJB
 gPjOJ43Gz4R4CAb5CGyy2AAzVc6jjS1xcV3S0DJ5kZSJ7rm0R33L7p1bEUmTdV5b1+RT
 23Js93BsaoYPsGOnTrUqXBNwtIQ/LbtQF77sIbAAA/OMUzOuONf0vvJIaJIMO3Ff69c9
 +AwA==
X-Gm-Message-State: AOAM533R3+PPcWmhLdo9aJ09DexnppHJa6sIjuVFl2YprbvkRbhK1SQ2
 Dk9uA+94OOHsFVx1ZjFvJH0=
X-Google-Smtp-Source: ABdhPJxaQtJm2Ptjqmgs4tg4kBYirTDYajluQiD1zY0Rdr0SCp0FgZI+YsgXKs6sUgruTBl3VH3MOw==
X-Received: by 2002:a05:6000:1106:: with SMTP id
 z6mr18085543wrw.336.1590473059358; 
 Mon, 25 May 2020 23:04:19 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id p4sm20610162wrq.31.2020.05.25.23.04.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 23:04:18 -0700 (PDT)
Subject: Re: [PATCH 0/7] audio: Spring cleaning
To: qemu-devel@nongnu.org
References: <20200505132603.8575-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <47df77c5-cac4-e23b-5651-3011fe4409d4@amsat.org>
Date: Tue, 26 May 2020 08:04:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505132603.8575-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <DirtY.iCE.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 3:25 PM, Philippe Mathieu-Daudé wrote:
> Cleaning old branches, salvaging what seems worthwhile...
> This series is from the time I wanted cleaner buffer handling
> to avoid abuses, started with chardev/ but got lost with reviews.
> audio/ is smaller, so easier.
> 
> - Convert various prototypes to use const buffers
> - Expose 'audio/audio.h' via public include directory.
> 
> Philippe Mathieu-Daudé (7):
>   audio: Let audio_sample_to_uint64() use const samples argument
>   audio: Let capture_callback handler use const buffer argument

Ping for 1 & 2 maybe?

>   audio: Move advance() helper to 'audio_int.h'
>   audio: Split advance() helper as in() and out()
>   audio: Let HWVoice write() handlers take a const buffer
>   audio: Let AUD_write() use a const buffer argument
>   audio: Expose 'audio/audio.h' under the include/ directory
> 
>  audio/audio_int.h                | 25 +++++++++++++++++++------
>  {audio => include/audio}/audio.h | 14 ++++----------
>  audio/alsaaudio.c                |  8 ++++----
>  audio/audio.c                    | 19 ++++++++++---------
>  audio/audio_legacy.c             |  2 +-
>  audio/audio_win_int.c            |  2 +-
>  audio/coreaudio.c                |  7 ++++---
>  audio/dsoundaudio.c              |  4 ++--
>  audio/mixeng.c                   |  6 +++---
>  audio/noaudio.c                  |  4 ++--
>  audio/ossaudio.c                 | 10 +++++-----
>  audio/paaudio.c                  |  6 +++---
>  audio/sdlaudio.c                 |  8 +++++---
>  audio/spiceaudio.c               |  4 ++--
>  audio/wavaudio.c                 |  4 ++--
>  audio/wavcapture.c               |  4 ++--
>  ui/vnc.c                         |  2 +-
>  MAINTAINERS                      |  1 +
>  18 files changed, 71 insertions(+), 59 deletions(-)
>  rename {audio => include/audio}/audio.h (95%)
> 

