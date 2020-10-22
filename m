Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFECC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 21:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC74221D43
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 21:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVe7OkX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC74221D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVi03-0004zZ-U8
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 17:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVhxn-0003qQ-Co
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 17:17:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVhxl-0007hk-BG
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 17:17:35 -0400
Received: by mail-wr1-x444.google.com with SMTP id h5so5151299wrv.7
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Eo10DiFfaYXb2tc6AaJuCnr+m1mxE9zBAdbtcLatX+s=;
 b=VVe7OkX86kZtwk3p6wow9ALa38e/L7ZwmxB8cUqozVHxeQDA0aWa5C4McaledoW5z9
 ofFiYeBgAZEa57SHL0mNPDzCJRaXV+i7AQLewE+eww7+K/UIRrlvkpfw5rRbVNSwmGLw
 jb0gWwGuStM6U1Zn3lr9/kSylE/cegj2pikF7hkLTPLx00n4haARWryJ2w3RKbojiy7s
 yNfUp9VZfrJ+RNpS4Qht2uMFVp0QaQgnVCdNvITRh4bQDhtHLBxROGvcp+hbYswA2uqo
 yjlrNyKybhlrNh4cAXbDIrgJahmGlx6tQojn9dXS8xrQHU1F09n1CovKQyWRnZkeeaKk
 /J8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Eo10DiFfaYXb2tc6AaJuCnr+m1mxE9zBAdbtcLatX+s=;
 b=UoBAwfUGdBe38KoIU8u2xRZzCBWGDoIr0N/nhBQLUwhV0EMsNUy6v6LBdkAGORZk3M
 te8Y2AZ5waGcox4eOufLCKkfSoPx7ceb9BRKZZ6Zlv9n4Ojj6jOQTCMv4i2wcbOxETtw
 q3MOD6F1i7KNzosCW83Ssl9/5GHsjDp9dMGYPjOViT7K1m4TzhdyafoTp/kfCV5eUh7Y
 yyxNoDs14/nzyIQOaRkfXpa0xHlOLv4y+myiuFI72SkeI1z5wAnaTEZSiu0BLe/8PtuP
 t3VT8SyUiTffr32bLNgA27U10+z6ry3oevWJdBc6hAFfqJW3E/CICchEjxfc8g9V+ztV
 F86g==
X-Gm-Message-State: AOAM531T05VHzX+ngC8C2/JC5ahUJ0erUwLHJp733mwHGL3sLjfUV8rW
 cMyf0i15niQLkHTFEf4eKko=
X-Google-Smtp-Source: ABdhPJxO5Z5xoMjwDWfpSxXNxK74JYDHRJBoOrcwH8rtflfC8LhYRb4UPhpYpSR87hnYMv4w1i9sLA==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr4544506wro.273.1603401451106; 
 Thu, 22 Oct 2020 14:17:31 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id e15sm5730172wro.13.2020.10.22.14.17.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2020 14:17:30 -0700 (PDT)
Subject: Re: Ramping up Continuous Fuzzing of Virtual Devices in QEMU
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>
References: <20201022161938.7clfymu6a3zl46s2@mozz.bu.edu>
 <20201022162416.iccjosbeg753qbzc@mozz.bu.edu>
 <20201022163925.GE428835@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a4b6f592-2fda-fcfa-f49e-7dcdfbea9833@amsat.org>
Date: Thu, 22 Oct 2020 23:17:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201022163925.GE428835@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, 0ops@0ops.net, liq3ea@gmail.com,
 rjones@redhat.com, qemu-devel@nongnu.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, andrey.shinkevich@virtuozzo.com,
 pbonzini@redhat.com, ppandit@redhat.com, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/20 6:39 PM, Daniel P. Berrangé wrote:
> On Thu, Oct 22, 2020 at 12:24:16PM -0400, Alexander Bulekov wrote:
>> +CC Prasad
>>
>> On 201022 1219, Alexander Bulekov wrote:
>>> Hello,
>>> QEMU was accepted into Google's oss-fuzz continuous-fuzzing platform [1]
>>> earlier this year. The fuzzers currently running on oss-fuzz are based on my
>>> 2019 Google Summer of Code Project, which leveraged libfuzzer, qtest and libqos
>>> to provide a framework for writing virtual-device fuzzers. At the moment, there
>>> are a handful of fuzzers upstream and running on oss-fuzz(located in
>>> tests/qtest/fuzz/). They fuzz only a few devices and serve mostly as
>>> examples.
>>>
>>> If everything goes well, soon a generic fuzzer [2] will land upstream, which
>>> allows us to fuzz many configurations of QEMU, without any device-specific
>>> code. To date this fuzzer has led to ~50 bug reports on launchpad. Once the
>>> generic-fuzzer lands upstream, OSS-Fuzz will automatically start fuzzing a
>>> bunch [3] of fuzzer configurations, and it is likely to find bugs.  Others will
>>> also be able to send simple patches to add additional device configurations for
>>> fuzzing.
>>>
>>> The oss-fuzz process looks roughly like this:
>>>      1. oss-fuzz fuzzes QEMU
>>>      2. When oss-fuzz finds a bug, it reports it to a few [4] people that have
>>>      access to reports and reproducers.
>>>      3. If a fix is merged upstream, oss-fuzz will figure this out and mark the
>>>      bug as fixed and make the report public 30 days later.
>>>      3. After 90 days the bug(fixed or not) becomes public, so anyone can view
>>>      it here https://bugs.chromium.org/p/oss-fuzz/issues/list
>>>
>>> The oss-fuzz reports look like this:
>>> https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=23701&q=qemu&can=2
>>>
>>> This means that when oss-fuzz find new bugs, the relevant developers do not
>>> know about them unless someone with access files a separate report to the
>>> list/launchpad. So far this hasn't been a problem, since oss-fuzz has only been
>>> running some small example fuzzers. Once [2] lands upstream, we should
>>> see a significant uptick in oss-fuzz reports, and I hope that we can develop a
>>> process to ensure these bugs are properly dealt with. One option we have is to
>>> make the reports public immediately and send notifications to
>>> qemu-devel. This is the approach taken by some other projects on
>>> oss-fuzz, such as LLVM. Though its not on oss-fuzz, bugs found by
>>> syzkaller in the kernel, are also automatically sent to a public list.
>>> The question is:
>>>
>>> What approach should we take for dealing with bugs found on oss-fuzz?
> 
> If we assume that a non-negligible number of fuzz bugs will be exploitable
> by a malicious guest OS to break out into the host, then I think it is
> likely undesirable to make them public immediately without at least a basic
> human triage step to catch possibly serious security issues.
> 
> Still a large % are likely to be low impact / not urgent to deal with so
> we want a low overhead way to handle the fuzz output, which doesn't create
> a bottleneck on a small number of people.
> 
> Overall my feeling is that we want to be able to farm out triage to the
> respective subsystem maintainers, who can then decide whether the bug
> needs notifying to the security team, or can be made public immediately.
> 
> I think ideally we would be doing triage in QEMU's own bug tracker, so
> we don't need to have maintainers create accounts on a 3rd party tracker
> to see reports.
> 
> Is is practical to identify a primary affected source file from the fuzz
> crash report with any level reliablility such that we could file a private
> launchpad bug, automatically CC'ing a subsystem maintainer (and the security
> team)  ?

Also what is not very clear is, who is supposed/going to fix these bugs?

I see this pattern:

a) bug found by human: human keeps asking for the bug
   1/ security issue: someone assigned to fix
   2/ else: if human keeps asking, the bug gets eventually fixed.

b) bug found by fuzzer:
   1/ security issue: someone assigned to fix
   2/ else: nothing happens because unlikely hit by user

Do we want to keep tracking b.2 bug reports? I think this is the case of
the ~50 Alexander mentioned.

Regards,

Phil.

