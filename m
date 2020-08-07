Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D11EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 17:36:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F6F7204EA
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 17:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6F7204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k46I5-0004Ut-Ce
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 13:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k46Gs-0002nK-5W
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 13:35:10 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:40497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k46Gq-0000vv-Ab
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 13:35:09 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MS4WT-1kB5bu2lul-00TSQy; Fri, 07 Aug 2020 19:34:57 +0200
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200803094629.21898-1-Filip.Bozuta@syrmia.com>
 <20200803094629.21898-3-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2 2/8] linux-user: Add support for a group of btrfs
 ioctls used for snapshots
Message-ID: <9ae719de-c5c2-0912-ee66-d1aba900cf45@vivier.eu>
Date: Fri, 7 Aug 2020 19:34:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803094629.21898-3-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QdgczGPsH14jv/IzRBt9Z1+tshrrqArPGRH7mqVq1dyqQXWKj7L
 tO2RgK46/l15aSQ2Y8+tr2I2wethyp4vOe7VVFMNx8G32jxB0W2aamyl0SiNdVS4trUcraq
 5lOvFkOQ1qLKVzPshmiZRPQ6HQyBKeILZiYTUEWGWBPU0i9sSZLLZeHTZjX9beL/+zUFNge
 y5k0WC9kJI+z9vOa3Mxdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+jmSmZja+lw=:G8RW06T6zk4mf8NZPxhVgM
 UH/XbHeKEe1zyIJtBxC4op7R5zMlx/gjl9cmX/YNTR5ErtCqJpUhvBajZfLFKOengrOKFrdOA
 TaWXpRBNfTxvRqHgNN05MJS9w6lwPqGzmm9Fk5ZQ/VyXpzQmUky3pg0hKaLXcu10Rny9iw6x8
 xSkcXUXlrHnk6XD1IBjAEQhybrSxnVW7FwuloN0jfjxv7gOEdXgho8OOSvKo5VqN7F4UhMuGL
 H2lXc8DTE6hCaaCsAsQrZ2mSrLkA6NS6sEkK4PTmwugqxYX6usZcNAZ5aeU42V2jQA833M+pu
 rfw868KG4DX/Kf65BpU1CMgtqnMHL/j117QnhCTdv55IWHR8tbYD+UzLPPVcSK3LwQOC2wTr1
 GCCaeel3mqDYarPd6rAiUeOUdB6xL5YkKsNDOrqldWI4bwsJ0C7jk9gRDXG8BlD648DHXUGIk
 q21883Ix+MAYPT1M8ONee0hruucejw3+TvRJh/2wxBN97jsBgk9pK10WsJTtPShZs/kH4uaH5
 eOvl7SXwHC78qsWOhFJ4yqhvXCKtUa8+52WPJjbfxnoq7CgDnYzyGpjMwn7djJg53aHz0Dpw4
 0QJU2yaWJCSpsobm9FuHOoqKXqHjDfH7h8HMW6gi31ncOwImSKoHvrTycIaqdBAByRMyAIBXR
 ANtaB9QKdEwJRkOeL888jPuiZJKBclmEdDaddJaT6ig9bgD01UleHsLXLoCLOK4bes8yRo1OJ
 s/6PhBvSNGIVPuSYgqn2bySJ/rsqhG5xcqGK+Mp7o3F1FuuxiPqtQi5AYevTFK0QELhklLBz6
 fGULQkEl38GFLLCzGJz+qk2Fi2MnJoX6qrKLkJjrxv0xcGSLpgBsM5xDKmPPYJczzyxFm3m
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 13:35:07
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
> BTRFS_IOC_SNAP_CREATE - Creating a subvolume snapshot
> 
>     Create a snapshot of a btrfs subvolume. The snapshot is created using the
>     ioctl's third argument that is a pointer to a 'struct btrfs_ioctl_vol_args'
>     (which was mentioned in the previous patch). Before calling this ioctl,
>     the fields of the structure should be filled with aproppriate values for
>     the file descriptor and path of the subvolume for which the snapshot is to
>     be created.
> 
> BTRFS_IOC_SNAP_DESTROY - Removing a subvolume snapshot
> 
>     Delete a snapshot of a btrfs subvolume. The snapshot is deleted using the
>     ioctl's third argument that is a pointer to a 'struct btrfs_ioctl_vol_args'
>     (which was mentioned in the previous patch). Before calling this ioctl,
>     the fields of the structure should be filled with aproppriate values for
>     the file descriptor and path of the subvolume for which the snapshot is to
>     be deleted.
> 
> Implementation notes:
> 
>     Since the thunk type 'struct btrfs_ioctl_vol_args' is defined in the
>     previous patch, the implementation for these ioctls was straightforward.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/ioctls.h       | 8 ++++++++
>  linux-user/syscall_defs.h | 2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 544184ff95..2422675dd0 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -174,10 +174,18 @@
>       IOCTL(FS_IOC32_GETVERSION, IOC_R, MK_PTR(TYPE_INT))
>       IOCTL(FS_IOC32_SETVERSION, IOC_W, MK_PTR(TYPE_INT))
>  
> +#ifdef BTRFS_IOC_SNAP_CREATE
> +     IOCTL(BTRFS_IOC_SNAP_CREATE, IOC_W,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
> +#endif
>  #ifdef BTRFS_IOC_SUBVOL_CREATE
>       IOCTL(BTRFS_IOC_SUBVOL_CREATE, IOC_W,
>             MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
>  #endif
> +#ifdef BTRFS_IOC_SNAP_DESTROY
> +     IOCTL(BTRFS_IOC_SNAP_DESTROY, IOC_W,
> +           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
> +#endif
>  #ifdef BTRFS_IOC_SUBVOL_GETFLAGS
>       IOCTL(BTRFS_IOC_SUBVOL_GETFLAGS, IOC_R, MK_PTR(TYPE_ULONGLONG))
>  #endif
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 67a3c110b6..16966c323f 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -968,7 +968,9 @@ struct target_rtc_pll_info {
>  #define TARGET_FS_IOC32_SETVERSION TARGET_IOW('v', 2, int)
>  
>  /* btrfs ioctls */
> +#define TARGET_BTRFS_IOC_SNAP_CREATE            TARGET_IOWU(BTRFS_IOCTL_MAGIC, 1)
>  #define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 14)
> +#define TARGET_BTRFS_IOC_SNAP_DESTROY           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 15)
>  #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, 25,\
>                                                             abi_ullong)
>  #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
> 

Applied to my linux-user-for-5.2 branch.

Thanks,
Laurent

