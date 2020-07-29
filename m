Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151D4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C7E207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C7E207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0oKI-0004kJ-Un
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 11:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k0oJC-0003rv-99
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 11:47:58 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k0oJA-00072N-3H
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 11:47:57 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MScHp-1kBd9P2DY9-00Sxam; Wed, 29 Jul 2020 17:47:46 +0200
Subject: Re: [PATCH 1/4] linux-user: Add support for a group of btrfs ioctls
 used for subvolumes
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200709155203.21106-1-Filip.Bozuta@syrmia.com>
 <20200709155203.21106-2-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e3e51721-9164-0055-17bb-aba1142dc9b0@vivier.eu>
Date: Wed, 29 Jul 2020 17:47:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709155203.21106-2-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WRp/FLJqG9x3E755s+kYouZQ5ykrJzQhviDpPZkdvecDiBSgMwZ
 FQ6rA6eDD8yZiXqR9anhpDY5jb+8tphnELJ+2b62sShXhA95KkN89rnwt9v+H/B51NHUsei
 jFr91qNZdpwYSdHKhqsIzPMgLtSGIhd30gAhiWm2bLK1HwSNTtLdvuSix6uIA6Fte5hHg3h
 6v4zVfqZ7OHQeSClD3aJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C/dY722FlnI=:FJZab7yiXeGPVSRRR1QTub
 zFwNQw+GXmkJepxTOTvLTr3/3qLID66cvIBmhMWCdccvcWdmu6DqkTr40OApN7/4jETnPN/js
 aisKLxNOx4pgu6kBBo+4QzNrULVQR6oB0ovopFfNuh9Zf5j8FHG3KIA2N3XKI13JP0IotdxDI
 +81jVQEj6Dk7r/qjM5b2OI9JSYJgfi+eKQqIHTPuet0URsH+CJ/UGVNLKdk1xRJfGMnhup9Ga
 ndylIy4YS6IV9AQXIYFDQuHJk8HgX4lMYzLSUMYpgsxrFReXdtwoir4jKUzcgD1seH/8yyPie
 3wBqmw/Z5npxueWu51kxPt6vr+DWru0YQ1wOw2SsZrIGGYSrOHsU/JNKShu2A/ZVJkaNSB8QP
 HdzuzfN4G9OwXiLdoj/TTK6luSfg3HPpO6xs9WHD3zRuRd0zAikfjPmWTTgo+yFpemRs/jflk
 YHygVcamKhHNVmgzpXc5jRc1IYwzUaGjF3Jg4cc7en/XtnSF+mIre9ItZzvShBVwVfQEeA1P4
 X6JGtRYlVp5hSuneM3KzqD0SV/QYBV14iC9xqYRo2hXn5FUgvUdkPWa8mvXcqtmwjQJl9/00S
 styzURVuv8B0WhSj+vM4SpnZDZWxWeROMFxzyBKGOKA9EiZ8sl2BF7vDM0EErNUYs7rvc3jmS
 6tAyAJSnltgCX7PBctHSvbBWMwHVdzsxZx7WxUNTOF2qxGa19kqvWupsXvFMfAaYBXreqmDtN
 m6Ax1rWr4lBBuiQChyGJt6dCTa50FBY9oVivPoaT2peMHgzkWeY6tehvxhr+jeQYTmZYgq824
 SBnN+47V5OEsDwMx6pMxmfGHrwO/ZwQbIWwMYDvhJ2SUxLg23dV3kEQbAPAeDaiY8UFNx0V
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 11:47:48
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

Le 09/07/2020 à 17:52, Filip Bozuta a écrit :
> This patch implements functionality of following ioctls:
> 
> BTRFS_IOC_SUBVOL_CREATE - Creating a btrfs subvolume
> 
>     Create a btrfs subvolume. The subvolume is created using the ioctl's
>     third argument which represents a pointer to a following structure
>     type:
> 
>     struct btrfs_ioctl_vol_args {
> 	__s64 fd;
> 	char name[BTRFS_PATH_NAME_MAX + 1];
>     };
> 
>     Before calling this ioctl, the fields of this structure should be filled
>     with aproppriate values. The fd field represents the file descriptor
>     value of the subvolume and the name field represents the subvolume
>     path.
> 
> BTRFS_IOC_SUBVOL_GETFLAGS - Getting subvolume flags
> 
>     Read the flags of the btrfs subvolume. The flags are read using
>     the ioctl's third argument that is a pointer of __u64 (unsigned long).
>     The third argument represents a bit mask that can be composed of following
>     values:
>     BTRFS_SUBVOL_RDONLY           (1ULL << 1)
>     BTRFS_SUBVOL_QGROUP_INHERIT   (1ULL << 2)
>     BTRFS_DEVICE_SPEC_BY_ID       (1ULL << 3)
>     BTRFS_SUBVOL_SPEC_BY_ID       (1ULL << 4)
> 
> BTRFS_IOC_SUBVOL_SETFLAGS - Setting subvolume flags
> 
>     Set the flags of the btrfs subvolume. The flags are set using the
>     ioctl's third argument that is a pointer of __u64 (unsigned long).
>     The third argument represents a bit mask that can be composed of same
>     values as in the case of previous ioctl (BTRFS_IOC_SUBVOL_GETFLAGS).
> 
> BTRFS_IOC_SUBVOL_GETINFO - Getting subvolume information
> 
>     Read information about the subvolume. The subvolume information is
>     returned in the ioctl's third argument which represents a pointer to
>     a following structure type:
> 
>     struct btrfs_ioctl_get_subvol_info_args {
> 	/* Id of this subvolume */
> 	__u64 treeid;
> 
> 	/* Name of this subvolume, used to get the real name at mount point */
> 	char name[BTRFS_VOL_NAME_MAX + 1];
> 
> 	/*
> 	 * Id of the subvolume which contains this subvolume.
> 	 * Zero for top-level subvolume or a deleted subvolume.
> 	 */
> 	__u64 parent_id;
> 
> 	/*
> 	 * Inode number of the directory which contains this subvolume.
> 	 * Zero for top-level subvolume or a deleted subvolume
> 	 */
> 	__u64 dirid;
> 
> 	/* Latest transaction id of this subvolume */
> 	__u64 generation;
> 
> 	/* Flags of this subvolume */
> 	__u64 flags;
> 
> 	/* UUID of this subvolume */
> 	__u8 uuid[BTRFS_UUID_SIZE];
> 
> 	/*
> 	 * UUID of the subvolume of which this subvolume is a snapshot.
> 	 * All zero for a non-snapshot subvolume.
> 	 */
> 	__u8 parent_uuid[BTRFS_UUID_SIZE];
> 
> 	/*
> 	 * UUID of the subvolume from which this subvolume was received.
> 	 * All zero for non-received subvolume.
> 	 */
> 	__u8 received_uuid[BTRFS_UUID_SIZE];
> 
> 	/* Transaction id indicating when change/create/send/receive happened */
> 	__u64 ctransid;
> 	__u64 otransid;
> 	__u64 stransid;
> 	__u64 rtransid;
> 	/* Time corresponding to c/o/s/rtransid */
> 	struct btrfs_ioctl_timespec ctime;
> 	struct btrfs_ioctl_timespec otime;
> 	struct btrfs_ioctl_timespec stime;
> 	struct btrfs_ioctl_timespec rtime;
> 
> 	/* Must be zero */
> 	__u64 reserved[8];
>      };
> 
>      All of the fields of this structure are filled after the ioctl call.
> 
> Implementation notes:
> 
>     Ioctls BTRFS_IOC_SUBVOL_CREATE and BTRFS_IOC_SUBVOL_GETINFO have structure
>     types as third arguments. That is the reason why a corresponding definition
>     are added in file 'linux-user/syscall_types.h'.
> 
>     The line '#include <linux/btrfs.h>' is added in file 'linux-user/syscall.c' to
>     recognise preprocessor definitions for these ioctls. Since the file "linux/btrfs.h"
>     was added in the kernel version 3.9, it is enwrapped in an #ifdef statement
>     with parameter CONFIG_BTRFS which is defined in 'configure' if the
>     header file is present.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  configure                  |  9 +++++++++
>  linux-user/ioctls.h        | 15 +++++++++++++++
>  linux-user/syscall.c       |  3 +++
>  linux-user/syscall_defs.h  | 10 ++++++++++
>  linux-user/syscall_types.h | 28 ++++++++++++++++++++++++++++
>  5 files changed, 65 insertions(+)
> 
> diff --git a/configure b/configure
> index b969dee675..8b3b214031 100755
> --- a/configure
> +++ b/configure
> @@ -4945,6 +4945,12 @@ if check_include sys/kcov.h ; then
>      kcov=yes
>  fi
>  
> +# check for btrfs filesystem support (kernel must be 3.9+)
> +btrfs=no
> +if check_include linux/btrfs.h ; then
> +    btrfs=yes
> +fi
> +
>  # If we're making warnings fatal, apply this to Sphinx runs as well
>  sphinx_werror=""
>  if test "$werror" = "yes"; then
> @@ -7057,6 +7063,9 @@ fi
>  if test "$kcov" = "yes" ; then
>    echo "CONFIG_KCOV=y" >> $config_host_mak
>  fi
> +if test "$btrfs" = "yes" ; then
> +  echo "CONFIG_BTRFS=y" >> $config_host_mak
> +fi
>  if test "$inotify" = "yes" ; then
>    echo "CONFIG_INOTIFY=y" >> $config_host_mak
>  fi
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 0defa1d8c1..544184ff95 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -174,6 +174,21 @@
>       IOCTL(FS_IOC32_GETVERSION, IOC_R, MK_PTR(TYPE_INT))
>       IOCTL(FS_IOC32_SETVERSION, IOC_W, MK_PTR(TYPE_INT))
>  
> +#ifdef BTRFS_IOC_SUBVOL_CREATE
> +     IOCTL(BTRFS_IOC_SUBVOL_CREATE, IOC_W,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
> +#endif
> +#ifdef BTRFS_IOC_SUBVOL_GETFLAGS
> +     IOCTL(BTRFS_IOC_SUBVOL_GETFLAGS, IOC_R, MK_PTR(TYPE_ULONGLONG))
> +#endif
> +#ifdef BTRFS_IOC_SUBVOL_SETFLAGS
> +     IOCTL(BTRFS_IOC_SUBVOL_SETFLAGS, IOC_W, MK_PTR(TYPE_ULONGLONG))
> +#endif
> +#ifdef BTRFS_IOC_GET_SUBVOL_INFO
> +     IOCTL(BTRFS_IOC_GET_SUBVOL_INFO, IOC_R,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_subvol_info_args)))
> +#endif
> +
>  #ifdef CONFIG_USBFS
>    /* USB ioctls */
>    IOCTL(USBDEVFS_CONTROL, IOC_RW,
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 05f03919ff..4a65b28999 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -112,6 +112,9 @@
>  #include <linux/if_alg.h>
>  #include <linux/rtc.h>
>  #include <sound/asound.h>
> +#ifdef CONFIG_BTRFS
> +#include <linux/btrfs.h>
> +#endif
>  #include "linux_loop.h"
>  #include "uname.h"
>  
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 152ec637cb..c11bcc6ba9 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -967,6 +967,16 @@ struct target_rtc_pll_info {
>  #define TARGET_FS_IOC32_GETVERSION TARGET_IOR('v', 1, int)
>  #define TARGET_FS_IOC32_SETVERSION TARGET_IOW('v', 2, int)
>  
> +/* btrfs ioctls */
> +#define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOW(BTRFS_IOCTL_MAGIC, \
> +                                               14, struct btrfs_ioctl_vol_args)
> +#define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, \
> +                                                           25, abi_ullong)
> +#define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, \
> +                                                           26, abi_ullong)
> +#define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IOR(BTRFS_IOCTL_MAGIC, \
> +                                   60, struct btrfs_ioctl_get_subvol_info_args)

I think you should use TARGET_IOWU() and TARGET_IORU() that compute the
size of the structure according to the STRUCT_ definitions rather than
to the host structure definition.

With that changed:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent


