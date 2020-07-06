Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F929C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E273D206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNFMlh4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E273D206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsU8Q-0006ZO-7d
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsU7V-0005X5-Bl; Mon, 06 Jul 2020 12:37:29 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:39989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsU7T-0002AR-NJ; Mon, 06 Jul 2020 12:37:29 -0400
Received: by mail-il1-x143.google.com with SMTP id e18so22738885ilr.7;
 Mon, 06 Jul 2020 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gUa/JAequ5IOqanfZzjwe7iEx/8B4O6WJ7E2KVpYgKc=;
 b=GNFMlh4/llPGqic0xnoM+u3q+H/vXIj80H2Lyck23QC2borcKGqxnQze4wwpxW0bv2
 Jno8bRQsCim2lV8QgIrJ/KyA+7UdOEGZnUDt5TbMbENY7/JempE8lNA74CyQMOAH1+yU
 xtZ/UcVGUCFvlJ1+QjD0Ztz0RHMkMa3/sW13+i0c/hdvuuRPCjvwhhUxQwDCHl4J1oN7
 K+ahdUPvIHnEgfEEYw0tx2ek0itPAh4oSJQCXYYEjaJvoyjIdeOwX3ElYWl0OpD0LmDZ
 aNUej1qzFnvvlBwlMjT8LImsVYK4I7x7oMGgEBp9S+Cf/MH4sr1IA+eStjS7OHJQVzrg
 hlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gUa/JAequ5IOqanfZzjwe7iEx/8B4O6WJ7E2KVpYgKc=;
 b=GGjU41DEI6HradF0QwIQ/Uj51hd+ab4cQi9lKH+Er52MBNz8stJmrTtcIfrQMqDMhC
 Kxoy+p+8lxhyTga6imFgbk2mEdd9V0HoMkBx602t6ITNxp28j6yux8FtHShlxWOmBZ48
 U9NhNfBi85z3j97aqnfA+05Lx2dEP8rjfonPlWeigAA/i7YJaumTQUkYOtJNIksVtBAn
 G2WbN8m9UydlTKaM6H7wAx9x2jUdZ/rUZWD7gpEWjlvs7cJn5btUvr/rtcc5T8wU4C+b
 GUQLbW2b7lmmMvl9zvTQR1NcJVmeDVaySBCbrGh3j/jy9G5ld9m6Wtn4wbCgwHPKIT+Q
 ZMrA==
X-Gm-Message-State: AOAM530C+dcxeZhYjfPgM2d7+KAFtR8rgVp/ATfm/LxOS0/0EjbFd1pS
 AtnlOQ/H/21y3Cts7G8XyLPIabIeUy4B+usuHFPAgtNO
X-Google-Smtp-Source: ABdhPJzCWYErNKhtLyQYqRHLcYxzZZg7PCRyk6WbfeM2A8lD/Mpyhxguk7UVN+YsUOsdEzSnhtvBTxI2ahx4PLseIX0=
X-Received: by 2002:a92:bb84:: with SMTP id x4mr32098391ilk.177.1594053446396; 
 Mon, 06 Jul 2020 09:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-7-f4bug@amsat.org>
In-Reply-To: <20200630133912.9428-7-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:27:36 -0700
Message-ID: <CAKmqyKN6h1BWaD3kryxkAHDGwsiMbJoLWTckZ+borPbOCQeMyg@mail.gmail.com>
Subject: Re: [PATCH v7 06/17] hw/sd/sdcard: Restrict Class 6 commands to SCSD
 cards
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 6:44 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Only SCSD cards support Class 6 (Block Oriented Write Protection)
> commands.
>
>   "SD Specifications Part 1 Physical Layer Simplified Spec. v3.01"
>
>   4.3.14 Command Functional Difference in Card Capacity Types
>
>   * Write Protected Group
>
>   SDHC and SDXC do not support write-protected groups. Issuing
>   CMD28, CMD29 and CMD30 generates the ILLEGAL_COMMAND error.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/sd/sd.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 7e0d684aca..871c30a67f 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -922,6 +922,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, =
SDRequest req)
>          sd->multi_blk_cnt =3D 0;
>      }
>
> +    if (sd_cmd_class[req.cmd] =3D=3D 6 && FIELD_EX32(sd->ocr, OCR, CARD_=
CAPACITY)) {
> +        /* Only Standard Capacity cards support class 6 commands */
> +        return sd_illegal;
> +    }
> +
>      switch (req.cmd) {
>      /* Basic commands (Class 0 and Class 1) */
>      case 0:    /* CMD0:   GO_IDLE_STATE */
> --
> 2.21.3
>
>

