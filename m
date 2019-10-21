Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31354CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B710E20873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B710E20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXkn-0003pS-HT
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMXgr-0008O7-6t
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMXgq-0003NR-43
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:25:41 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:52303)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMXgp-0003N6-Qy
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:25:40 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MIdNt-1iGig23yUP-00EbBp; Mon, 21 Oct 2019 15:25:32 +0200
Subject: Re: [PATCH v8 3/9] linux-user/strace: Improve settimeofday()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20191021114857.20538-1-f4bug@amsat.org>
 <20191021114857.20538-4-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <26a8cc88-ba17-73d0-0edc-c73389a35088@vivier.eu>
Date: Mon, 21 Oct 2019 15:25:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191021114857.20538-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rSkWak3L9zfyJq2+HbxJKfy/66EsINGk3Hr3BQGAgUxd+5SigdY
 9co8qJ98Tg9sYijMLQp6K4Aty7QI7zz2leUP0p9WA95gcmqk2NCifoVyVc9O2YP8GzHvcs2
 4lr9kKVOgb50ci2sbHO4Erff7VAsiv5mA93TZU0m8BmyIefmzHM5ZpJHxtxFk9fPdC74Uum
 sRU5+wwbIoSlTIeXrz2/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U9xKvUOm52Q=:5KSnI0HKyuDCMNX4Am5x+o
 4VdIUusI+bPqTvwbzis3V0taI4HCEDqvyEK1hqXDiMa1vkiGFiB1JiUXydiUe1jW0aGht6aiQ
 lzmxBH7KneXnnZnCB8IF7Y61qQz0q1oCbI/zYjV/R2wOBPVF8oo/hlZHiOz09O/4skrh+LB91
 +nnFBRuBFKHYwF2a5eQo5imr6x1d2HdX04TG6lKqWWH5l3xZWkhCxUnoLIan/8LDP3AUbxd0p
 8PgnafeX51m92qZNFlduy7LkMynjNmRm/f9e//Y4M5xdEPbPsnqAKivuAJWMdzIeseGx2u7ue
 LU8VWjAdHW4hrwqm7vqKEshAtzbI8ihEjepu/2/CleDJiAzcmDVh8G/pN/eHLdcep6uHTZi2H
 6f5j76ZP9XhehlwaVEIVMbdPGldnsrF1XXMrL/kaLQ+rlCMdgWdnE0pD9J7U0+BRZXlHPsiYx
 bo6T92bCyGXg3kwgmIFvh2uc2TK1Gv0QKJXgQ8KAKf6NDDTyxV8KJ4+c54ojcoybR82aux70j
 o7l3BOk47IOiCrjAVahMg23GgsRJOd6p/LOpCgu+nxKlaSDu5mRbCpfGh/UQnbB++Z3F9tn8Y
 WJzoR9E6WvyKV86AMPbAWb3SdzM5zi2PlauCmzm8MftdeEmszWcfpcxQaMxU8p7JIMYG+Yjmt
 ktAGM/QE+BFMPnEDWlB/nWKPcM5h+eyfsQJS+pO7o34HNupvBft59+d5Uz0/lf10vd6AUZje1
 ihmddunhHYmsalV/tXCyZX/8zyc42OROGQDhfLmvpsyJZM0DucQmXQtK7yrmJC+TW1THdmoZK
 QLFmb/qa5yl/MklqtgdrB3uB5rkzWzQcF84UQCR/j8mS/jyrqdEf+LpPHGqOiaZ4k9bKncKx9
 +MFJTEfmZ8AAWCSrqjxgugF3iboylQsRtoewsPKFY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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
Cc: =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
 Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 21/10/2019 à 13:48, Philippe Mathieu-Daudé a écrit :
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-By: Guido Günther <agx@sigxcpu.org>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/strace.c    | 13 +++++++++++++
>  linux-user/strace.list |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 2cd6687cd9..fd5596a640 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1583,6 +1583,19 @@ print_futimesat(const struct syscallname *name,
>  }
>  #endif
>  
> +#ifdef TARGET_NR_settimeofday
> +static void
> +print_settimeofday(const struct syscallname *name,
> +                abi_long arg0, abi_long arg1, abi_long arg2,
> +                abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_timeval(arg0, 0);
> +    print_timezone(arg1, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
>  #ifdef TARGET_NR_link
>  static void
>  print_link(const struct syscallname *name,
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index 63a946642d..1ff9168369 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -1345,7 +1345,7 @@
>  { TARGET_NR_set_tid_address, "set_tid_address" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_settimeofday
> -{ TARGET_NR_settimeofday, "settimeofday" , NULL, NULL, NULL },
> +{ TARGET_NR_settimeofday, "settimeofday" , NULL, print_settimeofday, NULL },
>  #endif
>  #ifdef TARGET_NR_setuid
>  { TARGET_NR_setuid, "setuid" , NULL, NULL, NULL },
> 

Applied to my linux-user branch.

Thanks,
Laurent

