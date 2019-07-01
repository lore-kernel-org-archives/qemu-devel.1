Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5773CC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 08:44:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BAF82089C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 08:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAF82089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhrut-0004Zi-Ex
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 04:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39438)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hhrth-0003pi-TU
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hhrtg-0002VE-Kk
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:42:49 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:59205)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hhrtg-0002UK-BM
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:42:48 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mj8iJ-1iDMkv1mOD-00f83v; Mon, 01 Jul 2019 10:42:32 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1561718618-20218-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1561718618-20218-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9aaae9ca-39d8-39f8-9cb0-516c62eb1d25@vivier.eu>
Date: Mon, 1 Jul 2019 10:42:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561718618-20218-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YZ5HdQ9z/W5/kFdWXd4DoK0SrSrnYhBCOa0frNoZ5unxscDOpy6
 qzgWEwcaGjwNRmAx0S9Xgb6CX79UrMZiiCYi+ydI/n6QGW73JzFV+fdHGXRB9ftFJ2opzZb
 iDPJ3Zu6TqmVzudl1HDnm4Q2gJxq4nf6Jdp1JeizL2+HTm18vL0cgyKsyfXJp4+aWv3DTtW
 NZ9jmGChIBed9EuR4bRpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J8pJtvLfY7c=:Nj4tfwF+eHAH9IwiZv77jV
 XrbyB2iMOWdXSeg0yk4fC1LxWCYggJvmSXhPQx06AS5yaiY66UQfqLBuWUAazXOM7Gd+x9y5L
 nVFA4/jWsCImrF4Xk2OvwKC6oEY88dgU3O4DFGFfiNpVe1Qyv7a9oAAzESGcJQqr3k2Onhajd
 4STsoFFGgyyM0m2dpq+2M8HE6PbcBZ2ql2cNc1jMYdvQjzNOCcxreXJYb3bGOVt10knSQGJqi
 4sUofmHPBywCm4XSjH9i0TU40azqd86WIGgEOEVIp8vS9Xk4RMIUMZAmtVTYL0NZv8n/ylZGI
 v0ZGCf8Cw0A/u8jEBGV6shD6zUbSH3CyyZOBWdAoLysJdjOuWcENwl5SscjNUN3PEfG4TjqqG
 G8zqZ8BZ5oIjcPRtr2kEJL+/Pbm+PP2kc3SMrjcjE6QKIG59t5tM6gexMmYTrT2VDf/LXv199
 1hK3WVVxQT2GRwoHLyuu7seDX7RAGDUqcyhdeLezw48AY09HsNYsdVF59BRyNXOnQvP056h/V
 v849KL7ZSi8BBUaXK7EFZPtkrtUpxp5T/3B3AzpBM1ZBvCAxqxskyY4ZsvuJvpp4PScV3bjm1
 Qb/Qo3Z0Z3pykCejp22eEjvEVkU3lAV05YxoIg0QRIgj9xXeCqumHrhk0TvYIeM9UgdLmKbbb
 942dZtVcaRymJfhojuT7n0lRDDUVu2AL1Dy6zI/TwVXiPPvwzpPvrtIK38SRgu/7ErOpZcxyR
 wzhW9vR8BlrCJ5kFCFj+wUkDl1u+zUHQ/bgJ/phkZDtNPHbXIA6KnmNLH9o=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: Re: [Qemu-devel] [PATCH v16 2/5] linux-user: Add support for strace
 for statx() syscall
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
Cc: amarkovic@wavecomp.com, Jim Wilson <jimw@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 28/06/2019 à 12:43, Aleksandar Markovic a écrit :
> From: Jim Wilson <jimw@sifive.com>
> 
> All of the flags need to be conditional as old systems don't have
> statx support.  Otherwise it works the same as other stat family
> syscalls.  This requires the pending patch to add statx support.
> 
> Tested on Ubuntu 16.04 (no host statx) and Ubuntu 19.04 (with host
> statx) using a riscv32-linux toolchain.
> 
> Signed-off-by: Jim Wilson <jimw@sifive.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/strace.c    | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  linux-user/strace.list |  3 ++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 6f72a74..c80e93b 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -976,6 +976,76 @@ UNUSED static struct flags msg_flags[] = {
>      FLAG_END,
>  };
>  
> +UNUSED static struct flags statx_flags[] = {
> +#ifdef AT_EMPTY_PATH
> +    FLAG_GENERIC(AT_EMPTY_PATH),
> +#endif
> +#ifdef AT_NO_AUTOMOUNT
> +    FLAG_GENERIC(AT_NO_AUTOMOUNT),
> +#endif
> +#ifdef AT_SYMLINK_NOFOLLOW
> +    FLAG_GENERIC(AT_SYMLINK_NOFOLLOW),
> +#endif
> +#ifdef AT_STATX_SYNC_AS_STAT
> +    FLAG_GENERIC(AT_STATX_SYNC_AS_STAT),
> +#endif
> +#ifdef AT_STATX_FORCE_SYNC
> +    FLAG_GENERIC(AT_STATX_FORCE_SYNC),
> +#endif
> +#ifdef AT_STATX_DONT_SYNC
> +    FLAG_GENERIC(AT_STATX_DONT_SYNC),
> +#endif
> +    FLAG_END,
> +};
> +
> +UNUSED static struct flags statx_mask[] = {
> +/* This must come first, because it includes everything.  */
> +#ifdef STATX_ALL
> +    FLAG_GENERIC(STATX_ALL),
> +#endif
> +/* This must come second; it includes everything except STATX_BTIME.  */
> +#ifdef STATX_BASIC_STATS
> +    FLAG_GENERIC(STATX_BASIC_STATS),
> +#endif
> +#ifdef STATX_TYPE
> +    FLAG_GENERIC(STATX_TYPE),
> +#endif
> +#ifdef STATX_MODE
> +    FLAG_GENERIC(STATX_MODE),
> +#endif
> +#ifdef STATX_NLINK
> +    FLAG_GENERIC(STATX_NLINK),
> +#endif
> +#ifdef STATX_UID
> +    FLAG_GENERIC(STATX_UID),
> +#endif
> +#ifdef STATX_GID
> +    FLAG_GENERIC(STATX_GID),
> +#endif
> +#ifdef STATX_ATIME
> +    FLAG_GENERIC(STATX_ATIME),
> +#endif
> +#ifdef STATX_MTIME
> +    FLAG_GENERIC(STATX_MTIME),
> +#endif
> +#ifdef STATX_CTIME
> +    FLAG_GENERIC(STATX_CTIME),
> +#endif
> +#ifdef STATX_INO
> +    FLAG_GENERIC(STATX_INO),
> +#endif
> +#ifdef STATX_SIZE
> +    FLAG_GENERIC(STATX_SIZE),
> +#endif
> +#ifdef STATX_BLOCKS
> +    FLAG_GENERIC(STATX_BLOCKS),
> +#endif
> +#ifdef STATX_BTIME
> +    FLAG_GENERIC(STATX_BTIME),
> +#endif
> +    FLAG_END,
> +};
> +
>  /*
>   * print_xxx utility functions.  These are used to print syscall
>   * parameters in certain format.  All of these have parameter
> @@ -2611,6 +2681,22 @@ print_tgkill(const struct syscallname *name,
>  }
>  #endif
>  
> +#ifdef TARGET_NR_statx
> +static void
> +print_statx(const struct syscallname *name,
> +            abi_long arg0, abi_long arg1, abi_long arg2,
> +            abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_at_dirfd(arg0, 0);
> +    print_string(arg1, 0);
> +    print_flags(statx_flags, arg2, 0);
> +    print_flags(statx_mask, arg3, 0);
> +    print_pointer(arg4, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
>  /*
>   * An array of all of the syscalls we know about
>   */
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index db21ce4..63a9466 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -1650,3 +1650,6 @@
>  #ifdef TARGET_NR_atomic_barrier
>  { TARGET_NR_atomic_barrier, "atomic_barrier", NULL, NULL, NULL },
>  #endif
> +#ifdef TARGET_NR_statx
> +{ TARGET_NR_statx, "statx", NULL, print_statx, NULL },
> +#endif
> 

Applied to my linux-user branch.

Thanks,
Laurent


