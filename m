Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9B3C3F68F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:54:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5DC2467E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5DC2467E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irLhw-0000u1-VE
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 07:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irLgm-0008K2-9o
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irLgi-0001CF-Nq
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:52:56 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:41743)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irLgi-0001Be-Ej
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:52:52 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N49xZ-1jqZ7Y1g5B-0107Zc; Tue, 14 Jan 2020 13:52:33 +0100
Subject: Re: [PATCH 09/12] linux-user: Add support for getting/setting
 specified alsa timer parameters using ioctls
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>, qemu-devel@nongnu.org
References: <1578574763-8327-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1578574763-8327-10-git-send-email-Filip.Bozuta@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3ae36dc8-0c5c-1923-e3a1-4d38145a905d@vivier.eu>
Date: Tue, 14 Jan 2020 13:52:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578574763-8327-10-git-send-email-Filip.Bozuta@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YirI6mCZc9QFKNkTAVrpSgzNGlEcj5XkEApk7p16l28KRtKPaGD
 vQ4F470Cjdg+Zsyqb1uBpr8LZvo+B7bVAz55+qchjRKRUreOFLH6pND/7cw5RQe7lvLY053
 P4uRPXchLfvfWid/b2Ys70OZOpk1QZQ7XXJVcHdHqfs9B28OO1ht/LAACm0OrZGAMme0LK5
 8dWng386zt1qz/BGd0+MQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3A+o6ivWF2U=:FRYZ0P0Zi8HOFFSKOyCsgW
 C/2OMTgh593SzaraMXFs2GpaFVwoyX8fcTDPRjcz58HdRXhq3nJHQIAmj/TMECRonlPrcE9sK
 TKXYGyhJe0eWsqZ0xf1W3jpUhhpXo3HhGMHn32kj0dL4/Z8qs4aLnT+BlYfB393MnnkbYt35U
 WKYkjjZMrKqJAlf7FhR9/ujukImp+w+JfocO/kK8h+sYUQGzpEya/96uUjq20KFrL2LysIGaQ
 /18o53P/3w3XOt4qpBKtOykQjVbVpmsVmQ61xY1kqJI5M52yewsuv9mXZl3VHk9a2lZ5cWDj9
 t7gz5AbXqEPgMHMK/+ricCyEEc9JgdpXUFLf1JWfaQ5ITsy35//FPFAO0A7gPOVUdFudiMAAN
 kxxzK9QwHVKuHspxFUFLGys+BURgVgk/La4wDITjssYnv4uk4Zf5/gtFxFL9aWcRh8YtF53lQ
 svqHYuGvZV5T4HSO0Acotn1sVfNAP4LYCRRElDSky3miKs0aS66yGzWegxTRLQW+WehovHhF3
 BODJGMxVotGywJ/KOuRCqcxgkQYyj4atyH6PERdsFXhv7ireFT5ys6GqlMuF3+QxfFnm8zWvF
 P4Zn3iLAffP+so2q01hUk2sxB77QnfeLECexpmPQgkxRTvmZdh1uanIw/stYFnIqCdLPvyFiN
 9k1RHcHkg4nx8TP8HWTQaQ3fLslaLRaXUvcwvXMHxcjdVD/x0tlXrL4p/H5s8UTQwyo0PxIhR
 eYGVG0JTm/1J9SxuUOH9pOsg2cgcokrCuuYzWl0hX4z8BXY1QFIKyB8IHrwq9boxU0+2gAFS5
 USfQz8is1jOXNMGTGNytb8P4caE6PyjRYZVd6VU7y3W8nfCegDCoZr3I8fM5dytGJUYePXunj
 QFxzKH8IixKTmm1wZxbQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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

Le 09/01/2020 à 13:59, Filip Bozuta a écrit :
> This patch implements functionalities of following ioctls:
> 
> SNDRV_TIMER_IOCTL_GINFO - Getting information about specified timer
> 
>     Read information about the specified timer. The information about the
>     timer is returned in the following structure:
> 
>         struct snd_timer_ginfo {
>             struct snd_timer_id tid;      /* requested timer ID */
>             unsigned int flags;           /* timer flags - SNDRV_TIMER_FLG_* */
>             int card;                     /* card number */
>             unsigned char id[64];         /* timer identification */
>             unsigned char name[80];       /* timer name */
>             unsigned long reserved0;      /* reserved for future use */
>             unsigned long resolution;     /* average period resolution in ns */
>             unsigned long resolution_min; /* minimal period resolution in ns */
>             unsigned long resolution_max; /* maximal period resolution in ns */
>             unsigned int clients;         /* active timer clients */
>             unsigned char reserved[32];   /* reserved */
>         };
> 
>     A pointer to this structure should be passed as the third ioctl's argument.
>     Before calling the ioctl, the field "tid" should be initialized with the id
>     information for the timer which information is to be obtained. After the
>     ioctl call, the rest of the structure fields are filled with values from
>     the timer device with the specified id. If there is no device with the
>     specified id, the error ENODEV ("No such device") is returned.
> 
> SNDRV_TIMER_IOCTL_GPARAMS - Setting precise period duration
> 
>     Sets timer precise period duration numerator and denominator in seconds. The
>     period duration is set in the following structure:
> 
>         struct snd_timer_gparams {
>             struct snd_timer_id tid;    /* requested timer ID */
>             unsigned long period_num;   /* period duration - numerator */
>             unsigned long period_den;   /* period duration - denominator */
>             unsigned char reserved[32]; /* reserved */
>         };
> 
>     A pointer to this structure should be passed as the third ioctl's argument.
>     Before calling the ioctl, the field "tid" should be initialized with the id
>     information for the timer which period duration is to be set. Also, the
>     fileds "period_num" and "period_den" should be filled with the period
>     duration numerator and denominator values that are to be set respectively.
>     If there is no device with the specified id, the error ENODEV ("No such
>     device") is returned.
> 
> SNDRV_TIMER_IOCTL_GSTATUS - Getting current period resolution
> 
>     Read timer current period resolution in nanoseconds and period resolution
>     numerator and denominator in seconds. The period resolution information is
>     returned in the following structure:
> 
>     struct snd_timer_gstatus {
>         struct snd_timer_id tid;        /* requested timer ID */
>         unsigned long resolution;       /* current period resolution in ns */
>         unsigned long resolution_num;   /* period resolution - numerator */
>         unsigned long resolution_den;   /* period resolution - denominator */
>         unsigned char reserved[32];     /* reserved for future use */
>     };
> 
>     A pointer to this structure should be passed as the third ioctl's argument.
>     Before calling the ioctl, the field "tid" should be initialized with the id
>     information for the timer which period resolution is to be obtained. After
>     the ioctl call, the rest of the structure fields are filled with values
>     from the timer device with the specified id. If there is no device with the
>     specified id, the error ENODEV ("No such device") is returned.
> 
> Implementation notes:
> 
>     All ioctls in this patch have pointer to some kind of a structure as their
>     third argument. That is the reason why corresponding definitions were added
>     in 'linux-user/syscall_types.h'. All of these strcutures have some fields
>     that are of type 'unsigned long'. That is the reason why separate target
>     structures were defined in 'linux-user/syscall_defs.h'. Also, all of the
>     structures have a field with type 'struct snd_timer_id' which is the reason
>     why a separate target structure 'struct target_snd_timer_id' was also
>     defined. The rest of the implementation was straightforward.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>  linux-user/ioctls.h        |  6 ++++++
>  linux-user/syscall_defs.h  | 43 +++++++++++++++++++++++++++++++++++++++++++
>  linux-user/syscall_types.h | 26 ++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 9106773..989eb9b 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -453,6 +453,12 @@
>    IOCTL(SNDRV_TIMER_IOCTL_NEXT_DEVICE, IOC_RW,
>          MK_PTR(MK_STRUCT(STRUCT_snd_timer_id)))
>    IOCTL(SNDRV_TIMER_IOCTL_TREAD, IOC_W, MK_PTR(TYPE_INT))
> +  IOCTL(SNDRV_TIMER_IOCTL_GINFO, IOC_RW,
> +        MK_PTR(MK_STRUCT(STRUCT_snd_timer_ginfo)))
> +  IOCTL(SNDRV_TIMER_IOCTL_GPARAMS, IOC_W,
> +        MK_PTR(MK_STRUCT(STRUCT_snd_timer_gparams)))
> +  IOCTL(SNDRV_TIMER_IOCTL_GSTATUS, IOC_RW,
> +        MK_PTR(MK_STRUCT(STRUCT_snd_timer_gstatus)))
>  
>    IOCTL(HDIO_GETGEO, IOC_R, MK_PTR(MK_STRUCT(STRUCT_hd_geometry)))
>    IOCTL(HDIO_GET_UNMASKINTR, IOC_R, MK_PTR(TYPE_INT))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 8d505c1..4d4dad3 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -2425,11 +2425,54 @@ struct target_statfs64 {
>  
>  #define TARGET_SOUND_MIXER_WRITE_RECSRC	TARGET_MIXER_WRITE(SOUND_MIXER_RECSRC)
>  
> +struct target_snd_timer_id {
> +    int dev_class;
> +    int dev_sclass;
> +    int card;
> +    int device;
> +    int subdevice;
> +};
> +
> +struct target_snd_timer_ginfo {
> +    struct target_snd_timer_id tid;
> +    unsigned int flags;
> +    int card;
> +    unsigned char id[64];
> +    unsigned char name[80];
> +    abi_ulong reserved0;
> +    abi_ulong resolution;
> +    abi_ulong resolution_min;
> +    abi_ulong resolution_max;
> +    unsigned int clients;
> +    unsigned char reserved[32];
> +};
> +
> +struct target_snd_timer_gparams {
> +    struct target_snd_timer_id tid;
> +    abi_ulong period_num;
> +    abi_ulong period_den;
> +    unsigned char reserved[32];
> +};
> +
> +struct target_snd_timer_gstatus {
> +    struct target_snd_timer_id tid;
> +    abi_ulong resolution;
> +    abi_ulong resolution_num;
> +    abi_ulong resolution_den;
> +    unsigned char reserved[32];
> +};
> +
>  /* alsa timer ioctls */
>  #define TARGET_SNDRV_TIMER_IOCTL_PVERSION     TARGET_IOR('T', 0x00, int)
>  #define TARGET_SNDRV_TIMER_IOCTL_NEXT_DEVICE  TARGET_IOWR('T', 0x01,                     \
>                                                            struct snd_timer_id)
>  #define TARGET_SNDRV_TIMER_IOCTL_TREAD        TARGET_IOW('T', 0x02, int)
> +#define TARGET_SNDRV_TIMER_IOCTL_GINFO        TARGET_IOWR('T', 0x03,                     \
> +                                                          struct target_snd_timer_ginfo)
> +#define TARGET_SNDRV_TIMER_IOCTL_GPARAMS      TARGET_IOW('T', 0x04,                      \
> +                                                         struct target_snd_timer_gparams)
> +#define TARGET_SNDRV_TIMER_IOCTL_GSTATUS      TARGET_IOWR('T', 0x05,                     \
> +                                                          struct target_snd_timer_gstatus)
>  
>  /* vfat ioctls */
>  #define TARGET_VFAT_IOCTL_READDIR_BOTH    TARGET_IORU('r', 1)
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index 2f4cd78..4e90716 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -90,6 +90,32 @@ STRUCT(snd_timer_id,
>         TYPE_INT, /* device */
>         TYPE_INT) /* subdevice */
>  
> +STRUCT(snd_timer_ginfo,
> +       MK_STRUCT(STRUCT_snd_timer_id), /* tid */
> +       TYPE_INT, /* flags */
> +       TYPE_INT, /* card */
> +       MK_ARRAY(TYPE_CHAR, 64), /* id */
> +       MK_ARRAY(TYPE_CHAR, 80), /* name */
> +       TYPE_ULONG, /* reserved0 */
> +       TYPE_ULONG, /* resolution */
> +       TYPE_ULONG, /* resolution_min */
> +       TYPE_ULONG, /* resolution_max */
> +       TYPE_INT, /* clients */
> +       MK_ARRAY(TYPE_CHAR, 32)) /* reserved */
> +
> +STRUCT(snd_timer_gparams,
> +       MK_STRUCT(STRUCT_snd_timer_id), /* tid */
> +       TYPE_ULONG, /* period_num */
> +       TYPE_ULONG, /* period_den */
> +       MK_ARRAY(TYPE_CHAR, 32)) /* reserved */
> +
> +STRUCT(snd_timer_gstatus,
> +       MK_STRUCT(STRUCT_snd_timer_id), /* tid */
> +       TYPE_ULONG, /* resolution */
> +       TYPE_ULONG, /* resolution_num */
> +       TYPE_ULONG, /* resolution_den */
> +       MK_ARRAY(TYPE_CHAR, 32)) /* reserved */
> +
>  /* loop device ioctls */
>  STRUCT(loop_info,
>         TYPE_INT,                 /* lo_number */
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

