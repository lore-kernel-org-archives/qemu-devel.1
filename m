Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E2CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 17:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 882BA204EC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 17:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882BA204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k46I8-0004dV-Pa
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 13:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k46H1-0002te-E5
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 13:35:19 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:55393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k46Gy-0000wo-0t
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 13:35:19 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MauJJ-1kbFMS2ZT9-00cO5H; Fri, 07 Aug 2020 19:35:11 +0200
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200803094629.21898-1-Filip.Bozuta@syrmia.com>
 <20200803094629.21898-7-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2 6/8] linux-user: Add support for two btrfs ioctls used
 for subvolume
Message-ID: <671f8841-e8b6-f039-453f-2b7465410194@vivier.eu>
Date: Fri, 7 Aug 2020 19:35:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803094629.21898-7-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mwLXOJ3HvZNXyj3Cx1YS7SHLKji7X8dlQw8vuS2m1kXRhuGDKeF
 uyWC5ZSUp2tP14B5hVbyrqTJtCpY8yFiSljKx1xPCuSDnd5CPt3sQWLMwWGOgZOtIkDUFRc
 CD5uYAIgyTh59kBHf3IxkUJIiVC+eIqzTDiuUuJwiL0R7OL93eUAIN+GNvcs6iR20CILq8S
 WxX5ZSNNJ8h6qGA8x8AFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IeNugT7Gn74=:TkmLbR8lfZcYKR6mdIsgD2
 4JEi+1dcHlscETvQIsBDNXiD3D7JARlExAfWKUl6avGadtzLZeZd9oFkhpqlINhzjgndAbBoX
 wNVooTqMvpstKsj+x4WPxbBOdRBVIALFrBXGH/yiua0LS5bKwj1/0Su7AFYH0G5X3lNeiFpdt
 qyNvzX+uKdBh66kpKCci05k7QGm5t6awEQKDcUTOHa0pFgVc5D4g4H+oBH1DJ+9f1nIrM8nF2
 ROalIuBwGDlRXlgtzfzGWyVXygkrp/eMClb6fDdGUndVzblGIW0nfQEfvjnlqYn0dnagTnoER
 GAdyevfpgw6FtdHO+Fans/al6OTYREc+NNtobKsL6sO9Aa/g9roJPIALRtA+TU2qD0oVRDysp
 b58aJo+DWG1/NpB9kcC+oMeP4hfpQ33stbFONfeIBQQxoduuKnBrs49Ou1wna9ujxJrLBPDhd
 XPEBJpuSO3LJplwUF1bsCq5t21AxmFuNBMlzAu/ncS+ekchvGPQ9eQLxKRSRDSEDSqSx1WY88
 uNYsQOzFnwSvqLfsvAzUIn3B4Cv+pzgexh0mkCPoYc+/Fh+Au4ou21T3JPk0mV11/sA1559So
 tG76YefnlaL7xbHBUnI2/I3AfxekveyZwsZA+e/fOz9IidTJ1KnzY3i749caBvAFsZtFu8+Id
 dmnJBakZ/us7d5e1RyKpGZlneAd+d5XBMsWpNoWwsw3MwpIXW+QsOnU4quff1fWf0DWhlwt+M
 CK/SZ6MnnbZcypx7CKSoVh4hApD8dDFByfJKGrqnsdYlGC60EnDEjoDGJJajynTwofc+4gDAL
 j3FaRUvp1rhuiUUMfaPC+ORM/WJ6fi+iqlS9d3LDa7iSZA5D2Geu0Yg5f3z5YJ7sFKgT5Ph
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 13:35:10
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 03/08/2020 à 11:46, Filip Bozuta a écrit :
> This patch implements functionality for following ioctl:
> 
> BTRFS_IOC_DEFAULT_SUBVOL - Setting a default subvolume
> 
>     Set a default subvolume for a btrfs filesystem. The third
>     ioctl's argument is a '__u64' (unsigned long long) which
>     represents the id of a subvolume that is to be set as
>     the default.
> 
> BTRFS_IOC_GET_SUBVOL_ROOTREF - Getting tree and directory id of subvolumes
> 
>     Read tree and directory id of subvolumes from a btrfs
>     filesystem. The tree and directory id's are returned in the
>     ioctl's third argument which represents a pointer to a
>     following type:
> 
>     struct btrfs_ioctl_get_subvol_rootref_args {
> 		/* in/out, minimum id of rootref's treeid to be searched */
> 		__u64 min_treeid;
> 
> 		/* out */
> 		struct {
> 			__u64 treeid;
> 			__u64 dirid;
> 		} rootref[BTRFS_MAX_ROOTREF_BUFFER_NUM];
> 
> 		/* out, number of found items */
> 		__u8 num_items;
> 		__u8 align[7];
>      };
> 
>      Before calling this ioctl, 'min_treeid' field should be filled
>      with value that represent the minimum value for the tree id.
> 
> Implementation notes:
> 
>     Ioctl BTRFS_IOC_GET_SUBVOL_ROOTREF uses the above mentioned structure
>     type as third argument. That is the reason why a aproppriate thunk
>     structure definition is added in file 'syscall_types.h'.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/ioctls.h        |  7 +++++++
>  linux-user/syscall_defs.h  |  3 +++
>  linux-user/syscall_types.h | 11 +++++++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index a7f5664487..2c553103e6 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -206,6 +206,9 @@
>       IOCTL(BTRFS_IOC_INO_LOOKUP, IOC_RW,
>             MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_ino_lookup_args)))
>  #endif
> +#ifdef BTRFS_IOC_DEFAULT_SUBVOL
> +     IOCTL(BTRFS_IOC_DEFAULT_SUBVOL, IOC_W, MK_PTR(TYPE_ULONGLONG))
> +#endif
>  #ifdef BTRFS_IOC_SUBVOL_GETFLAGS
>       IOCTL(BTRFS_IOC_SUBVOL_GETFLAGS, IOC_R, MK_PTR(TYPE_ULONGLONG))
>  #endif
> @@ -248,6 +251,10 @@
>       IOCTL(BTRFS_IOC_GET_SUBVOL_INFO, IOC_R,
>             MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_subvol_info_args)))
>  #endif
> +#ifdef BTRFS_IOC_GET_SUBVOL_ROOTREF
> +     IOCTL(BTRFS_IOC_GET_SUBVOL_ROOTREF, IOC_RW,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_subvol_rootref_args)))
> +#endif
>  #ifdef BTRFS_IOC_INO_LOOKUP_USER
>       IOCTL(BTRFS_IOC_INO_LOOKUP_USER, IOC_RW,
>             MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_ino_lookup_user_args)))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 538b884b8f..f1718ac521 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -976,6 +976,8 @@ struct target_rtc_pll_info {
>  #define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 14)
>  #define TARGET_BTRFS_IOC_SNAP_DESTROY           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 15)
>  #define TARGET_BTRFS_IOC_INO_LOOKUP             TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 18)
> +#define TARGET_BTRFS_IOC_DEFAULT_SUBVOL         TARGET_IOW(BTRFS_IOCTL_MAGIC, 19,\
> +                                                           abi_ullong)
>  #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, 25,\
>                                                             abi_ullong)
>  #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
> @@ -989,6 +991,7 @@ struct target_rtc_pll_info {
>  #define TARGET_BTRFS_IOC_GET_SUPPORTED_FEATURES TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
>  #define TARGET_BTRFS_IOC_LOGICAL_INO_V2         TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 59)
>  #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IORU(BTRFS_IOCTL_MAGIC, 60)
> +#define TARGET_BTRFS_IOC_GET_SUBVOL_ROOTREF     TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 61)
>  #define TARGET_BTRFS_IOC_INO_LOOKUP_USER        TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 62)
>  
>  /* usb ioctls */
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index 978f2d682c..6bac8f46bb 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -381,6 +381,17 @@ STRUCT(btrfs_ioctl_dev_info_args,
>         MK_ARRAY(TYPE_ULONGLONG, 379), /* unused */
>         MK_ARRAY(TYPE_CHAR, BTRFS_DEVICE_PATH_NAME_MAX)) /* path */
>  
> +STRUCT(rootref,
> +       TYPE_ULONGLONG, /* treeid */
> +       TYPE_ULONGLONG) /* dirid */
> +
> +STRUCT(btrfs_ioctl_get_subvol_rootref_args,
> +       TYPE_ULONGLONG, /* min_treeid */
> +       MK_ARRAY(MK_STRUCT(STRUCT_rootref),
> +                BTRFS_MAX_ROOTREF_BUFFER_NUM), /* rootref */
> +       TYPE_CHAR, /* num_items */
> +       MK_ARRAY(TYPE_CHAR, 7)) /* align */
> +
>  STRUCT(btrfs_ioctl_get_dev_stats,
>         TYPE_ULONGLONG, /* devid */
>         TYPE_ULONGLONG, /* nr_items */
> 

Applied to my linux-user-for-5.2 branch.

Thanks,
Laurent


