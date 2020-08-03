Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED17C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 14:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12524206DA
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 14:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12524206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2bEC-00044O-7t
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 10:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k2bCW-0001ub-AG
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 10:12:28 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:49645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k2bCS-0002EK-Ji
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 10:12:27 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MYvHa-1kFssN2PGy-00Utsx; Mon, 03 Aug 2020 16:12:11 +0200
Subject: Re: [PATCH v2 5/8] linux-user: Add support for a group of btrfs inode
 ioctls
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200803094629.21898-1-Filip.Bozuta@syrmia.com>
 <20200803094629.21898-6-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7e3adead-db53-5ffc-ce4c-b3945c41a63c@vivier.eu>
Date: Mon, 3 Aug 2020 16:12:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803094629.21898-6-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pFeHRMVW565OSvluXqR0abuhKpnAe2EdvYUv6XDwmOeNNffppFU
 06c6arzZ7bOWgw84t8uYz9RkJyMGp+RwXyL0I+UoILCoh6bTFpj6/kdF6QLSg0eKUoKNELB
 RdactTXQ9eRtQFAhJuNVHPQhX+TlaMEUrKqz35gKgtkLJCdqgJzT4Xw90PxL7EgskEgpW2O
 E0VZlWOa46KbwlzlDie0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8a3uoE3c6vw=:K7j48sAGoBxCb2BXIWnp5p
 caPDoc3k8RqsWt4nYebFo4H2HUjlI0BQKkwVEVKYrSQPsMLC2qIC1bHtdeFat6ox0g/N2s5ZK
 W8wCwnbQNYBrDhdUeV+rz170h5V/041o7tel1/PbmcWXRhq0rmux4XMJlB+U0ZYcON4KuSOMG
 Yu8Pegpl6r1W1vM3xsM/Zv6ZnY54i2QKpNP4pie6PFplCgNMZd33XKF9wF5vwnJ2dDavSNMN8
 hGk9OCHCe0sl1TBC39O/gwv5KYGcWW9GuFib27EH73AnoUQt881OJn23DhvzO4tzagpjj9eO6
 H3cksAsmSXpsvCcyv4ncHeszY1HRsiD0XK1mcAMe6UsNFauIxPkV2gujz1e4EeQyhegcALbeL
 8DaJHt4e+0wXM8yiK5UBYKPbeKPMYGKMtDThEphNEIlHHcS9SZ8hgsfEE9dp5k3PKK64GtBKO
 3dKwqpGdRKG9rzuBjqcMCUHo1OFWDT9S038eKE+6TdIAHTD9EXIOH1orDuinlH9C36rdrF7Np
 DTwyWueFI2SJOZ6mbl/rF7gbtEJ/JebrFBLZieyyBY49vY+Qiw1QV7TH6V04fAj28Osi8V78Y
 fCYog0VBouW8dlycOVL8Pwou8mFyu9A12msl4+0J8zvrYKYL+GjXYJBoVEfGPa9aLRGF9TppX
 6sf5p0egzi9VmSjQSJGSWuFifs1SqYyMcyGCbMkjDmuxQJZaOVIx/pazQV0P0G0SthBp6457Y
 wiJ224Q61nmivMeCG9lCCzz65Ml9pbyY7FttZfzOLDNHWEMh7wPyEgdw6AKtg9Mhof3Iy/H6P
 KzIhWAntKbOTRsBHaMKyRdArNkjYubNKXKban4T3iuHh7uhrCaN9t846niSg1xci3IeLHNm
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 10:12:20
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
> This patch implements functionality of following ioctls:
> 
> BTRFS_IOC_INO_LOOKUP - Reading tree root id and path
> 
>     Read tree root id and path for a given file or directory.
>     The name and tree root id are returned in an ioctl's third
>     argument that represents a pointer to a following type:
> 
>     struct btrfs_ioctl_ino_lookup_args {
> 	__u64 treeid;
> 	__u64 objectid;
> 	char name[BTRFS_INO_LOOKUP_PATH_MAX];
>     };
> 
>     Before calling this ioctl, field 'objectid' should be filled
>     with the object id value for which the tree id and path are
>     to be read. Value 'BTRFS_FIRST_FREE_OBJECTID' represents the
>     object id for the first available btrfs object (directory or
>     file).
> 
> BTRFS_IOC_INO_PATHS - Reading paths to all files
> 
>     Read path to all files with a certain inode number. The paths
>     are returned in the ioctl's third argument which represents
>     a pointer to a following type:
> 
>     struct btrfs_ioctl_ino_path_args {
> 	__u64				inum;		/* in */
> 	__u64				size;		/* in */
> 	__u64				reserved[4];
> 	/* struct btrfs_data_container	*fspath;	   out */
> 	__u64				fspath;		/* out */
>      };
> 
>      Before calling this ioctl, the 'inum' and 'size' field should
>      be filled with the aproppriate inode number and size of the
>      directory where file paths should be looked for. For now, the
>      paths are returned in an '__u64' (unsigned long long) value
>      'fspath'.
> 
> BTRFS_IOC_LOGICAL_INO - Reading inode numbers
> 
>      Read inode numbers for files on a certain logical adress. The
>      inode numbers are returned in the ioctl's third argument which
>      represents a pointer to a following type:
> 
>      struct btrfs_ioctl_logical_ino_args {
> 	__u64				logical;	/* in */
> 	__u64				size;		/* in */
> 	__u64				reserved[3];	/* must be 0 for now */
> 	__u64				flags;		/* in, v2 only */
> 	/* struct btrfs_data_container	*inodes;	out   */
> 	__u64				inodes;
>      };
> 
>      Before calling this ioctl, the 'logical' and 'size' field should
>      be filled with the aproppriate logical adress and size of where
>      the inode numbers of files should be looked for. For now, the
>      inode numbers are returned in an '__u64' (unsigned long long)
>      value 'inodes'.
> 
> BTRFS_IOC_LOGICAL_INO_V2 - Reading inode numbers
> 
>      Same as the above mentioned ioctl except that it allows passing
>      a flags 'BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET'.
> 
> BTRFS_IOC_INO_LOOKUP_USER - Reading subvolume name and path
> 
>      Read name and path of a subvolume. The tree root id and
>      path are read in an ioctl's third argument which represents a
>      pointer to a following type:
> 
>      struct btrfs_ioctl_ino_lookup_user_args {
> 	/* in, inode number containing the subvolume of 'subvolid' */
> 	__u64 dirid;
> 	/* in */
> 	__u64 treeid;
> 	/* out, name of the subvolume of 'treeid' */
> 	char name[BTRFS_VOL_NAME_MAX + 1];
> 	/*
> 	 * out, constructed path from the directory with which the ioctl is
> 	 * called to dirid
> 	 */
> 	char path[BTRFS_INO_LOOKUP_USER_PATH_MAX];
>      };
> 
>      Before calling this ioctl, the 'dirid' and 'treeid' field should
>      be filled with aproppriate values which represent the inode number
>      of the directory that contains the subvolume and treeid of the
>      subvolume.
> 
> Implementation notes:
> 
>      All of the ioctls in this patch use structure types as third arguments.
>      That is the reason why aproppriate thunk definitions were added in file
>      'syscall_types.h'.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/ioctls.h        | 20 ++++++++++++++++++++
>  linux-user/syscall_defs.h  |  5 +++++
>  linux-user/syscall_types.h | 24 ++++++++++++++++++++++++
>  3 files changed, 49 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index c6303a0406..a7f5664487 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -202,6 +202,10 @@
>       IOCTL(BTRFS_IOC_SNAP_DESTROY, IOC_W,
>             MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
>  #endif
> +#ifdef BTRFS_IOC_INO_LOOKUP
> +     IOCTL(BTRFS_IOC_INO_LOOKUP, IOC_RW,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_ino_lookup_args)))
> +#endif
>  #ifdef BTRFS_IOC_SUBVOL_GETFLAGS
>       IOCTL(BTRFS_IOC_SUBVOL_GETFLAGS, IOC_R, MK_PTR(TYPE_ULONGLONG))
>  #endif
> @@ -212,6 +216,14 @@
>       IOCTL(BTRFS_IOC_DEV_INFO, IOC_RW,
>             MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_dev_info_args)))
>  #endif
> +#ifdef BTRFS_IOC_INO_PATHS
> +     IOCTL(BTRFS_IOC_INO_PATHS, IOC_RW,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_ino_path_args)))
> +#endif
> +#ifdef BTRFS_IOC_LOGICAL_INO
> +     IOCTL(BTRFS_IOC_LOGICAL_INO, IOC_RW,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_logical_ino_args)))
> +#endif
>  #ifdef BTRFS_IOC_GET_DEV_STATS
>       IOCTL(BTRFS_IOC_GET_DEV_STATS, IOC_RW,
>             MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_dev_stats)))
> @@ -228,10 +240,18 @@
>       IOCTL(BTRFS_IOC_GET_SUPPORTED_FEATURES, IOC_R,
>             MK_PTR(MK_ARRAY(MK_STRUCT(STRUCT_btrfs_ioctl_feature_flags), 3)))
>  #endif
> +#ifdef BTRFS_IOC_LOGICAL_INO_V2
> +     IOCTL(BTRFS_IOC_LOGICAL_INO_V2, IOC_RW,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_logical_ino_args)))
> +#endif
>  #ifdef BTRFS_IOC_GET_SUBVOL_INFO
>       IOCTL(BTRFS_IOC_GET_SUBVOL_INFO, IOC_R,
>             MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_subvol_info_args)))
>  #endif
> +#ifdef BTRFS_IOC_INO_LOOKUP_USER
> +     IOCTL(BTRFS_IOC_INO_LOOKUP_USER, IOC_RW,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_ino_lookup_user_args)))
> +#endif
>  
>  #ifdef CONFIG_USBFS
>    /* USB ioctls */
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 13a444356b..538b884b8f 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -975,16 +975,21 @@ struct target_rtc_pll_info {
>  #define TARGET_BTRFS_IOC_RM_DEV                 TARGET_IOWU(BTRFS_IOCTL_MAGIC, 11)
>  #define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 14)
>  #define TARGET_BTRFS_IOC_SNAP_DESTROY           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 15)
> +#define TARGET_BTRFS_IOC_INO_LOOKUP             TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 18)
>  #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, 25,\
>                                                             abi_ullong)
>  #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
>                                                             abi_ullong)
>  #define TARGET_BTRFS_IOC_DEV_INFO               TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 30)
> +#define TARGET_BTRFS_IOC_INO_PATHS              TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 35)
> +#define TARGET_BTRFS_IOC_LOGICAL_INO            TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 36)
>  #define TARGET_BTRFS_IOC_GET_DEV_STATS          TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 52)
>  #define TARGET_BTRFS_IOC_GET_FEATURES           TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
>  #define TARGET_BTRFS_IOC_SET_FEATURES           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 57)
>  #define TARGET_BTRFS_IOC_GET_SUPPORTED_FEATURES TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
> +#define TARGET_BTRFS_IOC_LOGICAL_INO_V2         TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 59)
>  #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IORU(BTRFS_IOCTL_MAGIC, 60)
> +#define TARGET_BTRFS_IOC_INO_LOOKUP_USER        TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 62)
>  
>  /* usb ioctls */
>  #define TARGET_USBDEVFS_CONTROL TARGET_IOWRU('U', 0)
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index e26ab01e8f..978f2d682c 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -349,6 +349,30 @@ STRUCT(btrfs_ioctl_get_subvol_info_args,
>         MK_STRUCT(STRUCT_btrfs_ioctl_timespec), /* rtime */
>         MK_ARRAY(TYPE_ULONGLONG, 8)) /* reserved */
>  
> +STRUCT(btrfs_ioctl_ino_lookup_args,
> +       TYPE_ULONGLONG, /* treeid */
> +       TYPE_ULONGLONG, /* objectid */
> +       MK_ARRAY(TYPE_CHAR, BTRFS_INO_LOOKUP_PATH_MAX)) /* name */
> +
> +STRUCT(btrfs_ioctl_ino_path_args,
> +       TYPE_ULONGLONG, /* inum */
> +       TYPE_ULONGLONG, /* size */
> +       MK_ARRAY(TYPE_ULONGLONG, 4), /* reserved */
> +       TYPE_ULONGLONG) /* fspath */
> +
> +STRUCT(btrfs_ioctl_logical_ino_args,
> +       TYPE_ULONGLONG, /* logical */
> +       TYPE_ULONGLONG, /* size */
> +       MK_ARRAY(TYPE_ULONGLONG, 3), /* reserved */
> +       TYPE_ULONGLONG, /* flags */
> +       TYPE_ULONGLONG) /* inodes */
> +
> +STRUCT(btrfs_ioctl_ino_lookup_user_args,
> +       TYPE_ULONGLONG, /* dirid */
> +       TYPE_ULONGLONG, /* treeid */
> +       MK_ARRAY(TYPE_CHAR, BTRFS_VOL_NAME_MAX + 1), /* name */
> +       MK_ARRAY(TYPE_CHAR, BTRFS_INO_LOOKUP_USER_PATH_MAX)) /* path */
> +
>  STRUCT(btrfs_ioctl_dev_info_args,
>         TYPE_ULONGLONG, /* devid */
>         MK_ARRAY(TYPE_CHAR, BTRFS_UUID_SIZE), /* uuid */
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

