Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3A0C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE8232072B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8232072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irLY3-00017T-TP
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 07:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irLXT-0000iR-25
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:43:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irLXR-0006sq-MO
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:43:18 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:47729)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irLXR-0006sg-DU
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:43:17 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MbS0X-1jNwKZ1Dgn-00bwjW; Tue, 14 Jan 2020 13:42:58 +0100
Subject: Re: [PATCH 07/12] linux-user: Add support for getting alsa timer
 version and id
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>, qemu-devel@nongnu.org
References: <1578574763-8327-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1578574763-8327-8-git-send-email-Filip.Bozuta@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <550283f8-9b85-0562-d149-b1a24b7b9bdf@vivier.eu>
Date: Tue, 14 Jan 2020 13:42:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578574763-8327-8-git-send-email-Filip.Bozuta@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:04o9VbI7KsukL8XZrnmPZLMh3jhQ+i0KNwj/Kc8egolURBVg2SO
 Y+g6p6r5GDBG+XIkE/1uTE0353P8abDd+ViVtJCHeUljYrGmMiGdMDnpdKF191x+i8K+L1J
 ZCi7uDlIOilakekHP4X5B2d+SDkL46cmj87FZNQekVBYcZQ/Y2p/CmZ0s1kUE+cB/KqtbhQ
 Oql4nvqJIFLG50wqM1NYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iWZDimZ/BFg=:e9671vX212nHy9BY4I5oJg
 s4H1TtUSQ4SJGwsUdTUqQ0PqWCeUZYtsupklzP9hO36WqGDcoaRsCXnizMM6uk2EGYHCOfXFf
 pvNVMrlwszWXIGFE4c3pIyFuLSCHVRrQgHaM1e0RXDxfvzqDK1opwW3VoMxf7bY0OdWWD5I/3
 L7Y7mGIsgX2stB0LYehzmVd34UcfOwiZCDsRqknZqhYd1uYbkJp3ISJvYrM90yf5acX6i8bQX
 CXRX6A8Z5nu6qM15iZOrQ2Gr2WTKBzH7VwVyeYF/neneooyX9ioNICcWYhYVgn/zuwQX/VkGP
 zmXsw62mf52niPiC3rz6nQfqJIu606PGGLhvfSd/vUghIEAUEToO8ZOY2xop+a1l785SxTTIb
 +4992v5Km5QR9DgwV9ppUz3NrsM/GQ6siDDZ+vMYbcoSQYpmxFnOap4iPZJcmdi2dIZM8mAMD
 cPlIBMH4N8eis8MNOF6CX7/7Tx/KSWwGZ4zVGBsavbgaPeVlai0sAeiNFP3IwzWlsz8qXwKsX
 grL0zPwrzjEYnlu8Zyo5YTn3BY+fSqVn/FpPk657IktyOFLlzRRGZeWRSz6GwN9vDP1PmpuuQ
 Soo8lMJXSKmf7TgI3oyKBZfXYkd0cQuKrrHEk5lmbdXUPD3pZ4wpENhWFY7vmUmfEUkTdOOWg
 nUzoEzo0jvfwCrL74KLXe4r1pScEdyZGAnHSSPC7IZppxMA5nzrEZnpCNFarS1ntL7U5M4Pns
 LtLJji5BUDz4pN8qdAIC2joi05ATNDkE0d/6NiHfHiVaSAk3Fs4qEImIsr4v2aeyAuRakrzzm
 zdtPsi1EV8Wkm3H87PT6L+iZywu68ZViXaiHXnjQy+H6qfvvKIIuyyj0lMywVU5RXI7CmSlvT
 ztwqnlGtdsBbkrrOQUkA==
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
> SNDRV_TIMER_IOCTL_PVERSION - Getting the sound timer version
> 
>     Read the sound timer version. The third ioctl's argument is
>     a pointer to an int in which the specified timers version
>     is returned.
> 
> SNDRV_TIMER_IOCTL_NEXT_DEVICE - Getting id information about next timer
> 
>     Read id information about the next timer device from the sound timer
>     device list. The id infomration is returned in the following structure:
> 
>         struct snd_timer_id {
>             int dev_class;    /* timer device class number */
>             int dev_sclass;   /* slave device class number (unused) */
>             int card;         /* card number */
>             int device;       /* device number */
>             int subdevice;    /* sub-device number */
>         };
> 
>     The devices in the sound timer device list are arranged by the fields
>     of this structure respectively (first by dev_class number, then by
>     card number, ...). A pointer to this structure should be passed as
>     the third ioctl's argument. Before calling the ioctl, the parameters
>     of this structure should be initialized in relation to the next timer
>     device which information is to be obtained. For example, if a wanted
>     timer device has the device class number equal to or bigger then 2,
>     the field dev_class should be initialized to 2. After the ioctl call,
>     the structure fields are filled with values from the next device in
>     the sound timer device list. If there is no next device in the list,
>     then the structure is filled with "zero" id values (in that case all
>     fields are filled with value -1).
> 
> Implementation notes:
> 
>     The ioctl 'SNDRV_TIMER_IOCTL_NEXT_DEVICE' has a pointer to a
>     'struct snd_timer_id' as its third argument. That is the reason why
>     corresponding definition is added in 'linux-user/syscall_types.h'.
>     Since all elements of this structure are of type 'int', the rest of
>     the implementation is straightforward.
> 
>     The line '#include <linux/rtc.h>' was added to recognize
>     preprocessor definitions for these ioctls. This needs to be
>     done only once in this series of commits. Also, the content
>     of this file (with respect to ioctl definitions) remained
>     unchanged for a long time, therefore there is no need to
>     worry about supporting older Linux kernel version.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>  linux-user/ioctls.h        | 4 ++++
>  linux-user/syscall.c       | 1 +
>  linux-user/syscall_defs.h  | 5 +++++
>  linux-user/syscall_types.h | 7 +++++++
>  4 files changed, 17 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 1f1f3e6..ed1bd4c 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -449,6 +449,10 @@
>    IOCTL(SOUND_MIXER_WRITE_LOUD, IOC_W, MK_PTR(TYPE_INT))
>    IOCTL(SOUND_MIXER_WRITE_RECSRC, IOC_W, MK_PTR(TYPE_INT))
>  
> +  IOCTL(SNDRV_TIMER_IOCTL_PVERSION, IOC_R, MK_PTR(TYPE_INT))
> +  IOCTL(SNDRV_TIMER_IOCTL_NEXT_DEVICE, IOC_RW,
> +        MK_PTR(MK_STRUCT(STRUCT_snd_timer_id)))
> +
>    IOCTL(HDIO_GETGEO, IOC_R, MK_PTR(MK_STRUCT(STRUCT_hd_geometry)))
>    IOCTL(HDIO_GET_UNMASKINTR, IOC_R, MK_PTR(TYPE_INT))
>    IOCTL(HDIO_GET_MULTCOUNT, IOC_R, MK_PTR(TYPE_INT))
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 74c3c08..a3993a2 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -108,6 +108,7 @@
>  #include <linux/netlink.h>
>  #include <linux/if_alg.h>
>  #include <linux/rtc.h>
> +#include <sound/asound.h>
>  #include "linux_loop.h"
>  #include "uname.h"
>  
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index af4f366..7409021 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -2425,6 +2425,11 @@ struct target_statfs64 {
>  
>  #define TARGET_SOUND_MIXER_WRITE_RECSRC	TARGET_MIXER_WRITE(SOUND_MIXER_RECSRC)
>  
> +/* alsa timer ioctls */
> +#define TARGET_SNDRV_TIMER_IOCTL_PVERSION     TARGET_IOR('T', 0x00, int)
> +#define TARGET_SNDRV_TIMER_IOCTL_NEXT_DEVICE  TARGET_IOWR('T', 0x01,                     \
> +                                                          struct snd_timer_id)
> +
>  /* vfat ioctls */
>  #define TARGET_VFAT_IOCTL_READDIR_BOTH    TARGET_IORU('r', 1)
>  #define TARGET_VFAT_IOCTL_READDIR_SHORT   TARGET_IORU('r', 2)
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index 4027272..2f4cd78 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -83,6 +83,13 @@ STRUCT(buffmem_desc,
>  STRUCT(mixer_info,
>         MK_ARRAY(TYPE_CHAR, 16), MK_ARRAY(TYPE_CHAR, 32), TYPE_INT, MK_ARRAY(TYPE_INT, 10))
>  
> +STRUCT(snd_timer_id,
> +       TYPE_INT, /* dev_class */
> +       TYPE_INT, /* dev_sclass */
> +       TYPE_INT, /* card */
> +       TYPE_INT, /* device */
> +       TYPE_INT) /* subdevice */
> +
>  /* loop device ioctls */
>  STRUCT(loop_info,
>         TYPE_INT,                 /* lo_number */
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

