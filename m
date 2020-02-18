Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83243C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 21:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D9121D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 21:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D9121D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4AHO-0002CV-IV
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 16:19:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4AGh-0001ji-6k
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 16:19:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4AGf-0002BJ-Sa
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 16:18:59 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:32855)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j4AGf-00026l-Ic
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 16:18:57 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N6bPS-1jWIxC2lYM-0180H9; Tue, 18 Feb 2020 22:18:40 +0100
Subject: Re: [PATCH v2 4/4] linux-user: Add support for FDGETFDCSTAT ioctl
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1579880839-31466-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1579880839-31466-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <69d96b23-bcdf-2753-3886-17d168177f83@vivier.eu>
Date: Tue, 18 Feb 2020 22:18:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579880839-31466-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1CfQsgEEsnglnu5XirTRrO7YzcSY9IwIwg97dtYitS6zqrnOP3e
 nNIqaHfouEsXrsNUn1elXDbs7ptxCjOPWVcoVkpGIEboMLZjKwrrDwcVk2yJRDomSAulV/6
 I9gBOwwboH7AT6K6hDgOpNywpufdbARLQ0TRz1VaHChbP4gBEHF4YqI9Rw9IWc5BGto6LTh
 9OwqNownpbLtFmNYdIkNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EbmRfbYX8HA=:rneMLEgnma0kvfZHFT8le3
 yUCkDTWJP+SOXZSDaonS1+BFApiIJkplr7CmBwUADhrmky+Sxfyvde6PYuoHiJxTu3Q0DtbMB
 Fv4TZwOxJj2vKUJgAQiF61e9bgZ4HxzoseXaJYoIeTPjxokRnxv+GYIGtNUGBXOkdu/VYEHPJ
 PZG0OiUP6iNnpnXU7Tgu2ws63zak6wXntok3McQg/p8p7r833qQfbpaZH46u46l5l6Jy1DhJW
 QqojklHE5dvpMqUAz5PyNlpZfu+AP25JEpWkB2zMYkAQaaW2l2zfpXQFAEWUPEMIJfoCRN/R8
 CBQtF4DxdZY0C8Po+VCycseB3853tEF6mVh4nbDkNUiKZZnKv5MYOHtJyICpYZkLHZWFOq95g
 AK84VegsqiONm+vx6LRC5lPKGj4/ob16Yh8pYEZrk3OOpjECJQ9q7FA/IBXh6yABAFtlEHYJT
 AEYzrDlM8U9ktJlRpkeBSDtnan1/6k1ySyFGBNXsFjaK8VvbnldjiCb764wSVwN2QGKvDXmtA
 e5rp4ljCyw2lF/IsLduG0KjuJgaWR5KDp5PJn9CQX48H3d+neZPhwsjaXbJEKzRNT4HHXHK1j
 AchNSgL8PV7agKOvNE71libd2abNcWglz8iJmq/AqY7C6n6aHephq48aAmpn9KkaDFuE16ObO
 j/hdCtuJ1OTOIlf+o7NI1MAIUC2+TWDZIbk7e6LG0YHsPqvoKIy+r4tdnGeohWs0UfEQmqK18
 Ec/SXWN8tSH6pEnSp1sPc3IrcNqoUp4rZTBGsXvZ26LIe7WNTcq8VDoVlYkR/OCDEYFknWpVl
 x6eVscFL89QeuESUS029U5VrlAiUzKBIsJKLcIOGtMZOIcuEzKZ7ejCdbEr5e84QkfxLAlK
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
> FDGETFDCSTAT's third agrument is a pointer to the structure:
> 
> struct floppy_fdc_state {
>     int spec1;
>     int spec2;
>     int dtr;
>     unsigned char version;
>     unsigned char dor;
>     unsigned long address;
>     unsigned int rawcmd:2;
>     unsigned int reset:1;
>     unsigned int need_configure:1;
>     unsigned int perp_mode:2;
>     unsigned int has_fifo:1;
>     unsigned int driver_version;
>     unsigned char track[4];
> };
> 
> defined in Linux kernel header <linux/fd.h>.
> 
> Since there is a fields of the structure of type 'unsigned long', there is
> a need to define "target_format_descr". Also, five fields rawcmd, reset,
> need_configure, perp_mode, and has_fifo are all just bitfields and are
> part od a single 'unsigned int' field.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/ioctls.h        |  2 ++
>  linux-user/syscall_defs.h  | 18 ++++++++++++++++++
>  linux-user/syscall_types.h | 12 ++++++++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index adc07ad..b3bbe6a 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -145,6 +145,8 @@
>       IOCTL(FDSETMAXERRS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
>       IOCTL(FDGETMAXERRS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
>       IOCTL(FDRESET, 0, TYPE_NULL)
> +     IOCTL(FDGETFDCSTAT, IOC_R,
> +           MK_PTR(MK_STRUCT(STRUCT_target_floppy_fdc_state)))
>       IOCTL(FDRAWCMD, 0, TYPE_NULL)
>       IOCTL(FDTWADDLE, 0, TYPE_NULL)
>       IOCTL(FDEJECT, 0, TYPE_NULL)
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index ae4c048..e08e5bc 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -933,6 +933,23 @@ struct target_rtc_pll_info {
>  
>  /* From <linux/fd.h> */
>  
> +struct target_floppy_fdc_state {
> +    int spec1;                      /* spec1 value last used */
> +    int spec2;                      /* spec2 value last used */
> +    int dtr;
> +    unsigned char version;          /* FDC version code */
> +    unsigned char dor;
> +    abi_ulong address;              /* io address */
> +    unsigned int rawcmd:2;
> +    unsigned int reset:1;
> +    unsigned int need_configure:1;
> +    unsigned int perp_mode:2;
> +    unsigned int has_fifo:1;
> +    unsigned int driver_version;    /* version code for floppy driver */
> +    unsigned char track[4];
> +};
> +

use abi_int/abi_uint rather than "int/unsigned int".

Thanks,
Laurent

