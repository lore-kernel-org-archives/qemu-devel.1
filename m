Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92022C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:01:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69211206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69211206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmyjJ-0000SY-Ah
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 07:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43896)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hmyj6-0008VM-OE
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hmyj1-0001Ot-OP
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:01:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38510)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hmyj1-0001OT-I8
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:00:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so14731534wmj.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 04:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VjhdeHmxIgz9h389WlYrNga6Vu7WsZpQmzZzXVBMIUw=;
 b=Gr/3SmOIFIXoZdBA9Jwrdf+qm2ZRRvu9bsDWMSjIhsYlOEECZa+wuBMLmZYAHrSM7o
 K3TlLgyRC/2Is2KKqAPKjsiLhYYHV59Y1RPq82DLYG8gSRLrYyIC+MB3r5kj0TMkuSPu
 pArhRljblpAHrHL3XZqXVNKtlzW8xcF4uLpmnROqkLrA5qmOKCmo3wt/KBrEaiOxwGa8
 /fsI9Td3j6kT5UXaXb6Izc2JKrc8lgT8P5Vv6pN7PqXc4O48l1xy0U9EDxk6gen+2h/p
 tnapVvmr90otvr7d8Tp3Fc+pP2vK/1bfiaUBGBgwlAybWO+Qju4x16eD8BP1UHCv58K4
 7nPQ==
X-Gm-Message-State: APjAAAVzH8k8fAMdi77m1GaECWxR0Opx6lC/0x1xtY1tYiqmQ6GFBIMi
 Kch41E87MVWBp4ozA1krAp8RdQ==
X-Google-Smtp-Source: APXvYqx5JK9K+i8DgaccoD/y0t5fUwZ2iOfo+CCRudhcpqCXIfG/aHl8u1oHazntfg7D5wnw1z4FaQ==
X-Received: by 2002:a7b:c651:: with SMTP id q17mr22522021wmk.136.1563188454395; 
 Mon, 15 Jul 2019 04:00:54 -0700 (PDT)
Received: from [192.168.178.40] ([151.20.129.151])
 by smtp.gmail.com with ESMTPSA id h133sm17603770wme.28.2019.07.15.04.00.52
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jul 2019 04:00:53 -0700 (PDT)
To: Yury Kotov <yury-kotov@yandex-team.ru>, Richard Henderson <rth@twiddle.net>
References: <20190710092338.23559-1-yury-kotov@yandex-team.ru>
 <20190710092338.23559-3-yury-kotov@yandex-team.ru>
 <1262801563183599@vla1-1374b6242101.qloud-c.yandex.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <50b64ede-13c1-6887-aaef-75ced63aaeda@redhat.com>
Date: Mon, 15 Jul 2019 13:00:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1262801563183599@vla1-1374b6242101.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] cpus: Fix throttling during vm_stop
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
Cc: Stefan Weil <sw@weilnetz.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "open list:Overall" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/07/19 11:40, Yury Kotov wrote:
> Hi,
> 
> 10.07.2019, 12:26, "Yury Kotov" <yury-kotov@yandex-team.ru>:
>> Throttling thread sleeps in VCPU thread. For high throttle percentage
>> this sleep is more than 10ms. E.g. for 60% - 15ms, for 99% - 990ms.
>> vm_stop() kicks all VCPUs and waits for them. It's called at the end of
>> migration and because of the long sleep the migration downtime might be
>> more than 100ms even for downtime-limit 1ms.
>> Use qemu_cond_timedwait for high percentage to wake up during vm_stop.
>>
>> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>> ---
>>  cpus.c | 27 +++++++++++++++++++--------
>>  1 file changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/cpus.c b/cpus.c
>> index ffc57119ca..3c069cdc33 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -74,6 +74,8 @@
>>
>>  #endif /* CONFIG_LINUX */
>>
>> +static QemuMutex qemu_global_mutex;
>> +
>>  int64_t max_delay;
>>  int64_t max_advance;
>>
>> @@ -776,7 +778,7 @@ static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
>>  {
>>      double pct;
>>      double throttle_ratio;
>> - long sleeptime_ns;
>> + int64_t sleeptime_ns;
>>
>>      if (!cpu_throttle_get_percentage()) {
>>          return;
>> @@ -784,11 +786,22 @@ static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
>>
>>      pct = (double)cpu_throttle_get_percentage()/100;
>>      throttle_ratio = pct / (1 - pct);
>> - sleeptime_ns = (long)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS);
>> -
>> - qemu_mutex_unlock_iothread();
>> - g_usleep(sleeptime_ns / 1000); /* Convert ns to us for usleep call */
>> - qemu_mutex_lock_iothread();
>> + /* Add 1ns to fix double's rounding error (like 0.9999999...) */
>> + sleeptime_ns = (int64_t)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS + 1);
>> +
>> + while (sleeptime_ns >= SCALE_MS && !cpu->stop) {
>> + int64_t start, end;
>> + start = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>> + qemu_cond_timedwait(cpu->halt_cond, &qemu_global_mutex,
> 
> Paolo, Richard, please tell me what you think.
> I'm not sure is it correct to use qemu_cond_timedwait() here?
> I see that qemu_cond_timedwait()/qemu_cond_wait() and
> qemu_mutex_(un)lock_iothread() have a different behavior in some cases.
> But there are some similar using of qemu_cond_wait with halt_cond, so may be
> it's ok to use qemu_cond_timedwait() here too.

Back in the day, Windows didn't have condition variables and making the
implementation robust and efficient was a mess---so there was no
qemu_cond_timedwait.  Semapshores are also a wee bit more scalable, so
qemu_sem_timedwait was introduced.

Now, I don't think it's an issue to add qemu_cond_timedwait.

Thanks,

Paolo

> 
>> + sleeptime_ns / SCALE_MS);
>> + end = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>> + sleeptime_ns -= end - start;
>> + }
>> + if (sleeptime_ns >= SCALE_US && !cpu->stop) {
>> + qemu_mutex_unlock_iothread();
>> + g_usleep(sleeptime_ns / SCALE_US);
>> + qemu_mutex_lock_iothread();
>> + }
>>      atomic_set(&cpu->throttle_thread_scheduled, 0);
>>  }
>>
>> @@ -1166,8 +1179,6 @@ static void qemu_init_sigbus(void)
>>  }
>>  #endif /* !CONFIG_LINUX */
>>
>> -static QemuMutex qemu_global_mutex;
>> -
>>  static QemuThread io_thread;
>>
>>  /* cpu creation */
>> --
>> 2.22.0
> 
> Regards,
> Yury
> 


