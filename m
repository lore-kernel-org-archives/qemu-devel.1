Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E8AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 19:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C078206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 19:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C078206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhHuT-0002bs-Mc
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 15:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhHtn-00022h-Dj
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 15:21:03 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:43553)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhHtm-0002jn-1t
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 15:21:02 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N4h7p-1j05DA32GN-011lH1; Fri, 05 Jun 2020 21:20:51 +0200
Subject: Re: [PULL 00/19] Linux user for 5.1 patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200605114700.1052050-1-laurent@vivier.eu>
 <CAFEAcA9f3jLSnf=M_V4tuWjjY12QFqzp5_PvkdbG38AmEK6dAw@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <67f3b206-6bf1-65c3-1054-3aded4c69a23@vivier.eu>
Date: Fri, 5 Jun 2020 21:20:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9f3jLSnf=M_V4tuWjjY12QFqzp5_PvkdbG38AmEK6dAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ujkmK3xpUun4hafxiSxMbAHbcUy+t9yAoCE8o16k7mX0yMsXnAq
 bBe1h8hQGskgxX/jUYACUKPufDeMIjxt4deZ2Pq0G7t55jq6M3XISMQLAD/N++8xDSWIYjH
 xzvozN+H83gX1BLzc383DxUruAS0kJA0uXMldLmkmlS392c4g6+hyRtlSgClgTT6QgMWREf
 RfTcdEOH1ZKLXiQmI2z4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:up11C5vsdYs=:dBCQWYF5LavEsPbQxnPS88
 eRS/VQysJakH6cde7G6KUZ6+6RJcXLxRa4DCXPH1/gKmjrfxYEO5VQ/DYkx3uW4hYbCUehlai
 ruxrJHoU9eof1KX+Gzr1m4cCnb8ML0gviBpAh2vqabL9I3w0qluBFNQWCYxrHfYKOlRS7D0C0
 koSQ+GAN6TrQbbuIr6GFDQ4YEcvqQHTShXTEbeAbKtvmlX2WH89+qiog8y32IfPQCGmzSvxkN
 Ee1sxIYn4AFvmPOSPfBuv3F8KvdikPaiLSHJOiYP7QtAlTZYBr11sIlgtDjB6CFXViM6D+FIc
 lHFZqu2Ld4AFr+I7FqdX4E4NlzRsxHFg9g3MlozcwZsrSkxI6jf+0RCl0Y5iUGEQd6JFXJAXB
 26Uwn95JmjrZC2GWgZ9pRMVu/H6pHhjNn3GkeGwZf4f+/hzhSL0Mp9PYS3CM+9WjaKGnIS8c7
 Sf5gCt/SCyO+OmHazub2Nba48jD0VgQtRRb7O3J3ft+Lb3BO+WK4FW/lU+FwcpxukXgU4DtnJ
 B1z+59OrIjZhFuULkal+daBvPmqqvOLAELiNQ+ETS5hnc/VWVSQWQg7F0YkIzbNIqShqAB+XF
 Y0rIqRHa7oFJpwPE7Py9aySEW1tblagQ4sIrgdJ86vjd6Bol8gyhPcS7VFnRBsOGMIwwYO+VG
 DV1+WKZQRs2L1wX23jAJkqpqHJ8lhEbLGwO2rRtqZMyxd276Xkh/iGsxgmYjwMmf4nKQyAtcd
 KMnV/kDykBG5tjC4mPHwLN25FLvrD/ooh5XXFOBKqSJu931QlTel1CIDQq4FdGluP1Vj02cgQ
 LuCDgkh5qqx9CgrXcUh0KmP50OQoCEZErPNGbTxSEv+E6tJpo9JlnfzXgZvKJuT+ecgs9az
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 15:20:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Le 05/06/2020 à 18:45, Peter Maydell a écrit :
> On Fri, 5 Jun 2020 at 12:48, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> The following changes since commit ddc760832fa8cf5e93b9d9e6e854a5114ac63510:
>>
>>   Merge remote-tracking branch 'remotes/gkurz/tags/9p-next-2020-05-26' into s=
>> taging (2020-05-26 14:05:53 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/vivier/qemu.git tags/linux-user-for-5.1-pull-request
>>
>> for you to fetch changes up to aa3d2045d4ca760bd8c22935a2d73ee4f3480bd5:
>>
>>   stubs: Restrict ui/win32-kbd-hook to system-mode (2020-06-05 11:36:00 +0200)
>>
>> ----------------------------------------------------------------
>> linux-user pull request 20200605
>>
>> Implement F_OFD_ fcntl() command, /proc/cpuinfo for hppa
>> Fix socket(), prnctl() error codes, underflow in target_mremap,
>>     epoll_create() strace, oldumount for alpha
>> User-mode build dependencies improvement
>>
>> ----------------------------------------------------------------
> 
> Hi; this failed to compile on s390 and ppc when building hppa-linux-user:
> 
> /home/ubuntu/qemu/linux-user/syscall.c: In function ‘do_openat’:
> /home/ubuntu/qemu/linux-user/syscall.c:7484:42: error: ‘is_proc’
> undeclared (first use in this function); did you mean ‘
> is_error’?
>          { "/proc/cpuinfo", open_cpuinfo, is_proc },
>                                           ^~~~~~~
>                                           is_error
> /home/ubuntu/qemu/linux-user/syscall.c:7484:42: note: each undeclared
> identifier is reported only once for each function
>  it appears in
> /home/ubuntu/qemu/rules.mak:69: recipe for target 'linux-user/syscall.o' failed
> 
> Looks like this is because the #if condition guarding the
> is_proc() definition doesn't line up with the uses (missing
> a check on TARGET_HPPA).

You're right.

I was thinking this kind of problem would be detected by the travis-ci
builds, but in fact ppc64 and s390 builds don't build other architecture
linux-user targets.

I update my PR.

Thanks,
Laurent

