Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C7DC433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 08:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE8C2067C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 08:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE8C2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9lGq-0005pO-UV
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 04:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k9lG9-0005Ca-Eb
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 04:21:49 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:55183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k9lG7-0000vf-F0
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 04:21:49 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MpD7H-1kzIy31MMR-00qm5T; Sun, 23 Aug 2020 10:21:40 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200813064923.263565-1-laurent@vivier.eu>
 <CAFEAcA9NUR6jzCypJv4pC-ghvzjk2ErfFJ65j6A=r1LUbzp6cw@mail.gmail.com>
 <011ed14a-74d8-7145-3007-db7fce74ab7c@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PULL 00/14] Linux user for 5.2 patches
Message-ID: <fc4f69d5-a660-479f-f810-c910cf3986a2@vivier.eu>
Date: Sun, 23 Aug 2020 10:21:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <011ed14a-74d8-7145-3007-db7fce74ab7c@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gRPcwv2E8DAILXFIqvk0hbsdlGMutlmNq9ZVTm7kvhA6DGzp4r+
 iW3RPsgiibZam8RH5YZQWbwwISq9YiEH0CgdCrUPcjnKZC/X+TdXnbEtgH8jpox/6XVKGXC
 s607VBPwjBvHDlePJ1wMVthXHBPcnYAX4DKEcSC1z3+jarVg3R58trLiYaltOZnLHIbAMYk
 xwvBpCubH3O45Zh4OXczA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GtgbJOSyPCI=:97qP/fEwqBj2l2ZZMk2Z+N
 LBawYK0mmg1PEM6N+w+Po2mFxjsIPEf4wF2UNwXm8tjgq6rTMKFb/p4LeokEqFZxv50ec8rSO
 atmIn79/cUlRPBUHy3BT0sILr7Z99VDUeDQJsQD37cyLctBMaYdt253c74Zs4rGro0UHZ6MG8
 5lYYP87tBXjBCJZkxJC9YechjUgG4Gvcs4/N+b6IKYWl5Zw9MBoGEV77WN/VBuvsCZQGUQIU/
 PAEJloZs0s4i+e7fzk0OGHRbsUWLBzwAAuvPi3F10wgskF5esd6nHwTxjRIm1pYcYcQTB4fk1
 LBDLiM4Cd2EFyguSbAt4SWPqyEuVxvZVgQGtvV0ufnffoUGBoEAxCG0MXPE+M+/SdvSN/tQ1o
 Ctih7xi/SfUqktzMkDButJTecOM6Ep3szAHrFqXJbOZFWEGlPi+rRZfCuuEf50JgwurOYCyOl
 BvYe+jHSYczXOm+k8V98mkIwtr0m3JmBqQYL6F+6BH8RktbqdgC8wT3wMj/GIpiq2kifoB3Ve
 eCZGOp53o1lihqhCA6hjavLwPEnv2+NEPGJI/a164KgOU50HHI0QWIeb3Rix+TfokajdFjwQG
 Zzlrp7VOAGLfSn5uziZZjN6957Jii9MzfnKZjkvhL39pvRVHhzqFtONc1+XIhti+besBH3XqE
 Zo9PLxRdM+X6ICx+aW9ii6mrHOCfWdHPArMtjooE6rAVFBSHOG1e1x+pS+XpV+2WOKHnWng49
 8v8I+ZcYRApWMTNV9n4eigf9RCGcGjuV3oOib+1aW8kltFytWpRXzTxaPl6Vqsi+qVfs5xZtb
 lSj4TDNUYLWXRAF1NFJBHYLNW4LYTkFRZwqvj5S2qBZxEd4ZIuwpnDWZS+MbzIN+WhT+xSs
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 04:21:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.948,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 21/08/2020 à 21:08, Laurent Vivier a écrit :
> Le 21/08/2020 à 18:23, Peter Maydell a écrit :
>> On Thu, 13 Aug 2020 at 07:51, Laurent Vivier <laurent@vivier.eu> wrote:
>>>
>>> The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:
>>>
>>>   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://github.com/vivier/qemu.git tags/linux-user-for-5.2-pull-request
>>>
>>> for you to fetch changes up to 04275cad60c8f99e0dd7f56aecda68ceac926da8:
>>>
>>>   linux-user: Fix 'utimensat()' implementation (2020-08-12 10:09:58 +0200)
>>>
>>> ----------------------------------------------------------------
>>> Add btrfs ioctls
>>> Add clock_getres_time64, timer_gettime64, timer_settime64,
>>>     timerfd_gettime64, timerfd_settime64
>>> Some fixes (page protection, print_fdset, timerspec, itimerspec)
>>>
>>> ----------------------------------------------------------------
>>
>> Fails to compile:
>>
>> ../../linux-user/syscall_types.h:407:28: error:
>> ‘BTRFS_INO_LOOKUP_USER_PATH_MAX’ undeclared here (not in a function);
>> did you mean ‘BTRFS_INO_LOOKUP_PATH_MAX’?
>>         MK_ARRAY(TYPE_CHAR, BTRFS_INO_LOOKUP_USER_PATH_MAX)) /* path */
>>                             ^
>>
>> ../../linux-user/syscall_types.h:451:17: error:
>> ‘BTRFS_MAX_ROOTREF_BUFFER_NUM’ undeclared here (not in a function)
>>                  BTRFS_MAX_ROOTREF_BUFFER_NUM), /* rootref */
>>                  ^
>>
>> On PPC, even more errors, relating to not having
>> BTRFS_PATH_NAME_MAX, PTRFS_VOL_NAME_MAX, etc.
>>
>> Not sure if this was a semantic conflict with the meson
>> conversion, or just an assumption of a newer btrfs.h
>> than some systems have.
> 
> Well, for me master is also broken (F32, linux-user only, static):
> 
> Compiling C object libqemuutil.a.p/util_compatfd.c.o
> ../../../Projects/qemu/util/compatfd.c: In function 'qemu_signalfd':
> ../../../Projects/qemu/util/compatfd.c:103:19: error: 'SYS_signalfd'
> undeclared (first use in this function); did you mean 'SYS_signalfd4'?
>   103 |     ret = syscall(SYS_signalfd, -1, mask, _NSIG / 8);
>       |                   ^~~~~~~~~~~~
>       |                   SYS_signalfd4
> ../../../Projects/qemu/util/compatfd.c:103:19: note: each undeclared
> identifier is reported only once for each function it appears in

"--static" seems broken too:

$ '.../configure' '--disable-system' '--enable-linux-user'
'--disable-tools' '--static' '--disable-slirp' '--enable-capstone=git'
C++ compiler c++ does not work with C compiler cc
Disabling C++ specific optional code
cross containers  docker

NOTE: guest cross-compilers enabled: cc
The Meson build system
Version: 0.55.0
...
             gprof enabled: NO
            sparse enabled: NO
            strip binaries: YES
                  profiler: NO
              static build: NO
               SDL support: NO
         SDL image support: NO
               GTK support: YES
...

Thanks,
Laurent


