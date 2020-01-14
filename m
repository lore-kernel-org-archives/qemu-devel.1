Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81672C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F4E222C4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F4E222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irNp6-0004IU-Hu
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irNoU-0003jB-1u
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:09:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irNoQ-0006Hb-I9
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:09:02 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:38575)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irNoQ-0006G6-8x
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:08:58 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MhWx1-1jMIqA3TkJ-00egtR; Tue, 14 Jan 2020 16:08:42 +0100
Subject: Re: [PATCH v5 07/20] linux-user: xtensa: Update syscall numbers to
 kernel 5.5 rc3 level
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1578947683-21011-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1578947683-21011-8-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5ae64820-8151-84b8-c4ae-848651f38b44@vivier.eu>
Date: Tue, 14 Jan 2020 16:08:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578947683-21011-8-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HnUtwYustp3in/vi01mBNwSEKvFCWEKlasO5Th9YEs3ORFwMArJ
 1RXknSdAzqN1OP7H4QfQg8LlwsHELPND5sz0gb1gHUuuSj7xwACxeZhGJKxk2Lb1Psh93Us
 wM8sf2pWNGRRankkO5cmwsaNUnsBLVaDpzwfmN5LTqwUq+LiJoSNoc8FGwgVKUDVoZNLQBi
 PJr+CBJKDT5+4GJO69kZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fP+UqFwAMS0=:+bvxF6TAI3gX/0onPuRzpO
 8w9/MHgwd9fwyyi+b1FN7g6Xm383mJexv8JU+rYFiN54eqk8ZAQbCYCC/gDwSiUQ+E1c5xrEf
 bCosaDbibXVJfv/FpBvZ4RY5wesuqqCY1uVxzdiMFhFo9s3Lp99K5Bs7NpPHU6M4OTj0/u+SP
 0aHn91P5sy+SJZJWXdkogXrsMrUfSxv3xbQ9TE3ZvTGqsZHv5sjSOlNNGDoAxpEEYxcZWU6my
 1z4r7B4H+cSYDoerXJUSI0977GBRdO3JK4lxXHXE9VVp31B72KJ/ufsFqOCeb4klHFusnq2rJ
 tDasRBfgcGt/V/ZFLnohDltwVVJ7XcyZBH5+X4Upjoc2GyhkwoC5wNhwKtw36EyQwvmFQsDRL
 mEi4GXLGhLOSN+jByyFNmyRp9OYM28NZ/nSiA10QQL+kIhZPNupGna0JEnSmX+AyZJHHctO3x
 +ygiecRKRSd78T2N92OkYf6waibeYG0qbn514tJ5IHleijUZsmaT5160kInYuJA2URDaBy3Mb
 V3DC2XQ+fG1+EmHRSxaFK4+t6HVfJmwzvIYi5+wZqOFxVkrrZVKJuRNlAd+iFrIBRhf/2X3bX
 /jtR/qidScNLPi9HR6JdJhDYppQ4cF7Gguls1dhZW9oMTBxTjl9yPTg41ii0TU0v6PuZMwEqV
 oRr31+NiinTUM6tFkHwmwhOnO0jqdpdLNUqe314sybFf8fLlLbkE09c2vFEseeUtDi3RlXTVx
 TL4T6STz8fKI8vDitQD/6GcGR5LwVvoFcu8VJGHzMHErR74XOoSJlW8GB1nowyY1WgnLb2/yA
 R4lTelYhJjznitiUhpWSXHAmNr5OilPDBXkkgFEoy7fsXF1oyFq6MeHhXplpj2RNKtv3lwGKm
 BIF4ieR2+qdki2uPiYww==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/01/2020 à 21:34, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Update xtensa syscall numbers based on Linux kernel tag v5.5-rc3
> (commit 46cf053e).
> 
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> ---
> 
> cc: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  linux-user/xtensa/syscall_nr.h | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/xtensa/syscall_nr.h b/linux-user/xtensa/syscall_nr.h
> index 27645be..3d19d0c 100644
> --- a/linux-user/xtensa/syscall_nr.h
> +++ b/linux-user/xtensa/syscall_nr.h
> @@ -431,7 +431,41 @@
>  #define TARGET_NR_pkey_free                          350
>  
>  #define TARGET_NR_statx                              351
> -
> -#define TARGET_NR_syscall_count                      352
> +#define TARGET_NR_rseq                               352
> +/* 353 through 402 are unassigned to sync up with generic numbers */
> +#define TARGET_NR_clock_gettime64                    403
> +#define TARGET_NR_clock_settime64                    404
> +#define TARGET_NR_clock_adjtime64                    405
> +#define TARGET_NR_clock_getres_time64                406
> +#define TARGET_NR_clock_nanosleep_time64             407
> +#define TARGET_NR_timer_gettime64                    408
> +#define TARGET_NR_timer_settime64                    409
> +#define TARGET_NR_timerfd_gettime64                  410
> +#define TARGET_NR_timerfd_settime64                  411
> +#define TARGET_NR_utimensat_time64                   412
> +#define TARGET_NR_pselect6_time64                    413
> +#define TARGET_NR_ppoll_time64                       414
> +#define TARGET_NR_io_pgetevents_time64               416
> +#define TARGET_NR_recvmmsg_time64                    417
> +#define TARGET_NR_mq_timedsend_time64                418
> +#define TARGET_NR_mq_timedreceive_time64             419
> +#define TARGET_NR_semtimedop_time64                  420
> +#define TARGET_NR_rt_sigtimedwait_time64             421
> +#define TARGET_NR_futex_time64                       422
> +#define TARGET_NR_sched_rr_get_interval_time64       423
> +#define TARGET_NR_pidfd_send_signal                  424
> +#define TARGET_NR_io_uring_setup                     425
> +#define TARGET_NR_io_uring_enter                     426
> +#define TARGET_NR_io_uring_register                  427
> +#define TARGET_NR_open_tree                          428
> +#define TARGET_NR_move_mount                         429
> +#define TARGET_NR_fsopen                             430
> +#define TARGET_NR_fsconfig                           431
> +#define TARGET_NR_fsmount                            432
> +#define TARGET_NR_fspick                             433
> +#define TARGET_NR_pidfd_open                         434
> +#define TARGET_NR_clone3                             435
> +
> +#define TARGET_NR_syscall_count                      436
>  
>  #endif /* XTENSA_SYSCALL_NR_H */
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

