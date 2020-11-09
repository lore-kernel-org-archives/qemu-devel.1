Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3F2C4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 23:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8E9206A1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 23:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxDThbvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8E9206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcGWB-0000se-Sd
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 18:24:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kcGVc-0000SN-1n; Mon, 09 Nov 2020 18:23:36 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:40212)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kcGVa-0002yZ-6X; Mon, 09 Nov 2020 18:23:35 -0500
Received: by mail-io1-xd44.google.com with SMTP id r9so11667718ioo.7;
 Mon, 09 Nov 2020 15:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/CiICKz+2B4vpnhgWNO7lP4LrrkBoaFELKFIpWJ8nuQ=;
 b=sxDThbvMD6h4roH6euJWOZGUlF4OW3I6WBktBVEnIKGCYQp0cOpcUJ9YzlEyA1iRCK
 peRsLJlle2CTTTv/kGDx9e/JsVbdeFDVyMQzat+VwV4uM8JwFgt0NOL6vcoKZNf2Hwzv
 eqaRdEQu+GTTQv+qnhC4Pe35nML7Ymmqe+r2I70FPfte/fxGyGXr+akUG+MMITmOhiI4
 SKgTJLz5NdWcAmciXJ2i3AqdwJdfCduAA2xJi1aSxgPLI0bX0VVHNypC2oF+YLcUDVkb
 dIzLbwHlFhR+g90bnpkK6/+T/2j8LUHEHrP6RvYMsJ7eU/CGo2J6hRVVYjdAwnWtWF4M
 7/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/CiICKz+2B4vpnhgWNO7lP4LrrkBoaFELKFIpWJ8nuQ=;
 b=Ub7OxHM5jmgqMk636FXWs4i5/c2LAUKWOZDbtZGuEvTEsJB5baVHMmZsdbaDLrPOln
 uDpmH6QdlReCgkdzAMxDzgJ3JL8lrvNx9B7E84L0K16Re1JoZKXWJICuLUoID1Cz8jSK
 Squ9YPTCCQbxEa/VeEsfjIzRHKjVPIl09uW/mPbTD2IAyGCOqWBllaoyyaWfe9VpVlIv
 SF0Eg5FRyq2gZxk0UVs8O5KWDUg3JjNHfGlH8Yr3Jbd7mf4w8xqfFcHmwrrkX/HOHKfa
 PltxRVcWnCJMR/euI9MTPqLVZ3IDAuR40/2r9zYkD85q5yZE8cYP9ut10IdpCX4Ms7sw
 EGuA==
X-Gm-Message-State: AOAM533vV+7Wh7v8ODDODF/0F1jza+k380CMoVPtB5DR8N5C3n4IJlq4
 K4tvsalJTxQjknXj/IIgvLJ49ynmPoE9ptYzlXQ=
X-Google-Smtp-Source: ABdhPJxaBO50xD8Wc31vTN9B1vm/hK1RntMTsv2LnyvfGmhQyXy8JavfwX+2dVD4WzLUYGjzmc1Oell7dwcEI8xyguc=
X-Received: by 2002:a02:6c09:: with SMTP id w9mr1476298jab.135.1604964212294; 
 Mon, 09 Nov 2020 15:23:32 -0800 (PST)
MIME-Version: 1.0
References: <68d4575deef2559b7a747f3bda193fcf43af4558.1604629928.git.alistair.francis@wdc.com>
 <1ef9a373-9c67-d12f-014a-9a88520b9635@amsat.org>
In-Reply-To: <1ef9a373-9c67-d12f-014a-9a88520b9635@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Nov 2020 15:11:31 -0800
Message-ID: <CAKmqyKPLg+-gmGBj0iKryOYz8VfCWFZqPccS+qLZa2qAoAwggQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] hw/intc/ibex_plic: Clear the claim register when
 read
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 6, 2020 at 6:20 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> On 11/6/20 3:32 AM, Alistair Francis wrote:
> > After claiming the interrupt by reading the claim register we want to
> > clear the register to make sure the interrupt doesn't appear at the nex=
t
> > read.
> >
> > This matches the documentation for the claim register as it clears the
> > pending bit (which we already do): https://docs.opentitan.org/hw/ip/rv_=
plic/doc/index.html
>
> "When an interrupt is claimed by a target the relevant bit of IP is
> cleared." Correct.

Yep, I improved this.

>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks

Alistair

>
> >
> > This also matches the current hardware.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/intc/ibex_plic.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/hw/intc/ibex_plic.c b/hw/intc/ibex_plic.c
> > index f49fa67c91..235e6b88ff 100644
> > --- a/hw/intc/ibex_plic.c
> > +++ b/hw/intc/ibex_plic.c
> > @@ -139,6 +139,9 @@ static uint64_t ibex_plic_read(void *opaque, hwaddr=
 addr,
> >          /* Return the current claimed interrupt */
> >          ret =3D s->claim;
> >
> > +        /* Clear the claimed interrupt */
> > +        s->claim =3D 0x00000000;
> > +
> >          /* Update the interrupt status after the claim */
> >          ibex_plic_update(s);
> >      }
> >
>

