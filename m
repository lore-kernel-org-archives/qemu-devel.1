Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B5DC433F1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:48:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE9A2078B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE9A2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsRf-0002zG-Hj
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 08:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jtsQc-0001xW-FE
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:46:58 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:54051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jtsQa-0006sD-MN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:46:58 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MZTa2-1kQF0N29l0-00WRno; Fri, 10 Jul 2020 14:46:45 +0200
To: Matus Kysel <mkysel@tachyum.com>, riku.voipio@iki.fi, qemu-devel@nongnu.org
References: <20200626124612.58593-1-mkysel@tachyum.com>
 <20200626124612.58593-2-mkysel@tachyum.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v3 1/2] linux-user: refactor ipc syscall
Message-ID: <b45a9fe1-ba32-8792-67e4-aececeee7227@vivier.eu>
Date: Fri, 10 Jul 2020 14:46:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200626124612.58593-2-mkysel@tachyum.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Gw5JJFf/M9On3C7V44/conuw9MVLvcYfLMf1W2jKWIF+GAZQnp/
 Lrh2OX8zJ9B8bXVimE0QiORlEdKe36sWTyDZUe9iWLuEfoxYbxiSP8swCqPtuTUl/PmI0M6
 CNaXxdQagqAn1cGC+eAwuR9bh3/SwwEqcJ538mW98USeih1kAp+vo3bau7Vo0d00NBAzAA+
 p2SsSJnisMBGzXfCr4+eQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0mrVZTHuz0Y=:ejEOOO/6Q4HtVlPhVkGaP9
 Ri8OqXIFuZwCGQJbCOmHIn/NfPSKoOqIr6hpeZgSJQtzFAOAWEPShwKU32uF30DiCDqHrWTVQ
 M7eXxxcRyhN1rinzWORX4dEJW+NoLCO1L/AMJMYysFs25xbSvaiqcjU9qMUH9AiGi62drn1Re
 CN1Wn3Pq8V3G4gZQaJzAJzJev+j03RGgAfhmq4E/rWIY0mj7JiqQp1H1CIGUsG9z05Q8EiGsh
 5exNl9VTLaEjqHEYVrASUMqR2UR6Tbkui2OLapLxRIDxDFR2TjWsd8xLK72BCWpYhN7Mj4G1b
 VmXWfgU27Rq1aAx6CC5vLvVgBL2n1Os9y9z8Lmf3RwXmZcLTUAo7AU1KZPXfA5QnyXruEL7dd
 4ltq2q3QqEovX/NWlGRFLJa0cf18QAeY9rv1o1tO+LRN3mkhfnu3IXSOoKsZwWkxivO16Y2xd
 1Y0OCOULK2JRnoYpKscKRGgbYSNXg7uzQOMptT93rz9vq2WnfMGTDnE7zFMxyjrkYyR/+tRNZ
 Zfc8VcFiO0EmGFUOnlRbkSLPylBLM3f3AjR8CB1dz05qTx1QmBczoOKgvuzx1VEiTYikM5Vpn
 XUY+3LMfRGzQ4oUu0P3MZC56lIh4R9P9yHwCkpb/n/y1eEs77PV/0AwIWdjQWJhv1PPnbK0ph
 El3Foh34mathKkDoPYdi8q/KzwtesEphU4fYqNOWWP8hrXJu1Q2WAviAspZgcbX8eG96BXbNd
 rs6B9/8nxdYfecv9zBO7w0q6QX4Uv2owP4Psr8x525jD5TB15NyQOMWHv2OkV4N6OMRzKmarB
 Uo/+QZt/jj7iK141R5e8BRGgPl7EDHehVWd4XUhbJgpV66K1dzdpSpnuFw6GdjX7o+0BYlF
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 08:46:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 26/06/2020 à 14:46, Matus Kysel a écrit :
> Refactoring ipc syscall for s390x and SPARC, so it matches glibc implementation
> 
> Signed-off-by: Matus Kysel <mkysel@tachyum.com>
> ---
>  linux-user/syscall.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 97de9fb5c9..990412733b 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -814,9 +814,14 @@ safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
>                const struct timespec *, req, struct timespec *, rem)
>  #endif
>  #ifdef __NR_ipc
> +#ifdef __s390x__
> +safe_syscall5(int, ipc, int, call, long, first, long, second, long, third,
> +              void *, ptr)
> +#else
>  safe_syscall6(int, ipc, int, call, long, first, long, second, long, third,
>                void *, ptr, long, fifth)
>  #endif
> +#endif
>  #ifdef __NR_msgsnd
>  safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
>                int, flags)
> @@ -4053,8 +4058,13 @@ static inline abi_long do_msgsnd(int msqid, abi_long msgp,
>  #endif
>  #ifdef __NR_ipc
>      if (ret == -TARGET_ENOSYS) {
> +#ifdef __s390x__
> +        ret = get_errno(safe_ipc(IPCOP_msgsnd, msqid, msgsz, msgflg,
> +                                 host_mb));
> +#else
>          ret = get_errno(safe_ipc(IPCOP_msgsnd, msqid, msgsz, msgflg,
>                                   host_mb, 0));
> +#endif
>      }
>  #endif
>      g_free(host_mb);
> @@ -4063,6 +4073,20 @@ static inline abi_long do_msgsnd(int msqid, abi_long msgp,
>      return ret;
>  }
>  
> +#ifdef __NR_ipc
> +#if defined(__sparc__)
> +/* SPARC for msgrcv it does not use the kludge on final 2 arguments.  */
> +#define MSGRCV_ARGS(__msgp, __msgtyp) __msgp, __msgtyp
> +#elif defined(__s390x__)
> +/* The s390 sys_ipc variant has only five parameters.  */
> +#define MSGRCV_ARGS(__msgp, __msgtyp) \
> +    ((long int[]){(long int)__msgp, __msgtyp})
> +#else
> +#define MSGRCV_ARGS(__msgp, __msgtyp) \
> +    ((long int[]){(long int)__msgp, __msgtyp}), 0
> +#endif
> +#endif
> +
>  static inline abi_long do_msgrcv(int msqid, abi_long msgp,
>                                   ssize_t msgsz, abi_long msgtyp,
>                                   int msgflg)
> @@ -4091,7 +4115,7 @@ static inline abi_long do_msgrcv(int msqid, abi_long msgp,
>  #ifdef __NR_ipc
>      if (ret == -TARGET_ENOSYS) {
>          ret = get_errno(safe_ipc(IPCOP_CALL(1, IPCOP_msgrcv), msqid, msgsz,
> -                        msgflg, host_mb, msgtyp));
> +                        msgflg, MSGRCV_ARGS(host_mb, msgtyp)));
>      }
>  #endif
>  
> 

This patch breaks build because there is safe_ipc() that is not updated
to use only 5 arguments with s390x. This is updated in the next patch so
the build in the end works, but it breaks bisect so you should fix that.

Otherwise:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent

