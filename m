Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ED3C76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 14:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2772190F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 14:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2772190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpZhc-0007op-Ud
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 10:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41944)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hpZhR-0007IU-TT
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hpZhP-0007tu-TV
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:54:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hpZhP-0007t2-N5
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:53:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id x1so24760006wrr.9
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 07:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=48pSmTsfX1IBuy3Fdbci5jqhLK0Buu4mrlDndjI5zd0=;
 b=ObzZQgKIXJvJvov3ntMZd28DNZnxo51KLCC7fCdpL/4RFH2J6K5aKhhqOaIia6pArB
 8ibCaru5+STjEEZ+ciY9s9Ue1Z3oNceLSwKt6pVweJrn9kX5GsFLScw6DGyehRGrKGo7
 CH3xgNZ5F3TCjc8g8RR+8c4egj9sqKv2OD7XWs4PrE5fYVF6kEdzqdoqO5gsypcoaHwz
 1uAbRsCHTD7upmUgE3PvhNE3cu0Yw6hXRAyiQ1DbOjsjaCvg4QtuK4/MYh/VpbS3loUR
 FexTf0F6kmO+/MM6NtX+B3oKn7Flco0JgF42GbOgKfjDPnI6xRJXzdqoBA0UaR9Tg4Bx
 ShDQ==
X-Gm-Message-State: APjAAAUkaM7r6PsupM8GnP6rluw0jtW9PnJKlNbqhiGopFjYGik2rKWU
 OFTEk7J2MaiyT32kla6obKcD7A==
X-Google-Smtp-Source: APXvYqxsCUx67QJAaL3HigWdxsDCFtvLqlP2b5uEprIc/5YVuBkaBdqMeBcUjeUJ0ujXRAm2SIYSfA==
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr72437652wrw.276.1563807238627; 
 Mon, 22 Jul 2019 07:53:58 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id t185sm33189789wma.11.2019.07.22.07.53.57
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 07:53:58 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1563806584-25975-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1563806584-25975-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c87c368d-9ce9-0059-4753-dd8579eba633@redhat.com>
Date: Mon, 22 Jul 2019 16:53:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1563806584-25975-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH for 4.1 v5 1/2] target/mips: Add 'fall
 through' comments for handling nanoMips' SHXS, SWXS
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
Cc: arikalo@wavecomp.com, sw@weilnetz.de, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 7/22/19 4:43 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> This was found by GCC 8.3 static analysis.
> 

Can you add:

"Missed in commit fb32f8c8560."

So when looking at this commit the missing 'fall through' is more obvious.

> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks,

Phil.

> ---
>  target/mips/translate.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 3575eff..ca62800 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -20141,12 +20141,14 @@ static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
>          switch (extract32(ctx->opcode, 7, 4)) {
>          case NM_SHXS:
>              check_nms(ctx);
> +            /* fall through */
>          case NM_LHXS:
>          case NM_LHUXS:
>              tcg_gen_shli_tl(t0, t0, 1);
>              break;
>          case NM_SWXS:
>              check_nms(ctx);
> +            /* fall through */
>          case NM_LWXS:
>          case NM_LWC1XS:
>          case NM_SWC1XS:
> 

