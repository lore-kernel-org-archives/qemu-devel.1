Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD31AC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A09FC24676
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09FC24676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irM62-0007ji-W2
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 08:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irLxT-0005Pj-OU
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:10:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irLxR-0005mB-It
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:10:11 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:37939)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irLxQ-0005lJ-Ck
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:10:08 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MA7X0-1iyShN0ECA-00BeO6; Tue, 14 Jan 2020 14:09:47 +0100
Subject: Re: [PATCH 11/12] linux-user: Add support for getting/setting
 selected alsa timer parameters using ioctls
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>, qemu-devel@nongnu.org
References: <1578574763-8327-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1578574763-8327-12-git-send-email-Filip.Bozuta@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <052dbd95-7479-3de5-bf39-6cb103499f91@vivier.eu>
Date: Tue, 14 Jan 2020 14:09:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578574763-8327-12-git-send-email-Filip.Bozuta@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wE/k5fq9UuPLqSbpA2g0qcygcNYtH3vTdq572LPBJ94MFXABJkq
 VQClLdgppKzWp/DO9xkyXEc0lObQq07VSjB2tz1Div+gXjoDiZFbiovXJdd6OcMnV2KIXMY
 OKRQ+7qgjkheeaQpKMbCm4ft+ZWqkZa/6042TKBTvQ4CBH8z1W5pIVCPB38xayiL5fsC2hV
 GM8xPQFEBK0Tw5zvY4Xkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xpRAcxb3r28=:oZelkSpzAbS88TjhUJtjz7
 pYo3WTVAeLSOAphJbP4+CawNWEL8xJBMfMJ1b4PMfxYIL/Vubqos+tE6tfl2wWDm+WeT+xpHw
 XuL2fpK+g+7Mwp5p8vYTHQ1fCDiskkRBE4rSU7IkkBxzmyrAmpICneC2rg6CjtRYiDoNcFxR1
 Pa5i7wldmIFafm0NQwNywA5xieWzWoiSQR132WF4NWPK5bLF+JyR21n8juhelbM1sGkCk0ht7
 cZugl4JFs8mvngzmW0q590vjix2fUKk4ciXH1vOj4V68ORlZEgJB/wnuZ46xbcDzWrm4mAGGD
 l5po1JVevRcsZ2pUxRt9U83PPY+3+SGUYNezydcg90WVQIzM1TAz3RFc+WcQlplYnSS4a/lXC
 9a0HWq7P6IqUSKBQrzuriFh5JmNXz7ceuj6862+joIMjdH9ukhkxLpx6HEWPVE9cX3ytSBqfD
 N9eZF+YLWhE/9MQKshs7DZHUkZ5ySaTfMT0c/nfXabn57dALtREQAjL/Hk1oM12w9kg2g1v2Z
 6qvZketlInuBEFhc4tg1RMMMETPug2MxIzLTscayXprLj3LgitA+PXM5kHnHYrDMl2Bj8/cVc
 JkmWBzue3NkppzJJ8b8H1mv8RtuMEZdMI3VBZOzIVZGii5y4QS4lSiZR7LduHyKKm6x6Gvu7h
 GimB1eGp09ijfJLfbMGnyS9eDAHQ4VMwT33ujonoFtB1KuycaIVrE4dL73ekkOCsRzwoY4Z/k
 Cgo8GQnsoIoixDmbzMnCTPpp6WAe5hyqGyDDtQiKEN6Tsc+/xLvVyVYAj7GNjNp8uAtugbHnC
 uxt5co64+4kRqYj0FYgGQbtkhdHeZEI6HRd7oRACvsSyEBFJ6s9pvH30pfvjTeJS932U3/Dic
 l79G2o/Nti8gPDf32N3+bGcLB79qGFzRZ8W5+D0/k=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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
> SNDRV_TIMER_IOCTL_INFO - Getting information about selected timer
> 
>     Read information about the selected timer. The information is returned in
>     the following structure:
> 
>     struct snd_timer_info {
>         unsigned int flags;         /* timer flags - SNDRV_TIMER_FLG_* */
>         int card;                   /* card number */
>         unsigned char id[64];       /* timer identificator */
>         unsigned char name[80];     /* timer name */
>         unsigned long reserved0;    /* reserved for future use */
>         unsigned long resolution;   /* average period resolution in ns */
>         unsigned char reserved[64]; /* reserved for future use */
>     };
> 
>     A pointer to this structure should be passed as the third ioctl's argument.
>     Before calling this ioctl, the ioctl "SNDRV_TIMER_IOCTL_SELECT" should be
>     called first to select the timer which information is to be obtained. If no
>     timer is selected, the error EBADFD ("File descriptor in bad shape") is
>     returned.
> 
> SNDRV_TIMER_IOCTL_PARAMS - Setting parameters for selected timer
> 
>     Sets parameters for the selected timer. The paramaters are set in the
>     following structure:
> 
>     struct snd_timer_params {
>         unsigned int flags;         /* flags - SNDRV_TIMER_PSFLG_* */
>         unsigned int ticks;         /* requested resolution in ticks */
>         unsigned int queue_size;    /* total size of queue (32-1024) */
>         unsigned int reserved0;     /* reserved, was: failure locations */
>         unsigned int filter;        /* event filter */
>         unsigned char reserved[60]; /* reserved */
>     };
> 
>     A pointer to this structure should be passed as the third ioctl's argument.
>     Before calling this ioctl, the ioctl "SNDRV_TIMER_IOCTL_SELECT" should be
>     called first to select the timer which parameters are to be set. If no
>     timer is selected, the error EBADFD ("File descriptor in bad shape") is
>     returned.
> 
> SNDRV_TIMER_IOCTL_STATUS - Getting status of selected timer
> 
>     Read status of the selected timer. The status of the timer is returned in
>     the following structure:
> 
>     struct snd_timer_status {
>         struct timespec tstamp;     /* Timestamp - last update */
>         unsigned int resolution;    /* current period resolution in ns */
>         unsigned int lost;          /* counter of master tick lost */
>         unsigned int overrun;       /* count of read queue overruns */
>         unsigned int queue;         /* used queue size */
>         unsigned char reserved[64]; /* reserved */
>     };
> 
>     A pointer to this structure should be passed as the third ioctl's argument.
>     Before calling this ioctl, the ioctl "SNDRV_TIMER_IOCTL_SELECT" should be
>     called first to select the timer which status is to be obtained. If no
>     timer is selected, the error EBADFD ("File descriptor in bad shape") is
>     returned.
> 
> Implementation notes:
> 
>     All ioctls in this patch have pointer to some kind of a structure
>     as their third argument. That is the reason why corresponding
>     definitions were added in 'linux-user/syscall_types.h'. Structure
>     'snd_timer_status' has field of type 'struct timespec' which is why
>     a corresponding definition of that structure was also added in
>     'linux-user/syscall_types.h'. All of these strucutures have some
>     fields that are of type 'unsigned long'. That is the reason why
>     separate target structures were defined in 'linux-user/syscall_defs.h'.
>     Structure 'struct timespec' already had a separate target definition
>     so that definition was used to define a target structure for
>     'snd_timer_status'. The rest of the implementation was straightforward.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>  linux-user/ioctls.h        |  5 +++++
>  linux-user/syscall_defs.h  | 25 +++++++++++++++++++++++++
>  linux-user/syscall_types.h | 29 +++++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 7652117..43e7e5d 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -461,6 +461,11 @@
>          MK_PTR(MK_STRUCT(STRUCT_snd_timer_gstatus)))
>    IOCTL(SNDRV_TIMER_IOCTL_SELECT, IOC_W,
>          MK_PTR(MK_STRUCT(STRUCT_snd_timer_select)))
> +  IOCTL(SNDRV_TIMER_IOCTL_INFO, IOC_R, MK_PTR(MK_STRUCT(STRUCT_snd_timer_info)))
> +  IOCTL(SNDRV_TIMER_IOCTL_PARAMS, IOC_W,
> +        MK_PTR(MK_STRUCT(STRUCT_snd_timer_params)))
> +  IOCTL(SNDRV_TIMER_IOCTL_STATUS, IOC_R,
> +        MK_PTR(MK_STRUCT(STRUCT_snd_timer_status)))
>  
>    IOCTL(HDIO_GETGEO, IOC_R, MK_PTR(MK_STRUCT(STRUCT_hd_geometry)))
>    IOCTL(HDIO_GET_UNMASKINTR, IOC_R, MK_PTR(TYPE_INT))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 9a33b71..d76124d 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -2467,6 +2467,25 @@ struct target_snd_timer_select {
>      unsigned char reserved[32];
>  };
>  
> +struct target_snd_timer_info {
> +    unsigned int flags;
> +    int card;
> +    unsigned char id[64];
> +    unsigned char name[80];
> +    abi_ulong reserved0;
> +    abi_ulong resolution;
> +    unsigned char reserved[64];
> +};
> +
> +struct target_snd_timer_status {
> +    struct target_timespec tstamp;
> +    unsigned int resolution;
> +    unsigned int lost;
> +    unsigned int overrun;
> +    unsigned int queue;
> +    unsigned char reserved[64];
> +};
> +
>  /* alsa timer ioctls */
>  #define TARGET_SNDRV_TIMER_IOCTL_PVERSION     TARGET_IOR('T', 0x00, int)
>  #define TARGET_SNDRV_TIMER_IOCTL_NEXT_DEVICE  TARGET_IOWR('T', 0x01,                     \
> @@ -2480,6 +2499,12 @@ struct target_snd_timer_select {
>                                                            struct target_snd_timer_gstatus)
>  #define TARGET_SNDRV_TIMER_IOCTL_SELECT       TARGET_IOW('T', 0x10,                      \
>                                                           struct target_snd_timer_select)
> +#define TARGET_SNDRV_TIMER_IOCTL_INFO         TARGET_IOR('T', 0x11,                      \
> +                                                         struct target_snd_timer_info)
> +#define TARGET_SNDRV_TIMER_IOCTL_PARAMS       TARGET_IOW('T', 0x12,                      \
> +                                                         struct snd_timer_params)
> +#define TARGET_SNDRV_TIMER_IOCTL_STATUS       TARGET_IOR('T', 0x14,                      \
> +                                                         struct target_snd_timer_status)
>  
>  /* vfat ioctls */
>  #define TARGET_VFAT_IOCTL_READDIR_BOTH    TARGET_IORU('r', 1)
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index 767632d..fbc4be7 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -120,6 +120,35 @@ STRUCT(snd_timer_select,
>         MK_STRUCT(STRUCT_snd_timer_id), /* id */
>         MK_ARRAY(TYPE_CHAR, 32)) /* reserved */
>  
> +STRUCT(snd_timer_info,
> +       TYPE_INT, /* flags */
> +       TYPE_INT, /* card */
> +       MK_ARRAY(TYPE_CHAR, 64), /* id */
> +       MK_ARRAY(TYPE_CHAR, 80), /* name */
> +       TYPE_ULONG, /* reserved0 */
> +       TYPE_ULONG, /* resolution */
> +       MK_ARRAY(TYPE_CHAR, 64)) /* reserved */
> +
> +STRUCT(snd_timer_params,
> +       TYPE_INT, /* flags */
> +       TYPE_INT, /* ticks */
> +       TYPE_INT, /* queue_size */
> +       TYPE_INT, /* reserved0 */
> +       TYPE_INT, /* filter */
> +       MK_ARRAY(TYPE_CHAR, 60)) /* reserved */
> +
> +STRUCT(timespec,
> +       TYPE_LONG, /* tv_sec */
> +       TYPE_LONG) /* tv_nsec */
> +
> +STRUCT(snd_timer_status,
> +       MK_STRUCT(STRUCT_timespec), /* tstamp */
> +       TYPE_INT, /* resolution */
> +       TYPE_INT, /* lost */
> +       TYPE_INT, /* overrun */
> +       TYPE_INT, /* queue */
> +       MK_ARRAY(TYPE_CHAR, 64)) /* reserved */
> +
>  /* loop device ioctls */
>  STRUCT(loop_info,
>         TYPE_INT,                 /* lo_number */
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

