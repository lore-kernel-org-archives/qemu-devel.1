Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB50C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 05:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE87E20716
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 05:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE87E20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnbVc-0003nN-0q
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 01:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnbUs-0002wI-0n
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 01:29:26 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:32987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnbUq-0002ns-4v
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 01:29:25 -0400
Received: by mail-ej1-f65.google.com with SMTP id n24so20323309ejd.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 22:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1OzgXCjAciDOMNHvrPPHr2ITdeGJk9DuhGKFYhqWMmA=;
 b=TRWgfeB5GTstw/QxS0atniiEHxfqVmYLCmGOl3ZRCsAXV6wHqfBul1rxgoC7F1vGZI
 GxlPy13mmTBP+VJvtC2nfDtK2o95IYl5gmMFMr3cbAbf8YxZTJxRK6mwD8AbQQVO6Hu6
 94KZbZ5dFVSbqx6FiqSi8LbGIq5APls9dfggusks4gVrFbM7VkmJc6lFLorSY11g4B4h
 BLWcS1fUCsX12YJdeIuhASNl7dQ5qaazgVzhrf286Jo9OfDp7YOpamHkUgYMfoY1z8AM
 ZEq50S/86V70RQ80g/ReBSDcY0arloaWWIiWYKRUNfNJK3BAkF0BghX7fsecmZYM4lQs
 ZOTA==
X-Gm-Message-State: AOAM530wLAN7oRon9oG7fNDHVuMIUS82sBMDNmc+jWvF+hWO24+ALX8f
 l8Gl4LrgYrQgVsAWZOOOqW73D4kAzJ7rlBF87Fo=
X-Google-Smtp-Source: ABdhPJyVb33dZ4fYhkQ2ctU2jHakMWtG7ETjc521YjfX2kk0lRP/GtrZwDsOeu5i/en2XSSk938zdg6NkzapSRkAA48=
X-Received: by 2002:a17:906:facb:: with SMTP id
 lu11mr13493231ejb.510.1592890162400; 
 Mon, 22 Jun 2020 22:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200621145235.9E241745712@zero.eik.bme.hu>
 <20200622213237.GB3258@minyard.net>
In-Reply-To: <20200622213237.GB3258@minyard.net>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jun 2020 07:29:10 +0200
Message-ID: <CAAdtpL6tJyUUvmyUzZyenbkXij+DW3WcruPyUL_V7VS-PfO5CA@mail.gmail.com>
Subject: Re: [PATCH] i2c: Match parameters of i2c_start_transfer and
 i2c_send_recv
To: Corey Minyard <cminyard@mvista.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.218.65;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:29:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 11:34 PM Corey Minyard <cminyard@mvista.com> wrote:
> On Sun, Jun 21, 2020 at 04:43:38PM +0200, BALATON Zoltan wrote:
> > These functions have a parameter that decides the direction of
> > transfer but totally confusingly they don't match but inverted sense.
> > To avoid frequent mistakes when using these functions change
> > i2c_send_recv to match i2c_start_transfer. Also use bool in
> > i2c_start_transfer instead of int to match i2c_send_recv.
>
> Hmm, I have to admit that this is a little better.  Indeed the
> hw/misc/auxbus.c looks suspicious.  I can't imagine that code has ever
> been tested.
>
> I don't know the policy on changing an API like this with silent
> semantic changes.  You've gotten all the internal ones; I'm wondering if
> we worry about silently breaking out of tree things.
>
> I'll pull this into my tree, but hopefully others will comment on this.

FYI this patch doesn't apply on current master:
https://patchew.org/logs/20200621145235.9E241745712@zero.eik.bme.hu/git/

>
> -corey
>
> >
> > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > ---
> > Looks like hw/misc/auxbus.c already got this wrong and calls both
> > i2c_start_transfer and i2c_send_recv with same is_write parameter.
> > Although the name of the is_write variable suggest this may need to be
> > inverted I'm not sure what that value actially means and which usage
> > was correct so I did not touch it. Someone knowing this device might
> > want to review and fix it.
> >
> >  hw/display/sm501.c   |  2 +-
> >  hw/i2c/core.c        | 34 +++++++++++++++++-----------------
> >  hw/i2c/ppc4xx_i2c.c  |  2 +-
> >  include/hw/i2c/i2c.h |  4 ++--
> >  4 files changed, 21 insertions(+), 21 deletions(-)
> >
> > diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> > index 2db347dcbc..ccd0a6e376 100644
> > --- a/hw/display/sm501.c
> > +++ b/hw/display/sm501.c
> > @@ -1034,7 +1034,7 @@ static void sm501_i2c_write(void *opaque, hwaddr addr, uint64_t value,
> >                      int i;
> >                      for (i = 0; i <= s->i2c_byte_count; i++) {
> >                          res = i2c_send_recv(s->i2c_bus, &s->i2c_data[i],
> > -                                            !(s->i2c_addr & 1));
> > +                                            s->i2c_addr & 1);
> >                          if (res) {
> >                              s->i2c_status |= SM501_I2C_STATUS_ERROR;
> >                              return;
> > diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> > index 1aac457a2a..c9d01df427 100644
> > --- a/hw/i2c/core.c
> > +++ b/hw/i2c/core.c
> > @@ -91,7 +91,7 @@ int i2c_bus_busy(I2CBus *bus)
> >   * without releasing the bus.  If that fails, the bus is still
> >   * in a transaction.
> >   */
> > -int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv)
> > +int i2c_start_transfer(I2CBus *bus, uint8_t address, bool recv)
> >  {
> >      BusChild *kid;
> >      I2CSlaveClass *sc;
> > @@ -175,26 +175,14 @@ void i2c_end_transfer(I2CBus *bus)
> >      bus->broadcast = false;
> >  }
> >
> > -int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send)
> > +int i2c_send_recv(I2CBus *bus, uint8_t *data, bool recv)
> >  {
> >      I2CSlaveClass *sc;
> >      I2CSlave *s;
> >      I2CNode *node;
> >      int ret = 0;
> >
> > -    if (send) {
> > -        QLIST_FOREACH(node, &bus->current_devs, next) {
> > -            s = node->elt;
> > -            sc = I2C_SLAVE_GET_CLASS(s);
> > -            if (sc->send) {
> > -                trace_i2c_send(s->address, *data);
> > -                ret = ret || sc->send(s, *data);
> > -            } else {
> > -                ret = -1;
> > -            }
> > -        }
> > -        return ret ? -1 : 0;
> > -    } else {
> > +    if (recv) {
> >          ret = 0xff;
> >          if (!QLIST_EMPTY(&bus->current_devs) && !bus->broadcast) {
> >              sc = I2C_SLAVE_GET_CLASS(QLIST_FIRST(&bus->current_devs)->elt);
> > @@ -206,19 +194,31 @@ int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send)
> >          }
> >          *data = ret;
> >          return 0;
> > +    } else {
> > +        QLIST_FOREACH(node, &bus->current_devs, next) {
> > +            s = node->elt;
> > +            sc = I2C_SLAVE_GET_CLASS(s);
> > +            if (sc->send) {
> > +                trace_i2c_send(s->address, *data);
> > +                ret = ret || sc->send(s, *data);
> > +            } else {
> > +                ret = -1;
> > +            }
> > +        }
> > +        return ret ? -1 : 0;
> >      }
> >  }
> >
> >  int i2c_send(I2CBus *bus, uint8_t data)
> >  {
> > -    return i2c_send_recv(bus, &data, true);
> > +    return i2c_send_recv(bus, &data, false);
> >  }
> >
> >  uint8_t i2c_recv(I2CBus *bus)
> >  {
> >      uint8_t data = 0xff;
> >
> > -    i2c_send_recv(bus, &data, false);
> > +    i2c_send_recv(bus, &data, true);
> >      return data;
> >  }
> >
> > diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> > index c0a8e04567..d3899203a4 100644
> > --- a/hw/i2c/ppc4xx_i2c.c
> > +++ b/hw/i2c/ppc4xx_i2c.c
> > @@ -239,7 +239,7 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
> >                      }
> >                  }
> >                  if (!(i2c->sts & IIC_STS_ERR) &&
> > -                    i2c_send_recv(i2c->bus, &i2c->mdata[i], !recv)) {
> > +                    i2c_send_recv(i2c->bus, &i2c->mdata[i], recv)) {
> >                      i2c->sts |= IIC_STS_ERR;
> >                      i2c->extsts |= IIC_EXTSTS_XFRA;
> >                      break;
> > diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> > index 4117211565..a09ab9230b 100644
> > --- a/include/hw/i2c/i2c.h
> > +++ b/include/hw/i2c/i2c.h
> > @@ -72,10 +72,10 @@ struct I2CBus {
> >  I2CBus *i2c_init_bus(DeviceState *parent, const char *name);
> >  void i2c_set_slave_address(I2CSlave *dev, uint8_t address);
> >  int i2c_bus_busy(I2CBus *bus);
> > -int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv);
> > +int i2c_start_transfer(I2CBus *bus, uint8_t address, bool recv);
> >  void i2c_end_transfer(I2CBus *bus);
> >  void i2c_nack(I2CBus *bus);
> > -int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send);
> > +int i2c_send_recv(I2CBus *bus, uint8_t *data, bool recv);
> >  int i2c_send(I2CBus *bus, uint8_t data);
> >  uint8_t i2c_recv(I2CBus *bus);
> >
> > --
> > 2.21.3
> >
>

