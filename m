Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670E2C5517A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81FC2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81FC2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQpJ-00083m-Qp
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kXQkk-00024U-No; Tue, 27 Oct 2020 11:19:14 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:50255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kXQki-0007y6-Dm; Tue, 27 Oct 2020 11:19:14 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.194])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 0C18F68D0EA4;
 Tue, 27 Oct 2020 16:19:01 +0100 (CET)
Received: from kaod.org (37.59.142.99) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 27 Oct
 2020 16:18:59 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G00334daecc6-0266-4a79-b0ad-919988a2ecde,
 8E5A4880AAF567D55136F4F8027E0847E2FD1EE8) smtp.auth=groug@kaod.org
Date: Tue, 27 Oct 2020 16:18:58 +0100
From: Greg Kurz <groug@kaod.org>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 4/5] spapr: Pass &error_abort when getting some PC DIMM
 properties
Message-ID: <20201027161858.590329a7@bahia>
In-Reply-To: <20201027125424.13833af8@redhat.com>
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
 <160309732180.2739814.7243774674998010907.stgit@bahia.lan>
 <20201023211509.5c316c01@redhat.com>
 <20201025162444.0fdec88a@bahia.lan>
 <20201027125424.13833af8@redhat.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: bd799c71-5f0c-492e-80f1-32c40d2b10c9
X-Ovh-Tracer-Id: 4207487953355250168
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgdejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheprhhthhesthifihguughlvgdrnhgvth
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 11:19:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Oct 2020 12:54:24 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Sun, 25 Oct 2020 16:24:44 +0100
> Greg Kurz <groug@kaod.org> wrote:
> 
> > On Fri, 23 Oct 2020 21:15:09 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> > 
> > > On Mon, 19 Oct 2020 10:48:41 +0200
> > > Greg Kurz <groug@kaod.org> wrote:
> > >   
> > > > Both PC_DIMM_SLOT_PROP and PC_DIMM_ADDR_PROP are defined in the
> > > > default property list of the PC DIMM device class:
> > > > 
> > > >     DEFINE_PROP_UINT64(PC_DIMM_ADDR_PROP, PCDIMMDevice, addr, 0),
> > > > 
> > > >     DEFINE_PROP_INT32(PC_DIMM_SLOT_PROP, PCDIMMDevice, slot,
> > > >                       PC_DIMM_UNASSIGNED_SLOT),
> > > > 
> > > > They should thus be always gettable for both PC DIMMs and NVDIMMs.
> > > > An error in getting them can only be the result of a programming
> > > > error. It doesn't make much sense to propagate the error in this
> > > > case. Abort instead.
> > > > 
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>  
> > > 
> > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > > 
> > > TODO for future,
> > > get rid of local_err in spapr_memory_plug() altogether, it should not fail.
> > > it needs moving check from spapr_drc_attach() to spapr_memory_pre_plug() time.
> > > 
> > > that will clear up (a bit) road for dropping errp in spapr_memory_plug()  
> > 
> > Igor,
> > 
> > I could find time to look a bit into attaching DRCs at pre-plug and I
> > think this isn't possible. The problem is that there doesn't seem to be
> > a reverse operation for pre-plug. If realize fails for the DIMM device,
> > spapr_drc_detach() wouldn't be called, which would be wrong.
> 
> probably I was clear enough, I didn't suggest to move spapr_drc_detach()
> to pre_plug time but rather do a bit of surgery along the lines:
> 

Ok, I get it now. I realize now I actually misread your suggestion. Sorry...

> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2db810f73a..59a229b4fa 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3474,6 +3474,11 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>          return;
>      }
>  
> +    get drc
> +    if (!spapr_drc_attachable(drc)) {
> +        error out
> +    }
> +

It might require some more code refactoring because the way regular
PC-DIMMs are broken down into a set of logical memory blocks (LMBs),
each one having its own DRC but it's certainly doable. Probably for
QEMU 6.0 though since we're entering soft freeze and David already
fired a PR today.

>      if (is_nvdimm) {
>          spapr_nvdimm_validate(hotplug_dev, NVDIMM(dev), size, &local_err);
>          if (local_err) {
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index fe998d8108..ae049bc202 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -371,14 +371,16 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
>      } while (fdt_depth != 0);
>  }
>  
> -void spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Error **errp)
> +
> +bool spapr_drc_attachable(SpaprDrc *drc)
> +{
> +   return !drc->dev;
> +}
> +
> +void spapr_drc_attach(SpaprDrc *drc, DeviceState *d)
>  {
>      trace_spapr_drc_attach(spapr_drc_index(drc));
>  
> -    if (drc->dev) {
> -        error_setg(errp, "an attached device is still awaiting release");
> -        return;
> -    }
>      g_assert((drc->state == SPAPR_DRC_STATE_LOGICAL_UNUSABLE)
>               || (drc->state == SPAPR_DRC_STATE_PHYSICAL_POWERON));
> 
> > 
> > Am I missing something ?
> > 
> > > > ---
> > > >  hw/ppc/spapr.c |   17 +++--------------
> > > >  1 file changed, 3 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > index 1b173861152f..62f217a6b914 100644
> > > > --- a/hw/ppc/spapr.c
> > > > +++ b/hw/ppc/spapr.c
> > > > @@ -3443,19 +3443,13 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> > > >  
> > > >      if (!is_nvdimm) {
> > > >          addr = object_property_get_uint(OBJECT(dimm),
> > > > -                                        PC_DIMM_ADDR_PROP, &local_err);
> > > > -        if (local_err) {
> > > > -            goto out_unplug;
> > > > -        }
> > > > +                                        PC_DIMM_ADDR_PROP, &error_abort);
> > > >          spapr_add_lmbs(dev, addr, size,
> > > >                         spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
> > > >                         &local_err);
> > > >      } else {
> > > >          slot = object_property_get_int(OBJECT(dimm),
> > > > -                                       PC_DIMM_SLOT_PROP, &local_err);
> > > > -        if (local_err) {
> > > > -            goto out_unplug;
> > > > -        }
> > > > +                                       PC_DIMM_SLOT_PROP, &error_abort);
> > > >          /* We should have valid slot number at this point */
> > > >          g_assert(slot >= 0);
> > > >          spapr_add_nvdimm(dev, slot, &local_err);
> > > > @@ -3634,7 +3628,6 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
> > > >                                          DeviceState *dev, Error **errp)
> > > >  {
> > > >      SpaprMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
> > > > -    Error *local_err = NULL;
> > > >      PCDIMMDevice *dimm = PC_DIMM(dev);
> > > >      uint32_t nr_lmbs;
> > > >      uint64_t size, addr_start, addr;
> > > > @@ -3650,11 +3643,7 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
> > > >      nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
> > > >  
> > > >      addr_start = object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,
> > > > -                                         &local_err);
> > > > -    if (local_err) {
> > > > -        error_propagate(errp, local_err);
> > > > -        return;
> > > > -    }
> > > > +                                          &error_abort);
> > > >  
> > > >      /*
> > > >       * An existing pending dimm state for this DIMM means that there is an
> > > > 
> > > > 
> > > >   
> > >   
> > 
> 


