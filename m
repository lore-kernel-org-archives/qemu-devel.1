Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E84C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 09:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2900A2072D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 09:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2900A2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Qnv-0006Ba-9C
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 04:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j9Qn6-0005Tw-6o
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:58:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j9Qn5-0008IA-4W
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:58:12 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:34999)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j9Qn2-0008AF-In; Wed, 04 Mar 2020 04:58:08 -0500
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M58zc-1j8KrO3Y2O-0016nU; Wed, 04 Mar 2020 10:58:03 +0100
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1583282640.git.alistair.francis@wdc.com>
 <406774cf394d785da30a30d99169f0b2cf1bb1de.1583282640.git.alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v4 2/3] linux-user/syscall: Add support for
 clock_gettime64/clock_settime64
Message-ID: <a1c8aa15-104b-0ba1-e300-f42e222bb999@vivier.eu>
Date: Wed, 4 Mar 2020 10:58:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <406774cf394d785da30a30d99169f0b2cf1bb1de.1583282640.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YG1ppnkns3vVIIBzOWDSSPPBRpZ0IPRNz5hAZYb3f1S9XVipII1
 vUJsRwQgZB3L43M5J5KQuIoAeF4ay1EuPbA2CmBDLWp4A3GBDopc4JUiDQuhMUkfkpnl/nt
 maS0bKo4Xwp91RsrmYaDgFDXvHbJ7U8hMNrZ7rRXkW60sj5SegouX3pAV5H/c+W64Hpv2/v
 Y6M4mdkVCEoFeNhYGiJJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KqMqkd0iT/w=:qtMMfr0Sco2IywS2SQ//f/
 VrS8XJRCo498mf5qKxc0v3h4cPmiGgDlQvX4On4mNwMvD7+XGkLXJMBADakSn9B5wLkxQfaB1
 5gQa1S5LYoscsCmtxM+ygjcp5dzgSKOisoAkuAwTt1Q1fTpu3ua9E74apuoXd+UV6XggkGOl/
 AjjqFZa56NsCCxXJB3v7lyh4l3rlJTccBHLp50UIs0AlLHlKAZcVCx+L4TxKjYrHkweRprT73
 Zdg3PIW5GON9vmi4WL44KN2QeO0fsQtpNrOOZbVSAe1FwO9IUHKjzljUJBBgbxFHTpStWnelq
 laG2KA/Uim5OXdoelD4gwOroEFPEBser8KnTbfWR4mR70dDPNqnvwnalBxMPKWA5kjIgEw/G1
 cLPyciP+YTsFicphBPU8MJPxrnzI41U2Xx40N+B5NmFDwn/VGMVhlSL5uenIDCdNTOmTnW8+0
 IbPPtuAduUYgo4P2IX/WPTKaUhEr9FheGzgkjpGhko6Ebo4WRdUUqunUr79vrE46/k5Kls4Ds
 nHM6EOF4tm3U6Q80ENFyzYmINZSN8gmeEZhUDcu7+K8AM7HjuNUqynbOT6zHZBSsSrN5K47uh
 NdxQRK21kNQlQDcO8wlHkp4Dgn+Q9cVHNOvXVsBI6KGuZ7rj7pZ16gQzRZMmpVfUIWumX1AHG
 FsIUS8KH7mQWljLPSrTxe/Ay8eC63IzjWrMosMVD06LLmOAROrtQCjDPNNVv0+Pcu05B8/oVn
 EkPk2ml09UaMlGF1qnsuN5yFvEytgHwi4y3lZtRZ3fi/tS8JDCJhK0NWKUNKc4FKWJpOhWCCZ
 wdQVMOoekxvj8UrF3BnjLqA1KcQ1kCXHv7poTAiiypeH1+ha+dHshrNtILjifkPU45RJGYx
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/03/2020 à 01:44, Alistair Francis a écrit :
> Add support for the clock_gettime64/clock_settime64 syscalls. Currently
> we only support these syscalls when running on 64-bit hosts.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  linux-user/syscall.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index c000fb07c5..82468e018d 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1236,6 +1236,22 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
>  }
>  #endif
>  
> +#if defined(TARGET_NR_clock_settime64) && HOST_LONG_BITS == 64

Remove the "HOST_LONG_BITS == 64"

> +static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
> +                                                 abi_ulong target_addr)
> +{
> +    struct target_timespec *target_ts;

Use target__kernel_timespec that uses 64bit fields.

target_timespec uses long, and on 32bit archs it's a 32bit field (and
_time64 syscalls are only available on 32bit archs).


> +
> +    if (!lock_user_struct(VERIFY_READ, target_ts, target_addr, 1)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __get_user(host_ts->tv_sec, &target_ts->tv_sec);
> +    __get_user(host_ts->tv_nsec, &target_ts->tv_nsec);
> +    unlock_user_struct(target_ts, target_addr, 0);
> +    return 0;
> +}
> +#endif
> +
>  static inline abi_long host_to_target_timespec(abi_ulong target_addr,
>                                                 struct timespec *host_ts)
>  {
> @@ -11465,6 +11481,20 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          return ret;
>      }
>  #endif
> +#ifdef TARGET_NR_clock_settime64
> +# if HOST_LONG_BITS == 64

Remove this check ...

> +    case TARGET_NR_clock_settime64:
> +    {
> +        struct timespec ts;
> +
> +        ret = target_to_host_timespec64(&ts, arg2);

.. and if your host is 64bit or is using _time64 syscall the field of
timespec would be 64bit and clock_settime uses the _time64 syscall.
In the other case (32bit clock_settime()), the fields will be rounded
(it will work until year 2038...) :)

> +        if (!is_error(ret)) {
> +            ret = get_errno(clock_settime(arg1, &ts));
> +        }
> +        return ret;
> +    }
> +# endif
> +#endif
>  #ifdef TARGET_NR_clock_gettime
>      case TARGET_NR_clock_gettime:
>      {
> @@ -11476,6 +11506,19 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          return ret;
>      }
>  #endif
> +#ifdef TARGET_NR_clock_gettime64
> +# if HOST_LONG_BITS == 64

ditto

> +    case TARGET_NR_clock_gettime64:
> +    {
> +        struct timespec ts;
> +        ret = get_errno(clock_gettime(arg1, &ts));
> +        if (!is_error(ret)) {
> +            ret = host_to_target_timespec64(arg2, &ts);
> +        }
> +        return ret;
> +    }
> +# endif
> +#endif
>  #ifdef TARGET_NR_clock_getres
>      case TARGET_NR_clock_getres:
>      {
> 

Thanks,
Laurent

