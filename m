Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448C2C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 16:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 101782070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 16:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKbykGgx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101782070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHsll-0000Pt-4f
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 12:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iHskx-0008Hd-FX
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 12:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iHskw-0007Ge-7w
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 12:54:39 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:39560)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iHskw-0007GA-0q; Tue, 08 Oct 2019 12:54:38 -0400
Received: by mail-lf1-x141.google.com with SMTP id 72so12494206lfh.6;
 Tue, 08 Oct 2019 09:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yKnbWPlo9JQzuklZk80XuvQ8O1Z/I/MhFT718KTVLWw=;
 b=QKbykGgxmL2kSxdvDJW/+1rMYtOzoIFmXPb0AUI2S47kGY8LOT6BFQ8iM7ARO5jyAi
 u35oJXH+48kcpDEFt3TKZsjh3+oohEIk5Hga4sorIFPXI+5d3tgayk0xTdcngPnIuJVS
 FY3TeS6jlUvoY26o0oeTGiw1EhN/iemv8rvBraITcRFuwNN4jMpKJz97TRJBNWZR9o/+
 HlkCJhytPeV6YBCntr0Ix7LFtVKbiZepxAAbmcUyjAVGVNKEYAklVb0M616qRCdmX8gP
 iCjaliIddQHmElr18Vu/OB4x3NcMDZlPyVgb2WWpBCt7f+amzU3tMn740Tei9BQ4X2xf
 HnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yKnbWPlo9JQzuklZk80XuvQ8O1Z/I/MhFT718KTVLWw=;
 b=aBlaMn7tbbwCKbr1JSD8X1u6WNKuhWD6bbthKd+GjREXmc3MVXnMDCF/cl9sIa7Bl6
 QTgWz1S5ZhqIqBAXljzJRTViG05aPaUk3qP3EPbwUFcEJw6iWe5jDp+HTQ0RyjRSIHdy
 NCHuaJCowolSO7DoId1opETwL9zkU0gDpTpkSoQ1k1YqieQATV5yfnGj1U3BeGiW0+Cl
 SgD+hdhXIXJZXRlMfJ9lWlbSO7H/DUeEW149/57M0xJJtar0Fb7O0ZrBTD0C7oXDMLVZ
 pmMC3SiN1TPHZ13Pcad+TgRS2yEdZuBMn3YsBNpno2g6orr9YMVdCMFlGHeIEa2B7sDZ
 2l+w==
X-Gm-Message-State: APjAAAX5/o5ocWGYMV0Nkq5PIEBF8HB6xSqwuycFSPmuCzMH3oQNpM2U
 F+XDuuiUpz1odY6J0sYavnDpCroiipV5bF6e4s4=
X-Google-Smtp-Source: APXvYqyDnrRaopvewc0mjs/V5HgFbwVTuDN7cWzjBnHn8WuxZOpfLlyvz7lfA/+nZloklBupGIgbnhMH+WMaJEyXLnw=
X-Received: by 2002:ac2:484a:: with SMTP id 10mr21047068lfy.135.1570553676497; 
 Tue, 08 Oct 2019 09:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191008001318.219367-1-jonathan@fintelia.io>
 <20191008001318.219367-4-jonathan@fintelia.io>
In-Reply-To: <20191008001318.219367-4-jonathan@fintelia.io>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 8 Oct 2019 09:49:39 -0700
Message-ID: <CAKmqyKN1LZjcd5wJ8PAFvh+RWxwWB9+zJOdh5_t4xjaFKCgc+g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] target/riscv: Make the priv register writable by
 GDB
To: Jonathan Behrens <jonathan@fintelia.io>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 7, 2019 at 5:20 PM Jonathan Behrens <jonathan@fintelia.io> wrote:
>
> Currently only PRV_U, PRV_S and PRV_M are supported, so this patch ensures that
> the privilege mode is set to one of them. Once support for the H-extension is
> added, this code will also need to properly update the virtualization status
> when switching between VU/VS-modes and M-mode.
>
> Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/gdbstub.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 33cf7c4c7d..bc84b599c2 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -387,6 +387,15 @@ static int riscv_gdb_get_virtual(CPURISCVState *cs, uint8_t *mem_buf, int n)
>
>  static int riscv_gdb_set_virtual(CPURISCVState *cs, uint8_t *mem_buf, int n)
>  {
> +    if (n == 0) {
> +#ifndef CONFIG_USER_ONLY
> +        cs->priv = ldtul_p(mem_buf) & 0x3;
> +        if (cs->priv == PRV_H) {
> +            cs->priv = PRV_S;
> +        }
> +#endif
> +        return sizeof(target_ulong);
> +    }
>      return 0;
>  }
>
> --
> 2.23.0
>

