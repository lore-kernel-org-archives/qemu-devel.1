Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8866BC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 563932067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563932067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRYH-0006SF-KP
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jCRMc-0003Al-Ao
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jCRMb-00050x-3r
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:11:18 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:38237)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jCRMa-0004yk-RE
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:11:17 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MNKqC-1iwQwc3cOA-00Oqac; Thu, 12 Mar 2020 18:11:13 +0100
Subject: Re: [PATCH v2] linux-user: do prlimit selectively
To: Tobias Koch <tobias.koch@nonterra.com>, qemu-devel@nongnu.org
References: <20200305202400.27574-1-tobias.koch@nonterra.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ad2ff41a-e01a-289f-da8f-b545c0ce7fc6@vivier.eu>
Date: Thu, 12 Mar 2020 18:11:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305202400.27574-1-tobias.koch@nonterra.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:K3PznwVPctZSm08ceDdfxqBeJALRX761fQsKSyIS/u36akclz63
 46y+V/tFyra6Nc28bxWwxcaC6Ng70fjLsLgz7c/CPudUH+5OHy4p+Hgt7YpeYt6KQQEuawJ
 RI/HjlmHEytqiP7jp5Ti5TQZgvuehefW/R0wqmDl12fJn9Plfpf7fRwxzpu7+d0S7KD6iiL
 CaQn16Mm9JX0ZTDSRBURg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wF2x+cV5dTs=:+kaIggJiFhjIhwYz7tAvqh
 DRLCZX+7KK6oLGr+MARbPuA2LBQejcLGs12/9euXcAnWZ/1TqV9HoK1SvA00V7Gn69vr0p33J
 y5KlcG9m80qpmPROB7VZfmaxgOgt99+lstEus8EbQGeMamTNLzMG3Nlfc/X9R6VjgNt40W3hO
 v8i+LjcSuNZSsL+QdXP39mIR8F4IbZwR9eSnNLbWmC1hWldA5hGt28ot+93SFz1p/BLQ8zkgv
 Bn4WSHo5OX+cD+cxKM5QAYiDiO9BKllU5hsQQsi+TdVDLCG6OKZcCddJhbWkxz53BGxfi0Hfw
 w4wKrEmnZICjvFm0vw4/GcEg6w9Y3xpWE9Vm6XEvW7dUogrtqq6x5jbVOiWlS9xbF9sp/zy/p
 Y2N0jZdALwUoUC8Js7fh48g9CpuVORiEdgPaOLSxc/x59qbWcfZWO0SXeRY+cs+9WJTBx6XM0
 AKHKJA6FU5a4lJQbk5L4PzMdakG9mP/Lc++1T00JPMpAMUS8fTG1+x78qEY8e9pXtkQ9N5sWR
 KK7qaCRBuUURGlBVPjHWh567JF6O5vGPqLY5mWaXWMSecebj4UxOxt1K1J4+So535AzoCzOpR
 hMf7/lk7llRSo1JxiqfZFoErgvYuRkwy4qTEpAeg7iJwhzj48vgQbHS/DCEq1VKzPfdd/ftNR
 blgPq1acfurf6MMxVBfniPHSI8w/7Cdb3swKdbbXTrlpx8PtUp6oZj4vHlRH9NV6SAuDhU///
 EqukCXCbwAaPZ03LMF18llfGamJEFC3he0fTrngutqEz6DcN0tH6JC0wAlC1E3PknsILaH7Hg
 4F/uK4PSFU1wx/bNDfHRUp63qvWp0q67zz49OCf6ciSdN1c2nMiRoCFJCL6qGNVe0R6hSuN
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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
Cc: riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 05/03/2020 à 21:24, Tobias Koch a écrit :
> Analogous to what commit 5dfa88f7 did for setrlimit, this commit
> selectively ignores limits for memory-related resources in prlimit64
> calls. This is to prevent too restrictive limits from causing QEMU
> itself to malfunction.
> 
> Signed-off-by: Tobias Koch <tobias.koch@nonterra.com>
> ---
>  linux-user/syscall.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8d27d10807..4f2f9eb12b 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11871,7 +11871,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          struct target_rlimit64 *target_rnew, *target_rold;
>          struct host_rlimit64 rnew, rold, *rnewp = 0;
>          int resource = target_to_host_resource(arg2);
> -        if (arg3) {
> +
> +        if (arg3 && (resource != RLIMIT_AS &&
> +                     resource != RLIMIT_DATA &&
> +                     resource != RLIMIT_STACK)) {
>              if (!lock_user_struct(VERIFY_READ, target_rnew, arg3, 1)) {
>                  return -TARGET_EFAULT;
>              }
> 

Applied to my linux-user branch.

Thanks,
Laurent

