Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80756C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 14:44:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA802064B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 14:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="QFZcN0U5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA802064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwo50-0007K3-Jl
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 10:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrtc27@jrtc27.com>) id 1jwo4G-0006Xq-UH
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 10:44:00 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jrtc27@jrtc27.com>) id 1jwo4E-0002If-Mf
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 10:44:00 -0400
Received: by mail-wm1-x341.google.com with SMTP id 22so18387163wmg.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2020 07:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jrtc27.com; s=gmail.jrtc27.user;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=2ZV2Vg08E0Fi1I39JJuwZXzIJ3C4rjnqoqWl0Fto08A=;
 b=QFZcN0U55b4EGnip84iWthf7xySS+MBlQwHlqP/4KMtPIzXv6LrfVHpZCI63uW5fSJ
 RBIY4oz+dlwaByKvWaePgnpUwulHnq2MoLVpN2u3ipHpjcVezIDAThhwxiJSv/K2+IGg
 HO5mojT3iJbjQziJ/gLdn+jbX56oQkX/jCo6sMgZmYA8bfadAD5z0fwi+Wkt+BjRqiJn
 727WWojz1VJoamsRN5LJ81gfLVV3PUmZtXpgh/gvotuRTdTJzoSevwM+mXE3KAulfXkZ
 Yd14Xz12J0tXG3o9cEf8Y1LEUXaE6kZHG2jTs3xHfjvjgDk9ARe7tZ3bSdkXESNa2Dym
 u7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=2ZV2Vg08E0Fi1I39JJuwZXzIJ3C4rjnqoqWl0Fto08A=;
 b=PjlRkjbMPi1wb0LgzILuyZHwlfWklgEwOLKkzu6q9H7U8tVdKbDWaGhOH/Hl178dbh
 yB6NURODrsaiLaKjXlz04BwfNRzNt0gvzQ5SZb9oUMaxhrWkxre2epS/gURXETWr/OSU
 gqPzv09Bbj1O1gYdlFzR+9uJZqs57my9GmD2OTXYZ3jWGMFJIP3osrGYmj9IKIgKPOHM
 d+MN0TOatrSTLMvaURAQlnAfsYwCfqrHpDXN+I1DHYNx+LiikXFSh9ejlQ23vetUxxuz
 jSWnoUGbqpZ8TG0jazYsolpVu1qgmcxi3/8CwDCDR/ihzNxLAcAvuxxuuYL3vX/pUZmG
 rYqg==
X-Gm-Message-State: AOAM533GGuBD+WmA4pSohXw+a7SnGmpHtEcxlF+W7U9CWm/XrkRFzzKc
 bb/sD1oF3RRPzuTwHj9BGZgKvQ==
X-Google-Smtp-Source: ABdhPJxNP+inUM5XrExIr8xJly44L8oQLOFwoLP9WKAmjWspvxVQkNkh9ElzAwsusOAncxE2i5c5ZQ==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr14140712wmk.34.1595083436946; 
 Sat, 18 Jul 2020 07:43:56 -0700 (PDT)
Received: from [192.168.149.251] (trinity-students-nat.trin.cam.ac.uk.
 [131.111.193.104])
 by smtp.gmail.com with ESMTPSA id a12sm21283398wrv.41.2020.07.18.07.43.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 18 Jul 2020 07:43:56 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] goldfish_rtc: Fix non-atomic read behaviour of
 TIME_LOW/TIME_HIGH
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <569659ed-7b03-7440-9167-855e92301f13@amsat.org>
Date: Sat, 18 Jul 2020 15:43:55 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <92816800-F7B8-45CB-9863-96B8DF526D29@jrtc27.com>
References: <20200718002027.82300-1-jrtc27@jrtc27.com>
 <20200718004934.83174-1-jrtc27@jrtc27.com>
 <569659ed-7b03-7440-9167-855e92301f13@amsat.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=jrtc27@jrtc27.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Anup Patel <anup.patel@wdc.com>, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18 Jul 2020, at 08:42, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> On 7/18/20 2:49 AM, Jessica Clarke wrote:
>> The specification says:
>>=20
>>   0x00  TIME_LOW   R: Get current time, then return low-order =
32-bits.
>>   0x04  TIME_HIGH  R: Return high 32-bits from previous TIME_LOW =
read.
>>=20
>>   ...
>>=20
>>   To read the value, the kernel must perform an IO_READ(TIME_LOW),
>>   which returns an unsigned 32-bit value, before an =
IO_READ(TIME_HIGH),
>>   which returns a signed 32-bit value, corresponding to the higher =
half
>>   of the full value.
>=20
> What a odd design choice...

It actually makes a lot of sense. You know software always needs both
halves, and needs them to be atomic, so this is an easy way to provide
atomicity across two seemingly-independent reads.

>> However, we were just returning the current time for both. If the =
guest
>> is unlucky enough to read TIME_LOW and TIME_HIGH either side of an
>> overflow of the lower half, it will see time be in the future, before
>> jumping backwards on the next read, and Linux currently relies on the
>> atomicity guaranteed by the spec so is affected by this. Fix this
>> violation of the spec by caching the correct value for TIME_HIGH
>> whenever TIME_LOW is read, and returning that value for any TIME_HIGH
>> read.
>>=20
>> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
>> ---
>> Changes since v1:
>>=20
>> * Add time_high to goldfish_rtc_vmstate and increment version.
>>=20
>> hw/rtc/goldfish_rtc.c         | 17 ++++++++++++++---
>> include/hw/rtc/goldfish_rtc.h |  1 +
>> 2 files changed, 15 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
>> index 01e9d2b083..6ddd45cce0 100644
>> --- a/hw/rtc/goldfish_rtc.c
>> +++ b/hw/rtc/goldfish_rtc.c
>> @@ -94,12 +94,22 @@ static uint64_t goldfish_rtc_read(void *opaque, =
hwaddr offset,
>>     GoldfishRTCState *s =3D opaque;
>>     uint64_t r =3D 0;
>>=20
>> +    /*
>> +     * =46rom the documentation linked at the top of the file:
>> +     *
>> +     *   To read the value, the kernel must perform an =
IO_READ(TIME_LOW), which
>> +     *   returns an unsigned 32-bit value, before an =
IO_READ(TIME_HIGH), which
>> +     *   returns a signed 32-bit value, corresponding to the higher =
half of the
>> +     *   full value.
>> +     */
>>     switch (offset) {
>>     case RTC_TIME_LOW:
>> -        r =3D goldfish_rtc_get_count(s) & 0xffffffff;
>> +        r =3D goldfish_rtc_get_count(s);
>> +        s->time_high =3D r >> 32;
>> +        r &=3D 0xffffffff;
>>         break;
>>     case RTC_TIME_HIGH:
>> -        r =3D goldfish_rtc_get_count(s) >> 32;
>> +        r =3D s->time_high;
>>         break;
>>     case RTC_ALARM_LOW:
>>         r =3D s->alarm_next & 0xffffffff;
>> @@ -216,7 +226,7 @@ static const MemoryRegionOps goldfish_rtc_ops =3D =
{
>>=20
>> static const VMStateDescription goldfish_rtc_vmstate =3D {
>>     .name =3D TYPE_GOLDFISH_RTC,
>> -    .version_id =3D 1,
>> +    .version_id =3D 2,
>>     .pre_save =3D goldfish_rtc_pre_save,
>>     .post_load =3D goldfish_rtc_post_load,
>>     .fields =3D (VMStateField[]) {
>> @@ -225,6 +235,7 @@ static const VMStateDescription =
goldfish_rtc_vmstate =3D {
>>         VMSTATE_UINT32(alarm_running, GoldfishRTCState),
>>         VMSTATE_UINT32(irq_pending, GoldfishRTCState),
>>         VMSTATE_UINT32(irq_enabled, GoldfishRTCState),
>> +        VMSTATE_UINT32(time_high, GoldfishRTCState),
>>         VMSTATE_END_OF_LIST()
>>     }
>> };
>> diff --git a/include/hw/rtc/goldfish_rtc.h =
b/include/hw/rtc/goldfish_rtc.h
>> index 16f9f9e29d..9bd8924f5f 100644
>> --- a/include/hw/rtc/goldfish_rtc.h
>> +++ b/include/hw/rtc/goldfish_rtc.h
>> @@ -41,6 +41,7 @@ typedef struct GoldfishRTCState {
>>     uint32_t alarm_running;
>>     uint32_t irq_pending;
>>     uint32_t irq_enabled;
>> +    uint32_t time_high;
>> } GoldfishRTCState;
>=20
> Maybe easier to cache the whole u64, this matches RTC_ALARM_LOW /
> RTC_ALARM_HIGH pattern (goldfish_rtc_vmstate change not included):

We could, but why waste space storing an extra 32 bits you never need?
I don't think saving all 64 bits makes it any easier to read, I'd
personally even argue it makes it slightly less obvious what's going on.

Jess


