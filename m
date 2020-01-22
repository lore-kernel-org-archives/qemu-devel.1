Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76CBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC5324655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC5324655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuGlx-0006Pj-Qy
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:14:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuGlI-0005uP-H4
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:13:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuGlH-0002Yi-9h
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:13:40 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:58841)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuGlH-0002YJ-0s
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:13:39 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MDgtl-1inR8m2lAF-00ArH1; Wed, 22 Jan 2020 15:13:23 +0100
Subject: Re: [PATCH 07/12] linux-user: Add support for
 FD<SETEMSGTRESH|SETMAXERRS|GETMAXERRS> ioctls
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1579214991-19602-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1579214991-19602-8-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9c1662d4-0b48-ebb5-024d-168aad99c6c0@vivier.eu>
Date: Wed, 22 Jan 2020 15:13:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1579214991-19602-8-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dG4TUregkEQCovi7xwYw+ygVaDFrhjpfYQbHBROHUvOCdIYYQxZ
 Fpd3LKe5aCVPLvvrNf9ecCf2CirznX8zx0kTrHYE1aXZ8crnpKZ6Aax0M4IM52ltN1XSWCz
 z6deaHNpYV+sUbIE4YJGrYE9OiIv5Mf70C5vUY1RwvmfZ8pWV9ns9KT1HFyYi1gGRtqJ6TQ
 QlxL7HzGSpkZisXU0G+wQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DcSyAJ9aBLI=:sm8vPYh45bMI6nH9pHOgyx
 Hc9CPjtyutqYmzrUNtIIAzQ5oqFvR43gLUavN8kr2HfF31/8iQvUYytbXvTs4/p9eY4QbyJVN
 Z5Qilf+humkcXSSQpMQC9KmrLtGmswLq/ql9VsqZmBAXi2tlWAOlqiyJ9P5+lNmCiVo4usi+i
 Oas+ZkMmep+fD67RUloS3W2XYUb6nA3bvcFgCQJYGTtrmYPMRIebcz+1qBLtIBfSf+EzaHTVd
 Rd0HMFTcnIUg8PL6Py7N0yFy2/f9/6SyUm+WZ33n/2VyGG1P96zmEiE0rQP2ECCIdDbuEY608
 KnkvPB8NMiJb+jU5fFHI0fwDQ2BpocIRAfgBDH5EQLGRL4eZ5O6Q8wl5sbQ5+rUwDMSG95+Il
 u7l01MxkQaGC988cGuaLpSYoVpIXbyC6BZxmozLK0/7wHTIFTnVsAjt177cTq3nJ5R9L8USy2
 5mDUyJ/FkKF9IOWq4idT/3mUD8E2BvZg/NK9FahScSr6npC+TlFo0/nBi1ID/l5BllKaDaEyi
 zicEmyqA9o6CGaChQSbH/rfDL3igdt3GoEgHpL5z5UMdhMDvwgqsUpS4NrHlwzcvLQaaxtBhq
 8RIMbMMxwvj3a/j4wOhagm5qkEIns+OPzYPil1Z8J8n4RJ/hTiq8aa6J+fS5bVW59IVGWJlcZ
 K1gnlj3oCUEXxm6YaM+AvlGVJ2UpLVGsISuC0t/PCOCGUhtbreu8HDsdpdnnhCJkOpelq1/Vk
 P11nqUK2S5JiYESAQxM/udDuFfxQm24HKiS7hJdIxBhqOy8LCbx9cj4ks/ZXHcYIB4UeJtvXm
 CqjTTMrCC9+n5euJdNq3Ju/OtfvLqovxTVzfH11LIq3YEXTLZ8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.73
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 16/01/2020 à 23:49, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> FDSETEMSGTRESH, FDSETMAXERRS, and FDGETMAXERRS ioctls are commands
> for controlling error reporting of a floppy drive.
> 
> FDSETEMSGTRESH's third agrument is a pointer to the structure:
> 
> struct floppy_max_errors {
>     unsigned int
>       abort,      /* number of errors to be reached before aborting */
>       read_track, /* maximal number of errors permitted to read an
>                    * entire track at once */
>       reset,      /* maximal number of errors before a reset is tried */
>       recal,      /* maximal number of errors before a recalibrate is
>                    * tried */
>       /*
>        * Threshold for reporting FDC errors to the console.
>        * Setting this to zero may flood your screen when using
>        * ultra cheap floppies ;-)
>        */
>       reporting;
> };
> 
> defined in Linux kernel header <linux/fd.h>.
> 
> Since all fields of the structure are of type 'unsigned int', there is
> no need to define "target_floppy_max_errors".
> 
> FDSETMAXERRS and FDGETMAXERRS ioctls do not use the third argument.
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/ioctls.h        | 3 +++
>  linux-user/syscall_defs.h  | 3 +++
>  linux-user/syscall_types.h | 7 +++++++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 66f8c4e..9e3ca90 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -114,7 +114,10 @@
>  
>       IOCTL(FDMSGON, 0, TYPE_NULL)
>       IOCTL(FDMSGOFF, 0, TYPE_NULL)
> +     IOCTL(FDSETEMSGTRESH, 0, TYPE_NULL)
>       IOCTL(FDFLUSH, 0, TYPE_NULL)
> +     IOCTL(FDSETMAXERRS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
> +     IOCTL(FDGETMAXERRS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
>       IOCTL(FDRESET, 0, TYPE_NULL)
>       IOCTL(FDRAWCMD, 0, TYPE_NULL)
>       IOCTL(FDTWADDLE, 0, TYPE_NULL)
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index d4d39de..e317115 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -899,7 +899,10 @@ struct target_pollfd {
>  
>  #define TARGET_FDMSGON        TARGET_IO(2, 0x45)
>  #define TARGET_FDMSGOFF       TARGET_IO(2, 0x46)
> +#define TARGET_FDSETEMSGTRESH TARGET_IO(2, 0x4a)
>  #define TARGET_FDFLUSH        TARGET_IO(2, 0x4b)
> +#define TARGET_FDSETMAXERRS  TARGET_IOW(2, 0x4c, struct floppy_max_errors)
> +#define TARGET_FDGETMAXERRS  TARGET_IOR(2, 0x0e, struct floppy_max_errors)
>  #define TARGET_FDRESET        TARGET_IO(2, 0x54)
>  #define TARGET_FDRAWCMD       TARGET_IO(2, 0x58)
>  #define TARGET_FDTWADDLE      TARGET_IO(2, 0x59)
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index ca9429e..434ce1c 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -266,6 +266,13 @@ STRUCT(blkpg_ioctl_arg,
>         TYPE_INT, /* datalen */
>         TYPE_PTRVOID) /* data */
>  
> +STRUCT(floppy_max_errors,
> +       TYPE_INT, /* abort */
> +       TYPE_INT, /* read_track */
> +       TYPE_INT, /* reset */
> +       TYPE_INT, /* recal */
> +       TYPE_INT) /* reporting */
> +
>  #if defined(CONFIG_USBFS)
>  /* usb device ioctls */
>  STRUCT(usbdevfs_ctrltransfer,
> 

Applied to my linux-user branch.

Thanks,
Laurent


