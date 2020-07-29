Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40138C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B7A520809
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B7A520809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ozI-0007AA-3f
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 12:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k0oyG-00061G-LR
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:30:24 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:47413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k0oyE-0004tw-4U
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:30:24 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MKbPg-1kLnEP3he8-00L1Ut; Wed, 29 Jul 2020 18:30:14 +0200
Subject: Re: [PATCH v2 3/4] linux-user: Add support for btrfs ioctls used to
 manage quota
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200717144435.268166-1-Filip.Bozuta@syrmia.com>
 <20200717144435.268166-4-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <41c0b36a-e7cf-6776-cd21-72dc7761923a@vivier.eu>
Date: Wed, 29 Jul 2020 18:30:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717144435.268166-4-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:O2010+epLYpEx7cvqTapltGVxra081sJ8HM/Ofp8gM0e6ESkp2/
 N2Ahx9Gok2/hIxsWp9ZNJYw1sOdrNE+b+y/BH5k98o4U5jRsuWTBnubsCvuqzKYZ09hOFi1
 PStAcsj68sfUjQsgB+1mqf3Hc155wVRDGW5/nuDo8pF/U4YghO+qmYpkldZDpGwzr/yH/E7
 hgm8cTiJwBowC6DndXmrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+wv9QGiJW8M=:pnDDVPhq4kgxYyYv/Z8O7R
 VEAbGVXD3atMK9qFbcluKnJMPfDWp3QHIl4j9gw2jW1HvmBen8Iv0V53W1LA2PsaSpwexay9L
 or61KmE9+um05OohdCjHXdbDkjeHfg0jUHPBVJ2n112DgovLsIph2rHEoVquZ5Nsq6JAe940k
 FSEnLpj/2JJTbGltET+KhHrcnoJH5YrATxunaEiYdvIj4p7X7ErBHSU6TnwZvsI/dOve2VlKQ
 o8Fyf62ufreqARVq3AgP6K/YGHgWILsfCBmt04WmozjP/j+Wc4eU8whgGMJ6PKn+zvg/UKBkC
 +DGJTdnenqHg15dk2CzSC4GMUdXa2+xjMb3ayMjpr13I5P3pbH9GpLmd0GXFfhcR/V0gVrH6u
 fkb6pWRECV6aXNgs/5wiN9N4MStR9Go/WItaOPmf5f4KHKneXNfiFpI4kxfJnbrSrgjacPpQ6
 fjQ9hOskYoj4zUKnd4e4WJx8QGmJsS3SPg6/P9MJJVEKjRx99XRSSnRAjFOaM+p+tIWwa/zQL
 YY7nswlxKGfSl7sx/rFfVQarKVSNxLAFmFj8BHByQq64ZNQrh/wCm8xdISVh7gusysnTKEBKV
 YdVS4rsjvce0UJRM8ERDXX9ppMdXHNlIZvy6lXmNoEPUxxcvyfraTzJJpF/tMhMu+mqooYCOI
 GWM2dOLL/E9cE2Psd09gtC8WQZM1xVcxK0WTAtDtCunnxAPZ4BK3GaVTY4Yth1uLag6oLnzJQ
 WvkPWR0RiJgSN2hyml7r7N5WcRXc3XxhrJh4u/hCg7c8Q/nhsn0K6a8Hu0xSwDQOi2F723spR
 /6TBx8m5aqDHAQz6TeIFIMHkDsYiOZk7OJ9HKWDY9c29sY2fGEODfM/87HmT7xdFgH487xnr9
 r/CJ54zmrcx465Lj486CvcZ7joqJ5mk1yYuac/51e/xSxwcIyyEH23JXUBTVX+
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 12:22:34
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
Cc: riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 17/07/2020 à 16:44, Filip Bozuta a écrit :
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
> ---
>  linux-user/ioctls.h        | 27 +++++++++++++++++++++++++++
>  linux-user/syscall_defs.h  | 14 ++++++++++++++
>  linux-user/syscall_types.h | 29 +++++++++++++++++++++++++++++
>  3 files changed, 70 insertions(+)
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
> index f4b4fc4a20..3f771ae5d1 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -996,6 +996,20 @@ struct target_rtc_pll_info {
>                                            35, struct btrfs_ioctl_ino_path_args)
>  #define TARGET_BTRFS_IOC_LOGICAL_INO            TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
>                                         36, struct btrfs_ioctl_logical_ino_args)
> +#define TARGET_BTRFS_IOC_QUOTA_CTL              TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
> +                                         40, struct btrfs_ioctl_quota_ctl_args)
> +#define TARGET_BTRFS_IOC_QGROUP_ASSIGN          TARGET_IOW(BTRFS_IOCTL_MAGIC, \
> +                                     41, struct btrfs_ioctl_qgroup_assign_args)
> +#define TARGET_BTRFS_IOC_QGROUP_CREATE          TARGET_IOW(BTRFS_IOCTL_MAGIC, \
> +                                     42, struct btrfs_ioctl_qgroup_create_args)
> +#define TARGET_BTRFS_IOC_QGROUP_LIMIT           TARGET_IOR(BTRFS_IOCTL_MAGIC, \
> +                                      43, struct btrfs_ioctl_qgroup_limit_args)
> +#define TARGET_BTRFS_IOC_QUOTA_RESCAN           TARGET_IOW(BTRFS_IOCTL_MAGIC, \
> +                                      44, struct btrfs_ioctl_quota_rescan_args)
> +#define TARGET_BTRFS_IOC_QUOTA_RESCAN_STATUS    TARGET_IOR(BTRFS_IOCTL_MAGIC, \
> +                                      45, struct btrfs_ioctl_quota_rescan_args)

With the 'U' variant:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent

