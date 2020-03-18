Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2403C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8500F2076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8500F2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEZOH-0003jR-O0
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 10:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jEZNf-0003CM-36
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jEZNd-0007U5-QD
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:09:11 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57631)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jEZNd-0007Nq-HM
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:09:09 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Ml6du-1jiMoE1gOy-00lTdL; Wed, 18 Mar 2020 15:09:02 +0100
Subject: Re: [PULL v2 00/37] Linux user for 5.0 patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200317155116.1227513-1-laurent@vivier.eu>
 <CAFEAcA9Pd6D6xaqN7XfOwRANxm=4uOYmdaBoeQiX4_Z-bXEi9g@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ff1fea42-0e3c-ed11-75d0-c6bae1466f28@vivier.eu>
Date: Wed, 18 Mar 2020 15:08:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Pd6D6xaqN7XfOwRANxm=4uOYmdaBoeQiX4_Z-bXEi9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Nigs5/c5KbjtKzybzwRE35FgQQQUY1EkDV8u6vKBqTT+AWk1rWU
 tUxegjgXpjfhI6FX4/35+fCogQMgH/afSBVvcY2GgIEgx10QNwVXPv3JCCQNcFArY3aUxyV
 81FR6JPYkDltndWFK+Kwvzng99yHE+fhy0PJBTuIKXFVyhoKSC5jsl938sgzcO/i2yWxzuJ
 X8lHo8cDwyDEQuE0x+pGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VKniymiNMZA=:fwsPCkoOa6gnr3xWMFQEfA
 5dZr+iXEMaXMOfWHTnmEVi34eHE+OQXujkZ9ckPJa4R9Hat+iOhx3srqM8t92VPfltkhtPTxn
 +1GXQDWt0D2hK5feFYCuuN2Sz0dZbatcpcsvQ46lCRMMa+CUFitH/fPBB+D49DP+Hrk5kkHnO
 1wh0tEqRmv1UX/TpWmJcyWCVfmapO9qWFat0kDLLNJkCMIzlKk1Idz+17R0cJAFqICVy6Q9ev
 iI7rGPSDLp/bXh3u03AyJdYjJ1x3/JEd11xw2aiFGHLgDyw8U5XTmog7f3EGxs6/fQVhBL3xp
 HaajHUL2l6dVkLVxZt5SifMdV3FKi91onKv2K6HUud6gVA33rZDptKt3/HlQ+1buwJSKVU5tH
 l7zxym4XsTO9V61IR9FASwb/QdT7LkXTvJ1G86MfXVBiRqSfQJ6SZp9NyzLy632OTM8USF537
 n/TY/WIe/Pd+95CJ+KJuL4pLhRxo+fHAOkXUetfPB6NT7jaILpNsMtSkexSMajMB6u5MMIPpt
 /RFPrI8uBlWn8Bf35OfWNzxdBKgq4JI3fnpciqWB2BOVio59NOk1mq9UpDKgBg2f2IuWEWtUk
 CWNNE8LNE5yX1wbfZD8DgTyYK9S/tEy0V5+Vo6MkwS+ZyqSVYo40Fk5Sq7B6kN/MLsQYvUQTC
 yQUbO6vflulyDmrG3CKvRxsjlliIQ3sAuv9cXHGQ7XFibHPYi4BG6ZPfOjmlZKZdvIHVdTgEk
 2uBXm6Zs1lTQiqi1iUm1m0ZmeMAiR/6S5idqqesR/QqfDPgVx24pp5yVyT9AZjM+wWFbd8kdJ
 B56YYSHkg4IyNWXB2oVzfGtQJqrFZw0VKbb4O04rF2TTvuv8q9rJH3t8gZyJ8yqb9w/u4Nu
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 18/03/2020 à 14:57, Peter Maydell a écrit :
> On Tue, 17 Mar 2020 at 16:05, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> The following changes since commit 373c7068dd610e97f0b551b5a6d0a27cd6da4506:
>>
>>   qemu.nsi: Install Sphinx documentation (2020-03-09 16:45:00 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request
>>
>> for you to fetch changes up to 85db278520fd800d8e8de9a527c8f0e1a962055e:
>>
>>   linux-user, openrisc: sync syscall numbers with kernel v5.5 (2020-03-17 16:36:17 +0100)
>>
>> ----------------------------------------------------------------
>> update syscall numbers to linux 5.5 (with scripts)
>> add futex_time64/clock_gettime64/clock_settime64
>> add AT_EXECFN
>> Emulate x86_64 vsyscalls
>>
>> v2: guard copy_to_user_timezone() with TARGET_NR_gettimeofday
>>     remove "Support futex_time64" patch
>>     guard sys_futex with TARGET_NR_exit
>>
>> ----------------------------------------------------------------
> 
> My set of "run ls for various architectures" linux-user tests
> https://people.linaro.org/~peter.maydell/linux-user-test-pmm-20200114.tgz
> fails with this pullreq:
> 
> e104462:bionic:linux-user-test-0.3$
> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/x86_64-linux-user/qemu-x86_64
> -L ./gnemul/qemu-x86_64 x86_64/ls -l dummyfile
> qemu: 0x40008117e9: unhandled CPU exception 0x101 - aborting
> RAX=000000000000003f RBX=000000006ffffe34 RCX=00000040008004c0
> RDX=0000004000813180
> RSI=0000000000000064 RDI=00000040007ffff0 RBP=000000006fffff40
> RSP=00000040007fffe8
> R8 =0000000000000000 R9 =00000040008004fe R10=0000004000801a18
> R11=0000004000801260
> R12=0000004000800240 R13=0000000000000008 R14=0000000000400040
> R15=00000040008032d0
> RIP=00000040008117e9 RFL=00000246 [---Z-P-] CPL=3 II=0 A20=1 SMM=0 HLT=0
> ES =0000 0000000000000000 00000000 00000000
> CS =0033 0000000000000000 ffffffff 00effb00 DPL=3 CS64 [-RA]
> SS =002b 0000000000000000 ffffffff 00cff300 DPL=3 DS   [-WA]
> DS =0000 0000000000000000 00000000 00000000
> FS =0000 0000000000000000 00000000 00000000
> GS =0000 0000000000000000 00000000 00000000
> LDT=0000 0000000000000000 0000ffff 00008200 DPL=0 LDT
> TR =0000 0000000000000000 0000ffff 00008b00 DPL=0 TSS64-busy
> GDT=     000000400091a000 0000007f
> IDT=     0000004000919000 000001ff
> CR0=80010001 CR2=0000000000000000 CR3=0000000000000000 CR4=00000220
> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
> DR3=0000000000000000
> DR6=00000000ffff0ff0 DR7=0000000000000400
> EFER=0000000000000500
> qemu:handle_cpu_signal received signal outside vCPU context @ pc=0x602e5482
> 

Is this x86 on x86?
I would say the problem is with the vsyscall patches.

Thanks,
Laurent

