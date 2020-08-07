Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406A4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 17:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00947204EA
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 17:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00947204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k46Iz-0006R5-AV
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 13:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k46Gw-0002qK-By
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 13:35:14 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:54745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k46Gt-0000wC-VW
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 13:35:14 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MrhHm-1kXgKv2nbA-00nhVB; Fri, 07 Aug 2020 19:35:01 +0200
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200803094629.21898-1-Filip.Bozuta@syrmia.com>
 <20200803094629.21898-4-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2 3/8] linux-user: Add support for btrfs ioctls used to
 manipulate with devices
Message-ID: <7d31d175-4d35-e66e-5cee-59a73341402a@vivier.eu>
Date: Fri, 7 Aug 2020 19:34:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803094629.21898-4-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CdtIENJ5G6DXQq10HZLxVmJ6v9HEfrg1S6kZZRBNuypU3gjoBQ7
 NZ6I2Ao8tq6yF6Os42ZwbI99GFU7q1r+ep0+5DBxZEiykR2pUo8xEN15Nrh4nYdJFFXXM6F
 UCbQ7SMKDTILb91QD7xB9m/H+XhlwK9imHaQ29erCiHVXIBL0WpwrsK6zQPdIne5pH74MWP
 5dC8Q8p+zwUYyOGosCq/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+5r8V200FQo=:vhSMINPYPTVHz/1xq/ZvmN
 ws3EAEYlhKin3zYMye+BJvhgVVpesU3q2u5zsHCYpq2NNUfLmnjJVd2MMNznSVKmznDd5iy9w
 Pus4HCB+z76tUAcT5Wanui+1KKJ7dU+uC8wk0ceCC8dO3i/lTGlaaDeIJ8PjfLYkZnbs3Y+Io
 266ZH77PSa6J/UDLE9UG7ne1Ol2zvDSB4V45BNYgUem06y9tlqeYMq/V4cgY0cFGRU7s+8v3Q
 0Xjrc5m9rYzv9kZG+WlybyUr9dPZ66aVrk1h94goH0MdbPnYSxNPMLEND2taTIQWqR/aRvfae
 Tf1BHEmi4oxn3Z9nDHG+5SRLm/E55ccQK9G+VjbwR+RLMUMeUw+OP9wuIiD3JjVLgMnByVpxc
 VX0988+bFbplbOFh7nfcTU12HvtS4U0J7VBgR0tACFMfCKlpJ4B895hhY1gAgYqJpvlPBByaK
 dqVg+d+cwi1gu7wrlRmULbMw40dG1Uwx0AVYjlNKdjAaWdOXf8G8c8/tqKt8fH2KfVNnGytSY
 CqRTNjTQuf7scuU+s0v1+7RqPkcVd5neMkamBXKCu7orewZab9EQoY66646BPj7zDm4jTMwY1
 tldcuvtgkmIJ9NPD+o0gTevisr0E0n2CrdRlCANUOoh2FqqmIRovD9irte8EdV/apF3zPGN9G
 QBBdjTASXc3A/sUBKgkFPow/ES/fOopH3OcG+mCY1lme3cp6E6T4gI0NGoDhPBvJFr2IaUXIQ
 g0N/EKmujaW9S4qdkFobQfsH2IQ9rmbtWzDLK3ZoE7qJyzDeXrXsdynml9lObdBgoqY5D27Zb
 eYXw8aRNz/h242Tz5gHYwgfZlRgTOxPvzOLmUjYiFlOBvsoJ7HYq4F5TsukiuAyksqv0v0V
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
> This patch implements functionality for following ioctls:
> 
> BTRFS_IOC_SCAN_DEV - Scanning device for a btrfs filesystem
> 
>     Scan a device for a btrfs filesystem. The device that is to
>     be scanned is passed in the ioctl's third argument which
>     represents a pointer to a 'struct ioc_vol_args' (which was
>     mentioned in a previous patch). Before calling this ioctl,
>     the name field of this structure should be filled with the
>     aproppriate name value which represents a path for the device.
>     If the device contains a btrfs filesystem, the ioctl returns 0,
>     otherwise a negative value is returned.
> 
> BTRFS_IOC_ADD_DEV - Adding a device to a btrfs filesystem
> 
>     Add a device to a btrfs filesystem. The device that is to be
>     added is passed in the ioctl's third argument which represents
>     a pointer to a 'struct ioc_vol_args' (which was mentioned in
>     a previous patch). Before calling this ioctl, the name field of
>     this structure should be filled with the aproppriate name value
>     which represents a path for the device.
> 
> BTRFS_IOC_RM_DEV - Removing a device from a btrfs filesystem
> 
>     Remove a device from a btrfs filesystem. The device that is to be
>     removed is passed in the ioctl's third argument which represents
>     a pointer to a 'struct ioc_vol_args' (which was mentioned in
>     a previous patch). Before calling this ioctl, the name field of
>     this structure should be filled with the aproppriate name value
>     which represents a path for the device.
> 
> BTRFS_IOC_DEV_INFO - Getting information about a device
> 
>     Obtain information for device in a btrfs filesystem. The information
>     is gathered in the ioctl's third argument which represents a pointer
>     to a following structure type:
> 
>     struct btrfs_ioctl_dev_info_args {
> 	__u64 devid;				/* in/out */
> 	__u8 uuid[BTRFS_UUID_SIZE];		/* in/out */
> 	__u64 bytes_used;			/* out */
> 	__u64 total_bytes;			/* out */
> 	__u64 unused[379];			/* pad to 4k */
> 	__u8 path[BTRFS_DEVICE_PATH_NAME_MAX];	/* out */
>     };
> 
>     Before calling this ioctl, field "devid" should be set with the id value
>     for the device for which the information is to be obtained. If this field
>     is not aproppriately set, the errno ENODEV ("No such device") is returned.
> 
> BTRFS_IOC_GET_DEV_STATS - Getting device statistics
> 
>     Obtain stats informatin for device in a btrfs filesystem. The information
>     is gathered in the ioctl's third argument which represents a pointer to
>     a following structure type:
> 
>     struct btrfs_ioctl_get_dev_stats {
> 	__u64 devid;				/* in */
> 	__u64 nr_items;				/* in/out */
> 	__u64 flags;				/* in/out */
> 
> 	/* out values: */
> 	__u64 values[BTRFS_DEV_STAT_VALUES_MAX];
> 
> 	/*
> 	 * This pads the struct to 1032 bytes. It was originally meant to pad to
> 	 * 1024 bytes, but when adding the flags field, the padding calculation
> 	 * was not adjusted.
> 	 */
> 	__u64 unused[128 - 2 - BTRFS_DEV_STAT_VALUES_MAX];
>     };
> 
>     Before calling this ioctl, field "devid" should be set with the id value
>     for the device for which the information is to be obtained. If this field
>     is not aproppriately set, the errno ENODEV ("No such device") is returned.
> 
> BTRFS_IOC_FORGET_DEV - Remove unmounted devices
> 
>     Search and remove all stale devices (devices which are not mounted).
>     The third ioctl argument is a pointer to a 'struct btrfs_ioctl_vol_args'.
>     The ioctl call will release all unmounted devices which match the path
>     which is specified in the "name" field of the structure. If an empty
>     path ("") is specified, all unmounted devices will be released.
> 
> Implementation notes:
> 
>     Ioctls BTRFS_IOC_DEV_INFO and BTRFS_IOC_GET_DEV_STATS use types
>     'struct btrfs_ioctl_dev_info_args' and ' struct btrfs_ioctl_get_dev_stats'
>     as third argument types. That is the reason why corresponding structure
>     definitions were added in file 'linux-user/syscall_types.h'.
>     Since the thunk type for 'struct ioc_vol_args' was already added in a
>     previous patch, the rest of the implementation was straightforward.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/ioctls.h        | 24 ++++++++++++++++++++++++
>  linux-user/syscall_defs.h  |  6 ++++++
>  linux-user/syscall_types.h | 16 ++++++++++++++++
>  3 files changed, 46 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 2422675dd0..c20bd97736 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -178,6 +178,22 @@
>       IOCTL(BTRFS_IOC_SNAP_CREATE, IOC_W,
>             MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
>  #endif
> +#ifdef BTRFS_IOC_SCAN_DEV
> +     IOCTL(BTRFS_IOC_SCAN_DEV, IOC_W,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
> +#endif
> +#ifdef BTRFS_IOC_FORGET_DEV
> +     IOCTL(BTRFS_IOC_FORGET_DEV, IOC_W,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
> +#endif
> +#ifdef BTRFS_IOC_ADD_DEV
> +     IOCTL(BTRFS_IOC_ADD_DEV, IOC_W,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
> +#endif
> +#ifdef BTRFS_IOC_RM_DEV
> +     IOCTL(BTRFS_IOC_RM_DEV, IOC_W,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
> +#endif
>  #ifdef BTRFS_IOC_SUBVOL_CREATE
>       IOCTL(BTRFS_IOC_SUBVOL_CREATE, IOC_W,
>             MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
> @@ -192,6 +208,14 @@
>  #ifdef BTRFS_IOC_SUBVOL_SETFLAGS
>       IOCTL(BTRFS_IOC_SUBVOL_SETFLAGS, IOC_W, MK_PTR(TYPE_ULONGLONG))
>  #endif
> +#ifdef BTRFS_IOC_DEV_INFO
> +     IOCTL(BTRFS_IOC_DEV_INFO, IOC_RW,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_dev_info_args)))
> +#endif
> +#ifdef BTRFS_IOC_GET_DEV_STATS
> +     IOCTL(BTRFS_IOC_GET_DEV_STATS, IOC_RW,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_dev_stats)))
> +#endif
>  #ifdef BTRFS_IOC_GET_SUBVOL_INFO
>       IOCTL(BTRFS_IOC_GET_SUBVOL_INFO, IOC_R,
>             MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_subvol_info_args)))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 16966c323f..23f966d552 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -969,12 +969,18 @@ struct target_rtc_pll_info {
>  
>  /* btrfs ioctls */
>  #define TARGET_BTRFS_IOC_SNAP_CREATE            TARGET_IOWU(BTRFS_IOCTL_MAGIC, 1)
> +#define TARGET_BTRFS_IOC_SCAN_DEV               TARGET_IOWU(BTRFS_IOCTL_MAGIC, 4)
> +#define TARGET_BTRFS_IOC_FORGET_DEV             TARGET_IOWU(BTRFS_IOCTL_MAGIC, 5)
> +#define TARGET_BTRFS_IOC_ADD_DEV                TARGET_IOWU(BTRFS_IOCTL_MAGIC, 10)
> +#define TARGET_BTRFS_IOC_RM_DEV                 TARGET_IOWU(BTRFS_IOCTL_MAGIC, 11)
>  #define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 14)
>  #define TARGET_BTRFS_IOC_SNAP_DESTROY           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 15)
>  #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, 25,\
>                                                             abi_ullong)
>  #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
>                                                             abi_ullong)
> +#define TARGET_BTRFS_IOC_DEV_INFO               TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 30)
> +#define TARGET_BTRFS_IOC_GET_DEV_STATS          TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 52)
>  #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IORU(BTRFS_IOCTL_MAGIC, 60)
>  
>  /* usb ioctls */
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index 75ce6482ea..b5718231e5 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -349,6 +349,22 @@ STRUCT(btrfs_ioctl_get_subvol_info_args,
>         MK_STRUCT(STRUCT_btrfs_ioctl_timespec), /* rtime */
>         MK_ARRAY(TYPE_ULONGLONG, 8)) /* reserved */
>  
> +STRUCT(btrfs_ioctl_dev_info_args,
> +       TYPE_ULONGLONG, /* devid */
> +       MK_ARRAY(TYPE_CHAR, BTRFS_UUID_SIZE), /* uuid */
> +       TYPE_ULONGLONG, /* bytes_used */
> +       TYPE_ULONGLONG, /* total_bytes */
> +       MK_ARRAY(TYPE_ULONGLONG, 379), /* unused */
> +       MK_ARRAY(TYPE_CHAR, BTRFS_DEVICE_PATH_NAME_MAX)) /* path */
> +
> +STRUCT(btrfs_ioctl_get_dev_stats,
> +       TYPE_ULONGLONG, /* devid */
> +       TYPE_ULONGLONG, /* nr_items */
> +       TYPE_ULONGLONG, /* flags */
> +       MK_ARRAY(TYPE_ULONGLONG, BTRFS_DEV_STAT_VALUES_MAX), /* values */
> +       MK_ARRAY(TYPE_ULONGLONG,
> +                128 - 2 - BTRFS_DEV_STAT_VALUES_MAX)) /* unused */
> +
>  STRUCT(rtc_time,
>         TYPE_INT, /* tm_sec */
>         TYPE_INT, /* tm_min */
> 

Applied to my linux-user-for-5.2 branch.

Thanks,
Laurent

