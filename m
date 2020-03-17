Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A19AC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A0F20735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzlHOh+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A0F20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEB9q-0004Ou-WA
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEAvu-00032h-Ab
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEAvt-0008Ld-1b
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:02:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:35710)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEAvs-0008KI-Si
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ltb8FyAB5nrmSAxMuXyxZoW28ONI4BXKV4H3Z/B8Ms8=;
 b=FzlHOh+wLzXD1+XKlr4MBkdI7n4BNS9FrW+7TrFdJtQ5gvmkIgJ+ykcFOx91GwO8XxmttP
 2eaL6DM9YvgtJZPqugCzf4Rn14YH2Twr/ALYY9TCXFsM51HYSLgvyFcGekQRB1HfGymYV0
 ymzZbFciTB7aMjlaT8ZisUOaNThzdWA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-iW7YZMxkNgOw5yyvHAFgKg-1; Tue, 17 Mar 2020 08:02:50 -0400
X-MC-Unique: iW7YZMxkNgOw5yyvHAFgKg-1
Received: by mail-wr1-f72.google.com with SMTP id o9so10581680wrw.14
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 05:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ltb8FyAB5nrmSAxMuXyxZoW28ONI4BXKV4H3Z/B8Ms8=;
 b=LJAn1ffNUnRacWmyJwgvOKk5loJvrFz8X3KlX9jzTc7E62mP3DIEzIF7RlWFfWolNq
 wsLn1xBStP7IAWvroMDKhBwPpt2tODvo1Nh2WGh+e+KyZwk0w6qBxtz8iw8hdMpdFz1i
 RDetloMk9ishibp+rS3wPSgIhnoPTnfcOG2EVC8CTCkmPU0rHm96rsRZ3OFJn1Ix0iaY
 9JkR7/tRLLRXkW+eECBDSPjR9iXCBu71RKyvKqLk2SjFUZEsIlfb0yNG9RnVOBqTWh0p
 oVmDHX3OQfylHUhzM+OY9gxlH3yZ8lo6Ebl9Qz8GoCCP8M3xlyBA8iJqFiN2mqQGGBXl
 WCQQ==
X-Gm-Message-State: ANhLgQ24+OXTy70fPgkiX++0wZ0lWzj+amIibSddhs2LMJ+GPdFoob1B
 iUU/Q7Q53WAzMG5UKF/MDJp4lhmRS19Ibb70aAcpuI4591O27BDOohaO6UMRbaPyLKu5SLLP4UY
 uuosun31wvZH2Wkk=
X-Received: by 2002:a5d:640a:: with SMTP id z10mr6093694wru.301.1584446569729; 
 Tue, 17 Mar 2020 05:02:49 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtrZZlsOBK2jVFLpO/lew9GuztbyxSkdYVWbW6HNmIKh54WWnRQTGpdkivyiB4XVv0vla6q+Q==
X-Received: by 2002:a5d:640a:: with SMTP id z10mr6093666wru.301.1584446569415; 
 Tue, 17 Mar 2020 05:02:49 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id g2sm4572104wrs.42.2020.03.17.05.02.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 05:02:48 -0700 (PDT)
Subject: Re: [PULL v2 00/61] Misc patches for soft freeze
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <1584396375-31278-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA-W=7LQyKvy-Pxv7eUh-tLoYu5jLiObTST0-Ee0wrCX7g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <da99ee7c-49fb-057e-a6bb-b2c89de86ffa@redhat.com>
Date: Tue, 17 Mar 2020 13:02:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-W=7LQyKvy-Pxv7eUh-tLoYu5jLiObTST0-Ee0wrCX7g@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Stefan

On 3/17/20 12:03 PM, Peter Maydell wrote:
> On Mon, 16 Mar 2020 at 22:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit a98135f727595382e200d04c2996e868b7925a01:
>>
>>    Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200316-pull-request' into staging (2020-03-16 14:55:59 +0000)
>>
>> are available in the git repository at:
>>
>>
>>    git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to 9d04fea181318684a899fadd99cef7e04097456b:
>>
>>    hw/arm: Let devices own the MemoryRegion they create (2020-03-16 23:02:30 +0100)
>>
>> ----------------------------------------------------------------
>> * Bugfixes all over the place
>> * get/set_uint cleanups (Felipe)
>> * Lock guard support (Stefan)
>> * MemoryRegion ownership cleanup (Philippe)
>> * AVX512 optimization for buffer_is_zero (Robert)
> 
> Hi; this generates a new warning on netbsd:
> 
> /home/qemu/qemu-test.N42OXz/src/util/qemu-timer.c: In function
> 'timerlist_expired':
> /home/qemu/qemu-test.N42OXz/src/util/qemu-timer.c:197:12: warning:
> 'expire_time' may be used uninitialized in this function
> [-Wmaybe-uninitialized]
>       return expire_time <= qemu_clock_get_ns(timer_list->clock->type);
>              ^
> /home/qemu/qemu-test.N42OXz/src/util/qemu-timer.c: In function
> 'timerlist_deadline_ns':
> /home/qemu/qemu-test.N42OXz/src/util/qemu-timer.c:235:11: warning:
> 'expire_time' may be used uninitialized in this function
> [-Wmaybe-uninitialized]
>       delta = expire_time - qemu_clock_get_ns(timer_list->clock->type);
>             ^
> 
> This is probably just the compiler being not smart enough
> to figure out that there's no code path where it's not
> initialized.
> 
> thanks
> -- PMM
> 


