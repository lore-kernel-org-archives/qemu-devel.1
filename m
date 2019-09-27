Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0488C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B5F20872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B5F20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDt2n-0001Fe-Af
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 12:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDqzU-0004Q8-Ej
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDqzP-0002al-5g
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:13:00 -0400
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:40601)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDqzO-0002aO-Uj
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:12:55 -0400
Received: from player773.ha.ovh.net (unknown [10.108.54.141])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 613AB10C761
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 16:12:52 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player773.ha.ovh.net (Postfix) with ESMTPSA id 1E1E8A517807;
 Fri, 27 Sep 2019 14:12:41 +0000 (UTC)
Date: Fri, 27 Sep 2019 16:12:40 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 20/20] spapr: Eliminate SpaprIrq::init hook
Message-ID: <20190927161240.69f63705@bahia.lan>
In-Reply-To: <20190926173937.302ec223@bahia.lan>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-21-david@gibson.dropbear.id.au>
 <20190926173937.302ec223@bahia.lan>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1793277080510372326
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeigdejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.61.149
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Sep 2019 17:39:37 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Wed, 25 Sep 2019 16:45:34 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > This method is used to set up the interrupt backends for the current
> > configuration.  However, this means some confusing redirection between
> > the "dual" mode init and the init hooks for xics only and xive only modes.
> > 
> > Since we now have simple flags indicating whether XICS and/or XIVE are
> > supported, it's easier to just open code each initialization directly in
> > spapr_irq_init().  This will also make some future cleanups simpler.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>
> 

Just one nit...

> >  hw/ppc/spapr_irq.c          | 138 ++++++++++++++++--------------------
> >  include/hw/ppc/spapr_irq.h  |   1 -
> >  include/hw/ppc/xics_spapr.h |   1 +
[...]
> > diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> > index 691a6d00f7..267984a97b 100644
> > --- a/include/hw/ppc/xics_spapr.h
> > +++ b/include/hw/ppc/xics_spapr.h
> > @@ -34,6 +34,7 @@
> >  #define TYPE_ICS_SPAPR "ics-spapr"
> >  #define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
> >  
> > +void ics_spapr_create(SpaprMachineState *spapr, int nr_xirqs, Error **errp);

... this looks like a leftover.

> >  void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *fdt,
> >                     uint32_t phandle);
> >  int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
> 


