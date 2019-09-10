Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71A4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:18:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB3A1208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3A1208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bLi-0000mZ-Nx
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7bKs-0000Cr-5G
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7bKq-0003Ju-OY
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:17:13 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:37547)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7bKq-0003Ij-FX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:17:12 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MMoOy-1hopzg2oMu-00IisZ; Tue, 10 Sep 2019 10:16:56 +0200
To: Shu-Chun Weng <scw@google.com>, Riku Voipio <riku.voipio@iki.fi>
References: <20190816211049.57317-1-scw@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <01038119-110d-a958-8771-7b002a6a549f@vivier.eu>
Date: Tue, 10 Sep 2019 10:16:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816211049.57317-1-scw@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OEYGxKMJKLeUf5mo8J0vT8UdaUH896lwYKDlW5T2+YBlOT9hMIA
 Jn0gWmSnaW/WUJldQezwFCGVISmufaEgh5/9HYJYjz8o1PGvxYJIpMi4GonQ4jR7KokBO4c
 BRYR3awKnuP8F4lfQnRfbSGuhLgb2e+k/NVfRWtlGucRXeEghRqL1Irv476zU/6Yq76lmFk
 m9J7uTjWiDe6fEZ5Yde1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f3rgsWEmijw=:NAWtdt2nONQo3N9iIKwugi
 4OtaHutpRf3vrdg5OJaNsVlMgdoPhwy/SDlz4EVipxwZkc8/CPaIWSol/l7wsb15CBa+0z49f
 Gaf7j5OkwrbZ57a0h5bOPwmlZ7XyBJMySsL3FBSx8XebuJqmMzsxcnU96/A8a9dX+fc5DA6O6
 uD+9zlGyLFwf+tGl8rNl/cpixPOgpmUWl8pHy82EmfZq/HoRt32eOyaB4/hOGcv8o8yxw9SrA
 uaFCuirMfMiHxvRSWXcyJH4WX1G1QzJrAakde+qR728tCW+KVLI6zdtV+L6lTrtz89/kHfFQL
 YuusD/Pp3ZwtgkmLVKxO31WiXINR22q+2NvoTlg4bpFtUjxN2ySForbhgqd3Iprq5qRK5F50+
 h0eSfKxM6ZNrVMGTlA+1HS8ZJPusPaPwd+yTip+euMb6mW6+Uqoa5unxe06I+odsbn8erb1Qr
 b/j8MHkhPr9yB0LaBexQk6RK2H2vWDW917z3TKlpeA2mTII5Ztlp62i733lF3DIlhYIoosUBh
 lSmEeeAoEZ8f4OVP7XGZbhqoJ5GTfqi7m7RTdlipDtfGP9Xq/JPNJ/dPaN9XX0kvlWw/GF4CM
 y2PUsL+mDaO2xLebK76c3RE8YUb9l4/aS1l5w4GrfV1E4x3gRWB6WgLXvzF06wC+Y//Cv3S/v
 3bHJTi8iDxKoQqb3ETIMIMqq2rr4B1NGbWw5x6aidxIrS65aFXqXI+ng76Drv3MfGEg8IIV7w
 UU5a/8XVT9nW76KoKDoHW0EXBk6nRBa4HdDetdaZcjTKv/+rroYmP0suYdULFBpttt91HvERM
 5scRreyp1SCMhCJ0MQhthncqOJrrGa69JLxlYXRPKmwswlr4ks=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: Re: [Qemu-devel] [PATCH] linux-user: add memfd_create
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
Cc: arunkaly@google.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 16/08/2019 à 23:10, Shu-Chun Weng via Qemu-devel a écrit :
> Add support for the memfd_create syscall. If the host does not have the
> libc wrapper, translate to a direct syscall with NC-macro.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1734792
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
>  include/qemu/memfd.h |  4 ++++
>  linux-user/syscall.c | 11 +++++++++++
>  util/memfd.c         |  2 +-
>  3 files changed, 16 insertions(+), 1 deletion(-)
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
> index 8367cb138d..b506c1f40e 100644
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
> @@ -11938,6 +11939,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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

Applied to my linux-user branch.

Thanks,
Laurent

