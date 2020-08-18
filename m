Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBB4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55ADB207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55ADB207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8497-0001Ox-Gz
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 12:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k83yI-0008GS-HB
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:56:22 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:54799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k83yF-0006oM-Mr
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:56:22 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MK3iK-1kNwAI29c6-00LS0A; Tue, 18 Aug 2020 17:56:16 +0200
To: Andrew Aladjev <aladjev.andrew@gmail.com>, qemu-devel@nongnu.org
References: <20200817235712.10957-1-aladjev.andrew@gmail.com>
 <20200817235712.10957-2-aladjev.andrew@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 2/3] linux user: moving is proc functions to separate file
Message-ID: <3cba9ec5-5041-f036-524f-c207cede4346@vivier.eu>
Date: Tue, 18 Aug 2020 17:56:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817235712.10957-2-aladjev.andrew@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rgj2ArV9Wru5n3DSdm346fjnBU7UpgqHestO8S845q9tbnSGxTW
 QajImMc/EUSRXeIYsRjRbdpGmhrHC8iHbxZiOlZlA4Fwg3Ne2GpXQjUsKaMduvV/hjqgfta
 xYo9cb/hxE9RXnzk5Xl6ZcO9xOC+G3tjJ3LxJY25jsm8yqfKS9fTQjmsQXRhMl0Q9trt5vC
 fnXEsG9ItaqZ6fn4+C9HQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:quL2GihK+BE=:IGTqtj9qAKue0xlgVH0WbF
 3zp6PevRJHk2O5r9JVj8LEFbSyRQkaOOajJDgumvM2gXAWCHLO09FGhCQu13BmARLQ00xrEfz
 FoWcRSOdpg2vAbjFw8is+1HPli+L5QlS8ArR+76gCE7V5BWyrN6b75MdQBKMZsRwtVfwb+96A
 kz/dP98oXzwqVwIpHef3kRiTDC3IIxRVlRyah36vJEuHzLnlUeYOLY9vJQBYNUdGZDO+rAMxS
 rCYnu6KAxc1bcJ5ON+94Tmfm1Lb2I7HkJ9WLAsscFPAPCKOW9O2K9K8IZVfNbg6EtLeFQOKFS
 zELHjLmAg2Oh6QaOMo85HHDQlLU+biwDk33L3xCuRgow5/aAJEtgJZRUvX8Um1OjGHbkecPY5
 k/0I69X4QLxQr6vLc8RD5VYRvZGpNFzMvvxbUzXWGR7VfDySnIb7WfJ/hiMuCN0roqVTUsBDo
 hXlfXdxfEIzrmW1PZnU5tcQIoyh8yZ1TQ4jHlUyTc0qVrH4zUOxHVxC6wFZ1/S8X9XXVGemLe
 lVuL0gjweqXu/urULhdNGhjtyWOlKB/4Tdcol0R9RA1fweWKqgXBlgz+GLbvd2gr5UTWWI6Za
 VvzdBPF0KsoEhMSQT43aRNguqu7Us59Bcu5C8vjncRLqpjHQirWrMrSxsxLVH+o+Vsn5qs0/A
 qre988tixgnlGkaHyv1lT+JfoC2EN8ns6JdGs+U+UBhWCjZmJSgbhaVMXjs+z9tBxijH3HtRH
 S7qqZGFBDDCv7//lsw8cuqKeGFx5KaX1brllyGeCXCWVcDr5fEZEFqgYosQZSD/4nEQVpwWIL
 0nQcEYvcqVc+elivRR3i1qmBferhAYFReJLume/5ZuHh859GihHC8m2VvvejLRsgZ3YDvcu
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 11:56:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Le 18/08/2020 à 01:57, Andrew Aladjev a écrit :
> Signed-off-by: Andrew Aladjev <aladjev.andrew@gmail.com>
> ---
>  linux-user/Makefile.objs  |  5 +++--
>  linux-user/syscall.c      | 33 +--------------------------------
>  linux-user/syscall_proc.c | 32 ++++++++++++++++++++++++++++++++
>  linux-user/syscall_proc.h |  7 +++++++
>  4 files changed, 43 insertions(+), 34 deletions(-)
>  create mode 100644 linux-user/syscall_proc.c
>  create mode 100644 linux-user/syscall_proc.h
> 
> diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
> index 1940910a73..20f8828b86 100644
> --- a/linux-user/Makefile.objs
> +++ b/linux-user/Makefile.objs
> @@ -1,7 +1,8 @@
>  obj-y = main.o syscall.o strace.o mmap.o signal.o \
>  	elfload.o linuxload.o uaccess.o uname.o \
> -	safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
> -        $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o
> +	safe-syscall.o syscall_proc.o \
> +	$(TARGET_ABI_DIR)/cpu_loop.o $(TARGET_ABI_DIR)/signal.o \
> +        exit.o fd-trans.o
>  

I think this will collide with Paolo's meson pull request.

>  obj-$(TARGET_HAS_BFLT) += flatload.o
>  obj-$(TARGET_I386) += vm86.o
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 5741c72733..01edc9b68d 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -125,6 +125,7 @@
>  #include "qapi/error.h"
>  #include "fd-trans.h"
>  #include "tcg/tcg.h"
> +#include "syscall_proc.h"
>  
>  #ifndef CLONE_IO
>  #define CLONE_IO                0x80000000      /* Clone io context */
> @@ -7482,38 +7483,6 @@ static int open_self_auxv(void *cpu_env, int fd)
>      return 0;
>  }
>  
> -static int is_proc_myself(const char *filename, const char *entry)
> -{
> -    if (!strncmp(filename, "/proc/", strlen("/proc/"))) {
> -        filename += strlen("/proc/");
> -        if (!strncmp(filename, "self/", strlen("self/"))) {
> -            filename += strlen("self/");
> -        } else if (*filename >= '1' && *filename <= '9') {
> -            char myself[80];
> -            snprintf(myself, sizeof(myself), "%d/", getpid());
> -            if (!strncmp(filename, myself, strlen(myself))) {
> -                filename += strlen(myself);
> -            } else {
> -                return 0;
> -            }
> -        } else {
> -            return 0;
> -        }
> -        if (!strcmp(filename, entry)) {
> -            return 1;
> -        }
> -    }
> -    return 0;
> -}
> -
> -#if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN) || \
> -    defined(TARGET_SPARC) || defined(TARGET_M68K) || defined(TARGET_HPPA)
> -static int is_proc(const char *filename, const char *entry)
> -{
> -    return strcmp(filename, entry) == 0;
> -}
> -#endif
> -
>  #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
>  static int open_net_route(void *cpu_env, int fd)
>  {
> diff --git a/linux-user/syscall_proc.c b/linux-user/syscall_proc.c
> new file mode 100644
> index 0000000000..34051a8e6b
> --- /dev/null
> +++ b/linux-user/syscall_proc.c
> @@ -0,0 +1,32 @@
> +#include "qemu/osdep.h"
> +
> +#include "syscall_proc.h"
> +
> +int is_proc_myself(const char *filename, const char *entry)
> +{
> +    if (!strncmp(filename, "/proc/", strlen("/proc/"))) {
> +        filename += strlen("/proc/");
> +        if (!strncmp(filename, "self/", strlen("self/"))) {
> +            filename += strlen("self/");
> +        } else if (*filename >= '1' && *filename <= '9') {
> +            char myself[80];
> +            snprintf(myself, sizeof(myself), "%d/", getpid());
> +            if (!strncmp(filename, myself, strlen(myself))) {
> +                filename += strlen(myself);
> +            } else {
> +                return 0;
> +            }
> +        } else {
> +            return 0;
> +        }
> +        if (!strcmp(filename, entry)) {
> +            return 1;
> +        }
> +    }
> +    return 0;
> +}
> +
> +int is_proc(const char *filename, const char *entry)
> +{
> +    return strcmp(filename, entry) == 0;
> +}
> diff --git a/linux-user/syscall_proc.h b/linux-user/syscall_proc.h
> new file mode 100644
> index 0000000000..3098af931f
> --- /dev/null
> +++ b/linux-user/syscall_proc.h
> @@ -0,0 +1,7 @@
> +#ifndef SYSCALL_PROC_H
> +#define SYSCALL_PROC_H
> +
> +int is_proc(const char *filename, const char *entry);
> +int is_proc_myself(const char *filename, const char *entry);
> +
> +#endif
> 

Please add a "SPDX-License-Identifier: GPL-2.0-or-later" header in the
new files.

Thanks,
Laurent





