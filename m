Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39DEC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A897207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A897207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irMDm-000211-GW
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 08:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irLlH-0005Us-0L
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:57:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irLlF-0002Z0-Im
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:57:34 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:60779)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irLlF-0002Yr-9N
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:57:33 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MStKw-1jF1hu21pW-00UMR6; Tue, 14 Jan 2020 13:57:20 +0100
Subject: Re: [PATCH 12/12] linux-user: Add support for selected alsa timer
 instructions using ioctls
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>, qemu-devel@nongnu.org
References: <1578574763-8327-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1578574763-8327-13-git-send-email-Filip.Bozuta@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <087de050-ea65-38a8-354f-a48a6b2d237c@vivier.eu>
Date: Tue, 14 Jan 2020 13:57:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578574763-8327-13-git-send-email-Filip.Bozuta@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:u1zWV1kvdp48Jscup6BY5nMVFEz0iexp/jCt7iPcTDTYBdSpwjX
 bO1YZ706u1Zv7GZ8M/2iqj/NU91hQqWLws0q4Fs+whOwynLagGGqPaIu9ut/AIOfxtJjf2g
 uA7KLJtIX8J+ntb5Cj49QkKetlNh4WReEttMncI/SPfK8TMWMCGxMtXY02au4K/Jdsb0++Y
 G3lEu5nCHQaZzGBShwQLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fN2S3F+hiEo=:iEnVQMYEs/WvW1HrFftRW2
 78eVwY8kAOf/yyKkPIZsnxsiM7AMp6OYQCfHsUh6PWzZEfb6/rd/7ZUmjOkLYGqC4lPlUUrCy
 y3Cbbz3rhCLCqNU46QG1uqrgQ/x4XkzbZB90xwt9Ohd9Sks8sRyi40qvMsVH4qU6E2zGDJTtv
 6JCLOBOqIroXvF5BeXFqHlFxbxRP70u2IE4d8tJTlmimrPznuiMeK/OsVxLW+d2X7S0MWf+Iw
 BUxOat8Yda1urihVGJwH6TT5zNmOs4kt6RnRP3MxMBDlH6lgmiCL5/YF5yUvr/GuUEwTDPgI7
 WIJYxGezT4+mJ7njYitIBdlmWWl/FUj6StsTTuoN4uHYgdCvI1IvsvE/ip/pn/dBw7gmCoD3x
 5xHSVd0XaOlrqqX/num+Hi0gPzc2YJT0iGHXYf60SIxX9rNX5pF0LsWeDe8tSNifg0ufqg3Ve
 eTWql0vPnolxyLplk43mkXvJbQfdwF3DjIl22wXqkz4NY9nOpwWR5c/+KijVE0qtisdm7nvJ5
 zK+O74KRkHkFOo5alFvB2oSSpjuxI/BEKN3u6rDsGHHZxjZIHBl5tBeVvoBC8Zq8N9dhVSMW0
 8yxHDobUCz/LwIODl/LDuMrSwdMipg0Pj5SA4/OUtNTtgvPaIgufjP9VeQ8zPWSB6vOi/7Uvh
 AWpQYElHuOb5Xhc5CDseei9mLF1Qr1mwd5JuN24fAHE6P2084js0XyZtNLzXQTr5s1UIZpLxk
 vkjeDPu973eH2EIq+/tBTsEQpQbQ3iaS6jjk8Jnh3WAiUcYHJrv/dBNRbHo13qPFx1s+1Zc9f
 CqTzhSQf1SEwFAqgXG09KcJxwN/syZx7rYOZo0UJM20nJ1dQAqmCcaYW3ZGS5fhpBDLUasiz0
 3xFh59lY/hMYfa01i9RZOHRqLMsGGjzsIQ7xyoTZE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
> SNDRV_TIMER_IOCTL_START - Start selected alsa timer
> 
>     Starts the timer device that is selected. The third ioctl's argument is
>     ignored. Before calling this ioctl, the ioctl "SNDRV_TIMER_IOCTL_SELECT"
>     should be called first to select the timer that is to be started. If no
>     timer is selected, the error EBADFD ("File descriptor in bad shape")
>     is returned.
> 
> SNDRV_TIMER_IOCTL_STOP - Stop selected alsa timer
> 
>     Stops the timer device that is selected. The third ioctl's argument is
>     ignored. Before calling this ioctl, the ioctl "SNDRV_TIMER_IOCTL_SELECT"
>     should be called first to select the timer that is to be stopped. If no
>     timer is selected, the error EBADFD ("File descriptor in bad shape")
>     is returned.
> 
> SNDRV_TIMER_IOCTL_CONTINUE - Continue selected alsa timer
> 
>     Continues the timer device that is selected. The third ioctl's argument is
>     ignored. Before calling this ioctl, the ioctl "SNDRV_TIMER_IOCTL_SELECT"
>     should be called first to select the timer that is to be continued. If no
>     timer is selected, the error EBADFD ("File descriptor in bad shape")
>     is returned.
> 
> SNDRV_TIMER_IOCTL_PAUSE - Pause selected alsa timer
> 
>     Pauses the timer device that is selected. The third ioctl's argument is
>     ignored. Before calling this ioctl, the ioctl "SNDRV_TIMER_IOCTL_SELECT"
>     should be called first to select the timer that is to be paused. If no
>     timer is selected, the error EBADFD ("File descriptor in bad shape")
>     is returned.
> 
> Implementation notes:
> 
>     Since all of the implemented ioctls have NULL as their third argument,
>     their implementation was straightforward.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>  linux-user/ioctls.h       | 4 ++++
>  linux-user/syscall_defs.h | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 43e7e5d..75a2f0e 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -466,6 +466,10 @@
>          MK_PTR(MK_STRUCT(STRUCT_snd_timer_params)))
>    IOCTL(SNDRV_TIMER_IOCTL_STATUS, IOC_R,
>          MK_PTR(MK_STRUCT(STRUCT_snd_timer_status)))
> +  IOCTL(SNDRV_TIMER_IOCTL_START, 0, TYPE_NULL)
> +  IOCTL(SNDRV_TIMER_IOCTL_STOP, 0, TYPE_NULL)
> +  IOCTL(SNDRV_TIMER_IOCTL_CONTINUE, 0, TYPE_NULL)
> +  IOCTL(SNDRV_TIMER_IOCTL_PAUSE, 0, TYPE_NULL)
>  
>    IOCTL(HDIO_GETGEO, IOC_R, MK_PTR(MK_STRUCT(STRUCT_hd_geometry)))
>    IOCTL(HDIO_GET_UNMASKINTR, IOC_R, MK_PTR(TYPE_INT))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index d76124d..311aec0 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -2505,6 +2505,10 @@ struct target_snd_timer_status {
>                                                           struct snd_timer_params)
>  #define TARGET_SNDRV_TIMER_IOCTL_STATUS       TARGET_IOR('T', 0x14,                      \
>                                                           struct target_snd_timer_status)
> +#define TARGET_SNDRV_TIMER_IOCTL_START        TARGET_IO('T', 0xa0)
> +#define TARGET_SNDRV_TIMER_IOCTL_STOP         TARGET_IO('T', 0xa1)
> +#define TARGET_SNDRV_TIMER_IOCTL_CONTINUE     TARGET_IO('T', 0xa2)
> +#define TARGET_SNDRV_TIMER_IOCTL_PAUSE        TARGET_IO('T', 0xa3)
>  
>  /* vfat ioctls */
>  #define TARGET_VFAT_IOCTL_READDIR_BOTH    TARGET_IORU('r', 1)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

