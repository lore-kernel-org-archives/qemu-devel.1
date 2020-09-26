Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEBCC2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 16:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504092177B
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 16:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504092177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMDKr-0000pp-56
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 12:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kMDJD-0000KW-M4
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 12:44:27 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:39063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kMDJB-0001pr-A3
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 12:44:27 -0400
Received: from [192.168.100.1] ([82.252.129.222]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mwfj2-1kfXKm0DVa-00y7P5; Sat, 26 Sep 2020 18:44:14 +0200
To: Shu-Chun Weng <scw@google.com>
References: <20200723231020.769893-1-scw@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2] linux-user: Add most IFTUN ioctls
Message-ID: <5f73f9b9-53dd-b483-4eed-07ab9d660ed1@vivier.eu>
Date: Sat, 26 Sep 2020 18:44:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200723231020.769893-1-scw@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kr+707T4UGVBXrol44KyuQ0RKEDXKDadn5Vy5vAyBBNw9mNO1UW
 U3MjBILouWWfKG3XnZ6z9DtZxc5Se099I6GFuh/4auT3VfgNvTGL06K3Eg26II2xOB8vRpH
 PbbSqZroMjWa4syecX2JCBcz2XJ/JnH77SdoySxmAh2MNCvu6Uzz8K+EXA3D+Tk3d+gRCNc
 FF6tupHeC/fjaHdSiCpRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9rJvqT3IqpY=:0P9XT2+eYMKjpYWCWp8KMn
 A+cJ62rwBnTRqo6HrFq47nTn3M5H3oGbrld33zPDPovcvaYVqEde40bATEDU/e4SazEbLGJKc
 e7hmU21jZcyWpsWjInnmsA4buX3nZRVVAVehegGZNmfnJOqmbvII8L5WrOmFONnprKnXNAPS9
 NwDXSVBp3AdoFp2QWnT+F9uvN4H6dwcbIRgVRtkxoGvh5Pyz/d/0gxHnmg6f5hHB3Xjc1wE8B
 2a2iXPN+CtaHd+UqDE89Xnx5e9yQ/YF+Jip4ZuX0eHQgMgiVWQpKLlqH4IblXy5AGHGFFOuys
 UKSN45RTveVu0guDxAPo/Pq1MpVuTYrqo9nHd80U//pCW4jffC7YIH+k6niUpQB6A7fkS68Ev
 XtXqhe8MKpgxl2WfBEVfpP8aIhi+BiKU4U+326fIIjCilLc5c+/R1mmX3sfLGcTOaT5o9tzhP
 V9H9id4PUhk/J23CeuXKT0e513M71mEu6Ch/XfhAsM/GMwBS8pnF+gpgUIgn3/l2+iPf50kow
 7ofLsDzdQNNSI2pN3geTYnwYEJyhQKicMh8rIffjSz8a065EI1whGRCVOSpnqKqYKfcpMyXbK
 YvntqeCCMbIvghKRf7edk702ohpF0pUcxxRQAvZ1sHknl3oQd29tK2lYP89FTxZR9NKbicy6r
 frYGgSdKHS2FeeYIyHs19bBoH49zFXADwX2s1wod+5HPIRzqmSEM6pmxjVnTlyQvUHLuSI1op
 v45aTAQp2yNrUuAjrcig+XEaLfUSdRzH4aYC2TA+H0FaxDrZrOpCq+8gkuOjVMR2jF5bVYcHY
 lPQQN4q/7qUnOXVXpduwHa+nCTgKdsR8xlutrc7fUX367tOWIGLzB9bZsSWOZ06s1ui3s0s
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/26 12:44:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.213,
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
Cc: Josh Kunz <jkz@google.com>, riku.voipio@iki.fi, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 24/07/2020 à 01:10, Shu-Chun Weng a écrit :
> The three options handling `struct sock_fprog` (TUNATTACHFILTER,
> TUNDETACHFILTER, and TUNGETFILTER) are not implemented. Linux kernel
> keeps a user space pointer in them which we cannot correctly handle.
> 
> Signed-off-by: Josh Kunz <jkz@google.com>
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
> v2:
>   Title changed from "linux-user: Add several IFTUN ioctls"
> 
>   Properly specify the argument types for various options, including a custom
>   implementation for TUNSETTXFILTER.
> 
>   #ifdef guards for macros introduced up to 5 years ago.
> 
>  linux-user/ioctls.h       | 45 +++++++++++++++++++++++++++++++++++++++
>  linux-user/syscall.c      | 36 +++++++++++++++++++++++++++++++
>  linux-user/syscall_defs.h | 32 ++++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 0713ae1311..b9fb01f558 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -593,3 +593,48 @@
>    IOCTL(KCOV_DISABLE, 0, TYPE_NULL)
>    IOCTL(KCOV_INIT_TRACE, IOC_R, TYPE_ULONG)
>  #endif
> +
> +  IOCTL(TUNSETDEBUG,     IOC_W, TYPE_INT)
> +  IOCTL(TUNSETIFF,       IOC_RW, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))

Why is this IOC_RW?

> +  IOCTL(TUNSETPERSIST,   IOC_W, TYPE_INT)
> +  IOCTL(TUNSETOWNER,     IOC_W, TYPE_INT)
> +  IOCTL(TUNSETLINK,      IOC_W, TYPE_INT)
> +  IOCTL(TUNSETGROUP,     IOC_W, TYPE_INT)
> +  IOCTL(TUNGETFEATURES,  IOC_R, MK_PTR(TYPE_INT))
> +  IOCTL(TUNSETOFFLOAD,   IOC_W, TYPE_LONG)

Why is this long?

> +  IOCTL_SPECIAL(TUNSETTXFILTER, IOC_W, do_ioctl_TUNSETTXFILTER,
> +                /*
> +                 * We can't represent `struct tun_filter` in thunk so leaving
> +                 * this empty. do_ioctl_TUNSETTXFILTER will do the conversion.
> +                 */
> +                TYPE_NULL)

You should use TYPE_PTRVOID to allow QEMU_STRACE to display the pointer.
Or implement the function to dump the structure (see STRUCT_termios and
struct_termios_def).

> +  IOCTL(TUNGETIFF,       IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
> +  IOCTL(TUNGETSNDBUF,    IOC_R, MK_PTR(TYPE_INT))
> +  IOCTL(TUNSETSNDBUF,    IOC_W, MK_PTR(TYPE_INT))
> +  /*
> +   * TUNATTACHFILTER and TUNDETACHFILTER are not supported. Linux kernel keeps a
> +   * user pointer in TUNATTACHFILTER, which we are not able to correctly handle.
> +   */
> +  IOCTL(TUNGETVNETHDRSZ, IOC_R, MK_PTR(TYPE_INT))
> +  IOCTL(TUNSETVNETHDRSZ, IOC_W, MK_PTR(TYPE_INT))
> +  IOCTL(TUNSETQUEUE,     IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
> +  IOCTL(TUNSETIFINDEX ,  IOC_W, MK_PTR(TYPE_INT))
> +  /* TUNGETFILTER is not supported: see TUNATTACHFILTER. */
> +  IOCTL(TUNSETVNETLE,    IOC_W, MK_PTR(TYPE_INT))
> +  IOCTL(TUNGETVNETLE,    IOC_R, MK_PTR(TYPE_INT))
> +#ifdef TUNSETVNETBE
> +  IOCTL(TUNSETVNETBE,    IOC_W, MK_PTR(TYPE_INT))
> +  IOCTL(TUNGETVNETBE,    IOC_R, MK_PTR(TYPE_INT))
> +#endif
> +#ifdef TUNSETSTEERINGEBPF
> +  IOCTL(TUNSETSTEERINGEBPF, IOC_W, MK_PTR(TYPE_INT))
> +#endif
> +#ifdef TUNSETFILTEREBPF
> +  IOCTL(TUNSETFILTEREBPF, IOC_W, MK_PTR(TYPE_INT))
> +#endif
> +#ifdef TUNSETCARRIER
> +  IOCTL(TUNSETCARRIER,   IOC_W, MK_PTR(TYPE_INT))
> +#endif
> +#ifdef TUNGETDEVNETNS
> +  IOCTL(TUNGETDEVNETNS,  IOC_R, TYPE_NULL)
> +#endif
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1211e759c2..7f1efed189 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -56,6 +56,7 @@
>  #include <linux/wireless.h>
>  #include <linux/icmp.h>
>  #include <linux/icmpv6.h>
> +#include <linux/if_tun.h>
>  #include <linux/errqueue.h>
>  #include <linux/random.h>
>  #ifdef CONFIG_TIMERFD
> @@ -5422,6 +5423,41 @@ static abi_long do_ioctl_drm(const IOCTLEntry *ie, uint8_t *buf_temp,
>  
>  #endif
>  
> +static abi_long do_ioctl_TUNSETTXFILTER(const IOCTLEntry *ie, uint8_t *buf_temp,
> +                                        int fd, int cmd, abi_long arg)
> +{
> +    struct tun_filter *filter = (struct tun_filter *)buf_temp;
> +    struct tun_filter *target_filter;
> +    char *target_addr;
> +
> +    assert(ie->access == IOC_W);
> +
> +    target_filter = lock_user(VERIFY_READ, arg, sizeof(*filter), 1);

sizeof(*target_filter) vould be more coherent: we lock the target memory
so use the size of the type of the target.

> +    if (!target_filter) {
> +        return -TARGET_EFAULT;
> +    }
> +    filter->flags = tswap16(target_filter->flags);
> +    filter->count = tswap16(target_filter->count);
> +    unlock_user(target_filter, arg, sizeof(*filter));

unlock_user(target_filter, arg, 0) as we don't need to copy the value
back to the target.

> +
> +    if (filter->count) {
> +        if (sizeof(*filter) + filter->count * ETH_ALEN > MAX_STRUCT_SIZE) {

Rather than sizeof() use offsetof(struct tun_filter, addr)

> +            return -TARGET_EFAULT;
> +        }
> +
> +        target_addr = lock_user(VERIFY_READ, arg + sizeof(*filter),

Rather than sizeof() use offsetof(struct tun_filter, addr)

> +                                filter->count * ETH_ALEN, 1);
> +        if (!target_addr) {
> +            return -TARGET_EFAULT;
> +        }
> +        memcpy(filter->addr, target_addr, filter->count * ETH_ALEN);
> +        unlock_user(target_addr, arg + sizeof(*filter),

 offsetof(struct tun_filter, addr)

Thanks,
Laurent

