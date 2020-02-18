Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED8CC34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92FDB2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FDB2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j49nH-0002lA-LY
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 15:48:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j49mb-0002Kj-Fj
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:47:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j49ma-0003oT-BQ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:47:53 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:41509)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j49mZ-0003jK-Vn
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:47:52 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MnWx3-1jlUnp0yZx-00jWOC; Tue, 18 Feb 2020 21:47:32 +0100
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1579880839-31466-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1579880839-31466-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2 1/4] linux-user: Add support for
 FS_IOC_FS<GET|SET>XATTR ioctls
Message-ID: <2420c864-b62d-f721-74ac-f52ae0538662@vivier.eu>
Date: Tue, 18 Feb 2020 21:47:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579880839-31466-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oAdHdV9FJDw+ItKpRO87XdBRy1lEcTuw/wp5Z5ZKJ8Gcu0Nkf3J
 NmfpiWfmRMZf7q30J/WrBeAl9NsCXcGZIk5eOZxLP0Zf+nY2RsZEa1pJJ7q9vtjFSksl19o
 PSdJjopg0b2gTNyrG24B7G1IWEnNYGYNZ4VomL86k7/XuGE5LcRYYxX6okR0pYLsrl0QVBK
 pn8BUE29YcZ2s+MGpm44A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SFzFSHcnliY=:7eBZy3+/cPBk4wq59n7Y7h
 C3ONPcYJVSFDjNZwH2alDp0FERVHiG5DhOoYQP7rd9sKYPReWQjPl9MXJkMjKkrZ+yZJvVC2Z
 sIpxamsBjiaIHuFSvaoarqrti6v+l8/jimBwt1/irhcsuuqdAOjRqx6BLxdPerHj5O4keY7C4
 o7c5Lj2KJHlx4nL0rYQWwWUbCqsa4D82vCDlJUH+oy+7FDOxOsKrqg6RrogeHJ2CFNWIwIkQy
 DyCUvsksDCpNFKBDX/ANY9X546It/2CtKqIsSqVsyO4zZQoTtfB/D/pJ8fk416mL4kCN7IJvD
 4JNZc8IJ1sQFJ36uQifquAek5k0/gpu0ZQQ8AvFeKdEc0w74fcojwbFrqw+e3wjQJb88iae5v
 yWcbpcH47E+yq2K3KjNwtCztJxjVDHZTALcXkIpBYQR6d9kEicB0N5t9n/W2g7WckD9VoIwer
 YzNj3sg5CS/wB4lh2Bp0x8syOvA54OntDLWqpASogW2hoXHWB3CB6CjVq+sLgkEbhEYSjcRtO
 qUXiK884lNNmAEyKUVmRbRR+AuPIxqHHu0aP6awuQ2vZ+xn+im+CoW4j7/Ecy9yyjTzgDMS4F
 4fkImDAjY8fzXzEX52dfBLadK6q3jWUnGhOjcHbtO9g+qQ7K0VlwjwQnf6bgYdPlMKWEeyoq0
 VW5xe9u/CRzxQx+vwIzf9gMAC9lqWNwnRLTwcQpKCDe6Bb1bRib36zqVoAoFqLAczmkMWyGfK
 eeXvkYUN91hlqBNT3dFtAZ56ortQV3tUUpBlYCpo7QWqLawBFBTYuubVo0iXRzzQsOc/dHBIP
 XycCOpz2xDEA1jRq3+MoxTkBFhqECqZhEAq6vDLSn7+Ko21JBRNKvfUNIUuL1g2hkpyIyZf
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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

Le 24/01/2020 à 16:47, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Both FS_IOC_FSGETXATTR and FS_IOC_FSSETXATTR accept a pointer to
> the structure
> 
> struct fsxattr {
>     __u32         fsx_xflags;     /* xflags field value (get/set) */
>     __u32         fsx_extsize;    /* extsize field value (get/set)*/
>     __u32         fsx_nextents;   /* nextents field value (get)	*/
>     __u32         fsx_projid;     /* project identifier (get/set) */
>     __u32         fsx_cowextsize; /* CoW extsize field value (get/set)*/
>     unsigned char fsx_pad[8];
> };
> 
> as their third argument.
> 
> These ioctls were relatively recently introduced, so the "#ifdef"
> guards are used in this implementation.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/ioctls.h       | 7 +++++++
>  linux-user/syscall_defs.h | 6 ++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 73dcc76..9fb9d6f 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -173,6 +173,13 @@
>       IOCTL(FS_IOC32_SETFLAGS, IOC_W, MK_PTR(TYPE_INT))
>       IOCTL(FS_IOC32_GETVERSION, IOC_R, MK_PTR(TYPE_INT))
>       IOCTL(FS_IOC32_SETVERSION, IOC_W, MK_PTR(TYPE_INT))
> +#ifdef FS_IOC_FSGETXATTR
> +     IOCTL(FS_IOC_FSGETXATTR, IOC_W, MK_PTR(MK_STRUCT(STRUCT_fsxattr)))

kernel declares that as IOC_R

> +#endif
> +#ifdef FS_IOC_FSSETXATTR
> +     IOCTL(FS_IOC_FSSETXATTR, IOC_W, MK_PTR(MK_STRUCT(STRUCT_fsxattr)))
> +#endif
> +
>  
>  #ifdef CONFIG_USBFS
>    /* USB ioctls */
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 9b61ae8..ed5068f 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -966,6 +966,12 @@ struct target_rtc_pll_info {
>  #define TARGET_FS_IOC32_SETFLAGS TARGET_IOW('f', 2, int)
>  #define TARGET_FS_IOC32_GETVERSION TARGET_IOR('v', 1, int)
>  #define TARGET_FS_IOC32_SETVERSION TARGET_IOW('v', 2, int)
> +#ifdef FS_IOC_FSGETXATTR
> +#define TARGET_FS_IOC_FSGETXATTR TARGET_IOR('X', 31, struct fsxattr)
> +#endif
> +#ifdef FS_IOC_FSSETXATTR
> +#define TARGET_FS_IOC_FSSETXATTR TARGET_IOR('X', 32, struct fsxattr)

kernel declares that as _IOW

> +#endif
>  
>  /* usb ioctls */
>  #define TARGET_USBDEVFS_CONTROL TARGET_IOWRU('U', 0)
> 

where is defined STRUCT(fsxattr, ...)?

Thanks,
Laurent

