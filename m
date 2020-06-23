Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF7CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 23:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C7C20780
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 23:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGUWXkAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C7C20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnsTV-0003iF-GK
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 19:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jnsSt-0002pj-K1
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 19:36:31 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:33936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jnsSr-0000bl-TM
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 19:36:31 -0400
Received: by mail-io1-xd44.google.com with SMTP id m81so195698ioa.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 16:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Nl9jXdNtjAnTCrHlyLE4JKGJ5lvNmMPxJLiGu3DMeiA=;
 b=bGUWXkAy3TXr3oqC4qPelN2zc8gnMZEdpLP3VY7K5r7JmUbDA8HAemH5enETUY40Ef
 klZqEdT/SgPvSvXiGUWF9u9yei1XgAxtRCDI2xY7OA9DFFuFAZy/d+8kLePVF+u7+vvZ
 RsIVhKxrpvMGzfGrGpsX72gKEtAG4qDD4irnwoZl1kDxgDN6B4jqfX6tfOdc8ZFpIs97
 qnT3Up1OC/neH3j4Ar6MC0k92cL9C/A8K3hmHqXYMdvFb5hY+mf1W3fShSUnEMkN4LRi
 y9TG85ymRuLH8RcbfuV9w1lgtg8rqeBQG9HAE95zop8gE+Tb+ajzdtwRRjC/qQ8RAswf
 Wq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Nl9jXdNtjAnTCrHlyLE4JKGJ5lvNmMPxJLiGu3DMeiA=;
 b=E0hy4c25UPtcIz+Mh8NRBpJb0FhXFtstHYXFLDBUtqb320C0bot0tIr8Ga7ZYPLF6O
 vRyQUnBLWXbM0rzvV9EQlyUGXM0FyiO1wDVUFxQYKC5RNye8V20iBEBpBkacTt0OJ1hq
 4CNm7CJ+AOGc+TOHpgm+9TscQDR0dLu2jq6mFCrjGnVWI9vkz7PGrQkbHgJn8HPtRe5e
 +z3bonTwWHK4Hr77kvr7EcpoQTF0i9G0lc5jw+faBi2geCS2EthPgYjbQZoFU6gQeE+e
 /1UCwyX/oMp7K9OMVzS8FB7HM3s8u+wKFneUZ7RsQIubFNphfpbjQln5O0+gmveJnGNE
 wrGw==
X-Gm-Message-State: AOAM5325cQybRQQ2Q35KIEXVktCaDeNJLgrElcNDRU/7theOut3bTf9O
 u1AOV6d87Q0HEg6pdCuHsKpjpCLYdHKjGwzVGaBKBkL3
X-Google-Smtp-Source: ABdhPJyoWCpXE02O8apDVS06t7kC4vVJSaHSXlmwx830+TITN6vpvY+apUvd8LkTDwagCLEc4pw4kPB+6YELt59QxWI=
X-Received: by 2002:a05:6638:dd3:: with SMTP id
 m19mr27460860jaj.106.1592955387989; 
 Tue, 23 Jun 2020 16:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200623195441.14646-1-pbonzini@redhat.com>
In-Reply-To: <20200623195441.14646-1-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 23 Jun 2020 16:26:55 -0700
Message-ID: <CAKmqyKP4c1qBcWYP3R1bXB8xCR-6GBqwRe6qEYHkMNBjH3LVnA@mail.gmail.com>
Subject: Re: [PATCH] ibex_uart: fix XOR-as-pow
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 1:07 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The xor-as-pow warning in clang actually detected a genuine bug.
> Fix it.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/char/ibex_uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
> index 3e0dd9968e..45cd724998 100644
> --- a/hw/char/ibex_uart.c
> +++ b/hw/char/ibex_uart.c
> @@ -331,7 +331,7 @@ static void ibex_uart_write(void *opaque, hwaddr addr,
>          if (value & UART_CTRL_NCO) {
>              uint64_t baud = ((value & UART_CTRL_NCO) >> 16);
>              baud *= 1000;
> -            baud /= 2 ^ 20;
> +            baud >>= 20;

Whoops, that is clearly wrong. Thanks for catching this.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
>              s->char_tx_time = (NANOSECONDS_PER_SECOND / baud) * 10;
>          }
> --
> 2.26.2
>
>

