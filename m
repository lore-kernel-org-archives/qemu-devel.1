Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870CDC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 20:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 616C020659
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 20:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616C020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnTmV-0001i9-UC
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 16:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33083)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnTmL-0001GA-BK
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 16:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnTmK-0000du-Cb
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 16:10:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34753)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnTmK-0000d1-5a
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 16:10:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so17530062wmd.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 13:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Zw+8HmpX86TsiJv2o6MkZqzPjhh7CIeFqESDregC8K4=;
 b=ibn4yEYl2V32LwysDw6pReOXuawC/t2azKs1d+Zp8ZTaZxdg8k7w9F93MX0J8BQhkk
 /POIEeNeHLxC2YVk4EFXep0wcu6+sIbIc8agpCOADre6B59m7+5C/FU8BBVP8xFf/Zm+
 zk1BoYjZ0GKVPTFkc1Q6kMutc47Xw8VifNG9++itPpV5qx6uvrmijCCctTxLbGNLisw+
 3WFdTVuy2voH+bPXYZnYjXT6bE43l1HoFjyShRZUaeZn24Lshe2RWvY8xts6Iafdq9VM
 G/A8em87PLc5M1bDwA9VvQPXZh9ZyETUuRjWWDt9wwIhqy04xTyey7n/odyRZo553QCl
 /hRw==
X-Gm-Message-State: APjAAAWgcizhLdKl5lxEOGTZuirZYvFK099u9XB+zT0FOWRFlTSonIOi
 iiVkHJdH0I3RAX6PiScv+J/Jyg==
X-Google-Smtp-Source: APXvYqzt/Pznx7pLD4Z9AFEVrNYgEXFeZqDNGt5iun9xhqPdMnZwfR1ES37nvDJNznZAM+JhQP47bQ==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr31507518wmg.65.1563307822606; 
 Tue, 16 Jul 2019 13:10:22 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id f204sm29215812wme.18.2019.07.16.13.10.21
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 13:10:21 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20181102171638.24069-1-peter.maydell@linaro.org>
 <20181102171638.24069-9-peter.maydell@linaro.org>
 <3e3d2018-3993-f651-8e94-5bea612bd776@redhat.com>
 <CAFEAcA_FtoHOUv_cPgfO7GrZ8Ug9cKCvmY2z75i9DaAQ8Qx+gQ@mail.gmail.com>
 <417cd887-aec4-d8ba-1dd2-810bc4c04977@redhat.com>
 <CAFEAcA_JntiaOOWisqLVqAV6jc=wk4nR548KbbUcG0XLabcNpA@mail.gmail.com>
 <8d06b8f2-7ee8-a77a-81d7-3219d5e43c45@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <dfeab9fd-7ee1-01f2-dd38-cba449b1de63@redhat.com>
Date: Tue, 16 Jul 2019 22:10:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <8d06b8f2-7ee8-a77a-81d7-3219d5e43c45@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PULL 08/10] target/arm: Conditionalize some
 asserts on aarch32 support
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/19 8:42 PM, Laszlo Ersek wrote:
> On 07/16/19 18:59, Peter Maydell wrote:
>> On Tue, 16 Jul 2019 at 17:51, Laszlo Ersek <lersek@redhat.com> wrote:
>>> The issue still reproduces, so it makes sense for me to look at the host
>>> kernel version... Well, I'm afraid it won't help much, for an upstream
>>> investigation:
>>>
>>>   4.14.0-115.8.2.el7a.aarch64
>>>
>>> This is the latest released kernel from "Red Hat Enterprise Linux for
>>> ARM 64 7".
>>
>> OK. (I'm using 4.15.0-51-generic from ubuntu).
>>
>> Could you run with QEMU under gdb, and when it hits the
>> assertion go back up a stack frame to the arm_cpu_realizefn()
>> frame, and then "print /x cpu->isar" ? That should show us
>> what we think we've got as ID registers from the kernel.
>> (You might need to build QEMU with --enable-debug to get
>> useful enough debug info to do that, not sure.)
> 
> (My qemu build script always builds QEMU in two configs, the difference
> being --prefix and --enable-debug.)
> 
> This is what I got:
> 
> (gdb) frame 4
> #4  0x00000000006a063c in arm_cpu_realizefn (dev=0x1761140,
>     errp=0xffffffffe540)
>     at .../qemu/target/arm/cpu.c:1159
> 1159            assert(no_aa32 || cpu_isar_feature(arm_div, cpu));
> (gdb) print /x cpu->isar
> $1 = {id_isar0 = 0x0, id_isar1 = 0x0, id_isar2 = 0x0, id_isar3 = 0x0,
>   id_isar4 = 0x0, id_isar5 = 0x0, id_isar6 = 0x0, mvfr0 = 0x0,
>   mvfr1 = 0x0, mvfr2 = 0x0, id_aa64isar0 = 0x0, id_aa64isar1 = 0x0,
>   id_aa64pfr0 = 0x11, id_aa64pfr1 = 0x0, id_aa64mmfr0 = 0x0,
>   id_aa64mmfr1 = 0x0}

For ISAR0, DIVIDE=0

so cpu_isar_feature(arm_div, cpu)=false

For AA64PFR0, EL0=1, EL1=1.

EL0 = 1: EL0 can be executed in AArch64 state only.
EL1 = 1: EL1 can be executed in AArch64 state only.

so cpu_isar_feature(aa64_aa32, cpu)=false
then no_aa32=true

The commit description is "on a host that doesn't support aarch32 mode
at all, neither arm_div nor jazelle will be supported either."

Shouldn't we use a slighly different logic? Such:

-    assert(no_aa32 || cpu_isar_feature(arm_div, cpu));
+    assert(no_aa32 && !cpu_isar_feature(arm_div, cpu));

