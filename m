Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83A6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F002067C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F002067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAJNG-0004wx-TP
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 16:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAJMf-0004V2-21
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 16:46:49 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:49067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAJMc-0000FI-A6
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 16:46:48 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N8GIa-1kfIbD0znU-014D48; Mon, 24 Aug 2020 22:46:43 +0200
Subject: Re: [PATCH v4 3/5] linux-user: Add strace support for printing
 arguments of syscalls used to lock and unlock memory
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200811164553.27713-1-Filip.Bozuta@syrmia.com>
 <20200811164553.27713-4-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8c05d92c-a31b-4aeb-f220-c6106c75eded@vivier.eu>
Date: Mon, 24 Aug 2020 22:46:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811164553.27713-4-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QIbmkG/06/03YMwwDOm0S/sBAtBoeyiwcMvNkv2wvjN8m6bIxIu
 43Y84GfLwu6vdCqmESX3jfDdT6Bdt7ePzWQWAzJLa2tDracV4CgKknRTclLDWID0ClwIQOJ
 oaDDtbu/iyT49ThXDYU8FXZccXf9RXLR9FIB9weKaH/qb7HRQ4EyZ4LAQl+uU1mr5GvgGK5
 lXjv9R5E9aiVVtetMImWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V0SYbef5qds=:lsw7FqXHZE1jMZDPVyrNF9
 0bAVRbgJPER080kNaJDiHEQ6kZq2yBsSSVjYt2+oIeGKG0UxKhjZCjs8nmN6cjd3QNlzuG7Yn
 GNhjRJYKbCApkNd1DylWnXwIdYd/ee0+HEVknbXABBOAUNNUBNrM4jFsObk9xaxBcK767Dj6a
 6tlc/LCYzl5HxNxwG773qdmO7Mp0C7cGTtIL0kqr6tIc0ImtsDU3HFKoYFvihlbwh4c9AJPoa
 ESfiZAlEU3IGIME8nkCUXZqXb6BO6P13mzUFKwUcXxDTK7mICzxfwzN1qZ7cOh1q1Y0qKQshw
 D9WAoPg56TqKftw7usYsX8DwUgrJdY+hNiW3sTnP3D5WuJEIrt2VIZa2pkAYhZTlPCqncYU6X
 ARselpN/hvWvjtZqXVcCSKc0eUUmYLkviQlxTSm5D9SzGUmJg8klQBKZ9ze/CPpH6dIiIFzdo
 XaNGl+hlZMNZ1cvSjydySCARX1OmOep8naKvUdwjuqpADDmw48KnSY88F4xixsFpkExTdVs7H
 TWyfIYrpYxJLFftKJojHIt6a3U7Nf+H1VrV4d/eIVT/6PTGvxHXOybv5FcxHBlvwK46Jy3mbg
 7fRNm4AM4FtQ3OBMwdCSDpX1EK0a3hsmmzYSehOWdqyWWwXpWDzG03dsZZJMzc4/yOQl1Zo80
 F36z4I6Ge39UvLD6C1uoSzWjW4zYjmSHw9GEJfmAS+Bc1P8SxRNLKHoadADRTQyOasyLTU26/
 WgUBG4LEmQALVVtWG/32lRajM2jMgu3evZSaAb1s/i4DLgU+v0D2pbJeAcfhdybgFvQlXsqOB
 TE2Cm8dfOz1tjTa4oihxsPTIbTUKXjWjYzZTSjyc8HN+OW0DmQeqWtItgdB1tClZ+y4wZDE
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 16:46:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Le 11/08/2020 à 18:45, Filip Bozuta a écrit :
> This patch implements strace argument printing functionality for following syscalls:
> 
>     * mlock, munlock, mlockall, munlockall - lock and unlock memory
> 
>        int mlock(const void *addr, size_t len)
>        int munlock(const void *addr, size_t len)
>        int mlockall(int flags)
>        int munlockall(void)
>        man page: https://man7.org/linux/man-pages/man2/mlock.2.html
> 
> Implementation notes:
> 
>     Syscall mlockall() takes an argument that is composed of predefined values
>     which represent flags that determine the type of locking operation that is
>     to be performed. For that reason, a printing function "print_mlockall" was
>     stated in file "strace.list". This printing function uses an already existing
>     function "print_flags()" to print the "flags" argument.  These flags are stated
>     inside an array "mlockall_flags" that contains values of type "struct flags".
>     These values are instantiated using an existing macro "FLAG_TARGET()" that
>     crates aproppriate target flag values based on those defined in files
>     '/target_syscall.h'. These target flag values were changed from
>     "TARGET_MLOCKALL_MCL*" to "TARGET_MCL_*" so that they can be aproppriately set
>     and recognised in "strace.c" with "FLAG_TARGET()". Value for "MCL_ONFAULT"
>     was added in this patch. This value was also added in "syscall.c" in function
>     "target_to_host_mlockall_arg()". Because this flag value was added in kernel
>     version 4.4, it is enwrapped in an #ifdef directive (both in "syscall.c" and
>     in "strace.c") as to support older kernel versions.
>     The other syscalls have only primitive argument types, so the
>     rest of the implementation was handled by stating an appropriate
>     printing format in file "strace.list". Syscall mlock2() is not implemented in
>     "syscall.c" and thus it's argument printing is not implemented in this patch.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/aarch64/target_syscall.h    |  5 +++--
>  linux-user/alpha/target_syscall.h      |  5 +++--
>  linux-user/arm/target_syscall.h        |  6 ++++--
>  linux-user/cris/target_syscall.h       |  5 +++--
>  linux-user/hppa/target_syscall.h       |  5 +++--
>  linux-user/i386/target_syscall.h       |  5 +++--
>  linux-user/m68k/target_syscall.h       |  6 +++---
>  linux-user/microblaze/target_syscall.h |  5 +++--
>  linux-user/mips/target_syscall.h       |  5 +++--
>  linux-user/mips64/target_syscall.h     |  5 +++--
>  linux-user/nios2/target_syscall.h      |  5 +++--
>  linux-user/openrisc/target_syscall.h   |  5 +++--
>  linux-user/ppc/target_syscall.h        |  5 +++--
>  linux-user/riscv/target_syscall.h      |  5 +++--
>  linux-user/s390x/target_syscall.h      |  5 +++--
>  linux-user/sh4/target_syscall.h        |  5 +++--
>  linux-user/sparc/target_syscall.h      |  5 +++--
>  linux-user/sparc64/target_syscall.h    |  5 +++--
>  linux-user/strace.c                    | 21 +++++++++++++++++++++
>  linux-user/strace.list                 |  8 ++++----
>  linux-user/syscall.c                   | 10 ++++++++--
>  linux-user/tilegx/target_syscall.h     |  5 +++--
>  linux-user/x86_64/target_syscall.h     |  5 +++--
>  linux-user/xtensa/target_syscall.h     |  5 +++--
>  24 files changed, 97 insertions(+), 49 deletions(-)
> 
> diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
> index 995e475c73..3194e6b009 100644
> --- a/linux-user/aarch64/target_syscall.h
> +++ b/linux-user/aarch64/target_syscall.h
> @@ -16,8 +16,9 @@ struct target_pt_regs {
>  #define UNAME_MINIMUM_RELEASE "3.8.0"
>  #define TARGET_CLONE_BACKWARDS
>  #define TARGET_MINSIGSTKSZ       2048
> -#define TARGET_MLOCKALL_MCL_CURRENT 1
> -#define TARGET_MLOCKALL_MCL_FUTURE  2
> +#define TARGET_MCL_CURRENT 1
> +#define TARGET_MCL_FUTURE  2
> +#define TARGET_MCL_ONFAULT 4
>  
>  #define TARGET_PR_SVE_SET_VL  50
>  #define TARGET_PR_SVE_GET_VL  51
> diff --git a/linux-user/alpha/target_syscall.h b/linux-user/alpha/target_syscall.h
> index 3426cc5b4e..fd389422e3 100644
> --- a/linux-user/alpha/target_syscall.h
> +++ b/linux-user/alpha/target_syscall.h
> @@ -258,7 +258,8 @@ struct target_pt_regs {
>  #define TARGET_UAC_NOFIX		2
>  #define TARGET_UAC_SIGBUS		4
>  #define TARGET_MINSIGSTKSZ              4096
> -#define TARGET_MLOCKALL_MCL_CURRENT     0x2000
> -#define TARGET_MLOCKALL_MCL_FUTURE      0x4000
> +#define TARGET_MCL_CURRENT     0x2000
> +#define TARGET_MCL_FUTURE      0x4000
> +#define TARGET_MCL_ONFAULT     0x8000
>  
>  #endif /* ALPHA_TARGET_SYSCALL_H */
> diff --git a/linux-user/arm/target_syscall.h b/linux-user/arm/target_syscall.h
> index f85cbdaf56..e870ed7a54 100644
> --- a/linux-user/arm/target_syscall.h
> +++ b/linux-user/arm/target_syscall.h
> @@ -28,8 +28,10 @@ struct target_pt_regs {
>  #define TARGET_CLONE_BACKWARDS
>  
>  #define TARGET_MINSIGSTKSZ 2048
> -#define TARGET_MLOCKALL_MCL_CURRENT 1
> -#define TARGET_MLOCKALL_MCL_FUTURE  2
> +#define TARGET_MCL_CURRENT 1
> +#define TARGET_MCL_FUTURE  2
> +#define TARGET_MCL_ONFAULT 4
> +
>  #define TARGET_WANT_OLD_SYS_SELECT
>  
>  #define TARGET_FORCE_SHMLBA
> diff --git a/linux-user/cris/target_syscall.h b/linux-user/cris/target_syscall.h
> index 29d69009ff..d109a6b42a 100644
> --- a/linux-user/cris/target_syscall.h
> +++ b/linux-user/cris/target_syscall.h
> @@ -40,7 +40,8 @@ struct target_pt_regs {
>  
>  #define TARGET_CLONE_BACKWARDS2
>  #define TARGET_MINSIGSTKSZ 2048
> -#define TARGET_MLOCKALL_MCL_CURRENT 1
> -#define TARGET_MLOCKALL_MCL_FUTURE  2
> +#define TARGET_MCL_CURRENT 1
> +#define TARGET_MCL_FUTURE  2
> +#define TARGET_MCL_ONFAULT 4
>  
>  #endif
> diff --git a/linux-user/hppa/target_syscall.h b/linux-user/hppa/target_syscall.h
> index e2f366839d..f34e05edb5 100644
> --- a/linux-user/hppa/target_syscall.h
> +++ b/linux-user/hppa/target_syscall.h
> @@ -23,8 +23,9 @@ struct target_pt_regs {
>  #define UNAME_MINIMUM_RELEASE "2.6.32"
>  #define TARGET_CLONE_BACKWARDS
>  #define TARGET_MINSIGSTKSZ       2048
> -#define TARGET_MLOCKALL_MCL_CURRENT 1
> -#define TARGET_MLOCKALL_MCL_FUTURE  2
> +#define TARGET_MCL_CURRENT 1
> +#define TARGET_MCL_FUTURE  2
> +#define TARGET_MCL_ONFAULT 4
>  
>  #undef  TARGET_ENOMSG
>  #define TARGET_ENOMSG          35
> diff --git a/linux-user/i386/target_syscall.h b/linux-user/i386/target_syscall.h
> index 2854758134..ed356b3908 100644
> --- a/linux-user/i386/target_syscall.h
> +++ b/linux-user/i386/target_syscall.h
> @@ -151,8 +151,9 @@ struct target_vm86plus_struct {
>  
>  #define TARGET_CLONE_BACKWARDS
>  #define TARGET_MINSIGSTKSZ 2048
> -#define TARGET_MLOCKALL_MCL_CURRENT 1
> -#define TARGET_MLOCKALL_MCL_FUTURE  2
> +#define TARGET_MCL_CURRENT 1
> +#define TARGET_MCL_FUTURE  2
> +#define TARGET_MCL_ONFAULT 4
>  #define TARGET_WANT_OLD_SYS_SELECT
>  
>  #endif /* I386_TARGET_SYSCALL_H */
> diff --git a/linux-user/m68k/target_syscall.h b/linux-user/m68k/target_syscall.h
> index c0366b1c62..23359a6299 100644
> --- a/linux-user/m68k/target_syscall.h
> +++ b/linux-user/m68k/target_syscall.h
> @@ -21,9 +21,9 @@ struct target_pt_regs {
>  #define UNAME_MINIMUM_RELEASE "2.6.32"
>  
>  #define TARGET_MINSIGSTKSZ 2048
> -#define TARGET_MLOCKALL_MCL_CURRENT 1
> -#define TARGET_MLOCKALL_MCL_FUTURE  2
> -
> +#define TARGET_MCL_CURRENT 1
> +#define TARGET_MCL_FUTURE  2
> +#define TARGET_MCL_ONFAULT 4
>  #define TARGET_WANT_OLD_SYS_SELECT
>  
>  #endif /* M68K_TARGET_SYSCALL_H */
> diff --git a/linux-user/microblaze/target_syscall.h b/linux-user/microblaze/target_syscall.h
> index 4141cbaa5e..7f653db34f 100644
> --- a/linux-user/microblaze/target_syscall.h
> +++ b/linux-user/microblaze/target_syscall.h
> @@ -50,8 +50,9 @@ struct target_pt_regs {
>  
>  #define TARGET_CLONE_BACKWARDS
>  #define TARGET_MINSIGSTKSZ      2048
> -#define TARGET_MLOCKALL_MCL_CURRENT 1
> -#define TARGET_MLOCKALL_MCL_FUTURE  2
> +#define TARGET_MCL_CURRENT 1
> +#define TARGET_MCL_FUTURE  2
> +#define TARGET_MCL_ONFAULT 4
>  
>  #define TARGET_WANT_NI_OLD_SELECT
>  
> diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
> index d5509a34a7..dd6fd7af8e 100644
> --- a/linux-user/mips/target_syscall.h
> +++ b/linux-user/mips/target_syscall.h
> @@ -234,8 +234,9 @@ struct target_pt_regs {
>  
>  #define TARGET_CLONE_BACKWARDS
>  #define TARGET_MINSIGSTKSZ 2048
> -#define TARGET_MLOCKALL_MCL_CURRENT 1
> -#define TARGET_MLOCKALL_MCL_FUTURE  2
> +#define TARGET_MCL_CURRENT 1
> +#define TARGET_MCL_FUTURE  2
> +#define TARGET_MCL_ONFAULT 4
>  
>  #define TARGET_FORCE_SHMLBA
>  
> diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
> index 8ccc46822c..8594955eec 100644
> --- a/linux-user/mips64/target_syscall.h
> +++ b/linux-user/mips64/target_syscall.h
> @@ -231,8 +231,9 @@ struct target_pt_regs {
>  
>  #define TARGET_CLONE_BACKWARDS
>  #define TARGET_MINSIGSTKSZ      2048
> -#define TARGET_MLOCKALL_MCL_CURRENT 1
> -#define TARGET_MLOCKALL_MCL_FUTURE  2
> +#define TARGET_MCL_CURRENT 1
> +#define TARGET_MCL_FUTURE  2
> +#define TARGET_MCL_ONFAULT 4
>  
>  #define TARGET_FORCE_SHMLBA
>  
> diff --git a/linux-user/nios2/target_syscall.h b/linux-user/nios2/target_syscall.h
> index f3b2a500f4..78006c24d4 100644
> --- a/linux-user/nios2/target_syscall.h
> +++ b/linux-user/nios2/target_syscall.h
> @@ -31,7 +31,8 @@ struct target_pt_regs {
>  };
>  
>  #define TARGET_MINSIGSTKSZ 2048
> -#define TARGET_MLOCKALL_MCL_CURRENT 1
> -#define TARGET_MLOCKALL_MCL_FUTURE  2
> +#define TARGET_MCL_CURRENT 1
> +#define TARGET_MCL_FUTURE  2
> +#define TARGET_MCL_ONFAULT 4
>  
>  #endif /* NIOS2_TARGET_SYSCALL_H */
> diff --git a/linux-user/openrisc/target_syscall.h b/linux-user/openrisc/target_syscall.h
> index d586d2a018..ef0d89a551 100644
> --- a/linux-user/openrisc/target_syscall.h
> +++ b/linux-user/openrisc/target_syscall.h
> @@ -16,8 +16,9 @@ struct target_pt_regs {
>  #define UNAME_MINIMUM_RELEASE "2.6.32"
>  
>  #define TARGET_MINSIGSTKSZ 2048
> -#define TARGET_MLOCKALL_MCL_CURRENT 1
> -#define TARGET_MLOCKALL_MCL_FUTURE  2
> +#define TARGET_MCL_CURRENT 1
> +#define TARGET_MCL_FUTURE  2
> +#define TARGET_MCL_ONFAULT 4
>  
>  #define MMAP_SHIFT TARGET_PAGE_BITS
>  
> diff --git a/linux-user/ppc/target_syscall.h b/linux-user/ppc/target_syscall.h
> index afc0570410..c461f878f2 100644
> --- a/linux-user/ppc/target_syscall.h
> +++ b/linux-user/ppc/target_syscall.h
> @@ -72,8 +72,9 @@ struct target_revectored_struct {
>  #define TARGET_CLONE_BACKWARDS
>  
>  #define TARGET_MINSIGSTKSZ 2048
> -#define TARGET_MLOCKALL_MCL_CURRENT 0x2000
> -#define TARGET_MLOCKALL_MCL_FUTURE  0x4000
> +#define TARGET_MCL_CURRENT 0x2000
> +#define TARGET_MCL_FUTURE  0x4000
> +#define TARGET_MCL_ONFAULT 0x8000
>  #define TARGET_WANT_NI_OLD_SELECT
>  
>  #endif /* PPC_TARGET_SYSCALL_H */
> diff --git a/linux-user/riscv/target_syscall.h b/linux-user/riscv/target_syscall.h
> index a88e821f73..dc597c8972 100644
> --- a/linux-user/riscv/target_syscall.h
> +++ b/linux-user/riscv/target_syscall.h
> @@ -51,8 +51,9 @@ struct target_pt_regs {
>  #define UNAME_MINIMUM_RELEASE "4.15.0"
>  
>  #define TARGET_MINSIGSTKSZ 2048
> -#define TARGET_MLOCKALL_MCL_CURRENT 1
> -#define TARGET_MLOCKALL_MCL_FUTURE  2
> +#define TARGET_MCL_CURRENT 1
> +#define TARGET_MCL_FUTURE  2
> +#define TARGET_MCL_ONFAULT 4
>  
>  /* clone(flags, newsp, ptidptr, tls, ctidptr) for RISC-V */
>  /* This comes from linux/kernel/fork.c, CONFIG_CLONE_BACKWARDS */
> diff --git a/linux-user/s390x/target_syscall.h b/linux-user/s390x/target_syscall.h
> index 8d4f609eaa..94f84178db 100644
> --- a/linux-user/s390x/target_syscall.h
> +++ b/linux-user/s390x/target_syscall.h
> @@ -28,7 +28,8 @@ struct target_pt_regs {
>  
>  #define TARGET_CLONE_BACKWARDS2
>  #define TARGET_MINSIGSTKSZ        2048
> -#define TARGET_MLOCKALL_MCL_CURRENT 1
> -#define TARGET_MLOCKALL_MCL_FUTURE  2
> +#define TARGET_MCL_CURRENT 1
> +#define TARGET_MCL_FUTURE  2
> +#define TARGET_MCL_ONFAULT 4
>  
>  #endif /* S390X_TARGET_SYSCALL_H */
> diff --git a/linux-user/sh4/target_syscall.h b/linux-user/sh4/target_syscall.h
> index 2b5f75be13..c1437adafe 100644
> --- a/linux-user/sh4/target_syscall.h
> +++ b/linux-user/sh4/target_syscall.h
> @@ -16,8 +16,9 @@ struct target_pt_regs {
>  #define UNAME_MINIMUM_RELEASE "2.6.32"
>  
>  #define TARGET_MINSIGSTKSZ 2048
> -#define TARGET_MLOCKALL_MCL_CURRENT 1
> -#define TARGET_MLOCKALL_MCL_FUTURE  2
> +#define TARGET_MCL_CURRENT 1
> +#define TARGET_MCL_FUTURE  2
> +#define TARGET_MCL_ONFAULT 4
>  
>  #define TARGET_FORCE_SHMLBA
>  
> diff --git a/linux-user/sparc/target_syscall.h b/linux-user/sparc/target_syscall.h
> index b9160a771b..d8ea04ea83 100644
> --- a/linux-user/sparc/target_syscall.h
> +++ b/linux-user/sparc/target_syscall.h
> @@ -21,8 +21,9 @@ struct target_pt_regs {
>   */
>  #define TARGET_CLONE_BACKWARDS
>  #define TARGET_MINSIGSTKSZ      4096
> -#define TARGET_MLOCKALL_MCL_CURRENT 0x2000
> -#define TARGET_MLOCKALL_MCL_FUTURE  0x4000
> +#define TARGET_MCL_CURRENT 0x2000
> +#define TARGET_MCL_FUTURE  0x4000
> +#define TARGET_MCL_ONFAULT 0x8000
>  
>  /* For SPARC SHMLBA is determined at runtime in the kernel, and
>   * libc has to runtime-detect it using the hwcaps (see glibc
> diff --git a/linux-user/sparc64/target_syscall.h b/linux-user/sparc64/target_syscall.h
> index 3073a23e03..696a68b1ed 100644
> --- a/linux-user/sparc64/target_syscall.h
> +++ b/linux-user/sparc64/target_syscall.h
> @@ -22,8 +22,9 @@ struct target_pt_regs {
>   */
>  #define TARGET_CLONE_BACKWARDS
>  #define TARGET_MINSIGSTKSZ      4096
> -#define TARGET_MLOCKALL_MCL_CURRENT 0x2000
> -#define TARGET_MLOCKALL_MCL_FUTURE  0x4000
> +#define TARGET_MCL_CURRENT 0x2000
> +#define TARGET_MCL_FUTURE  0x4000
> +#define TARGET_MCL_ONFAULT 0x8000
>  
>  #define TARGET_FORCE_SHMLBA
>  
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 7dc239b9f1..40f863c6e2 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1194,6 +1194,15 @@ UNUSED static struct flags falloc_flags[] = {
>  #endif
>  };
>  
> +UNUSED static struct flags mlockall_flags[] = {
> +    FLAG_TARGET(MCL_CURRENT),
> +    FLAG_TARGET(MCL_FUTURE),
> +#ifdef MCL_ONFAULT
> +    FLAG_TARGET(MCL_ONFAULT),
> +#endif
> +    FLAG_END,
> +};
> +
>  /*
>   * print_xxx utility functions.  These are used to print syscall
>   * parameters in certain format.  All of these have parameter
> @@ -2005,6 +2014,18 @@ print_ftruncate64(void *cpu_env, const struct syscallname *name,
>  }
>  #endif
>  
> +#ifdef TARGET_NR_mlockall
> +static void
> +print_mlockall(void *cpu_env, const struct syscallname *name,
> +               abi_long arg0, abi_long arg1, abi_long arg2,
> +               abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_flags(mlockall_flags, arg0, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
>  #if defined(TARGET_NR_socket)
>  static void
>  print_socket(void *cpu_env, const struct syscallname *name,
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index 8e5303d035..d0ea7f3464 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -568,13 +568,13 @@
>  { TARGET_NR_mknodat, "mknodat" , NULL, print_mknodat, NULL },
>  #endif
>  #ifdef TARGET_NR_mlock
> -{ TARGET_NR_mlock, "mlock" , NULL, NULL, NULL },
> +{ TARGET_NR_mlock, "mlock" , "%s(%p," TARGET_FMT_lu ")", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_mlock2
>  { TARGET_NR_mlock2, "mlock2" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_mlockall
> -{ TARGET_NR_mlockall, "mlockall" , NULL, NULL, NULL },
> +{ TARGET_NR_mlockall, "mlockall" , NULL, print_mlockall, NULL },
>  #endif
>  #ifdef TARGET_NR_mmap
>  { TARGET_NR_mmap, "mmap" , NULL, print_mmap, print_syscall_ret_addr },
> @@ -637,10 +637,10 @@
>  { TARGET_NR_multiplexer, "multiplexer" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_munlock
> -{ TARGET_NR_munlock, "munlock" , NULL, NULL, NULL },
> +{ TARGET_NR_munlock, "munlock" , "%s(%p," TARGET_FMT_lu ")", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_munlockall
> -{ TARGET_NR_munlockall, "munlockall" , NULL, NULL, NULL },
> +{ TARGET_NR_munlockall, "munlockall" , "%s()", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_munmap
>  { TARGET_NR_munmap, "munmap" , NULL, print_munmap, NULL },
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1517096a9b..24d915f0ff 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6906,12 +6906,18 @@ static inline int target_to_host_mlockall_arg(int arg)
>  {
>      int result = 0;
>  
> -    if (arg & TARGET_MLOCKALL_MCL_CURRENT) {
> +    if (arg & TARGET_MCL_CURRENT) {
>          result |= MCL_CURRENT;
>      }
> -    if (arg & TARGET_MLOCKALL_MCL_FUTURE) {
> +    if (arg & TARGET_MCL_FUTURE) {
>          result |= MCL_FUTURE;
>      }
> +#ifdef MCL_ONFAULT
> +    if (arg & TARGET_MCL_ONFAULT) {
> +        result |= MCL_ONFAULT;
> +    }
> +#endif
> +
>      return result;
>  }
>  #endif
> diff --git a/linux-user/tilegx/target_syscall.h b/linux-user/tilegx/target_syscall.h
> index d731acdafa..8e9db734b8 100644
> --- a/linux-user/tilegx/target_syscall.h
> +++ b/linux-user/tilegx/target_syscall.h
> @@ -34,8 +34,9 @@ struct target_pt_regs {
>      tilegx_reg_t pad[2];
>  };
>  
> -#define TARGET_MLOCKALL_MCL_CURRENT 1
> -#define TARGET_MLOCKALL_MCL_FUTURE  2
> +#define TARGET_MCL_CURRENT 1
> +#define TARGET_MCL_FUTURE  2
> +#define TARGET_MCL_ONFAULT 4
>  
>  /* For faultnum */
>  #define TARGET_INT_SWINT_1            14
> diff --git a/linux-user/x86_64/target_syscall.h b/linux-user/x86_64/target_syscall.h
> index 5e221e1d9d..3ecccb72be 100644
> --- a/linux-user/x86_64/target_syscall.h
> +++ b/linux-user/x86_64/target_syscall.h
> @@ -101,7 +101,8 @@ struct target_msqid64_ds {
>  #define TARGET_ARCH_GET_FS 0x1003
>  #define TARGET_ARCH_GET_GS 0x1004
>  #define TARGET_MINSIGSTKSZ 2048
> -#define TARGET_MLOCKALL_MCL_CURRENT 1
> -#define TARGET_MLOCKALL_MCL_FUTURE  2
> +#define TARGET_MCL_CURRENT 1
> +#define TARGET_MCL_FUTURE  2
> +#define TARGET_MCL_ONFAULT 4
>  
>  #endif /* X86_64_TARGET_SYSCALL_H */
> diff --git a/linux-user/xtensa/target_syscall.h b/linux-user/xtensa/target_syscall.h
> index 3866dad849..afc86a153f 100644
> --- a/linux-user/xtensa/target_syscall.h
> +++ b/linux-user/xtensa/target_syscall.h
> @@ -43,7 +43,8 @@ struct target_pt_regs {
>      xtensa_reg_t areg[16];
>  };
>  
> -#define TARGET_MLOCKALL_MCL_CURRENT 1
> -#define TARGET_MLOCKALL_MCL_FUTURE  2
> +#define TARGET_MCL_CURRENT 1
> +#define TARGET_MCL_FUTURE  2
> +#define TARGET_MCL_ONFAULT 4
>  
>  #endif
> 


Applied to my linux-user-for-5.2 branch.

Thanks,
Laurent


