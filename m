Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6754FC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 20:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3714F2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 20:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3714F2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGTmb-0000gi-DY
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 16:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jGTly-0000Gy-7L
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 16:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jGTlx-0001sM-1Y
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 16:34:10 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:34143)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jGTlw-0001sA-Oz
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 16:34:08 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MowT0-1jc4Wv1FhW-00qPkp; Mon, 23 Mar 2020 21:33:59 +0100
To: Richard Henderson <richard.henderson@linaro.org>
References: <20200317155116.1227513-1-laurent@vivier.eu>
 <CAFEAcA9Pd6D6xaqN7XfOwRANxm=4uOYmdaBoeQiX4_Z-bXEi9g@mail.gmail.com>
 <610f250b-64b8-1cf4-00fe-5bf2f2eba864@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PULL v2 00/37] Linux user for 5.0 patches
Message-ID: <de0bec3f-473a-35d7-5a26-3bf79eee6181@vivier.eu>
Date: Mon, 23 Mar 2020 21:33:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <610f250b-64b8-1cf4-00fe-5bf2f2eba864@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fwQf7867rpDcIo97IHoXBNPgB/AODJEoS43QbiE+6BMqeSoW/Tm
 upGlJBNG36EEbQABrY+mCowKPiGLhDh6h6QD6sxrdhToLNZDKo2A8xpZ+1d+YeoGjaSaasI
 Y75PY7be75gTZvGaX/I4FSnDgjoMfq0UcrTzizR2tVV7ANCqTLwMzJlWpGix3vtZKKxtj1d
 dndHZwkbowEBz4E1JmBUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SCZcJvqClE4=:gF5TRHGmfCpeOnvVGBZe3c
 Q9UXARVARQ3ZvIOQFb3FWfOa1sL5Z9nSttke0BmnT27PR57pKvWGvxv4DYnZPM6OubmaLRDt0
 /AKJ2/z1j+DZ1PjrHAjSrP73aqycgvFLswWIjHFThVvsYgSQLo5A20hCWRhP9aLl00X45ZZqr
 M8t1orM3BJXJPZo1o+FJ7tskbjH60aoYWDLxzy3jE5XAEPJm4sRmO+ogbdKMXCceku5Kzy2ck
 sj1KPcBZd+B4gSc+Ch/3X7txnXUktJgPGJA1njOhp3EStp9gm985e6Hqi+tKH9Wyj9fPetwlj
 qDQ2x9AggvRQp8Hsno7q0jEOIGiSPtvlm05VGW6BRtkFH7mcqkFIJBeRdPgNcfbeY6ieCzCfn
 N8Xe8EBpi7UZEp4kK6HuC+H7yo6N8dFw016aOaQm3YjzSoF2MOBzPtYdQLUvOg1nKCiQcmQqt
 N/nluBM7tEtTF1iVFAWPbV8do5IdyqJbj3DIt1MPrnVhXXJPWhmhv0/XwJSpA/zLHOwq0jzhY
 NiqGaTHjYIRDbLx4jI9O9cZDEAebnsw6xov2beB7ZtkQIO/ustLyJTxDPMIQXQFFAa+g/48ng
 eablLgGTB0j1SDAxES4donHRwsJUTVxNntM5isPI5bdro9iGB0sGIJiiThDb67MjScp80zMX8
 x6mFbn5mwqhKQxZNIV/sE6OczAcgwpZ0MOIbefwb1OfyFwfdgkUUGWlCFDWQGMpOEZ6tN5MYL
 5SPQg/GaWgL+Qxxw6Dgr/FJE/5ekYYxaiNKUOfGPTH9QQcP5PhQX+vabrpQx1N3XcGd7Y9TM+
 C7RM1MNNRkfoXO4mTA7eAdg3qHENYx3YjM/sqt0jhTwMtSYkVVCqaXRN0+Fw6OyXI3/xIjY
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 18/03/2020 à 20:46, Richard Henderson a écrit :
> On 3/18/20 6:57 AM, Peter Maydell wrote:
>> My set of "run ls for various architectures" linux-user tests
>> https://people.linaro.org/~peter.maydell/linux-user-test-pmm-20200114.tgz
>> fails with this pullreq:
>>
>> e104462:bionic:linux-user-test-0.3$
>> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/x86_64-linux-user/qemu-x86_64
>> -L ./gnemul/qemu-x86_64 x86_64/ls -l dummyfile
>> qemu: 0x40008117e9: unhandled CPU exception 0x101 - aborting
> 
> 
> I replicated this on aarch64 host, with an existing build tree and merging in
> the pull request.  It does not occur when building the same merged tree from
> scratch.
> 
> I have no idea what the reason for this is.  Laurent suggested a file in the
> build tree that is shadowed by one in the source tree, but to me that makes no
> sense for this case:
> 
> It's target/i386/cpu.h that defines EXCP_SYSCALL (renumbered in this series
> from 0x100 to 0x101), which is not in the build tree.  It is
> linux-user/i386/cpu_loop.c that consumes EXCP_SYSCALL, and it is also not in
> the build tree.
> 
> However, from the error message above, it's clear that cpu_loop.o has not been
> rebuilt properly.
> 

I removed this series from the final pull request as the problem doesn't
seem related to change I made in configure.

I didn't find from where the problem comes.

Could you check if you are always able to reproduce the problem with master?

Thanks,
Laurent




