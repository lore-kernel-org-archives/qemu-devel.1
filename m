Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6C9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 17:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6EE204EA
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 17:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6EE204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k46Kt-0000Se-9E
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 13:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k46H8-00039G-Vk
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 13:35:27 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k46H6-00012q-9N
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 13:35:26 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Md6ZB-1kdRDt0Trv-00aAME; Fri, 07 Aug 2020 19:35:14 +0200
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200803094629.21898-1-Filip.Bozuta@syrmia.com>
 <20200803094629.21898-8-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2 7/8] linux-user: Add support for btrfs ioctls used to
 manage quota
Message-ID: <366903f1-1e40-a8f9-8a27-f4bab9b0ff18@vivier.eu>
Date: Fri, 7 Aug 2020 19:35:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803094629.21898-8-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0pYOPloxyRlnoo87TIgnUOk+h1F+cqJclH2HzZ1EWRUoa+d+FcX
 Xpg4TzT7R9Oexze/HUCXs4WCQ/7PD81J+Nl6yR9+WV/CHcQqWL6P+cnFIa7Yu1f0JZVssXb
 ZR3rckrWSRurj6wNeP3iLacvIRQ3RNUfWWaUNv2lNJC3+ryuNGvDHm0wk86kZkVpvVZ4tkj
 cn5tURD5vPeuQSBgJPm0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UEeCWqYVHPM=:lreMlz2BOPGDeyFNimF5ub
 +BvcO6lPbqHXlecwvImvoJZtmLFcT5mBk14jkSPIPKaLCIaGQcL0WkhpPxzOPDPoXNO46FG8O
 qa+4d9o5zGdf7dCGp9gFG+aXGnQs40JAPVRcHNWQ2iUFqXWl9uWq76Tkx+yvENsPQup3euWHy
 KI+dmm7BovvjTQfjS+h9P0XAJc44NzdAhqQN3ZO7Hr0R6nAJIgG6G5g/YlFRbZB88Lb7mmBUA
 SuUKQla6atFW2vQ4ZEKmw76DlErIpEmhEHQnO6HXx0MqaXfarRC8U1pRRJp9VXVLA9+rfBQWZ
 5KYl0KD5/mcz6fXhpkIbHd9NmYs+rLRisxNdUZjkCEZT5OMVXsFsU7rS9GBv1KmV2OYwC3YIM
 X2M+Xwo3gscSTXlw2L6qbhI5uh4qx0xqe5BVuOQ1/qpC7iu3Y4rCC8vwO/bKBfHNCAlzdP28k
 XSrH74s0M2dvzgywS8r6In5d8fD9jyIIFiMcdWem5t6VwwGFI4GA7vKWRA3Z7FM1tqeTnJ0xF
 AQ0+qmyyzIzHNcUgcWkrofBHYMYQrl0yBvU3DR4jDUTTn0k6nMR0rcnVwHsLzavfzh7bPZ3aQ
 WgkDS9GRx3z1BtPMZDFotGLGgZpkTxjbX+lrguhJd2wnUop6FP2srxfEzHxhoNI/vqFmMb5EP
 2Pa3uuwtMrd2AyIgdB/RrSCwrWROik4VkjxG0cgPgPDi3fPjb57DQrH74vgGqDgIU3nizncu2
 pVP/tFvlhXPCbEOBdIrpyi6vIJ6NgF4bG0T6zNuRjUJuBfjuEk2W+AgQ4ohqCubM+3++xGpAH
 txmWXAp/Su011lXmtaYenkuW7Cydk8ssO24Ilcuqu6mtppYJexDIDbeYloI9Z0lRqrMUOHI
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
> BTRFS_IOC_QUOTA_CTL - Enabling/Disabling quota support
> 
>     Enable or disable quota support for a btrfs filesystem. Quota
>     support is enabled or disabled using the ioctls third argument
>     which represents a pointer to a following type:
> 
>     struct btrfs_ioctl_quota_ctl_args {
> 	__u64 cmd;
> 	__u64 status;
>     };
> 
>     Before calling this ioctl, the 'cmd' field should be filled
>     with one of the values 'BTRFS_QUOTA_CTL_ENABLE' (enabling quota)
>     'BTRFS_QUOTA_CTL_DISABLE' (disabling quota).
> 
> BTRFS_IOC_QGROUP_CREATE - Creating/Removing a subvolume quota group
> 
>     Create or remove a subvolume quota group. The subvolume quota
>     group is created or removed using the ioctl's third argument which
>     represents a pointer to a following type:
> 
>     struct btrfs_ioctl_qgroup_create_args {
> 	__u64 create;
> 	__u64 qgroupid;
>     };
> 
>     Before calling this ioctl, the 'create' field should be filled
>     with the aproppriate value depending on if the user wants to
>     create or remove a quota group (0 for removing, everything else
>     for creating). Also, the 'qgroupid' field should be filled with
>     the value for the quota group id that is to be created.
> 
> BTRFS_IOC_QGROUP_ASSIGN - Asigning or removing a quota group as child group
> 
>     Asign or remove a quota group as child quota group of another
>     group in the btrfs filesystem. The asignment is done using the
>     ioctl's third argument which represents a pointert to a following type:
> 
>     struct btrfs_ioctl_qgroup_assign_args {
> 	__u64 assign;
> 	__u64 src;
> 	__u64 dst;
>     };
> 
>     Before calling this ioctl, the 'assign' field should be filled with
>     the aproppriate value depending on if the user wants to asign or remove
>     a quota group as a child quota group of another group (0 for removing,
>     everythin else for asigning). Also, the 'src' and 'dst' fields should
>     be filled with the aproppriate quota group id values depending on which
>     quota group needs to asigned or removed as child quota group of another
>     group ('src' gets asigned or removed as child group of 'dst').
> 
> BTRFS_IOC_QGROUP_LIMIT - Limiting the size of a quota group
> 
>     Limit the size of a quota group. The size of the quota group is limited
>     with the ioctls third argument which represents a pointer to a following
>     type:
> 
>     struct btrfs_ioctl_qgroup_limit_args {
> 	__u64	qgroupid;
> 	struct btrfs_qgroup_limit lim;
>     };
> 
>     Before calling this ioctl, the 'qgroup' id field should be filled with
>     aproppriate value of the quota group id for which the size is to be
>     limited. The second field is of following type:
> 
>     struct btrfs_qgroup_limit {
> 	__u64	flags;
> 	__u64	max_rfer;
> 	__u64	max_excl;
> 	__u64	rsv_rfer;
> 	__u64	rsv_excl;
>     };
> 
>     The 'max_rfer' field should be filled with the size to which the quota
>     group should be limited. The 'flags' field can be used for passing
>     additional options and can have values which can be found on:
>     https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/btrfs.h#L67
> 
> BTRFS_IOC_QUOTA_RESCAN_STATUS - Checking status of running rescan operation
> 
>     Check status of a running rescan operation. The status is checked using
>     the ioctl's third argument which represents a pointer to a following type:
> 
>     struct btrfs_ioctl_quota_rescan_args {
>         __u64   flags;
>         __u64   progress;
>         __u64   reserved[6];
>     };
> 
>     If there is a rescan operation running, 'flags' field is set to 1, and
>     'progress' field is set to aproppriate value which represents the progress
>     of the operation.
> 
> BTRFS_IOC_QUOTA_RESCAN - Starting a rescan operation
> 
>     Start ar rescan operation to Trash all quota groups and scan the metadata
>     again with the current config. Before calling this ioctl,
>     BTRFS_IOC_QUOTA_RESCAN_STATUS sould be run to check if there is already a
>     rescan operation runing. After that ioctl call, the received
>     'struct btrfs_ioctl_quota_rescan_args' should be than passed as this ioctls
>     third argument.
> 
> BTRFS_IOC_QUOTA_RESCAN_WAIT - Waiting for a rescan operation to finish
> 
>     Wait until a rescan operation is finished (if there is a rescan operation
>     running). The third ioctls argument is ignored.
> 
> Implementation notes:
> 
>     Almost all of the ioctls in this patch use structure types as third arguments.
>     That is the reason why aproppriate thunk definitions were added in file
>     'syscall_types.h'.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/ioctls.h        | 27 +++++++++++++++++++++++++++
>  linux-user/syscall_defs.h  |  7 +++++++
>  linux-user/syscall_types.h | 29 +++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 2c553103e6..8665f504bf 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -227,6 +227,33 @@
>       IOCTL(BTRFS_IOC_LOGICAL_INO, IOC_RW,
>             MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_logical_ino_args)))
>  #endif
> +#ifdef BTRFS_IOC_QUOTA_CTL
> +     IOCTL(BTRFS_IOC_QUOTA_CTL, IOC_RW,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_quota_ctl_args)))
> +#endif
> +#ifdef BTRFS_IOC_QGROUP_ASSIGN
> +     IOCTL(BTRFS_IOC_QGROUP_ASSIGN, IOC_W,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_qgroup_assign_args)))
> +#endif
> +#ifdef BTRFS_IOC_QGROUP_CREATE
> +     IOCTL(BTRFS_IOC_QGROUP_CREATE, IOC_W,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_qgroup_create_args)))
> +#endif
> +#ifdef BTRFS_IOC_QGROUP_LIMIT
> +     IOCTL(BTRFS_IOC_QGROUP_LIMIT, IOC_R,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_qgroup_limit_args)))
> +#endif
> +#ifdef BTRFS_IOC_QUOTA_RESCAN
> +     IOCTL(BTRFS_IOC_QUOTA_RESCAN, IOC_W,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_quota_rescan_args)))
> +#endif
> +#ifdef BTRFS_IOC_QUOTA_RESCAN_STATUS
> +     IOCTL(BTRFS_IOC_QUOTA_RESCAN_STATUS, IOC_R,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_quota_rescan_args)))
> +#endif
> +#ifdef BTRFS_IOC_QUOTA_RESCAN_WAIT
> +     IOCTL(BTRFS_IOC_QUOTA_RESCAN_WAIT, 0, TYPE_NULL)
> +#endif
>  #ifdef BTRFS_IOC_GET_DEV_STATS
>       IOCTL(BTRFS_IOC_GET_DEV_STATS, IOC_RW,
>             MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_dev_stats)))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index f1718ac521..1b1b2c2d96 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -985,6 +985,13 @@ struct target_rtc_pll_info {
>  #define TARGET_BTRFS_IOC_DEV_INFO               TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 30)
>  #define TARGET_BTRFS_IOC_INO_PATHS              TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 35)
>  #define TARGET_BTRFS_IOC_LOGICAL_INO            TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 36)
> +#define TARGET_BTRFS_IOC_QUOTA_CTL              TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 40)
> +#define TARGET_BTRFS_IOC_QGROUP_ASSIGN          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 41)
> +#define TARGET_BTRFS_IOC_QGROUP_CREATE          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 42)
> +#define TARGET_BTRFS_IOC_QGROUP_LIMIT           TARGET_IORU(BTRFS_IOCTL_MAGIC, 43)
> +#define TARGET_BTRFS_IOC_QUOTA_RESCAN           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 44)
> +#define TARGET_BTRFS_IOC_QUOTA_RESCAN_STATUS    TARGET_IORU(BTRFS_IOCTL_MAGIC, 45)
> +#define TARGET_BTRFS_IOC_QUOTA_RESCAN_WAIT      TARGET_IO(BTRFS_IOCTL_MAGIC, 46)
>  #define TARGET_BTRFS_IOC_GET_DEV_STATS          TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 52)
>  #define TARGET_BTRFS_IOC_GET_FEATURES           TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
>  #define TARGET_BTRFS_IOC_SET_FEATURES           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 57)
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index 6bac8f46bb..2f5bad808e 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -400,6 +400,35 @@ STRUCT(btrfs_ioctl_get_dev_stats,
>         MK_ARRAY(TYPE_ULONGLONG,
>                  128 - 2 - BTRFS_DEV_STAT_VALUES_MAX)) /* unused */
>  
> +STRUCT(btrfs_ioctl_quota_ctl_args,
> +       TYPE_ULONGLONG, /* cmd */
> +       TYPE_ULONGLONG) /* status */
> +
> +STRUCT(btrfs_ioctl_quota_rescan_args,
> +       TYPE_ULONGLONG, /* flags */
> +       TYPE_ULONGLONG, /* progress */
> +       MK_ARRAY(TYPE_ULONGLONG, 6)) /* reserved */
> +
> +STRUCT(btrfs_ioctl_qgroup_assign_args,
> +       TYPE_ULONGLONG, /* assign */
> +       TYPE_ULONGLONG, /* src */
> +       TYPE_ULONGLONG) /* dst */
> +
> +STRUCT(btrfs_ioctl_qgroup_create_args,
> +       TYPE_ULONGLONG, /* create */
> +       TYPE_ULONGLONG) /* qgroupid */
> +
> +STRUCT(btrfs_qgroup_limit,
> +       TYPE_ULONGLONG, /* flags */
> +       TYPE_ULONGLONG, /* max_rfer */
> +       TYPE_ULONGLONG, /* max_excl */
> +       TYPE_ULONGLONG, /* rsv_rfer */
> +       TYPE_ULONGLONG) /* rsv_excl */
> +
> +STRUCT(btrfs_ioctl_qgroup_limit_args,
> +       TYPE_ULONGLONG, /* qgroupid */
> +       MK_STRUCT(STRUCT_btrfs_qgroup_limit)) /* lim */
> +
>  STRUCT(btrfs_ioctl_feature_flags,
>         TYPE_ULONGLONG, /* compat_flags */
>         TYPE_ULONGLONG, /* compat_ro_flags */
> 

Applied to my linux-user-for-5.2 branch.

Thanks,
Laurent


