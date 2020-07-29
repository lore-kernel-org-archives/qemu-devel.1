Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733E0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E0320FC3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E0320FC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0onI-0001rH-Gy
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 12:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k0omk-0001QJ-6h
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:18:30 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k0omi-0003EU-2w
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:18:29 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MS3zP-1kC8Vv0rhj-00TSFP; Wed, 29 Jul 2020 18:18:24 +0200
Subject: Re: [PATCH v2 1/4] linux-user: Add support for a group of btrfs inode
 ioctls
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200717144435.268166-1-Filip.Bozuta@syrmia.com>
 <20200717144435.268166-2-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <86b2596c-2afa-a4a3-ad5e-2d030727b542@vivier.eu>
Date: Wed, 29 Jul 2020 18:18:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717144435.268166-2-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SGa2Hw8Z+sLq3ao52qzjxYOnIYIADC8YJC+/fMohqCggWVNETXz
 OY4yIAZlzJepCQ0+e+AdUZu3Vz0R/aOctOa0pKSjN91seX1sRSHzO0PeKgMUZQUhg0hiJgn
 frhQ8B17aA1oCQv32G4ikqg1nzxXRC0YptWUBR8yzYBN22DBPpfwCAIqcT42BtUcK3szAB0
 n2TE+pXTahQkV8zhv3hpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XxTTGWJmmtE=:LXP3z4SQOt9WNS/rzlDOz3
 m3HtPMgewVcn2VzQ093wXuJUraBV1WVzSeoLjFCxduiBWpwh1lPbV5xpC1qTDMlcuJFV/gQL7
 0AP9zgzTh+5QU0wYl3fHabSXKB6LejGVCxgUDpkrrpdVzTiDQ82B6jzZ446vYB6u7yvtSOQSX
 iOTzCuLcVotZYP5zqwZ36gbJS9WIF+Onz9/Ii7oUC9MIgxgNwCYbLNOPDD01IFRULZ0ohYSFh
 dSTRG8dIbTUPHR02NmLC5zfXmXU8E+uqyZaERIZ8oXv9TLMsyzdytoxp1w1o8M424yZjHF7LU
 LPjFFS32qdKQQ7A12khXvmKDKYVf0wIY35Yhz1jIQtKHeo92QKI9pyLpjzzXchwtD6mlOKAk0
 B7afiM90ZeVSEhjbmpcykEpe715RqYMVwaN/u/aguKlvaOcss+esB2d30a1tueRxzfFet4dMN
 dFhMCCQ9ORBNsyqG8dxFR3XxQQK19VakNA9MDVqKbwb/lucfxnhn5qQLCfIF5I7I8Yww3aX1h
 EJi21cppXEDhFLXCZw/ijscSgqX3uL1+OOg1CWq+DLC1X45RPhh0ccds90gvbTsxLmE/IuPFt
 ZNqZUFXnom27IxYbDzg2BKvEUjcrFuLFGbawZ8XEw1FU11U50MqnUjWy7cRbSAbaWORbp7WiG
 NZ6Jdc1kCIkp2CKDSvxJ19RsQqZdw/KBsOJeX//Ms9qSF3Cd+yprDj38VmsCYO+zzY7TBIzmH
 czXIZrBfbeHYBvbSoIaLKsla5TXwleIjBA1mqHK/G07yHrw5HWGYhtAtjYDKs9yRt2PayFbQM
 6kQc4ov8iVkPoQZfrWuzZDspn1GyllZ+YODrwGl1lrsMf2kIm59xO9y6k5CeFlii0Ar7RIe
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 12:18:26
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
Cc: riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 17/07/2020 à 16:44, Filip Bozuta a écrit :
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
>  linux-user/syscall_defs.h  | 10 ++++++++++
>  linux-user/syscall_types.h | 24 ++++++++++++++++++++++++
>  3 files changed, 54 insertions(+)
> 
...

> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 9db6f46cba..7bb105428b 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -982,12 +982,18 @@ struct target_rtc_pll_info {
>                                                 14, struct btrfs_ioctl_vol_args)
>  #define TARGET_BTRFS_IOC_SNAP_DESTROY           TARGET_IOW(BTRFS_IOCTL_MAGIC, \
>                                                 15, struct btrfs_ioctl_vol_args)
> +#define TARGET_BTRFS_IOC_INO_LOOKUP             TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
> +                                        18, struct btrfs_ioctl_ino_lookup_args)
>  #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, \
>                                                             25, abi_ullong)
>  #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, \
>                                                             26, abi_ullong)
>  #define TARGET_BTRFS_IOC_DEV_INFO               TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
>                                            30, struct btrfs_ioctl_dev_info_args)
> +#define TARGET_BTRFS_IOC_INO_PATHS              TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
> +                                          35, struct btrfs_ioctl_ino_path_args)
> +#define TARGET_BTRFS_IOC_LOGICAL_INO            TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
> +                                       36, struct btrfs_ioctl_logical_ino_args)
>  #define TARGET_BTRFS_IOC_GET_DEV_STATS          TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
>                                            52, struct btrfs_ioctl_get_dev_stats)
>  #define TARGET_BTRFS_IOC_GET_FEATURES           TARGET_IOR(BTRFS_IOCTL_MAGIC, \
> @@ -996,8 +1002,12 @@ struct target_rtc_pll_info {
>                                         57, struct btrfs_ioctl_feature_flags[2])
>  #define TARGET_BTRFS_IOC_GET_SUPPORTED_FEATURES TARGET_IOR(BTRFS_IOCTL_MAGIC, \
>                                         57, struct btrfs_ioctl_feature_flags[3])
> +#define TARGET_BTRFS_IOC_LOGICAL_INO_V2         TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
> +                                       59, struct btrfs_ioctl_logical_ino_args)
>  #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IOR(BTRFS_IOCTL_MAGIC, \
>                                     60, struct btrfs_ioctl_get_subvol_info_args)
> +#define TARGET_BTRFS_IOC_INO_LOOKUP_USER        TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
> +                                   62, struct btrfs_ioctl_ino_lookup_user_args)

Use the 'U' variant.

>  
>  /* usb ioctls */
>  #define TARGET_USBDEVFS_CONTROL TARGET_IOWRU('U', 0)
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index e26ab01e8f..980c29000a 100644
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
> +       TYPE_ULONGLONG, /* reserved */

This is reserved[4], use MK_ARRAY() here

> +       TYPE_ULONGLONG) /* fspath */
> +
> +STRUCT(btrfs_ioctl_logical_ino_args,
> +       TYPE_ULONGLONG, /* logical */
> +       TYPE_ULONGLONG, /* size */
> +       TYPE_ULONGLONG, /* reserved */

reserved[3]

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

Thanks,
Laurent

