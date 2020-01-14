Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B66EC33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D0524684
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D0524684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irNmi-0002OP-6b
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irNm3-0001xz-RQ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:06:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irNm2-0003ns-Kh
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:06:31 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:43079)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irNm2-0003ml-Bu
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:06:30 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MYvse-1jDKTH326C-00UvUY; Tue, 14 Jan 2020 16:06:07 +0100
Subject: Re: [PATCH v5 04/20] linux-user: microblaze: Update syscall numbers
 to kernel 5.5 rc3 level
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1578947683-21011-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1578947683-21011-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9fdcf1ea-cfb7-2d59-0d38-03990425eadc@vivier.eu>
Date: Tue, 14 Jan 2020 16:06:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578947683-21011-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TgI3BaslggXlWLOPOk98AcjRL3pSCtWKKry38uK2lko4SeFYanx
 GHXI84Nh1J6Kt/7EDL9P7DMgw5xaI5w1emDjgPJ5Ib3R253gqldeZhhm66NRmv45gOTuecf
 2CkUKhskKVX1sNHBzzppYE5AloeYjTCOgQB6f1qXXhNx4hMV0XNLhDsB5x8eSWLBCaOug/v
 fdmCZTPKxPvJ2WQCjJR2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ti/oJl7Jyv0=:oUnDzRaZ/G92s4rw6XyOip
 WzUhYNzZEVvbXuIeQAelIWqSJWNFOoCPcjAnunZYgvlnoGvvMJ02sSQ2YoY05ZSFldYRjLzzU
 vVIF7yN27JFFtdyHmcr3c3ePpIrih9QgsSjFS4oYvAgqsVu3pKcj3VivoP317uGk50UvgLQgp
 Ah8jzINQGvZb8j1GomuHh65PBt28g9/HXhhH+ilwMpojWxmbIFTPdyO2DO798gZ/+Q9/5FGv6
 w1TPYtlfpoofg9caI4O6eNQqYYyqbIIMnvYllNRp/OkVMqUPfyfTD+ETclz+KSV2MiyHSt0C7
 eAbU54QNfQmKmxKEn3nnr7NRFto6YWTXq+Dnfpw5BagXMw0YwTyO2RkaZBdtUFd79YfHwHIlU
 75BlVRkp7ffTVcAGaRXBzVSPpthvIMzi1v+RJVJOZXzSC1E9LizmnsiyhaW8Er+teKadzST1y
 6Cq4k4MaiGKstFA1657HGx0UeKNYGek+0peXFCKTvzgRlfzsLSJhEGz0cYd9ZQqBZUTtIGkXy
 H71YrVNTPIQAUUTQhXyOCc8takwkaawQNiImQnLDCKspmzyK/xnvC/4ZR3UxGA1XzyB/12TRo
 GBu7CHucARUbeJAMWVOBAu566lRIIDlPzK7MWXgav2w0CnWESNyu6LB4fTVv9gluTbQUiCmF6
 ZJl0erFWmPoydKqZXlbNFhT5Q6XNs5jkI7iNJxZpS+P72pBxyfdY3X6TTh+xMBfrRiXPkdvks
 ndX7JUrKL+Yc9oHnA4Y3e8sqRWYfCis42yWqC8n5876UpiNkBnFee5C3Nrqgrrh91HpCA75k7
 iP3whpQ8IBJxsdpqvZlFmtV01cpan0H1ClEMVJJ/1DwvRqaSnpSOn1qlYzhYTHZKmzPJd15i2
 391R9AqPdbuNHbQCQ6/kojafO/4fFW4zLW/LGyBX4=
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/01/2020 à 21:34, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Update microblaze syscall numbers based on Linux kernel tag v5.5-rc3
> (commit 46cf053e).
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> ---
> 
> cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> ---
>  linux-user/microblaze/syscall_nr.h | 45 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/linux-user/microblaze/syscall_nr.h b/linux-user/microblaze/syscall_nr.h
> index aa2eb93..ec1758e 100644
> --- a/linux-user/microblaze/syscall_nr.h
> +++ b/linux-user/microblaze/syscall_nr.h
> @@ -393,5 +393,50 @@
>  #define TARGET_NR_memfd_create          386
>  #define TARGET_NR_bpf                   387
>  #define TARGET_NR_execveat              388
> +#define TARGET_NR_userfaultfd           389
> +#define TARGET_NR_membarrier            390
> +#define TARGET_NR_mlock2                391
> +#define TARGET_NR_copy_file_range       392
> +#define TARGET_NR_preadv2               393
> +#define TARGET_NR_pwritev2              394
> +#define TARGET_NR_pkey_mprotect         395
> +#define TARGET_NR_pkey_alloc            396
> +#define TARGET_NR_pkey_free             397
> +#define TARGET_NR_statx                 398
> +#define TARGET_NR_io_pgetevents         399
> +#define TARGET_NR_rseq                  400
> +/* 401 and 402 are unused */
> +#define TARGET_NR_clock_gettime64       403
> +#define TARGET_NR_clock_settime64       404
> +#define TARGET_NR_clock_adjtime64       405
> +#define TARGET_NR_clock_getres_time64   406
> +#define TARGET_NR_clock_nanosleep_time64 407
> +#define TARGET_NR_timer_gettime64       408
> +#define TARGET_NR_timer_settime64       409
> +#define TARGET_NR_timerfd_gettime64     410
> +#define TARGET_NR_timerfd_settime64     411
> +#define TARGET_NR_utimensat_time64      412
> +#define TARGET_NR_pselect6_time64       413
> +#define TARGET_NR_ppoll_time64          414
> +#define TARGET_NR_io_pgetevents_time64  416
> +#define TARGET_NR_recvmmsg_time64       417
> +#define TARGET_NR_mq_timedsend_time64   418
> +#define TARGET_NR_mq_timedreceive_time64 419
> +#define TARGET_NR_semtimedop_time64     420
> +#define TARGET_NR_rt_sigtimedwait_time64 421
> +#define TARGET_NR_futex_time64          422
> +#define TARGET_NR_sched_rr_get_interval_time64 423
> +#define TARGET_NR_pidfd_send_signal     424
> +#define TARGET_NR_io_uring_setup        425
> +#define TARGET_NR_io_uring_enter        426
> +#define TARGET_NR_io_uring_register     427
> +#define TARGET_NR_open_tree             428
> +#define TARGET_NR_move_mount            429
> +#define TARGET_NR_fsopen                430
> +#define TARGET_NR_fsconfig              431
> +#define TARGET_NR_fsmount               432
> +#define TARGET_NR_fspick                433
> +#define TARGET_NR_pidfd_open            434
> +#define TARGET_NR_clone3                435
>  
>  #endif
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

