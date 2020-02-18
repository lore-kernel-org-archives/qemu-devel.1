Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E3CC34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D5F206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D5F206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j49se-0007W4-Ir
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 15:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j49s1-00075N-Rz
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:53:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j49ry-000223-RX
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:53:29 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:43955)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j49rx-0001xa-P5
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:53:25 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mx0VH-1jOrF23nXn-00yU6a; Tue, 18 Feb 2020 21:53:08 +0100
Subject: Re: [PATCH v2 2/4] linux-user: Add support for FITRIM ioctl
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1579880839-31466-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1579880839-31466-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ebc00405-19f7-7b7e-a51c-dab761e5bb04@vivier.eu>
Date: Tue, 18 Feb 2020 21:53:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579880839-31466-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rF3LHTSuzqa1QchLslARzj9uTCk/LYc+8daeaWM0J6EyDiZHEmK
 u1E5dtqAFhyD98/SBuTgnvmjD/ISGbbVVwASnL0xGJKA0u2RzjHHGLlr5BpgP0wKdNGqr3X
 A6pLFK0qvTNEmaNTiFtH2KligLz7DXPxyikXzXmNFi7ivoOJhaUhJ9nFkhorEDSwqCkP+7m
 b4I18rOEu6vF6+BMv2eLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AriQHyg4KW0=:y0rirgob1gvtFclx8lF4hu
 kSxvJAWIKS6lIfY6h1tpOR6oivYDGuMhL8o/+R4jsAniqbVI9GKMKq/Axx8Hvfb1/1ONMxb0c
 BK+mEz2wR+iTNtytdCbK90l37+P1yKi5FwpcWjJT5Nunhc2phfaydzLRbjtS4wpidm8xIny/R
 UUjYoIvkDQ0lPNm8eYWAaW0VnhUxrrotcdg4tMFwycEs4zXYZ1njXpAN2sClXYMmFmLhvRX1m
 7uyBS9Q+lfvVGD81qm4FdktQ4t4WMJkkDfRcbsViv4inZnzREDvpwu2yALdIeZNrbNKGUJTuz
 bmv3HP3BMPxuodQLdbJEkWPPOOGehKR8nsXGXycrQoFI0vUmgga8jLeUligAFRA/ksFnRGitF
 h5xsowkwziBC+cLrM6WA4xTignGtd5ISyMkxZh4FHttTXS3c29/FGkqLx2U1/5HCtw+gHHoG0
 k2eRepvIveOfJgrk7hA1gCxTPetHN2G6lkZXPIK8lKHXlVmh8y0qouPpwl5kifpLiqAIBqc6r
 8dW7oie+YJzKAH+cR8mtl9Xtf3UwQmaWOUHMdlsjwoJOAmsMTCOiSGXCDLVp/LKgjUN6k4gfj
 wnhcbW1Ox3w6jl9aYsXwUEWtaIlWxsAQVWjpkxW7BDyI4s/pgRnyCSxFh4NebFp6xvjDjnSj6
 F42ruxyFLsu5H1+Iw3tSrN8jnwPZnNIql/j7rLNP0U6pPc7CKYN9HUlVoCyo91L8mZIyHazlQ
 HwK94dSmgnDj+a13RVrbTRJtl72BvGTVxcwpnajf123DxMEWrzPToZ0lMZeJ2IKXR5tRHEiWv
 1ga/k4OGZb2heunO63lcCqYlvgFLYW7HNTwnfzpg8vhtIeh3nWWfsSF7m+N/gvUI2FFHOwc
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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
> FITRIM ioctl accepts a pointer to the structure
> 
> struct fstrim_range {
>     __u64 start;
>     __u64 len;
>     __u64 minlen;
> };
> 
> as its third argument.
> 
> All ioctls in this group (FI* ioctl) are guarded with "#ifdef", so the
> guards are used in this implementation too for consistency (however,
> many of ioctls in FI* group became old enough that their #ifdef guards
> could be removed, bit this is out of the scope of this patch).
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/ioctls.h        | 3 +++
>  linux-user/syscall_defs.h  | 1 +
>  linux-user/syscall_types.h | 5 +++++
>  3 files changed, 9 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 9fb9d6f..944fbeb 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -152,6 +152,9 @@
>  #ifdef FIBMAP
>       IOCTL(FIBMAP, IOC_W | IOC_R, MK_PTR(TYPE_LONG))
>  #endif
> +#ifdef FITRIM
> +     IOCTL(FITRIM, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_fstrim_range)))
> +#endif
>  #ifdef FICLONE
>       IOCTL(FICLONE, IOC_W, TYPE_INT)
>       IOCTL(FICLONERANGE, IOC_W, MK_PTR(MK_STRUCT(STRUCT_file_clone_range)))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index ed5068f..8761841 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -950,6 +950,7 @@ struct target_rtc_pll_info {
>  #define TARGET_FIBMAP     TARGET_IO(0x00,1)  /* bmap access */
>  #define TARGET_FIGETBSZ   TARGET_IO(0x00,2)  /* get the block size used for bmap */
>  
> +#define TARGET_FITRIM     TARGET_IOWR('X', 121, struct fstrim_range)
>  #define TARGET_FICLONE    TARGET_IOW(0x94, 9, int)
>  #define TARGET_FICLONERANGE TARGET_IOW(0x94, 13, struct file_clone_range)
>  
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index 5ba4155..dfd7608 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -226,6 +226,11 @@ STRUCT(dm_target_versions,
>  STRUCT(dm_target_msg,
>         TYPE_ULONGLONG) /* sector */
>  
> +STRUCT(fstrim_range,
> +       TYPE_LONGLONG, /* start */
> +       TYPE_LONGLONG, /* len */
> +       TYPE_LONGLONG) /* minlen */

they are __u64, use TYPE_ULONGLONG.

With that changed, you can add my:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


