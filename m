Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E65C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 19:09:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0524206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 19:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0524206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj65v-0005y8-VG
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 15:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jj63F-0003Gx-K4
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 15:06:17 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:54327)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jj63D-0006XD-Al
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 15:06:17 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MpTpc-1j8uHg0TgS-00pwJ7; Wed, 10 Jun 2020 21:06:12 +0200
To: Filip Bozuta <filip.bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200608164357.25065-1-filip.bozuta@syrmia.com>
 <20200608164357.25065-4-filip.bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2 3/6] linux-user: Add strace support for printing
 argument of syscalls used for extended attributes
Message-ID: <29e41cc8-ea01-daea-2599-7af138fb2be3@vivier.eu>
Date: Wed, 10 Jun 2020 21:06:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608164357.25065-4-filip.bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6hG1/pbQz/eusf0Oy/x7fJenFvlMDh2zm5Ih+1jCi4Lv6cDYFjS
 rPd/jdCpoomXazmIMN4bX4PdRuwQIq+yud6D93Aed+nc0jZH17mONbJjh1twj6CAqhCkTxx
 ZflU7+6+mdqviy9cDFfLLhi/g1b75gAu9KehMwWwvdnTQ0A7pU+8z3bWF2awqYyY7BO0o48
 eMVBlD0C5q8HV8qdjl74Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/g7/b2y4ioU=:UH1K2hcsngxQd/+e0f8Sfp
 5sCsAJDxYc29aWW+/0RWXC7UPSTbL7xsgeMbtK078rp3PGQjQPWWAZ2BbAe3/v+31zKMcXhR4
 aPR6UfDS0A8BDqAYWwQunHOcFCO6t95lzxidNdR2hGrbIbptyIPDXeHyOLI9SHL9Unx/iREsO
 lz3tvWD4/C5PVbkkQRvS2EHEkn1yxjBFI1TMEvAU3D1ojDcL+IdwDz8gane47mABpAIkEQsVp
 LdbkajTN5o+LWcrZj/objwvZKMKx3dTXbn3k3j1/5mCJkoy2798cjPIsVEKcIWzp9pQ7qucit
 0WDGXgjZL6jbZjUAHB4+VjhOhAhfFBAe4/7+zdxhTCSxJEvz5n+GV9teiOu2IqmW/JSNlIHhS
 hbHmwNDz4uFBNpb+L/5WdNF6951aH7dYY6I7O6DiCcBAzrvdFA7M76XBEQ9fqBnRG+bE8B5Xb
 YM1spPSad1fibsbsiEtmoHJhz0kygiu0sAhYLD8tnk3t0gAmLPzDp9Wku3o/7M4Z3lEql0H4c
 VdZ1S0RKnD3CnnhFriTB5J6KE7NEDU9o1FQUhyakUcj3RgCIuJHkUNErFGhutxgpqSHyCbbVO
 B1rHM2T7V5ShUBU3jZ748djcxJu4urd6RFeTqT245bACk0yUIVp7GuTH77AVZnpsMh85/29YV
 ollRuzAyUlENtySNhLl3XM/0ibMQ9RaxQoJe7s+KT3zX1BRCLsYBQ4njxjskDZY1azEUMAHzr
 6oeAuZUf3O72WOwarjwZyPvg9+oSUePr6CfC+PBpMXKePsMD6v6iQx8mojtut7rcyQA1Jm28V
 bwZeeP6jYPkOaRm6BxDIyYzxOO890pOlWpFfgLwerEZwuObEcQ=
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 15:06:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Le 08/06/2020 à 18:43, Filip Bozuta a écrit :
> From: Filip Bozuta <Filip.Bozuta@syrmia.com>
> 
> This patch implements strace argument printing functionality for following syscalls:
> 
>     *getxattr, lgetxattr, fgetxattr - retrieve an extended attribute value
> 
>         ssize_t getxattr(const char *path, const char *name, void *value, size_t size)
>         ssize_t lgetxattr(const char *path, const char *name, void *value, size_t size)
>         ssize_t fgetxattr(int fd, const char *name, void *value, size_t size)
>         man page: https://www.man7.org/linux/man-pages/man2/getxattr.2.html
> 
>     *listxattr, llistxattr, flistxattr - list extended attribute names
> 
>         ssize_t listxattr(const char *path, char *list, size_t size)
>         ssize_t llistxattr(const char *path, char *list, size_t size)
>         ssize_t flistxattr(int fd, char *list, size_t size)
>         man page: https://www.man7.org/linux/man-pages/man2/listxattr.2.html
> 
>     *removexattr, lremovexattr, fremovexattr - remove an extended attribute
> 
>          int removexattr(const char *path, const char *name)
>          int lremovexattr(const char *path, const char *name)
>          int fremovexattr(int fd, const char *name)
>          man page: https://www.man7.org/linux/man-pages/man2/removexattr.2.html
> 
> Implementation notes:
> 
>     All of the syscalls have strings as argument types and thus a separate
>     printing function was stated in file "strace.list" for every one of them.
>     All of these printing functions were defined in "strace.c" using existing
>     printing functions for appropriate argument types:
>        "print_string()" - for (const char*) type
>        "print_pointer()" - for (char*) and (void *) type
>        "print_raw_param()" for (int) and (size_t) type
>     Syscalls "getxattr()" and "lgetxattr()" have the same number and type of
>     arguments and thus their print functions ("print_getxattr", "print_lgetxattr")
>     share a same definition. The same statement applies to syscalls "listxattr()"
>     and "llistxattr()".
>     Function "print_syscall_ret_listxattr()" was added to print the returned list
>     of extended attributes for syscalls and was listed as a "result" function in file
>     "strace.list" for syscalls: "listxattr(), llistxattr(), flistxattr()".
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/strace.c    | 126 +++++++++++++++++++++++++++++++++++++++++
>  linux-user/strace.list |  21 ++++---
>  2 files changed, 138 insertions(+), 9 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index f980451e3f..59fdb0a05f 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -830,6 +830,45 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret,
>  }
>  #endif
>  
> +#if defined(TARGET_NR_listxattr) || defined(TARGET_NR_llistxattr) \
> + || defined(TARGGET_NR_flistxattr)
> +static void
> +print_syscall_ret_listxattr(const struct syscallname *name, abi_long ret,
> +                            abi_long arg0, abi_long arg1, abi_long arg2,
> +                            abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    const char *errstr = NULL;
> +
> +    qemu_log(" = ");
> +    if (ret < 0) {
> +        qemu_log("-1 errno=%d", errno);
> +        errstr = target_strerror(-ret);
> +        if (errstr) {
> +            qemu_log(" (%s)", errstr);
> +        }

We have several time this kind of code in strace.c
(print_syscall_ret_addr, print_syscall_ret_adjtimex, print_syscall_ret)
perhaps it could be moved  to generic function (in a previous patch)?

> +    } else {
> +        qemu_log(TARGET_ABI_FMT_ld, ret);
> +        qemu_log(" (list = ");
> +        if (arg1 != 0) {
> +            abi_long attr = arg1;
> +            for (;;) {

We should avoid an infinite loop, and it's easy as you now the size of
the buffer (ret).

> +                print_string(attr, 1);
> +                attr += target_strlen(attr) + 1;
> +                if (target_strlen(attr) == 0) {
> +                    break;
> +                }
> +                qemu_log(",");
> +            }
> +        } else {
> +            qemu_log("NULL");
> +        }
> +        qemu_log(")");
> +    }
> +
> +    qemu_log("\n");
> +}

You should do as for the entry functions, and define the ones for
llistxattr and flistxattr:

#define print_syscall_ret_flistxattr print_syscall_ret_listxattr
#define print_syscall_ret_xlistxattr print_syscall_ret_listxattr

I have no preference on that but it's to be homogeneous with the rest of
the code.

> +#endif
> +
>  UNUSED static struct flags access_flags[] = {
>      FLAG_GENERIC(F_OK),
>      FLAG_GENERIC(R_OK),
> @@ -1637,6 +1676,93 @@ print_fcntl(const struct syscallname *name,
>  #define print_fcntl64   print_fcntl
>  #endif
>  
> +#ifdef TARGET_NR_fgetxattr
> +static void
> +print_fgetxattr(const struct syscallname *name,
> +    abi_long arg0, abi_long arg1, abi_long arg2,
> +    abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_raw_param("%d", arg0, 0);
> +    print_string(arg1, 0);
> +    print_pointer(arg2, 0);
> +    print_raw_param(TARGET_FMT_lu, arg3, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
> +#ifdef TARGET_NR_flistxattr
> +static void
> +print_flistxattr(const struct syscallname *name,
> +    abi_long arg0, abi_long arg1, abi_long arg2,
> +    abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_raw_param("%d", arg0, 0);
> +    print_pointer(arg1, 0);
> +    print_raw_param(TARGET_FMT_lu, arg2, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
> +#if defined(TARGET_NR_getxattr) || defined(TARGET_NR_lgetxattr)
> +static void
> +print_getxattr(const struct syscallname *name,
> +    abi_long arg0, abi_long arg1, abi_long arg2,
> +    abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_string(arg0, 0);
> +    print_string(arg1, 0);
> +    print_pointer(arg2, 0);
> +    print_raw_param(TARGET_FMT_lu, arg3, 1);
> +    print_syscall_epilogue(name);
> +}
> +#define print_lgetxattr     print_getxattr
> +#endif
> +
> +#if defined(TARGET_NR_listxattr) || defined(TARGET_NR_llistxattr)
> +static void
> +print_listxattr(const struct syscallname *name,
> +    abi_long arg0, abi_long arg1, abi_long arg2,
> +    abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_string(arg0, 0);
> +    print_pointer(arg1, 0);
> +    print_raw_param(TARGET_FMT_lu, arg2, 1);
> +    print_syscall_epilogue(name);
> +}
> +#define print_llistxattr     print_listxattr
> +#endif
> +
> +#if defined(TARGET_NR_fremovexattr)
> +static void
> +print_fremovexattr(const struct syscallname *name,
> +    abi_long arg0, abi_long arg1, abi_long arg2,
> +    abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_raw_param("%d", arg0, 0);
> +    print_string(arg1, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
> +#if defined(TARGET_NR_removexattr) || defined(TARGET_NR_lremovexattr)
> +static void
> +print_removexattr(const struct syscallname *name,
> +    abi_long arg0, abi_long arg1, abi_long arg2,
> +    abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_string(arg0, 0);
> +    print_string(arg1, 1);
> +    print_syscall_epilogue(name);
> +}
> +#define print_lremovexattr     print_removexattr
> +#endif
> +
>  #ifdef TARGET_NR_futimesat
>  static void
>  print_futimesat(const struct syscallname *name,
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index fb9799e7e6..05a72370c1 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -218,13 +218,14 @@
>  { TARGET_NR_fdatasync, "fdatasync" , "%s(%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_fgetxattr
> -{ TARGET_NR_fgetxattr, "fgetxattr" , NULL, NULL, NULL },
> +{ TARGET_NR_fgetxattr, "fgetxattr" , NULL, print_fgetxattr, NULL },
>  #endif
>  #ifdef TARGET_NR_finit_module
>  { TARGET_NR_finit_module, "finit_module" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_flistxattr
> -{ TARGET_NR_flistxattr, "flistxattr" , NULL, NULL, NULL },
> +{ TARGET_NR_flistxattr, "flistxattr" , NULL, print_flistxattr,
> +                        print_syscall_ret_listxattr},

print_syscall_ret_flistxattr

>  #endif
>  #ifdef TARGET_NR_flock
>  { TARGET_NR_flock, "flock" , NULL, NULL, NULL },
> @@ -233,7 +234,7 @@
>  { TARGET_NR_fork, "fork" , "%s()", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_fremovexattr
> -{ TARGET_NR_fremovexattr, "fremovexattr" , NULL, NULL, NULL },
> +{ TARGET_NR_fremovexattr, "fremovexattr" , NULL, print_fremovexattr, NULL },
>  #endif
>  #ifdef TARGET_NR_fsetxattr
>  { TARGET_NR_fsetxattr, "fsetxattr" , NULL, NULL, NULL },
> @@ -396,7 +397,7 @@
>  { TARGET_NR_getuid32, "getuid32" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getxattr
> -{ TARGET_NR_getxattr, "getxattr" , NULL, NULL, NULL },
> +{ TARGET_NR_getxattr, "getxattr" , NULL, print_getxattr, NULL },
>  #endif
>  #ifdef TARGET_NR_getxgid
>  { TARGET_NR_getxgid, "getxgid" , NULL, NULL, NULL },
> @@ -480,7 +481,7 @@
>  { TARGET_NR_lchown32, "lchown32" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_lgetxattr
> -{ TARGET_NR_lgetxattr, "lgetxattr" , NULL, NULL, NULL },
> +{ TARGET_NR_lgetxattr, "lgetxattr" , NULL, print_lgetxattr, NULL },
>  #endif
>  #ifdef TARGET_NR_link
>  { TARGET_NR_link, "link" , NULL, print_link, NULL },
> @@ -495,10 +496,12 @@
>  { TARGET_NR_listen, "listen" , "%s(%d,%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_listxattr
> -{ TARGET_NR_listxattr, "listxattr" , NULL, NULL, NULL },
> +{ TARGET_NR_listxattr, "listxattr" , NULL, print_listxattr,
> +                       print_syscall_ret_listxattr},
>  #endif
>  #ifdef TARGET_NR_llistxattr
> -{ TARGET_NR_llistxattr, "llistxattr" , NULL, NULL, NULL },
> +{ TARGET_NR_llistxattr, "llistxattr" , NULL, print_llistxattr,
> +                        print_syscall_ret_listxattr},

print_syscall_ret_llistxattr

>  #endif
>  #ifdef TARGET_NR__llseek
>  { TARGET_NR__llseek, "_llseek" , NULL, print__llseek, NULL },
> @@ -510,7 +513,7 @@
>  { TARGET_NR_lookup_dcookie, "lookup_dcookie" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_lremovexattr
> -{ TARGET_NR_lremovexattr, "lremovexattr" , NULL, NULL, NULL },
> +{ TARGET_NR_lremovexattr, "lremovexattr" , NULL, print_lremovexattr, NULL },
>  #endif
>  #ifdef TARGET_NR_lseek
>  { TARGET_NR_lseek, "lseek" , NULL, NULL, NULL },
> @@ -1116,7 +1119,7 @@
>  { TARGET_NR_remap_file_pages, "remap_file_pages" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_removexattr
> -{ TARGET_NR_removexattr, "removexattr" , NULL, NULL, NULL },
> +{ TARGET_NR_removexattr, "removexattr" , NULL, print_removexattr, NULL },
>  #endif
>  #ifdef TARGET_NR_rename
>  { TARGET_NR_rename, "rename" , NULL, print_rename, NULL },
> 

Thanks,
Laurent

