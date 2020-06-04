Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6CEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 10:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87FBE2075B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 10:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZE3Kn9Qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FBE2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgnXq-0004Uy-Oj
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 06:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1jgnWP-00034E-VM; Thu, 04 Jun 2020 06:54:53 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43841)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1jgnWO-0002Pf-UV; Thu, 04 Jun 2020 06:54:53 -0400
Received: by mail-oi1-x243.google.com with SMTP id j189so4655452oih.10;
 Thu, 04 Jun 2020 03:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SWXZ5ULvx5RiZpH9RT5nB6Ol1XPXt8/7tRPhi1veAFM=;
 b=ZE3Kn9QwGWXwjhO0uIkW3XvYZNu/ayyIRPmDZpjZEuG+j7/pUB8C66S3FBUH182/Da
 71BU1WW2rGtTgjAozXr3ohGrqLOy7x9tp65QZ4uT0NwrGtSDuY1zPXjqo5CPRIwgr176
 2S1oUek+gpjtxXn7vShi3Wn+h5UCrZV2sLSjGAuAO3eQln0CWgNJ1mDQkkilYAigxS6N
 JJGu7e1a3alkbuz5suDRfwPtdPLEf/4Lr/3Zw1mDvrmF6Ch/I9+Qfn+iFu1pvzRGHb/T
 +bRE8imm5Zb4bZ8oJo8XQOIs25COtD0BxZcD3LQeMwbKP0OtpqHalCEBBiSSN0hLjsI0
 RvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SWXZ5ULvx5RiZpH9RT5nB6Ol1XPXt8/7tRPhi1veAFM=;
 b=uYmzFYPuZfwJQ6vy4NZ8lstmdL+BD8rz6CLnC6FXvrUXO83i+ynjuvzBnbRgwd/6+Q
 SnDYTIqeWRbOAkr2BQWCCMpeg47sUYo7dN833cDo2RmCItGbiFKQj1snCEqIEBKUhVmC
 UeRcikceLmYmmAb6vv97iNQOHemqFKg6M1KcljYrUMW52qVcalz52lTEH1gGdHDXfT/B
 52Drqcuvp1ohiVQ3KGej9xJ9mO/Whdv7evFJMxnmb7Pg+KPYa59P3NJldy/Ka2PQKO7Y
 ui5vz0D8vKAm/yQZAkP1s+t1Rc0DGl3PasclL7/apJwnxn6Wcyn4U3zDRwhsoz48A1KB
 Y2Kw==
X-Gm-Message-State: AOAM530ASzu0Q3tfPMz5MIQUyAS+sHlUI65UOBCVa6M0L8YO7t5/fAjS
 hRqIyBPzEhl3CDtiQPZsIiJPN/nHn3he/ZtVAGs=
X-Google-Smtp-Source: ABdhPJy4sON0EMrWauQLHMt06m33TjXNPa9FbtkcK/HXVkWeym7pj2HkJgk2bb+XU//2n4yfP0Eycf9lQcDEkjTShZo=
X-Received: by 2002:a05:6808:ab0:: with SMTP id
 r16mr2733069oij.24.1591268090545; 
 Thu, 04 Jun 2020 03:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <CA+MHfov0TVbwjy8g_cHVa6Y-bMowCbsGLdt8uUhmcns0v_eVLw@mail.gmail.com>
 <70cece8e-1caf-1387-25e7-971783817cc8@kaod.org>
In-Reply-To: <70cece8e-1caf-1387-25e7-971783817cc8@kaod.org>
From: Erik Smit <erik.lucas.smit@gmail.com>
Date: Thu, 4 Jun 2020 12:54:39 +0200
Message-ID: <CA+MHfovyMCjqwJ+G3XyRvr5fO60sGff7bwYqSa7a=mFo8CYoSw@mail.gmail.com>
Subject: Re: [PATCH] ftgmac100: Implement variable descriptor size
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=erik.lucas.smit@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 10:16, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 6/2/20 6:47 PM, Erik Smit wrote:
> > The hardware supports variable descriptor sizes, configured with the DB=
LAC
> > register.
>
> yes.
>
> The DBLAC default value is 0x00022F00 on AST2400 and 0x00022500 on AST250=
0
> and AST2600. The current reset handler needs a little fix btw.
>
> This sets the TX and RX descriptor default size to 4 words (2 * 8bytes).
>
> > Most drivers use the default 2*8, which is currently hardcoded in qemu,=
 but
> > the implementation of the driver in Supermicro BMC SMT_X11_158 uses 4*8=
.
>
> The first 4 words are architected but the specs allows the descriptors
> to be bigger which is what the Aspeed SDK is doing:
>
>         outl( 0x44f97, dev->base_addr + DBLAC_REG );
>
> It's using 8 words ( 4 * 8bytes) to store some address in the fifth.
> This is a waste btw.
>
>
> Thanks for spotting this. I think the patch is correct but we need to
> clarify a few things.
>
> > --
> > The implementation of the driver in Supermicro BMC SMT_X11_158 adds 4 e=
xtra
> > 4-bytes entries:
> > https://github.com/ya-mouse/openwrt-linux-aspeed/blob/master/drivers/ne=
t/ftgmac100_26.h#L387-L391
> >
> > And sets DBLAC to 0x44f97:
> > https://github.com/ya-mouse/openwrt-linux-aspeed/blob/master/drivers/ne=
t/ftgmac100_26.c#L449
> >
> > There's not a lot of public documentation on this hardware, but the
> > current linux driver shows the meaning of these registers:
> >
> > https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/fara=
day/ftgmac100.c#L280-L281
> >
> >         iowrite32(FTGMAC100_DBLAC_RXDES_SIZE(2) |   /* 2*8 bytes RX des=
cs */
> >                   FTGMAC100_DBLAC_TXDES_SIZE(2) |   /* 2*8 bytes TX des=
cs */
> >
> > Without this patch, networking in SMT_X11_158 does not pass data.
> >
> > Signed-off-by: Erik Smit <erik.lucas.smit@gmail.com <mailto:erik.lucas.=
smit@gmail.com>>
> > ---
> >  hw/net/ftgmac100.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> > index 25ebee7ec2..1640b24b23 100644
> > --- a/hw/net/ftgmac100.c
> > +++ b/hw/net/ftgmac100.c
> > @@ -79,6 +79,19 @@
> >  #define FTGMAC100_APTC_TXPOLL_CNT(x)        (((x) >> 8) & 0xf)
> >  #define FTGMAC100_APTC_TXPOLL_TIME_SEL      (1 << 12)
> >
> > +/*
> > + * DMA burst length and arbitration control register
> > + */
> > +#define FTGMAC100_DBLAC_RXFIFO_LTHR(x)      (((x) >> 0) & 0x7)
> > +#define FTGMAC100_DBLAC_RXFIFO_HTHR(x)      (((x) >> 3) & 0x7)
> > +#define FTGMAC100_DBLAC_RX_THR_EN           (1 << 6)
>
> The above definitions are AST2400 only. We should say so or leave them ou=
t
> because the model does not use them any how.

Like so?

#define FTGMAC100_DBLAC_RXFIFO_LTHR(x)      (((x) >> 0) & 0x7)  // AST2400-=
only
#define FTGMAC100_DBLAC_RXFIFO_HTHR(x)      (((x) >> 3) & 0x7)  // AST2400-=
only
#define FTGMAC100_DBLAC_RX_THR_EN           (1 << 6)            // AST2400-=
only

>
> > +#define FTGMAC100_DBLAC_RXBURST_SIZE(x)     (((x) >> 8) & 0x3)
> > +#define FTGMAC100_DBLAC_TXBURST_SIZE(x)     (((x) >> 10) & 0x3)
> > +#define FTGMAC100_DBLAC_RXDES_SIZE(x)       (((x) >> 12) & 0xf)
> > +#define FTGMAC100_DBLAC_TXDES_SIZE(x)       (((x) >> 16) & 0xf)
>
> I would include '* 8' in the {R,T}XDES_SIZE macros

Agreed.

> > +#define FTGMAC100_DBLAC_IFG_CNT(x)          (((x) >> 20) & 0x7)
> > +#define FTGMAC100_DBLAC_IFG_INC             (1 << 23)
> > +
> >  /*
> >   * PHY control register
> >   */
> > @@ -553,7 +566,7 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint=
32_t tx_ring,
> >          if (bd.des0 & s->txdes0_edotr) {
> >              addr =3D tx_ring;
> >          } else {
> > -            addr +=3D sizeof(FTGMAC100Desc);
> > +            addr +=3D (FTGMAC100_DBLAC_TXDES_SIZE(s->dblac)) * 8;
>
> and remove the '* 8' here.

Agreed.

> >          }
> >      }
> >
> > @@ -982,7 +995,7 @@ static ssize_t ftgmac100_receive(NetClientState *nc=
, const uint8_t *buf,
> >          if (bd.des0 & s->rxdes0_edorr) {
> >              addr =3D s->rx_ring;
> >          } else {
> > -            addr +=3D sizeof(FTGMAC100Desc);
> > +            addr +=3D (FTGMAC100_DBLAC_RXDES_SIZE(s->dblac)) * 8;
> >          }
> >      }
> >      s->rx_descriptor =3D addr;
>
>
> and when the DBLAC register is set, we should check the size values to ma=
ke
> sure they are not under sizeof(FTGMAC100Desc), in which case we should
> report an error.

Like so?

    case FTGMAC100_DBLAC: /* DMA Burst Length and Arbitration Control */
        s->dblac =3D value;
        if (FTGMAC100_DBLAC_TXDES_SIZE(s->dblac) < sizeof(FTGMAC100Desc))
            qemu_log_mask(LOG_GUEST_ERROR, "%s: transmit descriptor
too small : %d bytes\n",
                              __func__, FTGMAC100_DBLAC_TXDES_SIZE(s->dblac=
));
        if (FTGMAC100_DBLAC_RXDES_SIZE(s->dblac) < sizeof(FTGMAC100Desc))
            qemu_log_mask(LOG_GUEST_ERROR, "%s: receive descriptor too
small : %d bytes\n",
                              __func__, FTGMAC100_DBLAC_RXDES_SIZE(s->dblac=
));
        break;

Also, I've not got experience submitting patches to Qemu. My next step
would be to respin this patch and resend it to everybody as [PATCH
v2]?

Best regards,

Erik Smit

