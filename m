Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A34C433E3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA5C20823
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA5C20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgWBk-0001X8-A3
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 12:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jgW8K-00069X-RP
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:20:52 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:50663)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jgW8I-0005bW-Pl
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:20:52 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MHG4c-1jky7D1tDs-00DK92; Wed, 03 Jun 2020 18:20:47 +0200
To: Filip Bozuta <filip.bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200602115331.1659-1-filip.bozuta@syrmia.com>
 <20200602115331.1659-3-filip.bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 2/5] linux-user: Add strace support for printing argument
 of syscalls used for extend attributes
Message-ID: <e7d5ab62-372d-4519-3236-2fbae5f65a13@vivier.eu>
Date: Wed, 3 Jun 2020 18:20:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602115331.1659-3-filip.bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:duPL6tIef3Msw4KMrYcgm8pwNg17655r+gpUHGXSnFbc7Timrgp
 SoBOBDwA0mFIa92q2YclR/iFo7x1zEv498+bV+2OnqsUl8vBFCI8iuUlY1A+nL7MdxQt9T6
 lYPHBBka7wz+FKnpyeOvaMSFx8gkVUOwHXZkbUwOytAH5+WEee75Ch5l5UVWs5NMdRjmX+r
 nPSrTcQZl3JE5JwhhlHWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pGfBuTQ3qW0=:9y2OwdAl3nwFLNHUufweE+
 KblL3x7gGzD1tDOIGR04kDvvBudTvcMQZEX6/E9ZkKWdtzUYiD8Q6F6rUjIeLhG0eunQTFtfq
 GMAHhm1+6C0DtDCTAbzbq3k8efGolYavW6rkagnjCHdqjDLvSlMRoA5WyOGgLUTybhln1nlpt
 sIrGGm9GlUt1MOU1tRMVaUaqQg0aC2RcOkR4xZ7SiTfSTwu2mpArpavdAiyLNDOicCjprK7qe
 na5YeqICHCExulCE+cSWWZQ1aPlitMuF/Uc5lOBLPyKYLHa3T9y1wlOwbFmRUcuLwxaS38l1z
 AFrvhT/UvSbdMoBOvjoJxwDrpinnQ2flyT8ThLtDAufnMTbNiZN8Bfx09lqEA4BP+873Xzf2i
 LLQ0Dk0ak2uWXzUNBlvNrHl8kbrkxWZjMVCaPThDWii0qq2CCbDOQRxaCYJM9FbOmJ1WRQE++
 z6YwivFdWD55ZCi3uE241DXrSCMqbLFkZnnq4shQR4abcKGvE+Azm1nbTk1nxMNEmYzcr7M55
 5rr8Uej/ADYqKduXCTiSlSBvGiIyOnzA4G23U2X6W65Dms00hAHVBodJyCECCcrq3upntan65
 1UWdJrIT+UcXUJJGGR4PDLCmqj37AhEql9OGOQag9S8K/xeEVjwLki2S0R2i+hhPcMLbZFIex
 z5hh21W9eO0n4aAhVsb+T1sPaYfqVRFp143E8lIpu+Hi8eoDvcDElvP0pS9m+qo+uNTrUVoKS
 Rn1CBeGL3Ec3QdkM1oDo6FqeF2eN3ow29wCXRXNIp2oy6+GeuUHJ9pyy6OmjsQtxyPaovBi6l
 gmNeITMccPqQe6/pXNKqeZlJ1vfJJkFn5M7htckwA5EVkuQllKkLHRrJrAVswXmy0gwcrz5
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 12:20:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Le 02/06/2020 à 13:53, Filip Bozuta a écrit :
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
> Implementation notes:
> 
>     All of the syscalls have strings as argument types and thus a separate
>     printing function was stated in file "strace.list" for every one of them.
>     All of these printing functions were defined in "strace.c" using existing
>     printing functions for appropriate argument types:
>        "print_strig()" - for (const char*) type
>        "print_pointer()" - for (char*) and (void *) type
>        "print_raw_param()" for (int) and (size_t) type
>     Syscalls "getxattr()" and "lgetxattr()" have the same number and type of
>     arguments and thus their print functions ("print_getxattr", "print_lgetxattr")
>     share a same definition. The same statement applies to syscalls "listxattr()"
>     and "llistxattr()".
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/strace.c    | 60 ++++++++++++++++++++++++++++++++++++++++++
>  linux-user/strace.list | 12 ++++-----
>  2 files changed, 66 insertions(+), 6 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index c578876d22..5cf419989c 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1629,6 +1629,66 @@ print_fcntl(const struct syscallname *name,
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
> +    print_raw_param("%u", arg3, 1);

size_t is generally "unsigned long", so you should use TARGET_FMT_lu

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
> +    print_raw_param("%u", arg2, 1);

TARGET_FMT_lu

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
> +    print_raw_param("%u", arg3, 1);

TARGET_FMT_lu

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
> +    print_raw_param("%u", arg2, 1);

TARGET_FMT_lu

> +    print_syscall_epilogue(name);
> +}
> +#define print_llistxattr     print_listxattr
> +#endif
> +
>  #ifdef TARGET_NR_futimesat
>  static void
>  print_futimesat(const struct syscallname *name,
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index fb9799e7e6..8d51c54bca 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -218,13 +218,13 @@
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
> +{ TARGET_NR_flistxattr, "flistxattr" , NULL, print_flistxattr, NULL },
>  #endif
>  #ifdef TARGET_NR_flock
>  { TARGET_NR_flock, "flock" , NULL, NULL, NULL },
> @@ -396,7 +396,7 @@
>  { TARGET_NR_getuid32, "getuid32" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getxattr
> -{ TARGET_NR_getxattr, "getxattr" , NULL, NULL, NULL },
> +{ TARGET_NR_getxattr, "getxattr" , NULL, print_getxattr, NULL },
>  #endif
>  #ifdef TARGET_NR_getxgid
>  { TARGET_NR_getxgid, "getxgid" , NULL, NULL, NULL },
> @@ -480,7 +480,7 @@
>  { TARGET_NR_lchown32, "lchown32" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_lgetxattr
> -{ TARGET_NR_lgetxattr, "lgetxattr" , NULL, NULL, NULL },
> +{ TARGET_NR_lgetxattr, "lgetxattr" , NULL, print_lgetxattr, NULL },
>  #endif
>  #ifdef TARGET_NR_link
>  { TARGET_NR_link, "link" , NULL, print_link, NULL },
> @@ -495,10 +495,10 @@
>  { TARGET_NR_listen, "listen" , "%s(%d,%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_listxattr
> -{ TARGET_NR_listxattr, "listxattr" , NULL, NULL, NULL },
> +{ TARGET_NR_listxattr, "listxattr" , NULL, print_listxattr, NULL },
>  #endif
>  #ifdef TARGET_NR_llistxattr
> -{ TARGET_NR_llistxattr, "llistxattr" , NULL, NULL, NULL },
> +{ TARGET_NR_llistxattr, "llistxattr" , NULL, print_llistxattr, NULL },
>  #endif
>  #ifdef TARGET_NR__llseek
>  { TARGET_NR__llseek, "_llseek" , NULL, print__llseek, NULL },
> 

For the listxattr functions perhaps you can add a
print_syscall_ret_listxattr function to dump the returned list of
attributes.

It would be interesting to have also a print_syscall_ret_XXX function
for the getxattr functions to dump the returned values but it is not as
easy as for the list as value can be textual or binary data.

Thanks,
Laurent

