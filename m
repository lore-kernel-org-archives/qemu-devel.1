Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD022CA9EC9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 22:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C6A20663
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 22:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1sNtmMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C6A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRlCk-0001ry-It
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 17:52:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iRlBF-00013Z-ML
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 17:50:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iRlBC-00066w-QZ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 17:50:36 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:41241)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iRlBB-00064t-7Y; Mon, 04 Nov 2019 17:50:33 -0500
Received: by mail-lj1-x244.google.com with SMTP id m9so19484896ljh.8;
 Mon, 04 Nov 2019 14:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9kVs6zEhIaUYtoZsrcQ9DLJHMd5fX57zNJlXdyi8YO0=;
 b=U1sNtmMRSfMzMto4Sjq748jB9gPzxo49yQkPYbiY0ZZ+R6zuaZ1wHKg2g3Y4XZOGMJ
 5gvlGXSAbAIvU1yegxBI9qK7TGIcput01iiXpSBiHvkjdke81BbVI4Vu+DIJ7gIVe800
 r6BQbjqLqtYwcykSirAxDY2aJoXZC0KIz9DQt9PYAmhVWzXplab/rerUTQC1zgADoBm5
 QE7PKPLqUC6t9Z/G0XM9+ELMy32AASaaj6JDKEzlLP4oxH+zqBEnfz6aAi4LAarBu3Mi
 sZaD/X4yRP8mIVdCjEzdspkC8gvt5aRC7dBi8CHtF/r4JkawZj5TJYbg/Fu6gcwB2n7t
 Rsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9kVs6zEhIaUYtoZsrcQ9DLJHMd5fX57zNJlXdyi8YO0=;
 b=GcvHZqB6xKS9Cqw1PMObdNqbmaKCs3HehgKXoKi5k/ok+tWddQfeQOfZ62m/e+6Fhv
 0x2AWmZuGh8FwdUCVtJ34/Rpa62zaySd2DrFt8xG3oVu1DTmJexsal4gpvLPE0dl6pYp
 APPqFSBWVo8htIivWUnNVq4H5iBh84bm9ji0Vr81wA0RF2YaXLPEc7a9W+MgUUhZdY1S
 4tw+8GOhYOFGMRgyD13lUfFlm58dikxzZQTfxxPPvwxZurEb9lvnr/x6/1BxdqxY8liY
 SPgdKWsXfA2eWNIeYabV/1jlUVcjl5QsE56kWmHoZtl1P9WVJXPDFZ2p4HhsPto6GdNS
 MVvw==
X-Gm-Message-State: APjAAAUCzY5LCsnG7WOAbySJG01dHJ8Js1rp1be4NnkYsMHZBZLVMjcs
 pQorYrPS4SfClT94O2oRPhwcB2pX9c7bWeknzzw=
X-Google-Smtp-Source: APXvYqyKej4QO8cs8t9GFnXSOikoxVolCkQBFf7I126aTVa5aTPWtVEth+3JTVidq/Wn8rO1qDx/Bfui7HEElSJH4/M=
X-Received: by 2002:a2e:82cd:: with SMTP id n13mr20444780ljh.156.1572907830498; 
 Mon, 04 Nov 2019 14:50:30 -0800 (PST)
MIME-Version: 1.0
References: <20191104181604.21943-1-linus.ziegert+qemu@holoplot.com>
In-Reply-To: <20191104181604.21943-1-linus.ziegert+qemu@holoplot.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 4 Nov 2019 14:44:53 -0800
Message-ID: <CAKmqyKMWS18ssBUhDgYSnGiFRwCkSJPBRui4Op50Tq_Z-OUakA@mail.gmail.com>
Subject: Re: [PATCH] net/cadence_gem: Set PHY autonegotiation restart status
To: linus.ziegert@holoplot.com
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 Linus Ziegert <linus.ziegert+qemu@holoplot.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 4, 2019 at 2:02 PM <linus.ziegert@holoplot.com> wrote:
>
> From: Linus Ziegert <linus.ziegert+qemu@holoplot.com>
>
> The Linux kernel PHY driver sets AN_RESTART in the BMCR of the
> PHY when autonegotiation is started.
> Recently the kernel started to read back the PHY's AN_RESTART
> bit and now checks whether the autonegotiation is complete and
> the bit was cleared [1]. Otherwise the link status is down.
>
> The emulated PHY needs to clear AN_RESTART immediately to inform
> the kernel driver about the completion of autonegotiation phase.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c36757eb9dee
>
> Signed-off-by: Linus Ziegert <linus.ziegert+qemu@holoplot.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/net/cadence_gem.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 7f9cb5ab95..b8be73dc55 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -271,9 +271,10 @@
>  #define PHY_REG_EXT_PHYSPCFC_ST   27
>  #define PHY_REG_CABLE_DIAG   28
>
> -#define PHY_REG_CONTROL_RST  0x8000
> -#define PHY_REG_CONTROL_LOOP 0x4000
> -#define PHY_REG_CONTROL_ANEG 0x1000
> +#define PHY_REG_CONTROL_RST       0x8000
> +#define PHY_REG_CONTROL_LOOP      0x4000
> +#define PHY_REG_CONTROL_ANEG      0x1000
> +#define PHY_REG_CONTROL_ANRESTART 0x0200
>
>  #define PHY_REG_STATUS_LINK     0x0004
>  #define PHY_REG_STATUS_ANEGCMPL 0x0020
> @@ -1345,7 +1346,7 @@ static void gem_phy_write(CadenceGEMState *s, unsigned reg_num, uint16_t val)
>          }
>          if (val & PHY_REG_CONTROL_ANEG) {
>              /* Complete autonegotiation immediately */
> -            val &= ~PHY_REG_CONTROL_ANEG;
> +            val &= ~(PHY_REG_CONTROL_ANEG | PHY_REG_CONTROL_ANRESTART);
>              s->phy_regs[PHY_REG_STATUS] |= PHY_REG_STATUS_ANEGCMPL;
>          }
>          if (val & PHY_REG_CONTROL_LOOP) {
> --
> 2.21.0
>
>

