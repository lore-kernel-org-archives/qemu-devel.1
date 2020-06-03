Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15294C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24BE20679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24BE20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUJp-0001IN-39
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jgUJ0-00082h-9k
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:23:46 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:35349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jgUIy-0002Kk-QY
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:23:45 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N9dkB-1isbL443rp-015Yms; Wed, 03 Jun 2020 16:23:40 +0200
Subject: Re: [PATCH 1/5] linux-user: Add strace support for a group of syscalls
To: Filip Bozuta <filip.bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200602115331.1659-1-filip.bozuta@syrmia.com>
 <20200602115331.1659-2-filip.bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <488cbeed-359d-cbcc-aece-f70a82d9fb0f@vivier.eu>
Date: Wed, 3 Jun 2020 16:23:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602115331.1659-2-filip.bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:58g3DL6crqzO1DjuSFT6FNotU5R4umD9XOXvBrXba9l/arQX2oY
 u/tvR9AtQKut3K7gIu3tIdYdGlWF0hHsH5ai58Kx3ME4BiMPW5GJ9xme+XeKBnRMULirMuA
 Zm1ECfcklhdA2jTcn9CylPq+CAS43CHsdkIJg4E97xgygU7dnb/J4QmCmlAurRt+cC/YnTo
 pTMqYn2d83Evc9V7l6Ivw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uxXcZ27tTQE=:GhcdVCwx7yvLuppmEZtjpZ
 LgIRnAMg4uigeCKh2zLGop1rEw+mfjF327lXplY7mRBuRqo4v0tUfkMPtsq5r7oZjzF6t23Us
 qaBtWzrLwNiwvFCPTR1f3nTs2a0zx6Riw2UQO6SXWJ3Nd8ZIB6eV4R52+2xsgrNOiyOi8T6/x
 vT4ME6IaHzwVTwelRu/OIX4qNEC13fpbautmQVllfYjVAoWj9UHCdJjLZRrcu3jTuVwvci1B6
 yoJPflJ+YB89k1UO/to61cw66bBPaNjhPY0HQxGGuDOfD1wSb1GJA9rfzDrLtrS7IKPchq/lE
 GUI5ngAGK7poyVBgDaPX/vOoLhEZK3KnJxiF+JMj0TrtqhTJ3++sDmQnRXt2M6nW7JOP9zWRK
 4cNnWPj4SWmY09Mdysdu3LvB7j8wYh7vwZovteWKetfrwOoNKzrY8VAPc87y3UVE4A8ZNyxfT
 PW1QcOQfmYQGssUSLJZMZ2Oid0fyIBVVs88hMYZpjmb8LP/KQAq/aIJW9twSQWbCOj5SixSoI
 To081VHUMXHa+EnKEyRuKwwlAh33pBUw3GkFkl8pFnNrM/uIwc1kz7PLCtFdIfxX5wkDsyhng
 E3FA+vI1UcG72hGFTGbEtAnQcwzXyQFwzktWv4vP5tL9poxNMBFF8MzwdoTj8MttxspQi+bag
 g4r4iVa3lO7nciPyS1ycrkU9V1V+DWTinwzUgSG7GDVwKGi3JXXkKKc7rx20XPf0UbTAkgs3L
 YrVqudZ6wcwjXBzzjjSkbEoJEl52OixUZ4ttcc53lrE0uv/KWWFQObYNwKrpzASx8CZycImk0
 lgm4ie4wC/08XJ7oAsrWLgqUII1l1HmyHEmDcV20DTWpi10GmaFU7gqNHTIDnnO4IYhcHTQ
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 10:23:42
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
>     *acct - switch process accounting on or off
> 
>         int acct(const char *filename)
>         man page: https://www.man7.org/linux/man-pages/man2/acct.2.html
> 
>     *fsync, fdatasync - synchronize a file's in-core state with storage device
> 
>         int fsync(int fd)
>         int fdatasync(int fd)
>         man page: https://www.man7.org/linux/man-pages/man2/fsync.2.html
> 
>     *listen - listen for connections on a socket
> 
>         int listen(int sockfd, int backlog)
>         man page: https://www.man7.org/linux/man-pages/man2/listen.2.html
> 
> Implementation notes:
> 
>     Syscall acct() takes string as its only argument and thus a separate
>     print function "print_acct" is stated in file "strace.list". This
>     function is defined and implemented in "strace.c" by using an
>     existing function used to print string arguments: "print_string()".
>     All the other syscalls have only primitive argument types, so the
>     rest of the implementation was handled by stating an appropriate
>     printing format in file "strace.list".
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/strace.c    | 13 ++++++++++++-
>  linux-user/strace.list |  8 ++++----
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 0d9095c674..c578876d22 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1353,6 +1353,18 @@ print_access(const struct syscallname *name,
>  }
>  #endif
>  
> +#ifdef TARGET_NR_acct
> +static void
> +print_acct(const struct syscallname *name,
> +    abi_long arg0, abi_long arg1, abi_long arg2,
> +    abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_string(arg0, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
>  #ifdef TARGET_NR_brk
>  static void
>  print_brk(const struct syscallname *name,
> @@ -1617,7 +1629,6 @@ print_fcntl(const struct syscallname *name,
>  #define print_fcntl64   print_fcntl
>  #endif
>  
> -
>  #ifdef TARGET_NR_futimesat
>  static void
>  print_futimesat(const struct syscallname *name,
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index d49a1e92a8..fb9799e7e6 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -13,7 +13,7 @@
>  { TARGET_NR_access, "access" , NULL, print_access, NULL },
>  #endif
>  #ifdef TARGET_NR_acct
> -{ TARGET_NR_acct, "acct" , NULL, NULL, NULL },
> +{ TARGET_NR_acct, "acct" , NULL, print_acct, NULL },
>  #endif
>  #ifdef TARGET_NR_add_key
>  { TARGET_NR_add_key, "add_key" , NULL, NULL, NULL },
> @@ -215,7 +215,7 @@
>  { TARGET_NR_fcntl64, "fcntl64" , NULL, print_fcntl64, NULL },
>  #endif
>  #ifdef TARGET_NR_fdatasync
> -{ TARGET_NR_fdatasync, "fdatasync" , NULL, NULL, NULL },
> +{ TARGET_NR_fdatasync, "fdatasync" , "%s(%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_fgetxattr
>  { TARGET_NR_fgetxattr, "fgetxattr" , NULL, NULL, NULL },
> @@ -251,7 +251,7 @@
>  { TARGET_NR_fstatfs64, "fstatfs64" , "%s(%d,%p)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_fsync
> -{ TARGET_NR_fsync, "fsync" , NULL, NULL, NULL },
> +{ TARGET_NR_fsync, "fsync" , "%s(%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_ftime
>  { TARGET_NR_ftime, "ftime" , NULL, NULL, NULL },
> @@ -492,7 +492,7 @@
>  { TARGET_NR_Linux, "Linux" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_listen
> -{ TARGET_NR_listen, "listen" , NULL, NULL, NULL },
> +{ TARGET_NR_listen, "listen" , "%s(%d,%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_listxattr
>  { TARGET_NR_listxattr, "listxattr" , NULL, NULL, NULL },
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

