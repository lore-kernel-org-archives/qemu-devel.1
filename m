Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7814AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 12:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 472E0206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 12:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCzvQBlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472E0206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvgXg-0002vY-Gq
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 08:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvgX3-0002Vf-E3
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 08:29:05 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvgX1-0003NO-PX
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 08:29:05 -0400
Received: by mail-wr1-x441.google.com with SMTP id o11so2449778wrv.9
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 05:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QwnCcs0N8IT4qrwO/kJSO1UZKgGjJNbeTbFXMIOeQkY=;
 b=iCzvQBlOUDHHNE6wucHVp2Y0JIM1u4n4JhIdGGzv88fBybtlB+uZPzFnrLpbNymXPH
 isQcrek5fiN4NQicJwB4OnC1neP6ZuD/neT35KMj13EQdBBgM8uE8Rb5EWWXDn7ZtSaP
 HKFUFqrdrBiTQIhoRFH/n+E+jZQQkvWdEgAicBAdhZofdyQLJ3492JClbQdEpwg4KZta
 GmSSqpzNnvdVH16v8srOfQvPhAYfqxkwoNyUKllUORkUaOonlpTMPAmdS7rMhK+9lrgn
 U3TbVkr5dZo3qCV0XtCQcnJy2X3r+JZ0xO4eZW7hmEnnd9LwDguheD9z0fgcrPLz8fMI
 B81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QwnCcs0N8IT4qrwO/kJSO1UZKgGjJNbeTbFXMIOeQkY=;
 b=g8DxwmzGmAo0wuR+1rbtEeJcWConahGOIwjpWUw+NAPkbHiC2yNZ2qGvVGdPnRycP3
 UXqpECtzKLq3yUT/1AdG5HnGHJ4PynP2s1gcv4Z8l/mpZpxmrzVt3e92M5efnIuP2Vmi
 fq8q4B69jxxtZ64D57EWvnkTSkSIOYLJdYayNyKKF12YkX+KeMOGYTTvMFhv5i9sBh1N
 1rhGmy2krGCTGM8LiO8Y87t1Jr0O2XVscmO8WFFm8Bg8VxCaw24M14kb5jFzSK1zHWVV
 CjtBkH6o790DeGLT7n7pLqdPQeHWdLAvkLi70y/Qxx9s2GDUFM5Z+zmLPyYMESu77eZV
 ks2w==
X-Gm-Message-State: AOAM530Jx1DwWHiaISQz3ZkHgnIQ6HYnSF9eQ4D8nUZ0Mt1crrNA4kG3
 Tm9gpc94JfBBCWTg6qUrCvY8/ABxlLo=
X-Google-Smtp-Source: ABdhPJyN/ANi74iGZ6PURhEDuST7zTnyijrZ0j70oFWR75wxZqRzv36K9w3XVaS+avjd8nhqDG5dpw==
X-Received: by 2002:adf:fa8b:: with SMTP id h11mr11145633wrr.391.1594816141876; 
 Wed, 15 Jul 2020 05:29:01 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id u1sm4006391wrb.78.2020.07.15.05.29.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2020 05:29:01 -0700 (PDT)
Subject: Re: [PULL 0/9] final misc fixes for 5.1-rc0
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200714095247.19573-1-alex.bennee@linaro.org>
 <CAFEAcA-4U-LAjcBPWQNrtfk=Kr2zsejHGYCzLWSoYq97_o9j8g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <89543ebb-4c8d-64f6-f15a-e1736e683e22@amsat.org>
Date: Wed, 15 Jul 2020 14:29:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-4U-LAjcBPWQNrtfk=Kr2zsejHGYCzLWSoYq97_o9j8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 7/15/20 10:06 AM, Peter Maydell wrote:
> On Tue, 14 Jul 2020 at 10:52, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> The following changes since commit 20c1df5476e1e9b5d3f5b94f9f3ce01d21f14c46:
>>
>>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20200713-pull-request' into staging (2020-07-13 16:58:44 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/stsquad/qemu.git tags/pull-misc-for-rc0-140720-1
>>
>> for you to fetch changes up to 4e6400c97024c2660b6db8aab1f0677744449f36:
>>
>>   plugins: expand the bb plugin to be thread safe and track per-cpu (2020-07-14 09:08:25 +0100)
>>
>> ----------------------------------------------------------------
>> Final fixes for 5.1-rc0
>>
>>   - minor documentation nit
>>   - clean all deps on re(configure)
>>   - docker.py bootstrap fixes
>>   - tweak containers.yml wildcards
>>   - fix float16 nan detection
>>   - conditional use of -Wpsabi
>>   - fix missing iotlb data for plugins
>>   - proper locking for helper based bb count
> 
> Fails "make check" on aarch32 and aarch64 hosts, because
> eg qemu-system-arm segfaults on startup:

What host/distrib are you using?

I can not reproduce on aarch64 (Ubuntu 20.04 LTS) using:
gcc (Ubuntu 9.3.0-10ubuntu2) 9.3.0

Any config in particular?

> 
> $ gdb --args ./arm-softmmu/qemu-system-arm -M virt -display none
> [...]
> (gdb) r
> Starting program: /home/pm/qemu/build/all/arm-softmmu/qemu-system-arm
> -M virt -display none
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/aarch64-linux-gnu/libthread_db.so.1".
> [New Thread 0xffffe873e550 (LWP 1666261)]
> [New Thread 0xffffe7f3d550 (LWP 1666262)]
> [New Thread 0xffffe72e7550 (LWP 1666263)]
> 
> Thread 4 "qemu-system-arm" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0xffffe72e7550 (LWP 1666263)]
> 0x0000aaaaab1da004 in object_class_dynamic_cast_assert (class=0xaaaaabc209e0,
>     typename=typename@entry=0xaaaaab33bfe8 "cpu",
> file=file@entry=0xaaaaab3201a0 "/home/pm/qemu/accel/tcg/cputlb.c",
>     line=line@entry=1025, func=func@entry=0xaaaaab3202f0
> <__func__.35278> "tlb_fill") at /home/pm/qemu/qom/object.c:917
> 917         trace_object_class_dynamic_cast_assert(class ?
> class->type->name : "(null)",

