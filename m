Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47AAC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86927206B1
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86927206B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCfT4-0001Kq-K3
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 04:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jCfSW-0000tB-05
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jCfSU-0004kW-Tq
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:14:19 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:33961)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jCfSR-0004SE-NC; Fri, 13 Mar 2020 04:14:15 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mr8O8-1jiD7n2k0E-00oGsJ; Fri, 13 Mar 2020 09:14:09 +0100
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, aleksandar.m.mail@gmail.com
References: <cover.1584051142.git.alistair.francis@wdc.com>
 <ce73e32d4b399581b25d2323fad1d817d66dd11f.1584051142.git.alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v7 3/4] linux-user: Support futex_time64
Message-ID: <2043ccc2-c14e-5237-af54-e8f082164ed7@vivier.eu>
Date: Fri, 13 Mar 2020 09:14:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ce73e32d4b399581b25d2323fad1d817d66dd11f.1584051142.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QpGX9U3+W6sHJf9+2LYr5N2jtegsdE7ttk682AJcRMXvcZZV0IM
 CxNcO5t0ZBtsVeGkN2kz+qZqcPZAqGTqJnXOOJY3KAbpVLcvS7i4SkHTQXMFGN7s5/UNB6n
 QR6ERl6QtmgFgfAHnl70WIBPD117ZmwnsGDDCgBOVsg1/isv4VPm41HDRtEY5p728YOoSe3
 Hgsvd/gHdF3CoMMsPDTsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:suuffTUSAb4=:OC4ZwOovDX7X2Fwkvs0tqa
 t/NmU6AYosudJ8CBBO9vBMrASllP9nxBwcfDZ/wUu++ffoDVLzuoYLz+yGzvX6kxT30DwU0uM
 LSCO/R5b5CKwLA1HYctRyHSeeD29UeakKbozdwG9NNNEZR25xP/XYGlAn1KKzGRjF87PHAktG
 KZDtZEPEwDv00mB1HOV/kmAUGcm8DWw1kBMq+I0j7YRaxGPlmlEXB4Ch+0FJ2+0QtcXDrypYp
 BxkmoF72fn9Sqbba05tFBKwg597kf0q9dcsvS1adSnRYz3aKAYvbWKJj+2yaHt4rqhmu9qItB
 sRiVnDDwvsWq1gtd9BNvdvZGmKsxP+ok/4GN8rrXQY+Llqpll1DUu+6U/WncAupKxZQq1vJ+M
 7a+c2wl6ybkRzq/hR7N6HJYvzJ1Rp7WBfTMnCkXNyowYud3swgQCSvXgQ3hOv8kIGnidUOkyE
 D/6CBnt2OTyuBfxTHAKtg2puhuggA58Hy2plU1toXTE2v9zK4vmmCE7JqQhUsUO7DdHB7HR3j
 vKCKgEpPvPpUZU88fZzO8c4fby4Gil+t7/syoQ1YcDXBN3QsIUfAp6WehUp5CW+g0rY1qNx26
 yNixQU1FSCfLhB6PtHyI4eQUZCMxZwNDInEn9gZw/uUZfvBV0MB6uQF52qPm9jqxysMUjP5Bg
 i1a2Q0i17+e0GbHCif1aKY6cR+WmHG7sOlPQ4dJEkD8No1Zq2JluqQkUZcIJdpGQgx+aKSlT3
 wUvGzDi15wdtzyG0bmgaAZ3CDLdojoqlK0YapfuJATsw7j8tvTRbUpc3vSNUr9AgiyxpFfgm/
 WVSySQNr/yrsQJ2wkXKG/9FfJygjKXQhkVDBH/iSqoOk6qL5pkI2C71HIuF9FOBUlsupFae
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 12/03/2020 à 23:13, Alistair Francis a écrit :
> Add support for host and target futex_time64. If futex_time64 exists on
> the host we try that first before falling back to the standard futux
> syscall.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  linux-user/syscall.c | 144 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 131 insertions(+), 13 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 60fd775d9c..9ae7a05e38 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
...
> @@ -6890,6 +6905,55 @@ static inline abi_long host_to_target_statx(struct target_statx *host_stx,
>  }
>  #endif
>  
> +static int do_sys_futex(int *uaddr, int op, int val,
> +                         const struct timespec *timeout, int *uaddr2,
> +                         int val3)
> +{
> +#if HOST_LONG_BITS == 64
> +#if defined(__NR_futex)
> +    /* always a 64-bit time_t, it doesn't define _time64 version  */
> +    return sys_futex(uaddr, op, val, timeout, uaddr2, val3);
> +
> +#endif
> +#else /* HOST_LONG_BITS == 64 */
> +#if defined(__NR_futex_time64)
> +    if (sizeof(timeout->tv_sec) == 8) {
> +        /* _time64 function on 32bit arch */
> +        return sys_futex_time64(uaddr, op, val, timeout, uaddr2, val3);
> +    }
> +#endif
> +#if defined(__NR_futex)
> +    /* old function on 32bit arch */
> +    return sys_futex(uaddr, op, val, timeout, uaddr2, val3);
> +#endif
> +#endif /* HOST_LONG_BITS == 64 */
> +    return -TARGET_ENOSYS;

You cannot return -TARGET_ENOSYS because return value is supposed to be
a host value as you have direct value from sys_futex().

...

> @@ -7505,7 +7619,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              ts = cpu->opaque;
>              if (ts->child_tidptr) {
>                  put_user_u32(0, ts->child_tidptr);
> -                sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
> +                do_sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
>                            NULL, NULL, 0);

And return value is ignored. Anyway at this point we can't do anything
if it doesn't work, but it should not happen. So I think the best to do
is to add a g_assert_not_reached() in place of "return -TARGET_ENOSYS"
in do_sys_futex() (or "#error" if no futex function is available).

Thanks,
Laurent



