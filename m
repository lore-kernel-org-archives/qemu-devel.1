Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92B1C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 07:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B162F21849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 07:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B162F21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoNLK-00013G-TG
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 03:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34321)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hoNL8-0000T1-6s
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 03:30:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hoNL7-0002jl-9g
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 03:30:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hoNL7-0002jG-4T
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 03:30:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so31242467wrs.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 00:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h6SaMbLUxsNfiBr7ugrdEUpYvlqkvzcv1pXbGi5RT1M=;
 b=DO+46/0nuoAvYi58zfL03bY769AhcjkktLqz8nRbCN2IgXDZ3rGnB/HioVNAxh00zj
 soaTXUvHRhtzqwu9ZqvAGQ5INEjag0F7dt5FMKZYUQu7sleH2VsYwU7ZQj3wYWnq8IqO
 pze+dOqAcChr4Gpusfrj/xaMUM3YxpURZ7xegA4WneLQaTBC1/P6GhDGji2+F9GrNHNJ
 fihX8ZzpQc447c7RN2x4B3WZOdjVrwtEqCMJCBPrBaZwI97dQHn2uzVHlTg2CzQWesec
 CbkpzTbqrUn9ZMxl66zwKcCOscbpinsm0fYj0E8nIsAjvJJeANJrrRaQGqBL5zu1RpkZ
 CBHw==
X-Gm-Message-State: APjAAAU83NwHRGakv9UmES50FpBBpegMFYn+ZYM5727fxNvWQydhwzoW
 sY54/+AV6mqmTPFw0gYNxYiD0xyR034=
X-Google-Smtp-Source: APXvYqyDuAPd/yqV+G7Ng5nCxr2od2WHT74hWcn2Zamu93Si8xG6J5REr8aRzCW+x2cGKLzRE/uvHw==
X-Received: by 2002:a5d:618d:: with SMTP id j13mr53836462wru.195.1563521400051; 
 Fri, 19 Jul 2019 00:30:00 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id v15sm29519376wrt.25.2019.07.19.00.29.58
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 00:29:59 -0700 (PDT)
To: Stefan Weil <sw@weilnetz.de>, Gerd Hoffmann <kraxel@redhat.com>
References: <20190718193441.12490-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6241fd95-789f-f560-2170-0544cded1720@redhat.com>
Date: Fri, 19 Jul 2019 09:29:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190718193441.12490-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH] audio: Add missing fall through comments
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/18/19 9:34 PM, Stefan Weil wrote:
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  audio/audio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/audio/audio.c b/audio/audio.c
> index 5fd9a58a80..a7a13e900a 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -304,6 +304,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as)
>  
>      case AUDIO_FORMAT_S16:
>          sign = 1;
> +        /* fall through */
>      case AUDIO_FORMAT_U16:
>          bits = 16;
>          shift = 1;
> @@ -311,6 +312,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as)
>  
>      case AUDIO_FORMAT_S32:
>          sign = 1;
> +        /* fall through */
>      case AUDIO_FORMAT_U32:
>          bits = 32;
>          shift = 2;
> 

