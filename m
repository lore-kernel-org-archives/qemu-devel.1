Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445D5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:45:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14ADB21744
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14ADB21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k40oA-0003JA-7S
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 07:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k40nZ-0002rn-Iy
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:44:33 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k40nX-0002WK-OO
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:44:33 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N0FE1-1kyZBs2KEp-00xM0d; Fri, 07 Aug 2020 13:44:27 +0200
Subject: Re: [PATCH 1/6] linux-user: Support F_ADD_SEALS and F_GET_SEALS fcntls
To: Shu-Chun Weng <scw@google.com>, qemu-devel@nongnu.org
References: <cover.1595461447.git.scw@google.com>
 <827d9ab425cb0c580722c48fe7471b14cbb1a57d.1595461447.git.scw@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3309ae6e-9780-7ac5-fb9f-8860acd88c1b@vivier.eu>
Date: Fri, 7 Aug 2020 13:44:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <827d9ab425cb0c580722c48fe7471b14cbb1a57d.1595461447.git.scw@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6cD7esYHm4F5zNUTz8LfiQNszPEvJNHhzAeRJSPyj01YcO/zkoN
 Cy3cM6CPpXh6J9PYu4hMjgxv8DtKddilfdi3XZu4+0jQJIOG8E9O3bYX9wsoWf8faZ0km7E
 wPChWjaEkZSgQA05pAzcnKLkxXTYdsZjZbM/+7z7MtkrxXnrj90cs4yj3QxT+oZgQ540Vii
 0Iy+6V8XVxTciBlFUD78w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ot9ZS9NXXTY=:Lv3dD3Af5VsMnb+JL8noP4
 t1yHEdD5trDGzoTydx10Vm6qbGDq3yQbQ2trwzRO6//yf9OQyj1ZXPa9N1GNZFmeAY348zLTF
 iX7mVlnmUi+06ovtFIQ57XdDBtgzRwvyzXEZotHNs/+9Vmr6Q7cIfGdWHIiV+euBhMH0DSsxH
 PPNdA2uYXC9Z0S/+k5aKdLDJjx32/Di09R1vi/VgIUM8c3cLUOBKSsL5S2+uGksd87E3gghHL
 oQZPBZnrv/xH4xAu71lvBoMi2+xBqBxVcFN2ClsLVX1uw3tC4C1JdIUCIdV/eVn9vDaPn+p4y
 +hAloIAe+KIMPLDcH5AJOUeBPLSTscJvtIx3VxaSDXcK/kjJ4pVIB2JNqy1WAOT2T8yPCQLGn
 MIbWQIWBX17li/L1Xdumw83S7AoBmvl5VTBWu+xP7Xf1FTG9SAiaYTmPQjlU2bz2LFkt3pDAS
 +cRNYQ4ylm4SJ3UNBZdANVWsekW8QApckj3aGkmGstFXCz5bc71e9740QsNfDA/fntbJVv08P
 ikdkxWtDabhdG/Te+iiAwxvCGZSp1zbuTbDuX1jLgKvB+UAFqQmGsyJ2kgd4LYEi9KzhMsPTE
 C6dCyqP/dMPvJS0zVXYEdIlhkcZUTPH/FgDvu/G12eytqtZVoJFlOAIndt94twJUiYlsmd46N
 vxhL2v/erYTL1nZiJkhebH/B9J00rGQCy0wvId4k4JYzv5LTq58T8ZDdcKlPu/tGJnlC643x+
 uaEqKO8z/iY26tTYu4IbqykYYV9HBxyfqKtc8UHV/94F3F+U57ulD7lmfx2kR6pxdELAXQ9U5
 q0pvJOFsP4RXjSfnDSzEvEZGqzEV9uO6uk/58W0s9kh9CEE1KOOQMXgl07zbDIQA/aoLuxL
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 07:17:02
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

Le 23/07/2020 à 02:19, Shu-Chun Weng a écrit :
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
>  linux-user/syscall.c      | 10 ++++++++++
>  linux-user/syscall_defs.h | 14 ++++++++------
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1211e759c2..f97337b0b4 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6312,6 +6312,14 @@ static int target_to_host_fcntl_cmd(int cmd)
>      case TARGET_F_GETPIPE_SZ:
>          ret = F_GETPIPE_SZ;
>          break;
> +#endif
> +#ifdef F_ADD_SEALS
> +    case TARGET_F_ADD_SEALS:
> +        ret = F_ADD_SEALS;
> +        break;
> +    case TARGET_F_GET_SEALS:
> +        ret = F_GET_SEALS;
> +        break;
>  #endif
>      default:
>          ret = -TARGET_EINVAL;
> @@ -6598,6 +6606,8 @@ static abi_long do_fcntl(int fd, int cmd, abi_ulong arg)
>      case TARGET_F_GETLEASE:
>      case TARGET_F_SETPIPE_SZ:
>      case TARGET_F_GETPIPE_SZ:
> +    case TARGET_F_ADD_SEALS:
> +    case TARGET_F_GET_SEALS:
>          ret = get_errno(safe_fcntl(fd, host_cmd, arg));
>          break;
>  
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 3c261cff0e..70df1a94fb 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -2292,12 +2292,14 @@ struct target_statfs64 {
>  #endif
>  
>  #define TARGET_F_LINUX_SPECIFIC_BASE 1024
> -#define TARGET_F_SETLEASE (TARGET_F_LINUX_SPECIFIC_BASE + 0)
> -#define TARGET_F_GETLEASE (TARGET_F_LINUX_SPECIFIC_BASE + 1)
> -#define TARGET_F_DUPFD_CLOEXEC (TARGET_F_LINUX_SPECIFIC_BASE + 6)
> -#define TARGET_F_SETPIPE_SZ (TARGET_F_LINUX_SPECIFIC_BASE + 7)
> -#define TARGET_F_GETPIPE_SZ (TARGET_F_LINUX_SPECIFIC_BASE + 8)
> -#define TARGET_F_NOTIFY  (TARGET_F_LINUX_SPECIFIC_BASE+2)
> +#define TARGET_F_SETLEASE            (TARGET_F_LINUX_SPECIFIC_BASE + 0)
> +#define TARGET_F_GETLEASE            (TARGET_F_LINUX_SPECIFIC_BASE + 1)
> +#define TARGET_F_DUPFD_CLOEXEC       (TARGET_F_LINUX_SPECIFIC_BASE + 6)
> +#define TARGET_F_NOTIFY              (TARGET_F_LINUX_SPECIFIC_BASE + 2)
> +#define TARGET_F_SETPIPE_SZ          (TARGET_F_LINUX_SPECIFIC_BASE + 7)
> +#define TARGET_F_GETPIPE_SZ          (TARGET_F_LINUX_SPECIFIC_BASE + 8)
> +#define TARGET_F_ADD_SEALS           (TARGET_F_LINUX_SPECIFIC_BASE + 9)
> +#define TARGET_F_GET_SEALS           (TARGET_F_LINUX_SPECIFIC_BASE + 10)
>  
>  #include "target_fcntl.h"
>  
> 

Looks good. Please also update print_fcntl() in linux-user/strace.c

Thanks,
Laurent

