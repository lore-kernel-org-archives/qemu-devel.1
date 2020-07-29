Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D342C433E5
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2886220FC3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2886220FC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ogA-00046g-EU
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 12:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k0ofC-0002mH-Qk
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:10:42 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:50075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k0ofA-00020k-FM
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:10:42 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MJV9M-1kKfte0Qiu-00Jrhe; Wed, 29 Jul 2020 18:10:30 +0200
Subject: Re: [PATCH 4/4] linux-user: Add support for a group of btrfs ioctls
 used to get/set features
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200709155203.21106-1-Filip.Bozuta@syrmia.com>
 <20200709155203.21106-5-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3c053547-7790-18b4-7418-3741842e1829@vivier.eu>
Date: Wed, 29 Jul 2020 18:10:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709155203.21106-5-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lOc0BUHTdHiHZRTi1T6k2XCREt/t+AkmW/cFoXLxLE8PQy4FDR7
 ILrpBZtJaX/NiCtsoFy6/EO3RhkgNYtm7vcaUgMcdk6wzVWsdwLesRLB0RxulSpMY2New7w
 SN3V6gxX1vYvvW2LjExg6lXS1E2dME9M0w3JGGFQxwC3pT/slcVesrywfEmgPfpd2r/H5NW
 m86o0HPFbju8ktMogTfXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dc80dkXfGg4=:nZPoH6YYrz25iaVbfpQUYo
 rodz2Lsuwl/lEaFxa6H0Zq7LG7KBdPn3eX+G6j3QXDeFJNOnIfeQ7Jvw7GTc41dFruZgnrgvY
 OMCg5ogSvcIKW7Ve4PO3FdulWYD3iVDswZAhmhMRZkfWeZISdWt/xzcIOY26J1GJWqHWzY+51
 Y5b7YVS4b8/93lL0cO/jxHFwBY+DFUTnJK8/V6uJe9LoMOsh9sSQnDDASGF8r0kL75o9eW0Ny
 Bf7kTPx98tk1rSv2CgMuaraQl1+T7ID7Gmx+5jU910GkLJbAfI2jN50Pv3qqKndlMIapTdA7v
 uugKQBPUcncvXzEHuQ4fV9mo2dqVtbcLeiMmXcNDyAajaahK4vKc7Dz3QtsK7x1KQ6UPmmrT9
 Ryf1hTR8Nq4tf35gjYT9GOJXKv2Khvg8edKngldU8dbCe71+Fzt3JIho4uafxxUd7RvfgRut+
 l8I8xFfhpJ2TRhcdpsCRDwoZEMWKlLoLEmhJqOiuJ6bNWPP9lS406Nf3i2LKTC1KXrOqu5/vJ
 U/eKDLj9JODYHVkGp6co8399iYJ/4fQ4h52BKuoxAuTVZfVfuXmKtpLaxIzGr8OVCHhAC9Ylu
 O2/WwzdIaTHea+gr+cuM6K2y4lkf83sejz+EaCqBkXXcDk3EaL2rtD/L//ZqO5wu0ISNSs+3a
 nfWHe+gI7aJVQgvpiI0XdfxIYBZJzYubYMgtyJ/HARtMg4yVhv4Yk6tROm2N19bmtWmOoNd4B
 4QICUYAej69H7bppKQEeXILOqHsKoQtZVKsHVRfAatOJwRHn3ujW9GAgQkxAMUp5E9r8Giqbr
 WI1+YKGZuGFfoq6B+Q16VxB92oyRP2irjvbExDh0n3nswH4+Eo5xyoRVwKwe21M4Ij28ULX
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 11:47:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 09/07/2020 à 17:52, Filip Bozuta a écrit :
> This patch implements functionality for following ioctls:
> 
> BTRFS_IOC_GET_FEATURES - Getting feature flags
> 
>     Read feature flags for a btrfs filesystem. The feature flags
>     are returned inside the ioctl's third argument which represents
>     a pointer to a following structure type:
> 
>     struct btrfs_ioctl_feature_flags {
> 	__u64 compat_flags;
> 	__u64 compat_ro_flags;
> 	__u64 incompat_flags;
>     };
> 
>     All of the structure field represent bit masks that can be composed
>     of values which can be found on:
>     https://elixir.bootlin.com/linux/latest/source/fs/btrfs/ctree.h#L282
> 
> BTRFS_IOC_SET_FEATURES - Setting feature flags
> 
>     Set and clear feature flags for a btrfs filesystem. The feature flags
>     are set using the ioctl's third argument which represents a
>     'struct btrfs_ioctl_feature_flags[2]' array. The first element of the
>     array represent flags which are to be cleared and the second element of
>     the array represent flags which are to be set. The second element has the
>     priority over the first, which means that if there are matching flags
>     in the elements, they will be set in the filesystem. If the flag values
>     in the third argument aren't correctly set to be composed of the available
>     predefined flag values, errno ENOPERM ("Operation not permitted") is returned.
> 
> BTRFS_IOC_GET_SUPPORTED_FEATURES - Getting supported feature flags
> 
>     Read supported feature flags for a btrfs filesystem. The supported
>     feature flags are read using the ioctl's third argument which represents
>     a 'struct btrfs_ioctl_feature_flags[3]' array. The first element of this
>     array represents all of the supported flags in the btrfs filesystem.
>     The second element represents flags that can be safely set and third element
>     represent flags that can be safely clearead.
> 
> Implementation notes:
> 
>     All of the implemented ioctls use 'struct btrfs_ioctl_feature_flags' as
>     third argument. That is the reason why a corresponding defintion was added
>     in file 'linux-user/syscall_types.h'.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/ioctls.h        | 12 ++++++++++++
>  linux-user/syscall_defs.h  |  6 ++++++
>  linux-user/syscall_types.h |  5 +++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index c20bd97736..c6303a0406 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -216,6 +216,18 @@
>       IOCTL(BTRFS_IOC_GET_DEV_STATS, IOC_RW,
>             MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_dev_stats)))
>  #endif
> +#ifdef BTRFS_IOC_GET_FEATURES
> +     IOCTL(BTRFS_IOC_GET_FEATURES, IOC_R,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_feature_flags)))
> +#endif
> +#ifdef BTRFS_IOC_SET_FEATURES
> +     IOCTL(BTRFS_IOC_SET_FEATURES, IOC_W,
> +           MK_PTR(MK_ARRAY(MK_STRUCT(STRUCT_btrfs_ioctl_feature_flags), 2)))
> +#endif
> +#ifdef BTRFS_IOC_GET_SUPPORTED_FEATURES
> +     IOCTL(BTRFS_IOC_GET_SUPPORTED_FEATURES, IOC_R,
> +           MK_PTR(MK_ARRAY(MK_STRUCT(STRUCT_btrfs_ioctl_feature_flags), 3)))
> +#endif
>  #ifdef BTRFS_IOC_GET_SUBVOL_INFO
>       IOCTL(BTRFS_IOC_GET_SUBVOL_INFO, IOC_R,
>             MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_subvol_info_args)))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 20c03cd145..9db6f46cba 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -990,6 +990,12 @@ struct target_rtc_pll_info {
>                                            30, struct btrfs_ioctl_dev_info_args)
>  #define TARGET_BTRFS_IOC_GET_DEV_STATS          TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
>                                            52, struct btrfs_ioctl_get_dev_stats)
> +#define TARGET_BTRFS_IOC_GET_FEATURES           TARGET_IOR(BTRFS_IOCTL_MAGIC, \
> +                                         57, struct btrfs_ioctl_feature_flags)
> +#define TARGET_BTRFS_IOC_SET_FEATURES           TARGET_IOW(BTRFS_IOCTL_MAGIC, \
> +                                       57, struct btrfs_ioctl_feature_flags[2])
> +#define TARGET_BTRFS_IOC_GET_SUPPORTED_FEATURES TARGET_IOR(BTRFS_IOCTL_MAGIC, \
> +                                       57, struct btrfs_ioctl_feature_flags[3])
>  #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IOR(BTRFS_IOCTL_MAGIC, \
>                                     60, struct btrfs_ioctl_get_subvol_info_args)

TARGET_IORU() and TARGET_IOWU()

with that changed:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent

