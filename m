Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9725DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D03206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AN1KGCap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D03206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkrGL-0007de-Jk
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 11:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkrFf-0007BS-Ix
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:42:23 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkrFd-0005Ux-Mb
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:42:23 -0400
Received: by mail-ot1-x344.google.com with SMTP id 69so13456156otv.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 08:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/+oTDAUuYHbqzSHMPFX+92Wmj72nXwbVPeckQg8YmMg=;
 b=AN1KGCapj98it9cN/7dvJ8SMGC6UMILZbouu42u5sXHCyKj6hYNpydSzP2hdVn2FrX
 0MZRre0G7hlaUM3aiMf1cQwwP+m7pXCCr3X8yYFbHvGo2zJTPL6HO6GKH/okI2iT4Jbi
 NYFVp0gf7f6MAshLSr4UlaSLEKJi+IGekWcHBwJgW47DpJKx8U5ojLhwO3tMUuQKFOMd
 WbmIyZEO5BJoZ2xp6ELi0Cb8kQGd7n0cP/4NHnn6qgv2IIRe1e+K68kuJVL79KqNoiPB
 SiQYZ8syVUmenobf0bJCKtctPj7TraGmRCnjrtULqSh8+2MVF5IUDSW0tUl0js/TQKTf
 xU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/+oTDAUuYHbqzSHMPFX+92Wmj72nXwbVPeckQg8YmMg=;
 b=a2jKOKsUKRiJEELSqC5zIUaSQ8WdlvgYkaD9vwOMS7C3W3v4KALryxCECo633ISZzy
 GyrTuzEhmAGbCguKrdd/tSKE052pkbhYWS1CaTgNqG1+YlBZ/2MI7a0/rHLVGrXONNHM
 lyAeKuxswP6L/RdhHZmGKbd3Q5AwTPEukYr84E1wvg9/M2yBqNHPY6UXUbxixNAdAkH0
 iWZPlWs89lnHdOjTEP5gMB4n8lImtk5EMLYdjn3Z9HvgmZvyE8sE0xm8XoHg342miXFA
 zuvqYHq2oUCDYyaERh+B3lCtRSFKE7oeNsvEkwKnh10dW/EJdDA689ZRzkOZU6zzM6Ja
 nuuA==
X-Gm-Message-State: AOAM533XEkVP3ll3RDrzPNBac8y6I+/NFyppCO5QQTaOnWdQAk37DSt+
 NKOJ0jdTULj+Y/j98t6zJjZYQQD+VafgLxCX7gEVxA==
X-Google-Smtp-Source: ABdhPJxEscsmX2dNjMkCSZeRcAI9BuHbJmbW63WVhOyc/FfGojdgoTq29o4XdFJqsvlOpnhZruk3K7LKLHE+zeWhxD4=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr22564095ote.135.1592235740415; 
 Mon, 15 Jun 2020 08:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591471056.git.balaton@eik.bme.hu>
 <9fab4fe6513fe8b921ce86a57f4ff7e0d5a3c3f9.1591471056.git.balaton@eik.bme.hu>
In-Reply-To: <9fab4fe6513fe8b921ce86a57f4ff7e0d5a3c3f9.1591471056.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 16:42:09 +0100
Message-ID: <CAFEAcA-QBJ2CTRzjD=KY7WPHXaK=Qw514KTKvb8psRPrEAGyXA@mail.gmail.com>
Subject: Re: [PATCH 4/4] sm501: Optimise 1 pixel 2d ops
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 6 Jun 2020 at 20:22, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Some guests do 1x1 blits which is faster to do directly than calling a
> function for it so avoid overhead in this case.

How much does the performance improve by ?

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/sm501.c | 40 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 3397ca9fbf..59693fbb5c 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -793,6 +793,25 @@ static void sm501_2d_operation(SM501State *s)
>                  src_x == dst_x && src_y == dst_y) {
>                  break;
>              }
> +            /* Some clients also do 1 pixel blits, avoid overhead for these */
> +            if (width == 1 && height == 1) {
> +                unsigned int si = (src_x + src_y * src_pitch) * (1 << format);
> +                unsigned int di = (dst_x + dst_y * dst_pitch) * (1 << format);
> +                switch (format) {
> +                case 0:
> +                    s->local_mem[dst_base + di] = s->local_mem[src_base + si];
> +                    break;
> +                case 1:
> +                    *(uint16_t *)&s->local_mem[dst_base + di] =
> +                                    *(uint16_t *)&s->local_mem[src_base + si];
> +                    break;
> +                case 2:
> +                    *(uint32_t *)&s->local_mem[dst_base + di] =
> +                                    *(uint32_t *)&s->local_mem[src_base + si];
> +                    break;
> +                }

You could write this more compactly as
                   stn_he_p(&s->local_mem[dst_base + di], 1 << format,
                            ldn_he_p(&s->local_mem[src_base + si], 1
<< format));

(which handles the length-cases for you and also doesn't rely on
casting a uint8_t* giving you something correctly aligned for a
wider access).

> +                break;
> +            }
>              /* Check for overlaps, this could be made more exact */
>              uint32_t sb, se, db, de;
>              sb = src_base + src_x + src_y * (width + src_pitch);
> @@ -841,9 +860,24 @@ static void sm501_2d_operation(SM501State *s)
>              color = cpu_to_le16(color);
>          }
>
> -        pixman_fill((uint32_t *)&s->local_mem[dst_base],
> -                    dst_pitch * (1 << format) / sizeof(uint32_t),
> -                    8 * (1 << format), dst_x, dst_y, width, height, color);
> +        if (width == 1 && height == 1) {
> +            unsigned int i = (dst_x + dst_y * dst_pitch) * (1 << format);
> +            switch (format) {
> +            case 0:
> +                s->local_mem[dst_base + i] = color & 0xff;
> +                break;
> +            case 1:
> +                *(uint16_t *)&s->local_mem[dst_base + i] = color & 0xffff;
> +                break;
> +            case 2:
> +                *(uint32_t *)&s->local_mem[dst_base + i] = color;
> +                break;
> +            }

               stn_he_p(&s->local_mem[dst_base + i], 1 << format, color);


> +        } else {
> +            pixman_fill((uint32_t *)&s->local_mem[dst_base],
> +                        dst_pitch * (1 << format) / sizeof(uint32_t),
> +                        8 * (1 << format), dst_x, dst_y, width, height, color);
> +        }
>          break;
>      }
>      default:

thanks
-- PMM

