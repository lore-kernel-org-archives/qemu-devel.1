Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEB6C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 09:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1BA42070C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 09:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BA42070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx6FL-00026I-Vd
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 05:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38397)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hx6Et-0001fq-4R
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 05:03:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hx6Es-0006Ks-7s
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 05:03:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38645)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hx6Es-0006KS-1t
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 05:03:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id m125so7007994wmm.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 02:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pG3eyV5qyxx0kyDWxZ2LvsVScCi8zWEAvOHWj4p2YRM=;
 b=pLmyJqvHSxZuCht3vOYyuBU9RWKf8//G8JWVGnNO8/H4tOK1HgGZ4IjhWbsl9A7H+j
 6nurAJchSeiTeW4oQWeNGlaaTTjyXhaZ6TCRTEY8tTSWCZDdSFeyzHSidRLnMKlWl0Ee
 tU2XOWNebeGb9WnPqRAktJ5q6r1pEhV5uKN1XftDXakqmApbvM7nLqm5p88og8pSFo4j
 O2+yPxztkCXOTJrSF26SZh4rny9cw8DfdtNjxpUU1evfxAj9dg+3xG+mm6wbg/BMHN1l
 t2uaHvONu8jLEPG8TusyA58d8YYZBdvmXKlDWV1FvEuBvMAUThQZa7szGZTkZWSGuRGc
 W/7A==
X-Gm-Message-State: APjAAAXPxkEx4H7OrJzK9qHKSwFeiV7xtJMzA0nOpUWmoZUH7RgaaPt2
 G6BoZxqzH5rLqekLXT0KujPx0tHfPl8=
X-Google-Smtp-Source: APXvYqzw6Pkc0XRM+1J/eVWc+rNLsVxaAh76nJxG/Jsqkw9xUa6aZPCNoLgI1fg561A4YQCFXMfJwQ==
X-Received: by 2002:a05:600c:228e:: with SMTP id
 14mr1834957wmf.101.1565600617121; 
 Mon, 12 Aug 2019 02:03:37 -0700 (PDT)
Received: from [192.168.1.37] (225.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.225])
 by smtp.gmail.com with ESMTPSA id x6sm112818461wrt.63.2019.08.12.02.03.36
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 02:03:36 -0700 (PDT)
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <cover.1565558093.git.balaton@eik.bme.hu>
 <d99f9e07923a74932dbb15e93dd50aa8d2816b19.1565558093.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <55657720-8636-6997-932d-1aa88688d184@redhat.com>
Date: Mon, 12 Aug 2019 11:03:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d99f9e07923a74932dbb15e93dd50aa8d2816b19.1565558093.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 4/7] ati-vga: Fix cursor color with
 guest_hwcursor=true
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/11/19 11:14 PM, BALATON Zoltan wrote:
> Fixes: a38127414bd007c5b6ae64c664d9e8839393277e
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/ati.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 699f38223b..b849f5d510 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -207,7 +207,7 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
>                  }
>              } else {
>                  color = (xbits & BIT(7) ? s->regs.cur_color1 :
> -                                          s->regs.cur_color0) << 8 | 0xff;
> +                                          s->regs.cur_color0) | 0xff000000;
>              }
>              if (vga->hw_cursor_x + i * 8 + j >= h) {
>                  return; /* end of screen, don't span to next line */
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

