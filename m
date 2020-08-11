Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F294FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801752076C
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801752076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5UzN-0002d8-Kq
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 10:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k5Uy9-0001t3-LR
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:09:37 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:35373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k5Uy7-0000bx-J5
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:09:37 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MKKdD-1kQC722vxn-00Lmop; Tue, 11 Aug 2020 16:09:31 +0200
Subject: Re: [PATCH v2 1/8] linux-user: Support F_ADD_SEALS and F_GET_SEALS
 fcntls
To: Shu-Chun Weng <scw@google.com>, qemu-devel@nongnu.org
References: <cover.1597129029.git.scw@google.com>
 <020a4b8e2185a0aab62c99abd0d8f9d8ff315c37.1597129029.git.scw@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cd6fce1f-ea09-be73-bba4-5d5cb1776053@vivier.eu>
Date: Tue, 11 Aug 2020 16:09:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <020a4b8e2185a0aab62c99abd0d8f9d8ff315c37.1597129029.git.scw@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JviTGlVKvPRwYXpNZEOgWklcoKyCItADOctncgYCgh+gGc0/d3Y
 JXCY8fVmnf3EXWhqy3PfxO3yPL7apFlAu2nE3haRf9npHu9JrHKKCzHz0EyJvINwqJ3orln
 nBEL4WwzaxfYFi3pXblvMlIWgSd32J/tNU6SIpdbnnWxcW4nI71JzOD6an3nTcEw8pxd9xq
 AIZgZ4Qu+YKe5WQGuox3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cpPidyt8GTg=:QyNJzsm6VCJGN9CV9SNAYp
 qJZ0GZujvwsYfJT6vPNKTl7UJ+KDvx/plfQKuRqz5nne5lXKbENz7FWYEJYGS6rJDBtKcE6xB
 oiPM2UUPqiGkJ0T2dFRoBnjpDw3RCD2bGx8xbDcVwsXtDvuXU956Si+Ct874+iIscLx4rQpjk
 pbm7VjM6QzRUUHEFtRxhqo6s+6E26qzIR0KXFJr3r3Ctx9NFARYiR6yu3w2ebsot7SccEocY9
 LuTXP+f/ydGbRM3aX7uLMR6JzAVcwE1yjFQGd5O4kwAELP52faivCWReI9XhyEdAmMIS90NMr
 KmXQa9NhwD8E4v/9uQG735xiEY9qa6uRTvEdHxYZg+9aza5HamT3oi5oxtY2u0eN8B0hj1Xtn
 DJITesdSNK1MFzHmRLQX2u581X+u+xNHAnqtgRTyCUt2xF8fD+NJLYBzj3LtZfObfku1ESJBX
 TXtpBjN92PTEth0ltwy9aHM8HNpV+SenP9wsALwfcZ86m2NE2+kad/dbA1Ejqp94j3qhfdORk
 /AsMaJ6TtOsuUmlcsOL9U6JHTbjFMh8KoX1y3l0yR+g4utA1cjWVxseYF5t4lz/j60x8fUnvS
 Qn5kOxSGqy1vmqD1voeONdrnkmeUtbUunZp6KqQ+kp57x8oPuJ1dBYGiH5RuiH+WdbbYLiTc3
 o+zI+Po1oxGU2i05rpHoNKQJFwFwYAcK2xM+VLoE7M84onPiEZ9rzOphilGOtBhSuJHZIYXpZ
 CZeYK5xYyhfZ+7TENT0QO3tqF2wRliVKbDLYKrtN7/ATOg8UJyPg/2uNkQgGlj1RcVKAaUMQx
 hTJfEikLFqwaQGnKJUcCyFOPkh6y8sy+VcC3bz4R+FddKFpNmLhhnC5RB33IpyPm1i67t9V
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 10:09:33
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

Le 11/08/2020 à 09:09, Shu-Chun Weng a écrit :
> Also reorder blocks so that they are all in the same order everywhere.
> 
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
> v1 -> v2:
>   Updated print_fcntl().
> 
>  linux-user/strace.c       | 55 ++++++++++++++++++++++++++++++++-------
>  linux-user/syscall.c      | 10 +++++++
>  linux-user/syscall_defs.h | 14 +++++-----
>  3 files changed, 64 insertions(+), 15 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 13981341b3..4fff24b880 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1684,6 +1684,18 @@ print_fcntl(const struct syscallname *name,
>          qemu_log("F_SETFL,");
>          print_open_flags(arg2, 1);
>          break;
> +    case TARGET_F_OFD_GETLK:
> +        qemu_log("F_OFD_GETLK,");
> +        print_pointer(arg2, 1);
> +        break;
> +    case TARGET_F_OFD_SETLK:
> +        qemu_log("F_OFD_SETLK,");
> +        print_pointer(arg2, 1);
> +        break;
> +    case TARGET_F_OFD_SETLKW:
> +        qemu_log("F_OFD_SETLKW,");
> +        print_pointer(arg2, 1);
> +        break;
>      case TARGET_F_GETLK:
>          qemu_log("F_GETLK,");
>          print_pointer(arg2, 1);
> @@ -1726,26 +1738,51 @@ print_fcntl(const struct syscallname *name,
>  #endif
>      case TARGET_F_SETLEASE:
>          qemu_log("F_SETLEASE,");
> -        print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
> +        print_raw_param(TARGET_ABI_FMT_ld, arg2, 1);
>          break;
>      case TARGET_F_GETLEASE:
>          qemu_log("F_GETLEASE");
>          break;
> -    case TARGET_F_SETPIPE_SZ:
> -        qemu_log("F_SETPIPE_SZ,");
> -        print_raw_param(TARGET_ABI_FMT_ld, arg2, 1);
> -        break;
> -    case TARGET_F_GETPIPE_SZ:
> -        qemu_log("F_GETPIPE_SZ");
> -        break;
> +#ifdef F_DUPFD_CLOEXEC
>      case TARGET_F_DUPFD_CLOEXEC:
>          qemu_log("F_DUPFD_CLOEXEC,");
>          print_raw_param(TARGET_ABI_FMT_ld, arg2, 1);
>          break;
> +#endif
>      case TARGET_F_NOTIFY:
>          qemu_log("F_NOTIFY,");
> -        print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
> +        print_raw_param(TARGET_ABI_FMT_ld, arg2, 1);
>          break;
> +#ifdef F_GETOWN_EX
> +    case TARGET_F_GETOWN_EX:
> +        qemu_log("F_GETOWN_EX,");
> +        print_pointer(arg2, 1);
> +        break;
> +#endif
> +#ifdef F_SETOWN_EX
> +    case TARGET_F_SETOWN_EX:
> +        qemu_log("F_SETOWN_EX,");
> +        print_pointer(arg2, 1);
> +        break;
> +#endif
> +#ifdef F_SETPIPE_SZ
> +    case TARGET_F_SETPIPE_SZ:
> +        qemu_log("F_SETPIPE_SZ,");
> +        print_raw_param(TARGET_ABI_FMT_ld, arg2, 1);
> +        break;
> +    case TARGET_F_GETPIPE_SZ:
> +        qemu_log("F_GETPIPE_SZ");
> +        break;
> +#endif
> +#ifdef F_ADD_SEALS
> +    case TARGET_F_ADD_SEALS:
> +        qemu_log("F_ADD_SEALS,");
> +        print_raw_param("0x"TARGET_ABI_FMT_lx, arg2, 1);
> +        break;
> +    case TARGET_F_GET_SEALS:
> +        qemu_log("F_GET_SEALS");
> +        break;
> +#endif
>      default:
>          print_raw_param(TARGET_ABI_FMT_ld, arg1, 0);
>          print_pointer(arg2, 1);
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 945fc25279..5645862798 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6305,6 +6305,14 @@ static int target_to_host_fcntl_cmd(int cmd)
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
> @@ -6591,6 +6599,8 @@ static abi_long do_fcntl(int fd, int cmd, abi_ulong arg)
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

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

