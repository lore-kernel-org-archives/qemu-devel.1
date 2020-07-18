Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5E5C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 07:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF39D20724
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 07:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nk1IP1Zg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF39D20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwhVS-00065y-67
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 03:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwhUu-0005gE-Jw; Sat, 18 Jul 2020 03:43:04 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwhUs-00088T-UO; Sat, 18 Jul 2020 03:43:04 -0400
Received: by mail-wr1-x442.google.com with SMTP id r12so13202144wrj.13;
 Sat, 18 Jul 2020 00:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Y6LWcdDGN8QCwEbA1qBx/KZUkbT6m4rnd3MbmcbKm+A=;
 b=Nk1IP1ZgviUP44IOLNXkawtsyftswQ9zzP3g5naYNK9pE1ynHvcqR26fxABiuxmXdk
 HfOYt4wBqlf/GNbriof77eCquukm/a19HT8BJhR8O/si8E5YwnqnWGLAW5DDFPqA1jpl
 zk0o7SHEqVm1mer7GeTxT0m5EOfZFPnqlqI6vdwmzS4IOPRrhKV6fIsStk9+ig6pa/sb
 lQsbTTYdc+tzDGnYG2UJuQooruQN6OzN1Wrs6VbyB+10JGS9/xMbrXh6+nwUTi6/3LQt
 j2COKlOD9mA9TBWDnsb1U0Q4yyDvF77VD3V/6S51VNJw+QR0BHtYm6u8tx5sWhoYXPwa
 E5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y6LWcdDGN8QCwEbA1qBx/KZUkbT6m4rnd3MbmcbKm+A=;
 b=YiHxxuYyqokzADAfEZjKr9uVe+4Q+Tf6Dh4dTdWaoq5IlKCUflEFSlUZ4t/zjL75Pg
 T2tce9etjSRRnu2ywySX4mgfvdaAWbqaPYmiwzLEmR8f4c86ATSSVaP+Q1mWoL0vM4z5
 TAD2tNUcUdeLAbhozPdcWrwTVOHA2dY7cwxN3Rf3m8AaU42cL+0pZgQX8/zwGeWXPyVc
 uT0vdAfQrRulJAf0JVR5P5qIIglCGw71hnM9DEOIBUG1IrHGwifn6USIPz1SKoe9e0WV
 85ZYKaod+hvVJdtmIJjRR6ubKFEf11jVJajhpNafhmZM5diaYGhE9m450WGDun/fLNbK
 z/XA==
X-Gm-Message-State: AOAM5312v8N8ZX0i2oB/dz3hMX1BgpAInDKOdHUVT94Zgm6XTozrSS+u
 lfm3GAyg3VDhYiARyz/3gUWuWdSDcyU=
X-Google-Smtp-Source: ABdhPJxUqhsh7IJIStVs2BFdq57ghhA6aJQQLEfkc9Xt3AEkJwwQyAr0+cScx0F7SeonrqzYlLMWKQ==
X-Received: by 2002:adf:ed87:: with SMTP id c7mr13254156wro.422.1595058180398; 
 Sat, 18 Jul 2020 00:43:00 -0700 (PDT)
Received: from [192.168.1.43] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id n16sm17241749wmc.40.2020.07.18.00.42.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jul 2020 00:42:59 -0700 (PDT)
Subject: Re: [PATCH v2] goldfish_rtc: Fix non-atomic read behaviour of
 TIME_LOW/TIME_HIGH
To: Jessica Clarke <jrtc27@jrtc27.com>, qemu-riscv@nongnu.org
References: <20200718002027.82300-1-jrtc27@jrtc27.com>
 <20200718004934.83174-1-jrtc27@jrtc27.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <569659ed-7b03-7440-9167-855e92301f13@amsat.org>
Date: Sat, 18 Jul 2020 09:42:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200718004934.83174-1-jrtc27@jrtc27.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Anup Patel <anup.patel@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/18/20 2:49 AM, Jessica Clarke wrote:
> The specification says:
> 
>    0x00  TIME_LOW   R: Get current time, then return low-order 32-bits.
>    0x04  TIME_HIGH  R: Return high 32-bits from previous TIME_LOW read.
> 
>    ...
> 
>    To read the value, the kernel must perform an IO_READ(TIME_LOW),
>    which returns an unsigned 32-bit value, before an IO_READ(TIME_HIGH),
>    which returns a signed 32-bit value, corresponding to the higher half
>    of the full value.

What a odd design choice...

> 
> However, we were just returning the current time for both. If the guest
> is unlucky enough to read TIME_LOW and TIME_HIGH either side of an
> overflow of the lower half, it will see time be in the future, before
> jumping backwards on the next read, and Linux currently relies on the
> atomicity guaranteed by the spec so is affected by this. Fix this
> violation of the spec by caching the correct value for TIME_HIGH
> whenever TIME_LOW is read, and returning that value for any TIME_HIGH
> read.
> 
> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
> ---
> Changes since v1:
> 
>  * Add time_high to goldfish_rtc_vmstate and increment version.
> 
>  hw/rtc/goldfish_rtc.c         | 17 ++++++++++++++---
>  include/hw/rtc/goldfish_rtc.h |  1 +
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
> index 01e9d2b083..6ddd45cce0 100644
> --- a/hw/rtc/goldfish_rtc.c
> +++ b/hw/rtc/goldfish_rtc.c
> @@ -94,12 +94,22 @@ static uint64_t goldfish_rtc_read(void *opaque, hwaddr offset,
>      GoldfishRTCState *s = opaque;
>      uint64_t r = 0;
> 
> +    /*
> +     * From the documentation linked at the top of the file:
> +     *
> +     *   To read the value, the kernel must perform an IO_READ(TIME_LOW), which
> +     *   returns an unsigned 32-bit value, before an IO_READ(TIME_HIGH), which
> +     *   returns a signed 32-bit value, corresponding to the higher half of the
> +     *   full value.
> +     */
>      switch (offset) {
>      case RTC_TIME_LOW:
> -        r = goldfish_rtc_get_count(s) & 0xffffffff;
> +        r = goldfish_rtc_get_count(s);
> +        s->time_high = r >> 32;
> +        r &= 0xffffffff;
>          break;
>      case RTC_TIME_HIGH:
> -        r = goldfish_rtc_get_count(s) >> 32;
> +        r = s->time_high;
>          break;
>      case RTC_ALARM_LOW:
>          r = s->alarm_next & 0xffffffff;
> @@ -216,7 +226,7 @@ static const MemoryRegionOps goldfish_rtc_ops = {
> 
>  static const VMStateDescription goldfish_rtc_vmstate = {
>      .name = TYPE_GOLDFISH_RTC,
> -    .version_id = 1,
> +    .version_id = 2,
>      .pre_save = goldfish_rtc_pre_save,
>      .post_load = goldfish_rtc_post_load,
>      .fields = (VMStateField[]) {
> @@ -225,6 +235,7 @@ static const VMStateDescription goldfish_rtc_vmstate = {
>          VMSTATE_UINT32(alarm_running, GoldfishRTCState),
>          VMSTATE_UINT32(irq_pending, GoldfishRTCState),
>          VMSTATE_UINT32(irq_enabled, GoldfishRTCState),
> +        VMSTATE_UINT32(time_high, GoldfishRTCState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> diff --git a/include/hw/rtc/goldfish_rtc.h b/include/hw/rtc/goldfish_rtc.h
> index 16f9f9e29d..9bd8924f5f 100644
> --- a/include/hw/rtc/goldfish_rtc.h
> +++ b/include/hw/rtc/goldfish_rtc.h
> @@ -41,6 +41,7 @@ typedef struct GoldfishRTCState {
>      uint32_t alarm_running;
>      uint32_t irq_pending;
>      uint32_t irq_enabled;
> +    uint32_t time_high;
>  } GoldfishRTCState;

Maybe easier to cache the whole u64, this matches RTC_ALARM_LOW /
RTC_ALARM_HIGH pattern (goldfish_rtc_vmstate change not included):

-- >8 --
--- a/include/hw/rtc/goldfish_rtc.h
+++ b/include/hw/rtc/goldfish_rtc.h
@@ -37,6 +37,7 @@ typedef struct GoldfishRTCState {

     uint64_t tick_offset;
     uint64_t tick_offset_vmstate;
+    uint64_t rtc_time; /* Updated when RTC_TIME_LOW is read */
     uint64_t alarm_next;
     uint32_t alarm_running;
     uint32_t irq_pending;

--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -96,10 +96,11 @@ static uint64_t goldfish_rtc_read(void *opaque,
hwaddr offset,

     switch (offset) {
     case RTC_TIME_LOW:
-        r = goldfish_rtc_get_count(s) & 0xffffffff;
+        s->rtc_time = goldfish_rtc_get_count(s);
+        r = s->rtc_time & 0xffffffff;
         break;
     case RTC_TIME_HIGH:
-        r = goldfish_rtc_get_count(s) >> 32;
+        r = s->rtc_time >> 32;
         break;
     case RTC_ALARM_LOW:
         r = s->alarm_next & 0xffffffff;

---

