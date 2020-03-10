Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FF7C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 20:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90674215A4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 20:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90674215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBlJW-0007QM-Q3
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 16:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBlIm-0006zV-Vv
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 16:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBlIl-0007Xe-JY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 16:16:32 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:44235)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jBlIl-0007TK-AA
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 16:16:31 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MQ67s-1iyTdV1IGm-00M8N7; Tue, 10 Mar 2020 21:16:22 +0100
To: chengang@emindsoft.com.cn, riku.voipio@iki.fi
References: <20200226113834.26404-1-chengang@emindsoft.com.cn>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
Message-ID: <6abe4989-6d63-6bc5-f566-96d7bda30df7@vivier.eu>
Date: Tue, 10 Mar 2020 21:16:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200226113834.26404-1-chengang@emindsoft.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AgbJ8N8o4gbwxpKVfQAxczb35Iu1A+YwBV3+Gw6xCpU4erBbTpp
 7RYvJxOTChavMj8zVMypnPLm81PETjIhaaoTNhKRGrXNTdGADyDbHZbbzNpMBPQEauzvktB
 OKzZUjJaSvU8zpO87UcONZ1q98HFFn1wS3aOgw1+P95Ys2d2Va8jSnuj2Kn5KH0djV2d1qG
 40NkP1D7iIVuwuVHnNSiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kd6sio9dZnA=:SGcW+q7iX3fSg3s5GjYoVi
 FSvZtb9YzM5tl9T1ewsrRBdoXCVwWrxCRgEtSeI/dJxFVOK5GPElyLC01aPO3kYMdP9DJqJId
 D1shPmsqfyXuxj/KiZhf3ExMCqjemrgoPmMYrYOPFqZ2cngKywjbQ/FUoYqGa7u4kvxYHcEFU
 tGdYsyyMk+CH2yfUwxSC0yXvQoHFJPVgYeeoTpx7jGZLxrfRUe3Op1dY9cL5VXGBt7PX6OmYt
 DeeLMBmeFWHiL1/X6FA6uP+QW+RgWlZisk0LOwZ1ibpGRBi0Vt3npp7JIhjo+n+PQWbhm6Kk5
 xe2Bd3X0TNcnysx39KnJfMghnw3hv17YQRUVPVJeuMYoPowewGwB4il2aigZ5nWkgLArJYU8i
 BLx5IahJFGHeW9ceNsMB+ySShhl8QcmQxC/LC3oM1A1jPNzgh5RbwJ9+cPh3hzXJ1nwWIIMPc
 6kW9fpRFcFkmQWczHrCOP15WwL/RxDgajHtugeUuvk1viX2o4ED9SdU4Ok3LBfvpa8P911Hvq
 Dtf69dAXIERD4aw51Defkf3i9yjTDT7xVAfT7d2e044/h7SccIjPHTzbftOdWKWi39QsElS6c
 TrbYbME7nkESFniLUmseMs3iaPxQfV/fgu+RKMOqRnLbkk5QJA8rHz/0Gsd008bq4nFli/Eoo
 B6g0s/SIcC7CxlCfDVvqovSCWGkamU8ppDIeKeZwD+XsdAXbAu2N/KqcPc3xnSJ1xWUnxsJSD
 1OCFHs2KfOrDkWKf4lj4GUcp3eVJvQR7pKm6NjtGelDF68Nsa068yTUUrXdrY2kWuGjyj2R6A
 QsFi48R7YMTN4GGevbG4YFUxl5Tdx75bEQ1+DkjbNqyoaxp7acLZ8Dg6+rXZcVb0dbT1Rqq
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 26/02/2020 à 12:38, chengang@emindsoft.com.cn a écrit :
> From: Chen Gang <chengang@emindsoft.com.cn>
> 
> The other DRM_IOCTL_* commands will be done later.
> 
> Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
> ---
>  linux-user/ioctls.h        |   3 +
>  linux-user/syscall.c       | 134 +++++++++++++++++++++++++++++++++++++
>  linux-user/syscall_defs.h  |  16 +++++
>  linux-user/syscall_types.h |  12 ++++
>  4 files changed, 165 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 0defa1d8c1..c2294b48a0 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -574,6 +574,9 @@
>    IOCTL_SPECIAL(SIOCDELRT, IOC_W, do_ioctl_rt,
>                  MK_PTR(MK_STRUCT(STRUCT_rtentry)))
>  
> +  IOCTL_SPECIAL(DRM_IOCTL_VERSION, IOC_RW, do_ioctl_drm,
> +                MK_PTR(MK_STRUCT(STRUCT_drm_version)))
> +

Rather than adding a specific function to process the structure, perhaps
we can add this in a generic way?

The problem with drm_version structure is the pointers to the strings.

Did you try to add a TYPE_STRING in
thunk_type_size()/thunk_type_align()/think_convert()/do_ioctl() to do that?

...

> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 152ec637cb..5e455a32af 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -1167,6 +1167,9 @@ struct target_rtc_pll_info {
>  #define TARGET_DM_TARGET_MSG          TARGET_IOWRU(0xfd, 0x0e)
>  #define TARGET_DM_DEV_SET_GEOMETRY    TARGET_IOWRU(0xfd, 0x0f)
>  
> +/* drm ioctls */
> +#define TARGET_DRM_IOCTL_VERSION      TARGET_IOWRU('d', 0x00)

Why do you use the TARGET_IOWRU variant?

Can't you use TARGET_IOWR('d', 0x00, struct target_drm_version)?

> +
>  /* from asm/termbits.h */
>  
>  #define TARGET_NCC 8
> @@ -2598,6 +2602,18 @@ struct target_mq_attr {
>      abi_long mq_curmsgs;
>  };
>  
> +struct target_drm_version {
> +    int version_major;
> +    int version_minor;
> +    int version_patchlevel;
> +    abi_ulong name_len;
> +    abi_ulong name;
> +    abi_ulong date_len;
> +    abi_ulong date;
> +    abi_ulong desc_len;
> +    abi_ulong desc;
> +};
> +
>  #include "socket.h"
>  
>  #include "errno_defs.h"
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index 4e12c1661e..52a031ad35 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -292,6 +292,18 @@ STRUCT(dm_target_versions,
>  STRUCT(dm_target_msg,
>         TYPE_ULONGLONG) /* sector */
>  
> +/* TODO: use #ifdef 32 bit #else 64 bit, next */
> +STRUCT(drm_version,
> +       TYPE_INT, /* version_major */
> +       TYPE_INT, /* version_minor */
> +       TYPE_INT, /* version_patchlevel */
> +       TYPE_ULONG, /* name_len */
> +       TYPE_PTRVOID, /* name */
> +       TYPE_ULONG, /* date_len */
> +       TYPE_PTRVOID, /* date */
> +       TYPE_ULONG, /* desc_len */
> +       TYPE_PTRVOID) /* desc */
> +

After defining a TYPE_STRING, you could use MKPTR(TYPE_STRING) for name,
date and desc.

Thanks,
Laurent



