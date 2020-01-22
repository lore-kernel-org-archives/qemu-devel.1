Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D14C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE913217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE913217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuGxC-0003Ec-51
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:25:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuGrY-0004Md-SX
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:20:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuGrX-0006Xq-ND
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:20:08 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:59555)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuGrX-0006Wc-E3
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:20:07 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N9dkB-1ji8Qu3aEP-015Yep; Wed, 22 Jan 2020 15:19:46 +0100
Subject: Re: [PATCH v8 03/13] linux-user: Add support for getting/setting RTC
 periodic interrupt and epoch using ioctls
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>, qemu-devel@nongnu.org
References: <1579117007-7565-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1579117007-7565-4-git-send-email-Filip.Bozuta@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <45d3a596-f901-c3e4-59fa-5ebb317cfb49@vivier.eu>
Date: Wed, 22 Jan 2020 15:19:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1579117007-7565-4-git-send-email-Filip.Bozuta@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NcZYd62ZWUjQZVVidMsJCVJ6Sda1Jxm2HRgEh/qZkrPPVcUL6RU
 FPAu4lpR2VCrsZB/AGb8cmUroSADjDEn+NhChoGRUgpDpilAw30YQwCSNXWb3TSjDW63ELV
 5vk4WdEt/LdAaPJRZQwW7zi1WocYdBjf6C+NsYm8ATFW6aOMogIGJv9aLTjakr39CFg6K/A
 s9JACcPnhlfLH8Qyhzpvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xgx0f9HiQdM=:AVxLIGhzsZRGJqS196x3cb
 ignodjDrt8AiPWWmTcNgPgZv3sNj7LmKuBmSPTI+JruSuOvG7QdyOalzCfIB8KocKyMvWqhZZ
 qky7F4vIdd2TkEvI305+l39EGu19ltzdBPkhvkVXey3pU8X7n45kNbuW1gUnYZecYucmB5Fas
 zycXWRqeproaTYMjFDQRoZbxxXcpguGqq2tPrtWIr6BSooYJPdIOvvMgSOG8ZSdbznFfRoogY
 XWbgSOH4fmuC7tirArRSQWxkuTtr883JcMTQ3/BsxkfwaeVeqi/DXME1TnaAOgCADnnC17h5F
 /Xu7ogDerhhOjkcwVmGL89NGHKigw5Xfq0lhthhBzk1CPxOvjKScNxEWbOskM4Y+LQ7psr06p
 w/ajZg6ULqMymotY3PAxvTtdGaOrrKC+QV5TCR4Erk0BS0zBL5d/rH2sZYsi13CWBv7XPlA/b
 noAw6kZ7Yzto21s7g/BR7vavJ+xsJZshlzvLAnpOz3l1QGVM2Qj0IPP8EVpJ/OSXQBeUNhe6k
 h7OEGfSvCFIeH9tRj4tzwvi/mrRZ7or676eACbZ2HbtHvUtZEw0lBXgwRa4P0i/THVJtWgFGc
 82/xdyIkZJ7v7tToUp7A9n3SonJ8disC2lhaY81OOkfBNnwdwnBIKOCdFotnYBXEdZAoAffQJ
 5uy+VPLWSTcsEXmTW0/fkkc78GcDb+BAZGpLmVqwFJvztu1n+BqzGOnfD4NmpPri2H7QcYDED
 JhkQRqsB4oIRdVJH/R2V2QsxDlcxX2uDpIJ9QlmVWU41AZcnfSs+i/m0UwRQVnaXP1LxS4eAc
 DSyejbtnmlDM04ITpYi/HFLwi6Dm/GIQhEslx7iJO5q9m5XvDw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.74
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, arnd@arndb.de,
 richard.henderson@linaro.org, jcmvbkbc@gmail.com, amarkovic@wavecomp.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 15/01/2020 à 20:36, Filip Bozuta a écrit :
> This patch implements functionalities of following ioctls:
> 
> RTC_IRQP_READ, RTC_IRQP_SET - Getting/Setting IRQ rate
> 
>     Read and set the frequency for periodic interrupts, for RTCs
>     that support periodic interrupts. The periodic interrupt must
>     be separately enabled or disabled using the RTC_PIE_ON,
>     RTC_PIE_OFF requests. The third ioctl's argument is an
>     unsigned long * or an unsigned long, respectively. The value
>     is the frequency in interrupts per second. The set of allow‐
>     able frequencies is the multiples of two in the range 2 to
>     8192. Only a privileged process (i.e., one having the
>     CAP_SYS_RESOURCE capability) can set frequencies above the
>     value specified in /proc/sys/dev/rtc/max-user-freq. (This
>     file contains the value 64 by default.)
> 
> RTC_EPOCH_READ, RTC_EPOCH_SET - Getting/Setting epoch
> 
>     Many RTCs encode the year in an 8-bit register which is either
>     interpreted as an 8-bit binary number or as a BCD number. In
>     both cases, the number is interpreted relative to this RTC's
>     Epoch. The RTC's Epoch is initialized to 1900 on most systems
>     but on Alpha and MIPS it might also be initialized to 1952,
>     1980, or 2000, depending on the value of an RTC register for
>     the year. With some RTCs, these operations can be used to
>     read or to set the RTC's Epoch, respectively. The third
>     ioctl's argument is an unsigned long * or an unsigned long,
>     respectively, and the value returned (or assigned) is the
>     Epoch. To set the RTC's Epoch the process must be privileged
>     (i.e., have the CAP_SYS_TIME capability).
> 
> Implementation notes:
> 
>     All ioctls in this patch have a pointer to 'ulong' as their
>     third argument. That is the reason why corresponding parts
>     of added code in linux-user/syscall_defs.h contain special
>     handling related to 'ulong' type: they use 'abi_ulong' type
>     to make sure that ioctl's code is calculated correctly for
>     both 32-bit and 64-bit targets. Also, 'MK_PTR(TYPE_ULONG)'
>     is used for the similar reason in linux-user/ioctls.h.
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>  linux-user/ioctls.h       | 4 ++++
>  linux-user/syscall_defs.h | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index f472794..accbdee 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -81,6 +81,10 @@
>       IOCTL(RTC_ALM_SET, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
>       IOCTL(RTC_RD_TIME, IOC_R, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
>       IOCTL(RTC_SET_TIME, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
> +     IOCTL(RTC_IRQP_READ, IOC_R, MK_PTR(TYPE_ULONG))
> +     IOCTL(RTC_IRQP_SET, IOC_W, TYPE_ULONG)
> +     IOCTL(RTC_EPOCH_READ, IOC_R, MK_PTR(TYPE_ULONG))
> +     IOCTL(RTC_EPOCH_SET, IOC_W, TYPE_ULONG)
>  
>       IOCTL(BLKROSET, IOC_W, MK_PTR(TYPE_INT))
>       IOCTL(BLKROGET, IOC_R, MK_PTR(TYPE_INT))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index f0bf09d..bbfa935 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -776,6 +776,10 @@ struct target_pollfd {
>  #define TARGET_RTC_ALM_SET          TARGET_IOW('p', 0x07, struct rtc_time)
>  #define TARGET_RTC_RD_TIME          TARGET_IOR('p', 0x09, struct rtc_time)
>  #define TARGET_RTC_SET_TIME         TARGET_IOW('p', 0x0a, struct rtc_time)
> +#define TARGET_RTC_IRQP_READ        TARGET_IOR('p', 0x0b, abi_ulong)
> +#define TARGET_RTC_IRQP_SET         TARGET_IOW('p', 0x0c, abi_ulong)
> +#define TARGET_RTC_EPOCH_READ       TARGET_IOR('p', 0x0d, abi_ulong)
> +#define TARGET_RTC_EPOCH_SET        TARGET_IOW('p', 0x0e, abi_ulong)
>  
>  #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
>         defined(TARGET_XTENSA)
> 

Applied to my linux-user branch.

Thanks,
Laurent

