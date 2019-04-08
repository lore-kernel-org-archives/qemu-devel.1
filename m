Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2722C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 13:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B66FC213F2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 13:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66FC213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53422 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDUcf-0005da-2S
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 09:47:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hDUbD-0004rL-Ir
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hDUbC-0003uF-9H
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:46:11 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:36897)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hDUbB-0003rj-TF
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:46:10 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1N3bfB-1gmNKx04Fn-010Z55; Mon, 08 Apr 2019 15:45:48 +0200
To: ghorges <ghorges@xiyoulinux.org>, qemu-devel@nongnu.org
References: <20190408133854.25737-1-ghorges@xiyoulinux.org>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
	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
Message-ID: <3bbe2125-8542-cdc9-621c-830a0f3c0e8a@vivier.eu>
Date: Mon, 8 Apr 2019 15:45:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408133854.25737-1-ghorges@xiyoulinux.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:H3iAa+vxPEsmjV6dYFyOHVwQsh+R7F01Km3+tMAgAIwtAr46J6x
	wpRITSF63vLb/GOwrBlA2Q/SiovakfBlW/RjuKfbxCQGBEp38SmU8TiSaveJgYs4kVRXdYJ
	ur4bbOrc/OLIDyN4fJpperny/ESlgMibuJ5JJjR/G8CPjhoXP837HH2W0vBjgsZEHMIm1ek
	pV47mXtgxaj/lHBoseZgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uUlOAU5rRJE=:tJK4Izns8vlTl/u1xL2tiK
	aXQ+2otewNYquazJuG9Mj0g1NszSLFogKiFEE7L+BjvS3l+8mWYDOlgSFAjcUZXDcSK1XxOy3
	xJERsMwojAILicPI3j4n+qSzew3CTXzBUM8DTaVTbzIPgFwVxW7uLO5ACY9PSlExGT1f1V11b
	siJId+FhGQqqWteew59wuCsV3/Rk8NusYWu+/UpK8RkgwNA3NdaEKkUgKWIYx+0P4K50zkqYi
	nSCKYCwCx8cvbXXWXwcuHiK9abuAi5pgNnRD6P3uu9uty+MiwtMQPAZkYDYQzPfh8QJe4EGvk
	fSL/2KPFg/eQy+2/MX1Q4aj8qnZGLuMgkThY4Mf60KqYc4oy4rRTW0HSFggEgbEUAOrRy5oem
	2AClDpDKabGECVeJbn8CMtIMsjMxXF78sIAk2J7oDQy6OcaNUeN4sKlVDVketGj1r1CcEZJ/A
	29DWjr9bv6kFV+2uf2skaXxPr9Q2rTc0NNLUKsPFqUHH+5DoC7b/r0jzZGr7ndDRu2g+41VeQ
	qq+UHHLw3CEQu6CKQXg/oxZR1CjWWK8bIVQ3poCV4oqTpL45M63bu5YkrTgo+wuA4s6lgmS9D
	m5rrqgmKMzrU5vrut+mACWRdJ84PgqtRQvYLsaJiHi691QwdDl8KDowIIoPa/1tBEgxnNRYdD
	N4NXTNCKGk0yt3fjozHxDrP0YteZKI0SYwgQXY/VWOEQ5HlOI0sxBvni8ZVz2h4+8xSyOxce7
	s2fiN5WtNEoRYeBmC4UojU3+mKcKBR63gYbCFmU0gokeznTnPgR93GxNpmM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [PATCH] Wshadow in
 qemu/linux-user/syscall.c:Changed some variable names
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ghorges <1298394633@qq.com>, riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408134546.8ycrOCU3TzH4aCUffPjk9RcZHqTI-3SD4w1iMDIsxb8@z>

Hi,

Le 08/04/2019 à 15:38, ghorges a écrit :
> From: ghorges <1298394633@qq.com>

Very weird. Perhaps you can update the author with "git commit --amend
--author='ghorges <ghorges@xiyoulinux.org>'" to have the same email address?

> Signed-off-by: ghorges <ghorges@xiyoulinux.org>

we need a description here with at least the problem you are trying to
fix (the error message from the compiler, for instance).

Thanks,
Laurent

> ---
>  linux-user/syscall.c | 66 ++++++++++++++++++++++----------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 208fd1813d..985095e4d5 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8240,7 +8240,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  size_t size;
>              } sig, *sig_ptr;
>  
> -            abi_ulong arg_sigset, arg_sigsize, *arg7;
> +            abi_ulong arg_sigset, arg_sigsize, *arg7s;
>              target_sigset_t *target_sigset;
>  
>              n = arg1;
> @@ -8280,13 +8280,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  sig_ptr = &sig;
>                  sig.size = SIGSET_T_SIZE;
>  
> -                arg7 = lock_user(VERIFY_READ, arg6, sizeof(*arg7) * 2, 1);
> -                if (!arg7) {
> +                arg7s = lock_user(VERIFY_READ, arg6, sizeof(*arg7s) * 2, 1);
> +                if (!arg7s) {
>                      return -TARGET_EFAULT;
>                  }
> -                arg_sigset = tswapal(arg7[0]);
> -                arg_sigsize = tswapal(arg7[1]);
> -                unlock_user(arg7, arg6, 0);
> +                arg_sigset = tswapal(arg7s[0]);
> +                arg_sigsize = tswapal(arg7s[1]);
> +                unlock_user(arg7s, arg6, 0);
>  
>                  if (arg_sigset) {
>                      sig.set = &set;
> @@ -9479,14 +9479,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          }
>      case TARGET_NR_getcpu:
>          {
> -            unsigned cpu, node;
> -            ret = get_errno(sys_getcpu(arg1 ? &cpu : NULL,
> +            unsigned cpus, node;
> +            ret = get_errno(sys_getcpu(arg1 ? &cpus : NULL,
>                                         arg2 ? &node : NULL,
>                                         NULL));
>              if (is_error(ret)) {
>                  return ret;
>              }
> -            if (arg1 && put_user_u32(cpu, arg1)) {
> +            if (arg1 && put_user_u32(cpus, arg1)) {
>                  return -TARGET_EFAULT;
>              }
>              if (arg2 && put_user_u32(node, arg2)) {
> @@ -10649,24 +10649,24 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      case TARGET_NR_listxattr:
>      case TARGET_NR_llistxattr:
>      {
> -        void *p, *b = 0;
> +        void *q, *b = 0;
>          if (arg2) {
>              b = lock_user(VERIFY_WRITE, arg2, arg3, 0);
>              if (!b) {
>                  return -TARGET_EFAULT;
>              }
>          }
> -        p = lock_user_string(arg1);
> -        if (p) {
> +        q = lock_user_string(arg1);
> +        if (q) {
>              if (num == TARGET_NR_listxattr) {
> -                ret = get_errno(listxattr(p, b, arg3));
> +                ret = get_errno(listxattr(q, b, arg3));
>              } else {
> -                ret = get_errno(llistxattr(p, b, arg3));
> +                ret = get_errno(llistxattr(q, b, arg3));
>              }
>          } else {
>              ret = -TARGET_EFAULT;
>          }
> -        unlock_user(p, arg1, 0);
> +        unlock_user(q, arg1, 0);
>          unlock_user(b, arg2, arg3);
>          return ret;
>      }
> @@ -10686,25 +10686,25 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      case TARGET_NR_setxattr:
>      case TARGET_NR_lsetxattr:
>          {
> -            void *p, *n, *v = 0;
> +            void *q, *n, *v = 0;
>              if (arg3) {
>                  v = lock_user(VERIFY_READ, arg3, arg4, 1);
>                  if (!v) {
>                      return -TARGET_EFAULT;
>                  }
>              }
> -            p = lock_user_string(arg1);
> +            q = lock_user_string(arg1);
>              n = lock_user_string(arg2);
> -            if (p && n) {
> +            if (q && n) {
>                  if (num == TARGET_NR_setxattr) {
> -                    ret = get_errno(setxattr(p, n, v, arg4, arg5));
> +                    ret = get_errno(setxattr(q, n, v, arg4, arg5));
>                  } else {
> -                    ret = get_errno(lsetxattr(p, n, v, arg4, arg5));
> +                    ret = get_errno(lsetxattr(q, n, v, arg4, arg5));
>                  }
>              } else {
>                  ret = -TARGET_EFAULT;
>              }
> -            unlock_user(p, arg1, 0);
> +            unlock_user(q, arg1, 0);
>              unlock_user(n, arg2, 0);
>              unlock_user(v, arg3, 0);
>          }
> @@ -10731,25 +10731,25 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      case TARGET_NR_getxattr:
>      case TARGET_NR_lgetxattr:
>          {
> -            void *p, *n, *v = 0;
> +            void *q, *n, *v = 0;
>              if (arg3) {
>                  v = lock_user(VERIFY_WRITE, arg3, arg4, 0);
>                  if (!v) {
>                      return -TARGET_EFAULT;
>                  }
>              }
> -            p = lock_user_string(arg1);
> +            q = lock_user_string(arg1);
>              n = lock_user_string(arg2);
> -            if (p && n) {
> +            if (q && n) {
>                  if (num == TARGET_NR_getxattr) {
> -                    ret = get_errno(getxattr(p, n, v, arg4));
> +                    ret = get_errno(getxattr(q, n, v, arg4));
>                  } else {
> -                    ret = get_errno(lgetxattr(p, n, v, arg4));
> +                    ret = get_errno(lgetxattr(q, n, v, arg4));
>                  }
>              } else {
>                  ret = -TARGET_EFAULT;
>              }
> -            unlock_user(p, arg1, 0);
> +            unlock_user(q, arg1, 0);
>              unlock_user(n, arg2, 0);
>              unlock_user(v, arg3, arg4);
>          }
> @@ -10776,19 +10776,19 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      case TARGET_NR_removexattr:
>      case TARGET_NR_lremovexattr:
>          {
> -            void *p, *n;
> -            p = lock_user_string(arg1);
> +            void *q, *n;
> +            q = lock_user_string(arg1);
>              n = lock_user_string(arg2);
> -            if (p && n) {
> +            if (q && n) {
>                  if (num == TARGET_NR_removexattr) {
> -                    ret = get_errno(removexattr(p, n));
> +                    ret = get_errno(removexattr(q, n));
>                  } else {
> -                    ret = get_errno(lremovexattr(p, n));
> +                    ret = get_errno(lremovexattr(q, n));
>                  }
>              } else {
>                  ret = -TARGET_EFAULT;
>              }
> -            unlock_user(p, arg1, 0);
> +            unlock_user(q, arg1, 0);
>              unlock_user(n, arg2, 0);
>          }
>          return ret;
> 


