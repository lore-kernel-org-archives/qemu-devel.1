Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15BDC433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 08:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9F12067C
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 08:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8ZXyd0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9F12067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7E45-0003yd-OB
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 04:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7E34-0003I5-CL; Sun, 16 Aug 2020 04:29:50 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:43506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7E32-0002Hq-KI; Sun, 16 Aug 2020 04:29:50 -0400
Received: by mail-yb1-xb43.google.com with SMTP id m200so7673598ybf.10;
 Sun, 16 Aug 2020 01:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IwTz3CD8oLIaiLPD0JEy+kn7ElMHuylHQQFgungqQ9w=;
 b=W8ZXyd0rB/uDAE6CgBNFesmDDZ9/xoYRmqN/L/CbezqWmPKk90wI+eCNWCCtrx9rog
 oJxnuT0cyx4uMWp8dVF77fvfli+5EfNevv9RrzLJoGTZAZADZzAUER1ZHeqPTdUH5V46
 vujog09Wu6hOobEuMi5Wg7kDJF8I7ZL/YPyViMvBj5jCz/4X7ou17obq6Kc6QkjiFoBi
 f0uD7ZbQX1ASg2B6rnSpGP0pb7NpEUCX9DgcrhjaGx9PW9FSq21dSuAuqcqB+rBT4Ip0
 cbLmww3xZlbpaS508dz4yPog4F316eup2O/6+7Mb8fTwYwrNPPDzhh4IuS/ieDG/BVk1
 IuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IwTz3CD8oLIaiLPD0JEy+kn7ElMHuylHQQFgungqQ9w=;
 b=pN4cfA2CvgVkaVe0FH+2xpuegpXtufVv9k5ov/6ZpYQl4+JDMtpN9eTzgumS/IpMYn
 RO8xOyg+W6nhgdocn6qN8a/kSYQ+lgYFANhodrINPQ887TI7d1jbKbQdMqn1Qp8nWnXR
 uUnOSR5Hp1K4p/GhzEC2/jEeOQROZpBVHriXMK8ojFfwf3zCvnxjpSMv3PTbEmMhIULq
 z303KqoQ1AZ0JHiSRN4RGb93fC47xTxKlNf8z9+XaHE5JdcNksaUUbGf/KNwRI6u0c60
 d5pVhw7VGv1Sajs/MzkbM4ZpDFrH7Q7xjpvHKSWQ3LV6ZdOtcQhZDKYDp2UUPRG3hBUG
 tcoA==
X-Gm-Message-State: AOAM530aXO59S5ujhEbPIuF/TttAqSH5WF9gthQ+jKGRQ0QWdw066enH
 U9VApAIHDMUf0pV9Yhx0ObxPfoQ2djMUgRWa6WE=
X-Google-Smtp-Source: ABdhPJyBp3VOheTsPWIFaqqyDJC24gqIVroWcOVbqgQRaMtMLprNbolEfs7NH7l62pBA4r/oVeAqmUmupeRyY6Jx6Fo=
X-Received: by 2002:a25:37ca:: with SMTP id
 e193mr15023634yba.387.1597566586681; 
 Sun, 16 Aug 2020 01:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-15-git-send-email-bmeng.cn@gmail.com>
 <e97e1bc4-277d-9fdd-1372-f69d22b4a7e4@amsat.org>
In-Reply-To: <e97e1bc4-277d-9fdd-1372-f69d22b4a7e4@amsat.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 16 Aug 2020 16:29:35 +0800
Message-ID: <CAEUhbmX6O7gGc2+sZFXSve=rBJLZQ5ts2sfWM=OU6k+4j-uryg@mail.gmail.com>
Subject: Re: [PATCH 14/18] hw/net: cadence_gem: Add a new 'phy-addr' property
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, 
 John Linn <john.linn@xilinx.com>, 
 "Peter A. G. Crosthwaite" <peter.crosthwaite@petalogix.com>, 
 Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
 Nathan Rossi <nathan@nathanrossi.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Bin Meng <bin.meng@windriver.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Jason Wang <jasowang@redhat.com>, Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 15, 2020 at 5:06 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 8/14/20 6:40 PM, Bin Meng wrote:
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > At present the PHY address of the PHY connected to GEM is hard-coded
> > to either 23 (BOARD_PHY_ADDRESS) or 0. This might not be the case for
> > all boards. Add a new 'phy-addr' property so that board can specify
> > the PHY address for each GEM instance.
> >
> > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > ---
> >
> >  hw/net/cadence_gem.c         | 7 +++++--
> >  include/hw/net/cadence_gem.h | 2 ++
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> > index a93b5c0..9fa03de 100644
> > --- a/hw/net/cadence_gem.c
> > +++ b/hw/net/cadence_gem.c
> > @@ -1446,7 +1446,8 @@ static uint64_t gem_read(void *opaque, hwaddr off=
set, unsigned size)
> >              uint32_t phy_addr, reg_num;
> >
> >              phy_addr =3D (retval & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_=
ADDR_SHFT;
> > -            if (phy_addr =3D=3D BOARD_PHY_ADDRESS || phy_addr =3D=3D 0=
) {
> > +            if (phy_addr =3D=3D BOARD_PHY_ADDRESS || phy_addr =3D=3D 0=
 ||
> > +                phy_addr =3D=3D s->phy_addr) {
> >                  reg_num =3D (retval & GEM_PHYMNTNC_REG) >> GEM_PHYMNTN=
C_REG_SHIFT;
> >                  retval &=3D 0xFFFF0000;
> >                  retval |=3D gem_phy_read(s, reg_num);
> > @@ -1569,7 +1570,8 @@ static void gem_write(void *opaque, hwaddr offset=
, uint64_t val,
> >              uint32_t phy_addr, reg_num;
> >
> >              phy_addr =3D (val & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_ADD=
R_SHFT;
> > -            if (phy_addr =3D=3D BOARD_PHY_ADDRESS || phy_addr =3D=3D 0=
) {
> > +            if (phy_addr =3D=3D BOARD_PHY_ADDRESS || phy_addr =3D=3D 0=
 ||
> > +                phy_addr =3D=3D s->phy_addr) {
> >                  reg_num =3D (val & GEM_PHYMNTNC_REG) >> GEM_PHYMNTNC_R=
EG_SHIFT;
> >                  gem_phy_write(s, reg_num, val);
> >              }
> > @@ -1682,6 +1684,7 @@ static Property gem_properties[] =3D {
> >      DEFINE_NIC_PROPERTIES(CadenceGEMState, conf),
> >      DEFINE_PROP_UINT32("revision", CadenceGEMState, revision,
> >                         GEM_MODID_VALUE),
> > +    DEFINE_PROP_UINT8("phy-addr", CadenceGEMState, phy_addr, 0),
>
> This patch would be complete by moving the BOARD_PHY_ADDRESS definition
> to each board using this NIC, and setting the "phy-addr" property to
> this value.

I actually have no idea which board in QEMU is using this special PHY
address instead of default 0.

It looks BOARD_PHY_ADDRESS has been there since the initial version of
the cadence_gem model.

commit e9f186e514a70557d695cadd2c2287ef97737023
Author: Peter A. G. Crosthwaite <peter.crosthwaite@petalogix.com>
Date:   Mon Mar 5 14:39:12 2012 +1000

    cadence_gem: initial version of device model

    Device model for cadence gem ethernet controller.

    Signed-off-by: Peter A. G. Crosthwaite <peter.crosthwaite@petalogix.com=
>
    Signed-off-by: John Linn <john.linn@xilinx.com>
    Acked-by: Edgar E. Iglesias <edgar.iglesias@gmail.com>
    Signed-off-by: Edgar E. Iglesias <edgar.iglesias@gmail.com>

Later PHY address 0 was added via the following commit:

commit 553893736885e4f2dda424bff3e2200e1b6482a5
Author: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
Date:   Thu Apr 3 23:55:19 2014 -0700

    net: cadence_gem: Make phy respond to broadcast

    Phys must respond to address 0 by specification. Implement.

    Signed-off-by: Nathan Rossi <nathan.rossi@xilinx.com>
    Signed-off-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
    Message-id:
6f4d53b04ddbfb19895bfb61a595e69f1c08859a.1396594056.git.peter.crosthwaite@x=
ilinx.com
    Reviewed-by: Beniamino Galvani <b.galvani@gmail.com>
    Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I doubt the commit message said that PHYs must respond to address 0. I
am not aware of such specs. The issue was probably that whatever board
2nd commit was tested against did not have a PHY at address
BOARD_PHY_ADDRESS.

+ a couple of Xilinx folks to comment.

>
> >      DEFINE_PROP_UINT8("num-priority-queues", CadenceGEMState,
> >                        num_priority_queues, 1),
> >      DEFINE_PROP_UINT8("num-type1-screeners", CadenceGEMState,
> > diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.=
h
> > index 54e646f..01c6189 100644
> > --- a/include/hw/net/cadence_gem.h
> > +++ b/include/hw/net/cadence_gem.h
> > @@ -73,6 +73,8 @@ typedef struct CadenceGEMState {
> >      /* Mask of register bits which are write 1 to clear */
> >      uint32_t regs_w1c[CADENCE_GEM_MAXREG];
> >
> > +    /* PHY address */
> > +    uint8_t phy_addr;
> >      /* PHY registers backing store */
> >      uint16_t phy_regs[32];

Regards,
Bin

