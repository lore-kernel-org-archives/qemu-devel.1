Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A91C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 07:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 919E22068D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 07:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="gYkrJTNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919E22068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWbJv-0002Qg-Lt
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 02:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iWbEU-0000Ml-Dh
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 02:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iWbET-0006U6-Bn
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 02:13:58 -0500
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:41957)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iWbER-0006Rh-0Y; Mon, 18 Nov 2019 02:13:55 -0500
Received: by mail-qk1-x741.google.com with SMTP id m125so13527491qkd.8;
 Sun, 17 Nov 2019 23:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=31Nu3T80N9bZJ37joS3KaPNV8Dkm3/7sO4X0iTZqs+k=;
 b=gYkrJTNyuHG9UM7e4o91LJX4fjOlK86/l2RTHIvUwDJuUbIg6UvNJN5RDA4PcnG7f+
 iqgN7e2E7qfkHFHqwMkF4YaotgRtaiEAnsvZO1E62FU3T7dmRH1gNCQtd9wLrl3s1xy3
 HchSuvd/NzJZNt7/ruzQ814XGN1g8QZ3GemEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=31Nu3T80N9bZJ37joS3KaPNV8Dkm3/7sO4X0iTZqs+k=;
 b=QtCsP+uluM7O1rHneqVLByiz66JFVKst2hzQkfyp6x/Y/2dnreTMChwYXXkbwymPtM
 q/bZvcLAHW4D6kz7PPyrIW8Li6OcJL+Dl2J70y7kgx4i9UQoID4bHqwgxkynWPhtikIr
 d7ugvLjTZpS3WRPBdo7zFKRR9oAXsxpMGEvYOhJhx1Y5lZFVbRT1gujZVZTqHvThMZL1
 blpjz3Epr9a13tOjqkd8eYEq1U2t1PfZzqk6Mzvlaj3+5KHRdMNzSmdO64JFH3f1AYJY
 h8rXHi2XIgYDMnVM6DXR4UwGOc9TgHV2C/RwTiarHaHczI8WcivurZ/6DhX5R8WPygkE
 xejQ==
X-Gm-Message-State: APjAAAUUeRjqWx72fdH+9u+eY+GV2eZxwi0Y1+Am7okG7d2W2dpJvsv+
 M0hYXsSHmcGRSuFSQHNiwJXyLsumQh8PIx2mLzk=
X-Google-Smtp-Source: APXvYqyFxspMxhPioiQZV3VcxHM9r1mnUKs/0jYhOUXzx6n06rbuxjNTN4LWOYiFT0BaAQWk+fJAHV9LSH2R62tgmzg=
X-Received: by 2002:a05:620a:634:: with SMTP id
 20mr10371477qkv.330.1574061234127; 
 Sun, 17 Nov 2019 23:13:54 -0800 (PST)
MIME-Version: 1.0
References: <20191114094544.30114-1-clg@kaod.org>
 <20191114094544.30114-3-clg@kaod.org>
In-Reply-To: <20191114094544.30114-3-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 18 Nov 2019 07:13:42 +0000
Message-ID: <CACPK8Xd3Dedf+wjn1rpAw3wuaWCkJZBdWhFVvoLZs_E1SfWAaw@mail.gmail.com>
Subject: Re: [PATCH 2/5] aspeed/smc: Do not map disabled segment on the AST2600
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 Nov 2019 at 09:46, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The segments can be disabled on the AST2600 (zero register value).
> CS0 is open by default but not the other CS. This is closing the
> access to the flash device in user mode and forbids scanning.
>
> In the model, check the segment size and disable the associated region
> when the value is zero.
>
> Fixes: bcaa8ddd081c ("aspeed/smc: Add AST2600 support")
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  hw/ssi/aspeed_smc.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 955ec21852ac..86cadbe4cc00 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -444,8 +444,13 @@ static void aspeed_2600_smc_reg_to_segment(const Asp=
eedSMCState *s,
>      uint32_t start_offset =3D (reg << 16) & AST2600_SEG_ADDR_MASK;
>      uint32_t end_offset =3D reg & AST2600_SEG_ADDR_MASK;
>
> -    seg->addr =3D s->ctrl->flash_window_base + start_offset;
> -    seg->size =3D end_offset + MiB - start_offset;
> +    if (reg) {
> +        seg->addr =3D s->ctrl->flash_window_base + start_offset;
> +        seg->size =3D end_offset + MiB - start_offset;
> +    } else {
> +        seg->addr =3D s->ctrl->flash_window_base;
> +        seg->size =3D 0;
> +    }
>  }
>
>  static bool aspeed_smc_flash_overlap(const AspeedSMCState *s,
> @@ -486,7 +491,7 @@ static void aspeed_smc_flash_set_segment_region(Aspee=
dSMCState *s, int cs,
>      memory_region_transaction_begin();
>      memory_region_set_size(&fl->mmio, seg.size);
>      memory_region_set_address(&fl->mmio, seg.addr - s->ctrl->flash_windo=
w_base);
> -    memory_region_set_enabled(&fl->mmio, true);
> +    memory_region_set_enabled(&fl->mmio, !!seg.size);
>      memory_region_transaction_commit();
>
>      s->regs[R_SEG_ADDR0 + cs] =3D regval;
> @@ -526,8 +531,9 @@ static void aspeed_smc_flash_set_segment(AspeedSMCSta=
te *s, int cs,
>      }
>
>      /* Keep the segment in the overall flash window */
> -    if (seg.addr + seg.size <=3D s->ctrl->flash_window_base ||
> -        seg.addr > s->ctrl->flash_window_base + s->ctrl->flash_window_si=
ze) {
> +    if (seg.size &&
> +        (seg.addr + seg.size <=3D s->ctrl->flash_window_base ||
> +         seg.addr > s->ctrl->flash_window_base + s->ctrl->flash_window_s=
ize)) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: new segment for CS%d is inva=
lid : "
>                        "[ 0x%"HWADDR_PRIx" - 0x%"HWADDR_PRIx" ]\n",
>                        s->ctrl->name, cs, seg.addr, seg.addr + seg.size);
> --
> 2.21.0
>

