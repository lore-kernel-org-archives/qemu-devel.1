Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A89EC433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 13:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2D72075D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 13:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5QyOohM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2D72075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7Iwr-0006Rv-7e
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 09:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7Iw5-0005qS-IN; Sun, 16 Aug 2020 09:42:57 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:43370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7Iw2-0007g7-Tw; Sun, 16 Aug 2020 09:42:57 -0400
Received: by mail-yb1-xb43.google.com with SMTP id m200so7930644ybf.10;
 Sun, 16 Aug 2020 06:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1COg/2vwhp+Aa5Q1NsPo1GLWgtABuDaPgIVQmoDSxw4=;
 b=c5QyOohMqGiDbzbfqp13D5r+DYrVieT5o4zqWWB+3RZ9O4aT4VRDKqJuklpC+rjegj
 xwyRVaDLsPbR4/7H1j05UiTf6QySzb0LZZb0d3m7xld3XDdO4CQkxjYfkQDVOgK2v4gV
 DVKgHx3ZTS9jCbZF13j1jaqDMGtBCjEvVQ8yhftz50/kJgD8nCskZzFGppn7DxZJMhmN
 whKNlM6F3v2+RMtFVfnD5XS7vxhYQ5mpYft+j+9IQAvkXNtG65C+A312X9bnmxLLBIyO
 oyMbrcVn/zAr9X0aBvivH/z9CtRQM6TrVoKKshvttQSV/9nA7DU/QvE5Rd7wWsPhKobY
 7o3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1COg/2vwhp+Aa5Q1NsPo1GLWgtABuDaPgIVQmoDSxw4=;
 b=oyv9cyQIe1FWBCdCNQLDn5t+XseRZAyf1UGJNoO+/78sfkp/OyzFI6YyzoA1s2Mkm3
 8Oh3lXEYEVGZlrDEYxytNiRbDGto2kndA6t1FJlPoMdHBYh9MchNM6zzv8J2h1BscUNR
 IfeuqNQk72+4IC5Bt3u3WfYccKpYYrJ6/ukBY7PAIKGB5ysrmvR+D/0NXyDGfiZ3Ie4e
 ws+ubFCeGalXpQbJoAyBEeRd/UzcjQuvNh0mEfehWv9pqOYClLXaMSG2EBcrGfd3FMtl
 BR5os00Rwbdu+org6ZCREooNaKD8aQQMnCejGRCm4ar05GvOULqsjdi5JtTx40pZp4Zy
 M3Hg==
X-Gm-Message-State: AOAM533BjAkgzx/5RvD4NFI8OxgP0Kt5N93V9mucSULRubZLlIbN9XX3
 MD8S73bLBg3zuQYUL/w5JYqWkJUVEzSqmZzzcK0=
X-Google-Smtp-Source: ABdhPJwEnmKAka5H55ujXGS50ePA8OooocMcolD9WpMkHFr/jhq6k0J+PXVpSov9S/mGAa3P6OfOLhtQC9ZuJ390rq8=
X-Received: by 2002:a25:4251:: with SMTP id p78mr14670451yba.306.1597585373115; 
 Sun, 16 Aug 2020 06:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-15-git-send-email-bmeng.cn@gmail.com>
 <e97e1bc4-277d-9fdd-1372-f69d22b4a7e4@amsat.org>
 <CAEUhbmX6O7gGc2+sZFXSve=rBJLZQ5ts2sfWM=OU6k+4j-uryg@mail.gmail.com>
 <CA+aJhH1YooxPkaT2xc4o6CjDYLm++6psSc3ZZW-EiAPFCz=PjA@mail.gmail.com>
In-Reply-To: <CA+aJhH1YooxPkaT2xc4o6CjDYLm++6psSc3ZZW-EiAPFCz=PjA@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 16 Aug 2020 21:42:41 +0800
Message-ID: <CAEUhbmXQ6yxRMcP_LqaUTQra33iLsbU=vVs0MCaQkMU_ryUAUA@mail.gmail.com>
Subject: Re: [PATCH 14/18] hw/net: cadence_gem: Add a new 'phy-addr' property
To: Nathan Rossi <nathan@nathanrossi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Bin Meng <bin.meng@windriver.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Jason Wang <jasowang@redhat.com>, Palmer Dabbelt <palmerdabbelt@google.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Peter A. G. Crosthwaite" <peter.crosthwaite@petalogix.com>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 John Linn <john.linn@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 16, 2020 at 8:08 PM Nathan Rossi <nathan@nathanrossi.com> wrote=
:
>
> On Sun, 16 Aug 2020 at 18:29, Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > On Sat, Aug 15, 2020 at 5:06 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
> > >
> > > On 8/14/20 6:40 PM, Bin Meng wrote:
> > > > From: Bin Meng <bin.meng@windriver.com>
> > > >
> > > > At present the PHY address of the PHY connected to GEM is hard-code=
d
> > > > to either 23 (BOARD_PHY_ADDRESS) or 0. This might not be the case f=
or
> > > > all boards. Add a new 'phy-addr' property so that board can specify
> > > > the PHY address for each GEM instance.
> > > >
> > > > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > > > ---
> > > >
> > > >  hw/net/cadence_gem.c         | 7 +++++--
> > > >  include/hw/net/cadence_gem.h | 2 ++
> > > >  2 files changed, 7 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> > > > index a93b5c0..9fa03de 100644
> > > > --- a/hw/net/cadence_gem.c
> > > > +++ b/hw/net/cadence_gem.c
> > > > @@ -1446,7 +1446,8 @@ static uint64_t gem_read(void *opaque, hwaddr=
 offset, unsigned size)
> > > >              uint32_t phy_addr, reg_num;
> > > >
> > > >              phy_addr =3D (retval & GEM_PHYMNTNC_ADDR) >> GEM_PHYMN=
TNC_ADDR_SHFT;
> > > > -            if (phy_addr =3D=3D BOARD_PHY_ADDRESS || phy_addr =3D=
=3D 0) {
> > > > +            if (phy_addr =3D=3D BOARD_PHY_ADDRESS || phy_addr =3D=
=3D 0 ||
> > > > +                phy_addr =3D=3D s->phy_addr) {
> > > >                  reg_num =3D (retval & GEM_PHYMNTNC_REG) >> GEM_PHY=
MNTNC_REG_SHIFT;
> > > >                  retval &=3D 0xFFFF0000;
> > > >                  retval |=3D gem_phy_read(s, reg_num);
> > > > @@ -1569,7 +1570,8 @@ static void gem_write(void *opaque, hwaddr of=
fset, uint64_t val,
> > > >              uint32_t phy_addr, reg_num;
> > > >
> > > >              phy_addr =3D (val & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC=
_ADDR_SHFT;
> > > > -            if (phy_addr =3D=3D BOARD_PHY_ADDRESS || phy_addr =3D=
=3D 0) {
> > > > +            if (phy_addr =3D=3D BOARD_PHY_ADDRESS || phy_addr =3D=
=3D 0 ||
> > > > +                phy_addr =3D=3D s->phy_addr) {
> > > >                  reg_num =3D (val & GEM_PHYMNTNC_REG) >> GEM_PHYMNT=
NC_REG_SHIFT;
> > > >                  gem_phy_write(s, reg_num, val);
> > > >              }
> > > > @@ -1682,6 +1684,7 @@ static Property gem_properties[] =3D {
> > > >      DEFINE_NIC_PROPERTIES(CadenceGEMState, conf),
> > > >      DEFINE_PROP_UINT32("revision", CadenceGEMState, revision,
> > > >                         GEM_MODID_VALUE),
> > > > +    DEFINE_PROP_UINT8("phy-addr", CadenceGEMState, phy_addr, 0),
> > >
> > > This patch would be complete by moving the BOARD_PHY_ADDRESS definiti=
on
> > > to each board using this NIC, and setting the "phy-addr" property to
> > > this value.
> >
> > I actually have no idea which board in QEMU is using this special PHY
> > address instead of default 0.
>
> Given Xilinx's QEMU fork has not used this value for quite some time,
> I suspect it was only used to match an early chip emulation
> platform/board.
>
> https://github.com/Xilinx/qemu/blame/master/hw/net/cadence_gem.c#L248
>
> >
> > It looks BOARD_PHY_ADDRESS has been there since the initial version of
> > the cadence_gem model.
> >
> > commit e9f186e514a70557d695cadd2c2287ef97737023
> > Author: Peter A. G. Crosthwaite <peter.crosthwaite@petalogix.com>
> > Date:   Mon Mar 5 14:39:12 2012 +1000
> >
> >     cadence_gem: initial version of device model
> >
> >     Device model for cadence gem ethernet controller.
> >
> >     Signed-off-by: Peter A. G. Crosthwaite <peter.crosthwaite@petalogix=
.com>
> >     Signed-off-by: John Linn <john.linn@xilinx.com>
> >     Acked-by: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> >     Signed-off-by: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> >
> > Later PHY address 0 was added via the following commit:
> >
> > commit 553893736885e4f2dda424bff3e2200e1b6482a5
> > Author: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> > Date:   Thu Apr 3 23:55:19 2014 -0700
> >
> >     net: cadence_gem: Make phy respond to broadcast
> >
> >     Phys must respond to address 0 by specification. Implement.
> >
> >     Signed-off-by: Nathan Rossi <nathan.rossi@xilinx.com>
> >     Signed-off-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> >     Message-id:
> > 6f4d53b04ddbfb19895bfb61a595e69f1c08859a.1396594056.git.peter.crosthwai=
te@xilinx.com
> >     Reviewed-by: Beniamino Galvani <b.galvani@gmail.com>
> >     Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >
> > I doubt the commit message said that PHYs must respond to address 0. I
> > am not aware of such specs. The issue was probably that whatever board
> > 2nd commit was tested against did not have a PHY at address
> > BOARD_PHY_ADDRESS.
>
> It is common for phy devices to support it as a broadcast address. It
> is also commonly written in Xilinx documentation that it is treated as
> a broadcast address. e.g. the axi ethernet core
> (https://www.xilinx.com/support/documentation/ip_documentation/axi_ethern=
et/v7_0/pg138-axi-ethernet.pdf
> page 45). But 802.3 does not require it, instead address 0 is only
> reserved.
>
> With this commit the "must" refers to the device specification, in
> that QEMU is emulating a real phy (though more specifically the phy(s)
> that were being emulated for Zynq boards) that does respond to address
> 0 as a broadcast. This change was a trade off in order to make QEMU
> behave as it would on hardware, such that software using address 0 as
> broadcast would work correctly.
>

Thanks Nathan. So is it safe to just remove BOARD_PHY_ADDRESS and set
"phy-addr" property default value to 0?

Regards,
Bin

