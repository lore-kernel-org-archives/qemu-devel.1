Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CAEC0650E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 08:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3445218A3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 08:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3445218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiwrs-0006ua-2k
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 04:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52249)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hiwqn-00068P-CO
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 04:12:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hiwqm-0001oB-6M
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 04:12:17 -0400
Received: from 8.mo1.mail-out.ovh.net ([178.33.110.239]:42314)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hiwql-0001mb-VS
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 04:12:16 -0400
Received: from player693.ha.ovh.net (unknown [10.109.143.216])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id A30F5183930
 for <qemu-devel@nongnu.org>; Thu,  4 Jul 2019 10:12:11 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player693.ha.ovh.net (Postfix) with ESMTPSA id CC19F788DE9F;
 Thu,  4 Jul 2019 08:12:07 +0000 (UTC)
Date: Thu, 4 Jul 2019 10:12:04 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190704101204.4968e0a1@bahia.lan>
In-Reply-To: <20190704002357.GR9442@umbus.fritz.box>
References: <156217621200.562209.8968691631915806468.stgit@bahia.lan>
 <20190704002357.GR9442@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13032009949517814246
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrfedvgddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.110.239
Subject: Re: [Qemu-devel] [PATCH for-4.2] xics/kvm: Convert assert() to
 error_setg()
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
Cc: qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jul 2019 10:23:57 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jul 03, 2019 at 07:50:12PM +0200, Greg Kurz wrote:
> > ics_set_kvm_state_one() is called either during reset, in which case
> > both 'saved priority' and 'current priority' are equal to 0xff, or
> > during migration. In the latter case, 'saved priority' may differ
> > from 'current priority' only if the interrupt had been masked with
> > the ibm,int-off RTAS call. Instead of aborting QEMU, print out an
> > error and exit.
> 
> What's the rationale for this?  Doesn't hitting this indicate an error
> in the qemu code, for which an abort is the usual response?
> 

This error can be hit by the destination during migration if the
incoming stream is corrupted. Aborting in this case would mislead
the user into suspecting a bug in the destination QEMU, which isn't
the case.

Appart from that, when the in-kernel XICS is in use, only two functions
manipulate the ICS state: ics_set_kvm_state_one() and ics_get_kvm_state().
The code is trivial enough that I don't see a great value in the assert
in the first place... BTW, it comes from the commit:

commit 11ad93f68195f68cc94d988f2aa50b4d190ee52a
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Thu Sep 26 16:18:44 2013 +1000

    xics-kvm: Support for in-kernel XICS interrupt controller

Maybe you remember some context that justified the assert at the time ?

> > 
> > Based-on: <156217454083.559957.7359208229523652842.stgit@bahia.lan>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > 
> > This isn't a bugfix, hence targetting 4.2, but it depends on an actual
> > fix for 4.1, as mentionned in the Based-on tag.
> > ---
> >  hw/intc/xics_kvm.c |   17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> > index 2df1f3e92c7e..f8758b928250 100644
> > --- a/hw/intc/xics_kvm.c
> > +++ b/hw/intc/xics_kvm.c
> > @@ -255,8 +255,21 @@ int ics_set_kvm_state_one(ICSState *ics, int srcno, Error **errp)
> >      state = irq->server;
> >      state |= (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY_MASK)
> >          << KVM_XICS_PRIORITY_SHIFT;
> > -    if (irq->priority != irq->saved_priority) {
> > -        assert(irq->priority == 0xff);
> > +
> > +    /*
> > +     * An interrupt can be masked either because the ICS is resetting, in
> > +     * which case we expect 'current priority' and 'saved priority' to be
> > +     * equal to 0xff, or because the guest has called the ibm,int-off RTAS
> > +     * call, in which case we we have recorded the priority the interrupt
> > +     * had before it was masked in 'saved priority'. If the interrupt isn't
> > +     * masked, 'saved priority' and 'current priority' are equal (see
> > +     * ics_get_kvm_state()). Make sure we restore a sane state, otherwise
> > +     * fail migration.
> > +     */
> > +    if (irq->priority != irq->saved_priority && irq->priority != 0xff) {
> > +        error_setg(errp, "Corrupted state detected for interrupt source %d",
> > +                   srcno);
> > +        return -EINVAL;
> >      }
> >  
> >      if (irq->priority == 0xff) {
> > 
> 


