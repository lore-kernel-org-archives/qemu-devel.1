Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678C3C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F13F20737
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMAgXc05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F13F20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHDA2-00057h-7F
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 17:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jHD8B-0003PB-Sh
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 17:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jHD8A-00082o-Ng
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 17:00:07 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:42788)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jHD8A-00082W-JA; Wed, 25 Mar 2020 17:00:06 -0400
Received: by mail-ua1-x942.google.com with SMTP id m18so1311129uap.9;
 Wed, 25 Mar 2020 14:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MhEUb1T5SzB0U5/6m4YDytBRlOwpm4s/29Ez0LdF7ws=;
 b=MMAgXc05j+qMq1OdnC60taPkx5vAuj3jXVgxdzTOuBRKzdM4JdYZF2TdeRCPTZA7FX
 D5BfW3bsW5ovVsvd2fVuG2zHBzTpJgOWcVYkzJapb5qS8ynWtfqJgMJ3BP6qJ86BTNLm
 5yyMTJgFQXFqguz//ViAXijeiCaiwW2mMJUo6RsswMZa56KJwhk0mjcjc370kPV/Eq5u
 SpL4ZWSYoodQM8UYk10g6salY6EJN+dUHvSE/iyrng9svAnB5HeVfWR0EReLjVBZLtJT
 WGsBCrZ4eqk3KwDZ+t1IeTZM2/Q6txZ620x7qNkbRGbxZqimHbERxDIVB4nlulPvByA3
 lXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MhEUb1T5SzB0U5/6m4YDytBRlOwpm4s/29Ez0LdF7ws=;
 b=K1Ymfyd9FaYLMk3gTVl6T+3Z53C6Ol+7OGmhjRzc4F+hAp6cAD49uSpe4CGlzPAZX2
 k8e0GJn9X1ZwihIVbkeKOGuix7Gv1Yr4vouP58rI0diYgAK+715tsZBs2IN6zUPfBuCf
 sY41wi9bjZjLTnOZTLZ3Zd2KNIdUJaYz9rmXMZxcEE9sL+n5SEAAxEjWmWfYwHf1j3o6
 1Ca3SMtGxQviIn0G8ZqRHeh9nYHjud9ptFslx8L25PTgBSZNZhvFIKD5kBXw7uZeFXcu
 PRK6r636TatYpTZ1Et+AuWz9piWZBsLN1CQ74AvB0NU9RXhYcXb0jXT3cj2fxeQnVjQ6
 7OsQ==
X-Gm-Message-State: ANhLgQ2AAkQa+d+ei0IyX5dAZFAvgZ1q6k3+bu/iaO+xIuiwNx1eYfet
 gTsbbYog5MNDoCSiyBJI011rVGp0NQUAVAA633c=
X-Google-Smtp-Source: ADFU+vuTQvbXTZj20U7hF/huMINTpbhjlpsOTGMp90/fT248kXwiCKcjhK+yMzpa+MPCfULY+pm/NRN69I9jxgxyZUM=
X-Received: by 2002:a9f:2964:: with SMTP id t91mr4004815uat.21.1585170005961; 
 Wed, 25 Mar 2020 14:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200325191830.16553-1-f4bug@amsat.org>
 <20200325191830.16553-7-f4bug@amsat.org>
In-Reply-To: <20200325191830.16553-7-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2020 13:52:06 -0700
Message-ID: <CAKmqyKNqYcTkxi8S56quu2L19+B73XNEzdFe44D1cNBFvjDPCQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 06/12] hw/dma/xilinx_axidma: Add missing
 error-propagation code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::942
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 25, 2020 at 12:24 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Running the coccinelle script produced:
>
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file scripts/coccinelle/object_property_missing_error_propagate.=
cocci \
>     --keep-comments --smpl-spacing --dir hw
>
>   [[manual check required: error_propagate() might be missing in object_p=
roperty_set_link() hw//dma/xilinx_axidma.c:542:4]]
>
> Add the missing error_propagate() after manual review.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/dma/xilinx_axidma.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index 018f36991b..6e3406321c 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -521,39 +521,42 @@ static const MemoryRegionOps axidma_ops =3D {
>  static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
>  {
>      XilinxAXIDMA *s =3D XILINX_AXI_DMA(dev);
>      XilinxAXIDMAStreamSlave *ds =3D XILINX_AXI_DMA_DATA_STREAM(&s->rx_da=
ta_dev);
>      XilinxAXIDMAStreamSlave *cs =3D XILINX_AXI_DMA_CONTROL_STREAM(
>                                                              &s->rx_contr=
ol_dev);
>      Error *local_err =3D NULL;
>
>      object_property_add_link(OBJECT(ds), "dma", TYPE_XILINX_AXI_DMA,
>                               (Object **)&ds->dma,
>                               object_property_allow_set_link,
>                               OBJ_PROP_LINK_STRONG,
>                               &local_err);
>      object_property_add_link(OBJECT(cs), "dma", TYPE_XILINX_AXI_DMA,
>                               (Object **)&cs->dma,
>                               object_property_allow_set_link,
>                               OBJ_PROP_LINK_STRONG,
>                               &local_err);
>      if (local_err) {
>          goto xilinx_axidma_realize_fail;
>      }
>      object_property_set_link(OBJECT(ds), OBJECT(s), "dma", &local_err);
> +    if (local_err) {
> +        goto xilinx_axidma_realize_fail;
> +    }
>      object_property_set_link(OBJECT(cs), OBJECT(s), "dma", &local_err);
>      if (local_err) {
>          goto xilinx_axidma_realize_fail;
>      }
>
>      int i;
>
>      for (i =3D 0; i < 2; i++) {
>          struct Stream *st =3D &s->streams[i];
>
>          st->nr =3D i;
>          st->ptimer =3D ptimer_init(timer_hit, st, PTIMER_POLICY_DEFAULT)=
;
>          ptimer_transaction_begin(st->ptimer);
>          ptimer_set_freq(st->ptimer, s->freqhz);
>          ptimer_transaction_commit(st->ptimer);
>      }
>      return;
> --
> 2.21.1
>
>

