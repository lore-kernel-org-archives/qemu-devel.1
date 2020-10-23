Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADA9C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:34:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A302085B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A302085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwGl-0006UG-TJ
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kVwBZ-0002TX-GY
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 08:28:45 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33193)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kVwBP-0002N2-Cd
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 08:28:45 -0400
Received: from [192.168.100.1] ([82.252.139.38]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N3bjH-1kMh7T2FiF-010gS9; Fri, 23 Oct 2020 14:28:24 +0200
Subject: Re: linux-user: Support f_flags in statfs64 when available.
To: Franz-Josef Haider <franz.haider@jolla.com>,
 Riku Voipio <riku.voipio@iki.fi>
References: <2e405fe7-efab-dae5-93d6-02575773fd6e@jolla.com>
 <19d426e3-bc5f-7d47-3674-33384b08ab40@vivier.eu>
 <16e7f7fa-1b48-e701-0a5d-853b914917af@jolla.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b690cd03-8b88-094d-42bc-6200b9733fa8@vivier.eu>
Date: Fri, 23 Oct 2020 14:28:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <16e7f7fa-1b48-e701-0a5d-853b914917af@jolla.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iVNLr9at50rvxql2pxRNoskvJIbJ2Zi/RZ7Umj4+gy9B2v3xneQ
 mPV+TDVF4Uwc0V4RkaWkMj6dUEb8El9VP4Vqob4zGqAb8t4LIa0vTkVTuDZjqhNmukkYzW9
 Absw8CouH4oEbW/FW/RFlsk7axxKnczfdVBXgPcY+GI28WyHLb1nqUtJipt/jGDCKdRqkxQ
 RUu3TKI1najL2Jj0qER2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gp3fBj+Vxb0=:DnpHtvpnkwhewKL3BOmbsM
 D1Z6AbUzTZX7jFT67q+uwwnbgxwEd4lXTLgbIkPjMrIaO1WVIzsBAc5SgftRZ51h24s8hqxOg
 jntlZ7Jo2UGQqk7zy5TvOCD8FVsjZryvV84PJ2L4xrTJIwZf9hU2wcYUs3/d7SXzmqwNTvLe0
 tWnjIkHFuOx9o6XJ/27qzy6T4+XTRRwRZWfO6GpW/z2yNEX2tdlF1H65+Go1jv9oUrx9sqRf3
 xj5yrJvGAM9pGsgZkADkjFyovIJaGmtUFiLtFLJ+woKW3QhQ9C/LXCaV/jjGuYJ8mu/FYXc3I
 UVeqMwAMhc/y6z3K1naG5AZYscYeG15ZGVFhypuNcG5vZIGd3lOhZa5h6UKiyYgNDndHgxB7A
 V96NDaJPq5RCOg589PgDAb0PyRSj5WX6tk8q4Bu2nRJY1ri/g3FbtSJ5Xs71Q
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 08:28:33
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.108,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Le 23/10/2020 à 13:29, Franz-Josef Haider a écrit :
> Hi, is there anything preventing this from being merged?

Nothing except your mail format is a little bit weird and your patch is
corrupted...

Anyway, I've fixed these problems and it is now applied to my linux-user
branch. I try to do a pull request soon...

Thanks,
Laurent

> best regards,
> Franz-Josef
> 
> On 30/01/2020 18:52, Laurent Vivier wrote:
>> Le 30/01/2020 à 14:00, Frajo a écrit :
>>> linux-user: Support f_flags in statfs64 when available.
>>> Same as d4247ec2d79ef2477cb886fa688706b068119736 but for statfs64
>>> When running rpm within qemu-arm-dynamic this could cause rpm fail with
>>> an error like
>>> "installing package A needs B MB on the C filesystem" depending on what
>>> is in memory in f_flags.
>>> https://github.com/rpm-software-management/rpm/blob/af06db1d5558870f7fb8f5c502572c2d27af5c71/lib/transaction.c#L164
>>>
>>>
>>> From 6ceb5662b5fae827d2c0cdd9896eec75997c060a Mon Sep 17 00:00:00 2001
>>> From: Franz-Josef Haider <franz.haider@jolla.com>
>>> Date: Thu, 30 Jan 2020 14:28:24 +0200
>>> Subject: [PATCH 1/1] linux-user: Support f_flags in statfs64 when
>>> available.
>>>
>>> Same as d4247ec2d79ef2477cb886fa688706b068119736 but for statfs64
>>>
>>> Signed-off-by: Franz-Josef Haider <franz.haider@jolla.com>
>>> ---
>>>  linux-user/syscall.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>> index d60142f069..45782b1009 100644
>>> --- a/linux-user/syscall.c
>>> +++ b/linux-user/syscall.c
>>> @@ -8997,6 +8997,11 @@ static abi_long do_syscall1(void *cpu_env, int
>>> num, abi_long arg1,
>>>              __put_user(stfs.f_fsid.__val[1], &target_stfs->f_fsid.val[1]);
>>>              __put_user(stfs.f_namelen, &target_stfs->f_namelen);
>>>              __put_user(stfs.f_frsize, &target_stfs->f_frsize);
>>> +#ifdef _STATFS_F_FLAGS
>>> +            __put_user(stfs.f_flags, &target_stfs->f_flags);
>>> +#else
>>> +            __put_user(0, &target_stfs->f_flags);
>>> +#endif
>>>              memset(target_stfs->f_spare, 0, sizeof(target_stfs->f_spare));
>>>              unlock_user_struct(target_stfs, arg3, 1);
>>>          }
>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>


