Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9959BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C093205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C093205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Cnc-0008TZ-LA
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 12:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i1CkF-0005uq-1E
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i1CkB-0002EC-4I
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:48:57 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:53749)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i1CkA-0002Bv-Cb
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:48:54 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MLz7f-1hjwyD0A0P-00Hx40; Fri, 23 Aug 2019 18:48:36 +0200
To: Shu-Chun Weng <scw@google.com>, marcandre.lureau@gmail.com
References: <CAFEAcA-GWR6_wGCMWkMHttU3ARJPqfADvNTnqQUU_OzcWgHHuQ@mail.gmail.com>
 <20190819180947.180725-1-scw@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <66ab145d-2d5f-415c-8663-f8828041e93d@vivier.eu>
Date: Fri, 23 Aug 2019 18:48:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819180947.180725-1-scw@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YDYYpFs6RoKVk8H0Xb4z0i4/bS1GdKUw95mWd//zH5rc16BGk5v
 FlIYcvsG0vOFo+E6NsLqPmHDAJ4Ld+KWrV5DNAsBf3fmzDRKcT/9MLuNQq9wHwy8vQPCXln
 DoVeIkGsq6Z0ZgtmY+WGflNjcCyJ4TvRD8NoQAFzA9JOnFuuhHGE2bObJ5KW86vhkLPVFO6
 Jag/dIAQJPtNUMaLCywaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DjOtMq/nv2E=:oqhacqaObyjV3nNagDdTV0
 aVr08lxfWn6SHQRls5sLoHknNxkp/Tf5aUOA5XCV7fznyzbIKqCsqIxcA3XDvEJZQHPfmS/WI
 JECSEKG6Xq4EeK6FAkLjhcIIdzz2T2+m7Fu8swlJafld3MjfUmNW+dyEjd+a+0f4n0ZVB1xAG
 hVNYAcfchLjZ8woOt8h1OkrOqQ7Zk4osuE7OecShTpxGrhJWqC/7OM5WTLcJ95k6B/pGWbH+o
 C0PUv4Pe4XTXMxbgojuSmEPzDSojm64jOqUJDBEhbg0khG3rUWNpINA8ajTC4YKISLdpxpBpO
 rGH6CciSE9TCTC0S1M63XBkDsltWRFsJaFh00RXs8yyTXjYQjUoGreRFgAUlrpPvIQSC4Dehr
 2XXe3cUlasoaquqrICKg3j75oGjOq/PkUldyfKcyhDcPoYkwDDeR+YAInUtEkbgg128JabOEs
 oNu2UffS569bfE37a/yIr+2piI3h/I+ww1oOVSzc9EjjCNxzcr1kTwtAqYFO15kDC5k32EeRM
 wBUAOCBbmXfhPgcJ23HunF6Hj4IwI+EeivSUW4ZWfIsCvkVCXfiKMe/r35Vc8/t3+hsjiQq9h
 5lSsbOkHWtX//06DX24q2WoRDA+rMkbh7MyeKjGWwdMYLf2huFjDU2EdvTtKtm5KXKII8ORd+
 kL21aBlApgrkzpcPChSfglXfnZVJKmwyH4bDy2u3IZirUip5f4oqyEv6zVwJv7RO6SWzC/+95
 udFt6jwF38nVOXluSUFVwjrbm6wdyc3ZeEEA+er2uICEqnjrUN0Wgmc7ni0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: add memfd_create
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
Cc: arunkaly@google.com, riku.voipio@iki.fi, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 19/08/2019 à 20:09, Shu-Chun Weng via Qemu-devel a écrit :
> Add support for the memfd_create syscall. If the host does not have the
> libc wrapper, translate to a direct syscall with NC-macro.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1734792
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---

Please, next time, to help review, add an history here, something like:

v3: add fd_trans_unregister()
v2: no change

And don't send new versions as a reply to the previous ones.

>  include/qemu/memfd.h |  4 ++++
>  linux-user/syscall.c | 12 ++++++++++++
>  util/memfd.c         |  2 +-
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
> index d551c28b68..975b6bdb77 100644
> --- a/include/qemu/memfd.h
> +++ b/include/qemu/memfd.h
> @@ -32,6 +32,10 @@
>  #define MFD_HUGE_SHIFT 26
>  #endif
>  
> +#if defined CONFIG_LINUX && !defined CONFIG_MEMFD
> +int memfd_create(const char *name, unsigned int flags);
> +#endif
> +
>  int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
>                        uint64_t hugetlbsize, unsigned int seals, Error **errp);
>  bool qemu_memfd_alloc_check(void);
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8367cb138d..f3f9311e9c 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -20,6 +20,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
>  #include "qemu/path.h"
> +#include "qemu/memfd.h"
>  #include <elf.h>
>  #include <endian.h>
>  #include <grp.h>
> @@ -11938,6 +11939,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          /* PowerPC specific.  */
>          return do_swapcontext(cpu_env, arg1, arg2, arg3);
>  #endif
> +#ifdef TARGET_NR_memfd_create
> +    case TARGET_NR_memfd_create:
> +        p = lock_user_string(arg1);
> +        if (!p) {
> +            return -TARGET_EFAULT;
> +        }
> +        ret = get_errno(memfd_create(p, arg2));
> +        fd_trans_unregister(ret);
> +        unlock_user(p, arg1, 0);
> +        return ret;
> +#endif
>  
>      default:
>          qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
> diff --git a/util/memfd.c b/util/memfd.c
> index 00334e5b21..4a3c07e0be 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -35,7 +35,7 @@
>  #include <sys/syscall.h>
>  #include <asm/unistd.h>
>  
> -static int memfd_create(const char *name, unsigned int flags)
> +int memfd_create(const char *name, unsigned int flags)
>  {
>  #ifdef __NR_memfd_create
>      return syscall(__NR_memfd_create, name, flags);
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

