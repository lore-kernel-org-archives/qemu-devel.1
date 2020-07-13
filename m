Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD3EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D1920773
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="P+1lhqhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D1920773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvSv-0000gB-Av
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amergnat@baylibre.com>)
 id 1juvQE-0007az-GY
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:10:54 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:46777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amergnat@baylibre.com>)
 id 1juvQC-00059e-1e
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:10:54 -0400
Received: by mail-io1-xd44.google.com with SMTP id a12so12756349ion.13
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 03:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6KIapkecP6wBT0Pr8S6pDP9K02YkywqfJGPNPb/CTPc=;
 b=P+1lhqhpezpn1HAukSIpHmFDXnVoyfSWYDcGOmaLx2Z7hu55GAFQGwAI2Mo1lKOW18
 RmLFtdvGgAuWzhV1r2kQh7CwJSthEG3U6iD1b4It1dKRK2GbiQA9E+pm2XgU7AEKzjOX
 OLv04SrBPAIb5H5gxlukj25nn0SNkt90HhDpuCLhwVwHWMPE1Nq/Utc7VGr+yhH9/QkN
 bMG7vTCMiZ2b7AB1Tj9KxlKICmABEBmsgxjGEKd1vp8r6IqWW54KQwQl+U5L8UX77VpI
 72swpplykO7QJNIiPIwhDk8rIUK9Z1V3/oAW30Att43gXb6lrksPbWGcalGC8UI5aS8N
 a9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6KIapkecP6wBT0Pr8S6pDP9K02YkywqfJGPNPb/CTPc=;
 b=unsJqcdjr6EqjD8cjNnkMXYe/dhEXg28yGPDJD9MJnbeVZszWommsTJCAlT7x58yGj
 FGYLOxKvVAr8XqckfiQJ4pb1m+PKetOxWu5brE7iep7uULmvJqsdMgeAE5N9pnn8NLTM
 7P61Kv38ldaqwEGlMJsYS8S+V7G/htKlB5LlgWWaqVMqRhHWAqXs/fOHHRB2hZnxpU0W
 hWpCLH6XBpA917h7Db3L0KpEceaump3muDbgl9gSLClPl6Ju4TWDrah110GQ/3vdp1re
 QkCmKSXWbKZT832qh68662Arl2AYjWPBP45V2AYfe/Vzo9XssvoCQI82cZ0IFm0pRPZT
 QnQA==
X-Gm-Message-State: AOAM5337skDgqjupgUcv97LhFa4IYccIpjGb3S01kXBREa3DrXvl8yo0
 oReTw0SymH376RQ0XZaRMLpDQNmiH5bElTZeeiUGNg==
X-Google-Smtp-Source: ABdhPJxCcpRaLrUPioCfzdUAu4PUqpA562DOD10FM+BoLdvx/injl8SaKWfbbbfv3UV0peRt1lwPQdzGqj22ajDBXFU=
X-Received: by 2002:a02:6a26:: with SMTP id l38mr91014692jac.60.1594635049676; 
 Mon, 13 Jul 2020 03:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200706084550.24117-1-amergnat@baylibre.com>
 <CAKmqyKMhsF+X4L2Eahn3f-f-_F6ZUeTTimKWGibYo2VxVbFSiw@mail.gmail.com>
In-Reply-To: <CAKmqyKMhsF+X4L2Eahn3f-f-_F6ZUeTTimKWGibYo2VxVbFSiw@mail.gmail.com>
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Mon, 13 Jul 2020 12:10:38 +0200
Message-ID: <CAFGrd9qQ=VVdv15tGoTK_MF+3gwp1AKtuMBQCP_XMNOHJdQsnw@mail.gmail.com>
Subject: Re: [PATCH v1] target/riscv: fix pmp implementation
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=amergnat@baylibre.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>, baylibre-upstreaming@groups.io,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Nicolas Royer <nroyer@baylibre.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le ven. 10 juil. 2020 =C3=A0 22:35, Alistair Francis <alistair23@gmail.com>=
 a =C3=A9crit :
>
> On Mon, Jul 6, 2020 at 2:45 AM Alexandre Mergnat <amergnat@baylibre.com> =
wrote:
> >
> > The end address calculation for NA4 mode is wrong because the address
> > used isn't shifted.
> >
> > That imply all NA4 setup are not applied by the PMP.
>
> I'm not sure what you mean here, can you clarify this?

I'm just saying NA4 configuration doesn't work properly on QEMU (It
doesn't watch 4byte but a huge range)
because the end address calculation is wrong.

>
> >
> > The solution is to use the shifted address calculated for start address
> > variable.
> >
> > Modifications are tested on Zephyr OS userspace test suite which works
> > for other RISC-V boards (E31 and E34 core).
> >
> > Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>
> Otherwise:
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Alistair
>
> > ---
> >  target/riscv/pmp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> > index 9418660f1b..2a2b9f5363 100644
> > --- a/target/riscv/pmp.c
> > +++ b/target/riscv/pmp.c
> > @@ -171,7 +171,7 @@ static void pmp_update_rule(CPURISCVState *env, uin=
t32_t pmp_index)
> >
> >      case PMP_AMATCH_NA4:
> >          sa =3D this_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
> > -        ea =3D (this_addr + 4u) - 1u;
> > +        ea =3D (sa + 4u) - 1u;
> >          break;
> >
> >      case PMP_AMATCH_NAPOT:
> > --
> > 2.17.1
> >
> >

