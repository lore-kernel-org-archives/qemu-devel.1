Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEA7C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412F3207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412F3207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBeaU-0004RF-5w
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBeYP-0001u1-VS
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:36:29 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:50683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBeYN-00074v-WC
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:36:29 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MiuGK-1kqVfv1pBc-00exEp; Fri, 28 Aug 2020 15:36:23 +0200
Subject: Re: [PULL 00/18] Linux user for 5.2 patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200827192018.2442099-1-laurent@vivier.eu>
 <CAFEAcA99NybkNUT7dpECnHftOz5VrQCwZJqQkuO3sUAMseoYGQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <70c094cd-24c8-b239-fa59-4b6f24aea65c@vivier.eu>
Date: Fri, 28 Aug 2020 15:36:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA99NybkNUT7dpECnHftOz5VrQCwZJqQkuO3sUAMseoYGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tMvB9ukei/2pk1vsuDqu5Ooe8lNQIy+cxpw7Y/WBcc3JJXy7usW
 eo3jVdiQshHJp1rXRiNkc5vw7sFE9fJQ3E4UP5oYd6gXKX75gxw/kV2YG3C0Sd/xgn8gz87
 0ZmrTtfGdUhPUJBAvgubXZwiodIEtYBtI9j5uTH8MFeoACXi1m0/50RmRFJu3rdjRCI2fyr
 cfdILi/6rWGQ85nAfeY/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ds43A8IAmIs=:Vn8Jvdl63YBMBlYMxcs+yN
 z0cq6szR3UotvlHhAhscEI4+mhMBCQLlMnoh8zraAO1JT/zH6hmgMiyDX8n1PhH6EyUISJOYU
 vxBcU/yFVsTu6vqkXNaieypYvndXSyoLiUTWv8glcBXKSUiUotZ6ThfHuVtpN6awIozXAbHGX
 JEmgv6NgsWfHrpWdF+6PpW1gXh8851kNw6vvwNhDEk0SQPHh3Y/F/qaeefZr2sB/6wcv6lZS0
 LG8Rsbvsz1zbuCnwqZFljcgZTZ0gBNmzsUhXZ8ofeZ8kLNDLsSE6wD5SHbz/HUReX5EMu4Uf3
 7GDfqD/0oRuhB8pQxefmnF8t+NvjY1DKaZww8INe04OTAoGiJ+0rAIWMgR4zaCXHt4xzGirmE
 1p3EoWNcE2weOJo5pzjE8jkd5Xik53SnYokhGrhSyMqcLXpgfnMyE023jB/SmegFc7RzMIkJZ
 6+Zf/TPi+usJuWcNLrLWXONtUBHh+1ooykK9wj8z/Ne3R9eNsyJw9nI4hseqOM+/d+DxGV6al
 //wEmh2hYpsLJPrkcGQ6um5qiocyZs1hw0DZyidDJJ9woaguj3Ph4G9mvy9LqgQauo3GxshIA
 jTTn3RY7srT9vwVKbg5xze6SLaLcfMLIjKdec3x7GZzrX5W49cRUrsbiBhrE4/8DnSWxdtKZX
 NBkDB+9XXfJ4eu4+cqIjxHVMoVi5fkACo24wbB4sV8lwzMBKgIfRaa6xy2qgop3Ex2ST0xF4V
 lIwl/ksQ0q9Ied7kZL0dFAAHsNbPHAPLxvtnDv4XEz3/kZaUeed69Xj/USsCbXbzny0ThbiQG
 v7QPegrO7vpr7VL4zOUr+ANXdZxicZvhXIKm5ShjU/l2+6UDZgDSWE0BgpkoXWSH0/vUpk8
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 09:36:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.809,
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 28/08/2020 à 14:11, Peter Maydell a écrit :
> On Thu, 27 Aug 2020 at 20:23, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> The following changes since commit 25f6dc28a3a8dd231c2c092a0e65bd796353c769:
>>
>>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-08-26' =
>> into staging (2020-08-26 10:28:36 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/vivier/qemu.git tags/linux-user-for-5.2-pull-request
>>
>> for you to fetch changes up to aa26eb42f5eaec54257aaceaeda50b9aa98756a5:
>>
>>   linux-user: Add support for utimensat_time64() and semtimedop_time64() (202=
>> 0-08-27 12:29:51 +0200)
>>
>> ----------------------------------------------------------------
>> add utimensat_time64, semtimedop_time64, rt_sigtimedwait_time64,
>>     sched_rr_get_interval_time64, clock_nanosleep_time64, clock_adjtime64,
>>     mq_timedsend_time64, mq_timedreceive_time64
>> fix semop, semtimedop, clock_nanosleep, mq_timedsend, target_to_host_timespec=
>> 64
>> fix tembits.h
>> add more strace function
>> Add upport DRM_IOCTL_I915_GETPARAM
>> detect mismatched ELF ABI in qemu-mips[n32][el]
> 
> Hi; this fails to build with clang:
> 
> ../../linux-user/syscall.c:1181:24: error: unused function
> 'copy_from_user_timeval64' [-Werror,-Wunused-function]
> static inline abi_long copy_from_user_timeval64(struct timeval *tv,
>                        ^
> 1 error generated.

I've added the missing #ifdef and I'm going to resend the PR.

Thanks,
Laurent


