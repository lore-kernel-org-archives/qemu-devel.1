Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80CBC32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 07:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3E720815
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 07:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3E720815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFvgc-0007S9-3f
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 03:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFvfb-00070E-G0
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 03:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFvfZ-0001Ib-7t
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 03:37:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFvfY-0001I8-UC
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 03:37:01 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 89DCAC01DDF8
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 07:36:59 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id k67so349026wmf.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 00:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W3EsOsvmNUmQAz/nexuOfn5PJzideo+emXBuvFvVC+Q=;
 b=UI4FN7nZHhgf6LUqU1bwLPrZv32zXPTqbyYYVVhPho1fYCI8z2hShHvAimzD/JUb9E
 +xazSpXC7IU4An7dWtS+JmsRNERtxuYkKqTvHu8qCK5kBVbTYoEEzeJlOy/cx9NBYcCC
 L1UoJhL9zKEqmscaLHyu5w+/JJMyD7LnbPRlyziDlNVwyHycdQOm+o+1seJN1t9LGdR+
 mJsT91eAHQ4WDjmyG9M6jn2KQjJttyXyzW9j2PXZkw8p93X/pb6yfJVMQ8fUY0XuBDwn
 m5EUWYKMKcJhcL+mm1Az1JVrkw1v+HmwDo8MnCqVhLoROnzbUoElDJ4XsqsSMm2er42Q
 nuFw==
X-Gm-Message-State: APjAAAUDCYkShhdpZkGEurkxGLEk6CWn7HQsFdyKVcSnpRMgRFNE50o8
 DMysbULH/jgjfOfJEku3FkfgMnCEkcwfat66nx5Kn9kLN9xOcZ+vWzHOmrfz3km2ToMOSuRXMcF
 iE3aAOH+mMmfesuI=
X-Received: by 2002:a5d:4ac6:: with SMTP id y6mr628879wrs.102.1570088218326;
 Thu, 03 Oct 2019 00:36:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxhnmSUetJHKgFusFimZaKOrqf8PZlz2ubYzwqetopoMyiCL71bIVJutOA4BLos6d+HnN1e3Q==
X-Received: by 2002:a5d:4ac6:: with SMTP id y6mr628862wrs.102.1570088218069;
 Thu, 03 Oct 2019 00:36:58 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id h63sm3528149wmf.15.2019.10.03.00.36.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2019 00:36:57 -0700 (PDT)
Subject: Re: [PATCH] curses: correctly pass color and attributes to setcchar()
To: Matthew Kilgore <mattkilgore12@gmail.com>, qemu-devel@nongnu.org
References: <20191003001849.7109-1-mattkilgore12@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <58556cc8-0810-4630-5162-0a3a94484c4b@redhat.com>
Date: Thu, 3 Oct 2019 09:36:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191003001849.7109-1-mattkilgore12@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: samuel.thibault@ens-lyon.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Matthew,

On 10/3/19 2:18 AM, Matthew Kilgore wrote:
> The current code uses getcchar() and setcchar() to handle the cchar_t
> values, which is correct, however it incorrectly deconstructs the chtype
> value that it then passes to setcchar():
> 
>      1. The bit mask 0xff against the chtype is not guaranteed to be
>         correct. curses provides the 'A_ATTRIBUTES' and 'A_CHARTEXT' masks
>         to do this.
> 
>      2. The color pair has to be passed to setcchar() separately, any color
>         pair provided in the attributes is ignored.

You clearly describe 2 different changes in the same patch.
Do you mind splitting in 2 atomic patches?

> 
> The first point is not that big of a deal, the 0xff mask is very likely
> to be correct. The second issue however results in colors no longer
> working when using the curses display, instead the text will always be
> white on black.
> 
> This patch fixes the color issue by using PAIR_NUMBER() to retrieve the
> color pair number from the chtype value, and then passes that number to
> setcchar.

> Along with that, the hardcoded 0xff masks are replaced with
> A_ATTRIBUTES and A_CHARTEXT.

This comment would go in the 1st patch.

> 
> Signed-off-by: Matthew Kilgore <mattkilgore12@gmail.com>
> ---
>   ui/curses.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/ui/curses.c b/ui/curses.c
> index ec281125acbd..3a1b71451c93 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -75,14 +75,16 @@ static void curses_update(DisplayChangeListener *dcl,
>       line = screen + y * width;
>       for (h += y; y < h; y ++, line += width) {
>           for (x = 0; x < width; x++) {
> -            chtype ch = line[x] & 0xff;
> -            chtype at = line[x] & ~0xff;
> +            chtype ch = line[x] & A_CHARTEXT;
> +            chtype at = line[x] & A_ATTRIBUTES;
> +            short color_pair = PAIR_NUMBER(line[x]);
> +
>               ret = getcchar(&vga_to_curses[ch], wch, &attrs, &colors, NULL);
>               if (ret == ERR || wch[0] == 0) {
>                   wch[0] = ch;
>                   wch[1] = 0;
>               }
> -            setcchar(&curses_line[x], wch, at, 0, NULL);
> +            setcchar(&curses_line[x], wch, at, color_pair, NULL);
>           }
>           mvwadd_wchnstr(screenpad, y, 0, curses_line, width);
>       }
> 

