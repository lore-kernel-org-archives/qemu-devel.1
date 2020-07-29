Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4B9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32AE22075D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32AE22075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ora-00037g-FH
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 12:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k0oqo-0002dS-TX
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:22:42 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:50409)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k0oqh-0003ku-Dv
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:22:42 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MXXhv-1kHel42Uff-00Z03J; Wed, 29 Jul 2020 18:22:25 +0200
Subject: Re: [PATCH v2 2/4] linux-user: Add support for two btrfs ioctls used
 for subvolume
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200717144435.268166-1-Filip.Bozuta@syrmia.com>
 <20200717144435.268166-3-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <23adeefb-63d5-71fc-8e84-ec05f0ae56ac@vivier.eu>
Date: Wed, 29 Jul 2020 18:22:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717144435.268166-3-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WEFi3qDVeP59kfTMDXAW0kK1Cr7LkQfmr5Sev1KxlfHD224ihQi
 Rs1Ktyiwi3lFBzURD7WD36r1OvDKTBJkSoqbfTzyIObl/gXozJX7QbvhIkdnQl4gsdcQpb4
 C/we++/3kvIij2OMofU/Vem3Gyx6aOE66LC1Y0v1zR2VPmrBl0PM/mK4t0qEhDXlRABH+xB
 rvUTvw64eSFLtxkTiMYhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LnYRaNFL9O0=:qti7TXbzAF0LvLjArhTuTK
 VT+1P+Vg4GqHapKU/ejjLVEYDkuz2gVza0rL9ZK63TR3+vXmKj/Po3qyo6WrpdQcUbIW7YoHL
 vn5j8ZR+weGUAy50YdZy9D0funzicUDHeFtXP1/Gp3CgPvGAw5ySEOmfI0JEBtLFvFlyznGhM
 POZg2ZQJor3e7wNkMLBzTsjszMR3aSlj4bumjM+eKRbAMfbJhvc6jk3Kr/7Wjo5pVWXhHU+75
 wUfN1/cOEKe2uLVxTTT/cYUov1awDm2fgKZS3D9GEnZd+AEn2jR5k+HIXNtYBY6FQIazdRpAZ
 O7HOBweX2WGi7p5Lcx98HV3LwdwyIvk9VGdyttm0fFEqt3gTABemnnCgMkL4ulOBzUGY5FiH0
 HFR3EjGJawIie1BxzQ2omSg2NKz3qnMoJtePGkBBTggKNCZ2h6n18PMKrm0oFS9GarB8oq43i
 05X4+isp8J9zp9MKU5X7NfDYbDe8fKcOdSX8O8CpGoJlfEn1KVTRke1ZDyP1scmoaVjsnC0a2
 JW0Hb3Rh0rhgkIeLF0r8c75FJ2bPFsEDQKsiJS652P7noL1JKDRTA5cbeMRRECnmnOrtoCE2v
 dJouVLp2nQNapygyS54dQQ8JfICRbeMGqZt1uLC+4uOA6F0XZlZqoMh2hLKUfs2mQGUjCqe3l
 g5i8mzG1ondiEjggsp5yNtd1nguM/A8/fAc5hVMX390ZOkbngV+5V7UBNZFak+i/dcyL+25a/
 jzGb9GxNjmk9BxgSRpbJcDOXeKu03YM5Icaga5/p8OVcLUI+NJimhBvV087eUjpAwSogOcZaJ
 JzA/7yhMf+rdgZssJmvmd3F24d9lBS5cbiTV4ugXf+MBuOwpPXQRHYwcuXIFnlgi2RTyPrG
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 12:22:34
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
> ---
>  linux-user/ioctls.h        |  7 +++++++
>  linux-user/syscall_defs.h  |  4 ++++
>  linux-user/syscall_types.h | 11 +++++++++++
>  3 files changed, 22 insertions(+)
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
> index 7bb105428b..f4b4fc4a20 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -984,6 +984,8 @@ struct target_rtc_pll_info {
>                                                 15, struct btrfs_ioctl_vol_args)
>  #define TARGET_BTRFS_IOC_INO_LOOKUP             TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
>                                          18, struct btrfs_ioctl_ino_lookup_args)
> +#define TARGET_BTRFS_IOC_DEFAULT_SUBVOL         TARGET_IOW(BTRFS_IOCTL_MAGIC, \
> +                                                           19, abi_ullong)
>  #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, \
>                                                             25, abi_ullong)
>  #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, \
> @@ -1006,6 +1008,8 @@ struct target_rtc_pll_info {
>                                         59, struct btrfs_ioctl_logical_ino_args)
>  #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IOR(BTRFS_IOCTL_MAGIC, \
>                                     60, struct btrfs_ioctl_get_subvol_info_args)
> +#define TARGET_BTRFS_IOC_GET_SUBVOL_ROOTREF     TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
> +                                61, struct btrfs_ioctl_get_subvol_rootref_args)

This one needs TARGET_IOWRU(), the first one can be kept as it uses
abi_ullong.

with that changed:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent


