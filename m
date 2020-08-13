Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCC0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:02:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB4D620771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4D620771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6LIS-00018J-Se
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 18:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1k6LGz-0000Nx-2A; Thu, 13 Aug 2020 18:00:33 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:49073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1k6LGw-0008Um-OQ; Thu, 13 Aug 2020 18:00:32 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.173])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id D87DF56EF05D;
 Fri, 14 Aug 2020 00:00:25 +0200 (CEST)
Received: from kaod.org (37.59.142.98) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 14 Aug
 2020 00:00:25 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0028ee25d8a-88bb-427e-ae7e-662f88f3ff85,
 21E6336EA1F9EF687188A7B356EF1CEBE272E175) smtp.auth=groug@kaod.org
Date: Fri, 14 Aug 2020 00:00:24 +0200
From: Greg Kurz <groug@kaod.org>
To: Gustavo Romero <gromero@linux.vnet.ibm.com>
Subject: Re: [PATCH] spapr/xive: Use xive_source_esb_len()
Message-ID: <20200814000024.3b78d907@bahia.lan>
In-Reply-To: <b5cfd02b-abf7-8d03-7ae2-1f483bf7b0bc@linux.vnet.ibm.com>
References: <159733969034.320580.6571451425779179477.stgit@bahia.lan>
 <b5cfd02b-abf7-8d03-7ae2-1f483bf7b0bc@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 4c3dd400-ad62-4b83-b590-678300eb4ca5
X-Ovh-Tracer-Id: 13256626980328806819
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrleeigddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepuedugfeljeetjefhfeduhfffledvieelfffggeegfeegteegfeeukeduudetffdunecuffhomhgrihhnpehoiihlrggsshdrohhrghenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegtlhhgsehkrghougdrohhrgh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 18:00:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Aug 2020 17:38:59 -0300
Gustavo Romero <gromero@linux.vnet.ibm.com> wrote:

> Hi Greg,
> 

Hi Gustavo,

> On 8/13/20 2:28 PM, Greg Kurz wrote:
> > static inline size_t xive_source_esb_len(XiveSource *xsrc)
> > {
> >      return (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> > }
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > Follow-up on "ppc/xive: Rework setup of XiveSource::esb_mmio"
> > http://patchwork.ozlabs.org/project/qemu-devel/patch/159679992680.876294.7520540158586170894.stgit@bahia.lan/
> > ---
> >   hw/intc/spapr_xive.c     |    2 +-
> >   hw/intc/spapr_xive_kvm.c |    2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > index 3c84f64dc464..4bd0d606ba17 100644
> > --- a/hw/intc/spapr_xive.c
> > +++ b/hw/intc/spapr_xive.c
> > @@ -336,7 +336,7 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
> >       sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
> >   
> >       /* Set the mapping address of the END ESB pages after the source ESBs */
> > -    xive->end_base = xive->vc_base + (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> > +    xive->end_base = xive->vc_base + xive_source_esb_len(xsrc);
> >   
> >       /*
> >        * Allocate the routing tables
> > diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> > index 82a6f99f022d..3263b982239a 100644
> > --- a/hw/intc/spapr_xive_kvm.c
> > +++ b/hw/intc/spapr_xive_kvm.c
> > @@ -831,7 +831,7 @@ void kvmppc_xive_disconnect(SpaprInterruptController *intc)
> >   
> >       /* Clear the KVM mapping */
> >       xsrc = &xive->source;
> > -    esb_len = (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> > +    esb_len = xive_source_esb_len(xsrc);
> 
> hrm I'd like to not add another level of indirection here.
> In this specific case I think it's more clear to read just
> 
> 1ull << xsrc->esb_shift) * xsrc->nr_irqs
> 
> and get the idea of one IRQ per ESB page (or pair of pages,
> for trigger and management), than one having to look at
> what is inside "a box" called xive_source_esb_len().
> 
> Wrapping it under another function doesn't help more when
> reading the code, XIVE is already tricky enough :)
> 

Heh, XIVE is tricky enough that only a few people will dare
to touch this code and they'd better already know about the
one IRQ per ESB page thingy ;-)

More seriously, this is a matter of taste, but since you're likely
to be involved in XIVE a bit more than me, I'm perfectly fine with
keeping this open-coded.

> 
> Cheers,
> Gustavo
> 
> PS: It seems something messed up with the commit message. It
> can be that the ML did that tho...

It's more laziness on my side... I should have come up with a
proper changelog like "We already have an helper that provides
the length of the ESB mapping. No need to open-code this again."
instead of pasting a code snippet. Time to go on vacation I guess :)

Cheers,

--
Greg

