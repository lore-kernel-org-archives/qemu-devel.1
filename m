Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DB9C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 22:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB102089D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 22:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB102089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv6hA-0006uL-OK
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 18:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@cmp.felk.cvut.cz>)
 id 1jv6f6-0006Kc-09; Mon, 13 Jul 2020 18:11:00 -0400
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:42446)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pisa@cmp.felk.cvut.cz>)
 id 1jv6f3-0002OP-LT; Mon, 13 Jul 2020 18:10:59 -0400
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
 by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 06DM9u8j052207;
 Tue, 14 Jul 2020 00:09:56 +0200 (CEST)
 (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
 by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id
 06DM9tSm028537; Tue, 14 Jul 2020 00:09:55 +0200
Received: (from pisa@localhost)
 by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 06DM9tnX028534;
 Tue, 14 Jul 2020 00:09:55 +0200
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to
 pisa@cmp.felk.cvut.cz using -f
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] hw/net/can: Add missing fallthrough statements
Date: Tue, 14 Jul 2020 00:09:55 +0200
User-Agent: KMail/1.9.10
References: <20200630075520.29825-1-thuth@redhat.com>
 <c31c772f-9d30-ac47-9e91-02126dc79736@vivier.eu>
In-Reply-To: <c31c772f-9d30-ac47-9e91-02126dc79736@vivier.eu>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <202007140009.55103.pisa@cmp.felk.cvut.cz>
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 06DM9u8j052207
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-0.414, required 6, autolearn=not spam, BAYES_00 -0.50,
 KHOP_HELO_FCRDNS 0.09, NICE_REPLY_A -0.00, SPF_HELO_NONE 0.00,
 SPF_NONE 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1595283001.22094@OTc5TJqEOH+ilhRIaQSWIw
Received-SPF: none client-ip=2001:718:2:1611:0:1:0:70;
 envelope-from=pisa@cmp.felk.cvut.cz; helo=relay.felk.cvut.cz
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 18:10:52
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Oliver Hartkopp <socketcan@hartkopp.net>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Ondrej Ille <ondrej.ille@gmail.com>,
 Jan =?utf-8?q?Charv=C3=A1t?= <charvj10@fel.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Laurent and others,

On Monday 06 of July 2020 18:35:50 Laurent Vivier wrote:
> Le 30/06/2020 =C3=A0 09:55, Thomas Huth a =C3=A9crit=C2=A0:
> > Add fallthrough annotations to be able to compile the code without
> > warnings when using -Wimplicit-fallthrough in our CFLAGS. Looking
> > at the code, it seems like the fallthrough is indeed intended here,
> > so the comments should be appropriate.
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  hw/net/can/can_sja1000.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
> > index ea915a023a..299932998a 100644
> > --- a/hw/net/can/can_sja1000.c
> > +++ b/hw/net/can/can_sja1000.c
> > @@ -523,6 +523,7 @@ void can_sja_mem_write(CanSJA1000State *s, hwaddr
> > addr, uint64_t val, break;
> >          case 16: /* RX frame information addr16-28. */
> >              s->status_pel |=3D (1 << 5); /* Set transmit status. */
> > +            /* fallthrough */
> >          case 17 ... 28:
> >              if (s->mode & 0x01) { /* Reset mode */
> >                  if (addr < 24) {
> > @@ -620,6 +621,7 @@ void can_sja_mem_write(CanSJA1000State *s, hwaddr
> > addr, uint64_t val, break;
> >          case 10:
> >              s->status_bas |=3D (1 << 5); /* Set transmit status. */
> > +            /* fallthrough */
> >          case 11 ... 19:
> >              if ((s->control & 0x01) =3D=3D 0) { /* Operation mode */
> >                  s->tx_buff[addr - 10] =3D val; /* Store to TX buffer
> > directly. */
>
> cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>
>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

The fallthrough is intentional for sure but I have gone
through datasheet and checked why the status bit is set
there and my conclusion is that to mimic real HW the status
bit should not be set there. In the fact, it should be set
and immediately (in a future delayed) reset after SJA_CMR
transmit request write. This would mimic real hardware
more closely. May it be I send patch in future when more
of our developed CAN support is added to QEMU. The status
bit behavior has no influence on actual Linux SJA1000 driver
anyway.

So for now, I confirm that adding  /* fallthrough */ is correct
step forward.

Reviewed-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

By the way, we have prepared CAN FD support for QEMU,
the CAN core update and device model to emulate
our open-source/design/hardware CTU CAN FD IP core

  https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core

QEMU emulation

  https://gitlab.fel.cvut.cz/canbus/qemu-canbus/-/commits/charvj10-canfd

I hope to find time to add patch to document CAN support to CAN FD
extension and send whole series this week. Stay tuned, please.

Best wishes,
=20
                Pavel

=2D-=20

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://dce.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/


