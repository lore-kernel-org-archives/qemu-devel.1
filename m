Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC1FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 17:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E77204EA
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 17:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E77204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k46MI-0001ZH-My
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 13:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k46HA-0003C3-BX
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 13:35:28 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:57731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k46H8-00012u-28
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 13:35:28 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MfYDO-1kfLpc49Iu-00fxwA; Fri, 07 Aug 2020 19:35:17 +0200
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200803094629.21898-1-Filip.Bozuta@syrmia.com>
 <20200803094629.21898-9-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2 8/8] linux-user: Add support for btrfs ioctls used to
 scrub a filesystem
Message-ID: <512991ca-0ad1-71cf-cd21-2066802d80d2@vivier.eu>
Date: Fri, 7 Aug 2020 19:35:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803094629.21898-9-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pdXloEgv0FVVa9Kt/TRel3xFAnm1y2+q9uxggBewRwfoJRdQJRp
 NY5NOzceY/VvCPds26qJb7AgRTQsxhJdKH1hhVftnKd5q8/cqO+ZucDgvpN6OnEYHB/gAbr
 lc17tUzKhW/jzgtqkuqOR7WefL/UgNu69gIMNwCwA2Bc84UT4zpzOF6hTMFE2NVnBk7KD9w
 C99uJlIwPdxHu4WMzuk+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UwwBKWdAdSE=:HLwJTostVwrknDnSfy0WKC
 +Ozzf3EtupsipjO8svcTibrmskDZn4U3cqMKJokPsFOZ49CPLR2DZ9N8fntE9VRSgn4t1vknx
 TOkrYwpXq0j35YQrH/mmzqI+MXvRnnMFiipgi1U1YywJVXWXyf0o/N0hWDBuT5EX1XOW9lorZ
 NBN26/DNHIjiM7B5Gx1N35mUU3hyiBxvXNg1zI4nl7HF9yMMuZFF6LjG0DOC62bFzefMxMDEl
 r2tMy2pUIqcCTQblPD97xLtI3NA7RYpKf+vC1zLddHPzgErZqDkyBtOQFc6eePPgTa/qdHM1r
 Zmh+lI5LqKoi47trqBMXi+WPeNoix8nXFsiZYQXBTxSr7OkEikycELlelHY5SwYvXE5yrkMjH
 0WGTKb4rT4EocqTus8HVPr6qEEvVsjavNxWLi2ZVpztDFN5Zx+yZ0P8pNnqnCfmQfwPwnqPJf
 fbCl/8H4bNT3Qjdk5skveETm8FSY4x46+R0qExevn36lOahatHFQZVtqw7xZfgkfTXoFAIiXb
 CUdMYPO9CM8tWfBk+7RWFMRyiJ2msl7Vd5dM/37N+0JT6VDcOuH7wn4MWeZWihAm3wn3x36pU
 XEffPMHRD9BwFr4tHfENO3Np8X23O1DJ1vLBv9pre7NR75FIOxF1t1ue9MPJInLfe/l3Ag+UZ
 cLx7XKuJkuK2ot7WQO4HjCTgcL/q8RV9f+mrvCw2NqcJNz/wV9T0vFlZAyYiLtXrlVptTEjO9
 PsGG2U13MTLA52RiuPuMJb0LTpT+PNRL6ytrj4b9TUAuFtQNAX88NGcRIlpYtjPn5aiBO/zyo
 huNCzEMq9pvpb91zrMhYqiH7OuYHg6Idw/Pzn4gpAV5E2BfP6zJDqVXJHmj5mxby7XMxDgB
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 13:35:23
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

Le 03/08/2020 à 11:46, Filip Bozuta a écrit :
> This patch implements functionality for following ioctls:
> 
> BTRFS_IOC_SCRUB - Starting a btrfs filesystem scrub
> 
>     Start a btrfs filesystem scrub. The third ioctls argument
>     is a pointer to a following type:
> 
>     struct btrfs_ioctl_scrub_args {
> 	__u64 devid;				/* in */
> 	__u64 start;				/* in */
> 	__u64 end;				/* in */
> 	__u64 flags;				/* in */
> 	struct btrfs_scrub_progress progress;	/* out */
> 	/* pad to 1k */
> 	__u64 unused[(1024-32-sizeof(struct btrfs_scrub_progress))/8];
>     };
> 
>     Before calling this ioctl, field 'devid' should be filled
>     with value that represents the device id of the btrfs filesystem
>     for which the scrub is to be started.
> 
> BTRFS_IOC_SCRUB_CANCEL - Canceling scrub of a btrfs filesystem
> 
>     Cancel a btrfs filesystem scrub if it is running. The third
>     ioctls argument is ignored.
> 
> BTRFS_IOC_SCRUB_PROGRESS - Getting status of a running scrub
> 
>     Read the status of a running btrfs filesystem scrub. The third
>     ioctls argument is a pointer to the above mentioned
>     'struct btrfs_ioctl_scrub_args'. Similarly as with 'BTRFS_IOC_SCRUB',
>     the 'devid' field should be filled with value that represents the
>     id of the btrfs device for which the scrub has started. The status
>     of a running scrub is returned in the field 'progress' which is
>     of type 'struct btrfs_scrub_progress' and its definition can be
>     found at:
>     https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/btrfs.h#L150
> 
> Implementation nots:
> 
>     Ioctls in this patch use type 'struct btrfs_ioctl_scrub_args' as their
>     third argument. That is the reason why an aproppriate thunk type
>     definition is added in file 'syscall_types.h'.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/ioctls.h        | 11 +++++++++++
>  linux-user/syscall_defs.h  |  3 +++
>  linux-user/syscall_types.h | 27 +++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 8665f504bf..bf80615438 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -215,6 +215,17 @@
>  #ifdef BTRFS_IOC_SUBVOL_SETFLAGS
>       IOCTL(BTRFS_IOC_SUBVOL_SETFLAGS, IOC_W, MK_PTR(TYPE_ULONGLONG))
>  #endif
> +#ifdef BTRFS_IOC_SCRUB
> +     IOCTL(BTRFS_IOC_SCRUB, IOC_RW,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_scrub_args)))
> +#endif
> +#ifdef BTRFS_IOC_SCRUB_CANCEL
> +     IOCTL(BTRFS_IOC_SCRUB_CANCEL, 0, TYPE_NULL)
> +#endif
> +#ifdef BTRFS_IOC_SCRUB_PROGRESS
> +     IOCTL(BTRFS_IOC_SCRUB_PROGRESS, IOC_RW,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_scrub_args)))
> +#endif
>  #ifdef BTRFS_IOC_DEV_INFO
>       IOCTL(BTRFS_IOC_DEV_INFO, IOC_RW,
>             MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_dev_info_args)))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 1b1b2c2d96..83c291f2d3 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -982,6 +982,9 @@ struct target_rtc_pll_info {
>                                                             abi_ullong)
>  #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
>                                                             abi_ullong)
> +#define TARGET_BTRFS_IOC_SCRUB                  TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 27)
> +#define TARGET_BTRFS_IOC_SCRUB_CANCEL           TARGET_IO(BTRFS_IOCTL_MAGIC, 28)
> +#define TARGET_BTRFS_IOC_SCRUB_PROGRESS         TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 29)
>  #define TARGET_BTRFS_IOC_DEV_INFO               TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 30)
>  #define TARGET_BTRFS_IOC_INO_PATHS              TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 35)
>  #define TARGET_BTRFS_IOC_LOGICAL_INO            TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 36)
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index 2f5bad808e..fd6a91a309 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -373,6 +373,33 @@ STRUCT(btrfs_ioctl_ino_lookup_user_args,
>         MK_ARRAY(TYPE_CHAR, BTRFS_VOL_NAME_MAX + 1), /* name */
>         MK_ARRAY(TYPE_CHAR, BTRFS_INO_LOOKUP_USER_PATH_MAX)) /* path */
>  
> +STRUCT(btrfs_scrub_progress,
> +       TYPE_ULONGLONG, /* data_extents_scrubbed */
> +       TYPE_ULONGLONG, /* tree_extents_scrubbed */
> +       TYPE_ULONGLONG, /* data_bytes_scrubbed */
> +       TYPE_ULONGLONG, /* tree_bytes_scrubbed */
> +       TYPE_ULONGLONG, /* read_errors */
> +       TYPE_ULONGLONG, /* csum_errors */
> +       TYPE_ULONGLONG, /* verify_errors */
> +       TYPE_ULONGLONG, /* no_csum */
> +       TYPE_ULONGLONG, /* csum_discards */
> +       TYPE_ULONGLONG, /* super_errors */
> +       TYPE_ULONGLONG, /* malloc_errors */
> +       TYPE_ULONGLONG, /* uncorrectable_errors */
> +       TYPE_ULONGLONG, /* corrected_er */
> +       TYPE_ULONGLONG, /* last_physical */
> +       TYPE_ULONGLONG) /* unverified_errors */
> +
> +STRUCT(btrfs_ioctl_scrub_args,
> +       TYPE_ULONGLONG, /* devid */
> +       TYPE_ULONGLONG, /* start */
> +       TYPE_ULONGLONG, /* end */
> +       TYPE_ULONGLONG, /* flags */
> +       MK_STRUCT(STRUCT_btrfs_scrub_progress), /* progress */
> +       MK_ARRAY(TYPE_ULONGLONG,
> +                (1024 - 32 -
> +                 sizeof(struct btrfs_scrub_progress)) / 8)) /* unused */
> +
>  STRUCT(btrfs_ioctl_dev_info_args,
>         TYPE_ULONGLONG, /* devid */
>         MK_ARRAY(TYPE_CHAR, BTRFS_UUID_SIZE), /* uuid */
> 

Applied to my linux-user-for-5.2 branch.

Thanks,
Laurent


