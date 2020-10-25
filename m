Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3131C388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 15:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F19B8208A9
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 15:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19B8208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWhtw-0005T2-Vz
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 11:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kWht9-0004rr-E1; Sun, 25 Oct 2020 11:24:55 -0400
Received: from 10.mo52.mail-out.ovh.net ([87.98.187.244]:46194)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kWht7-0003Bx-Fe; Sun, 25 Oct 2020 11:24:55 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.235])
 by mo52.mail-out.ovh.net (Postfix) with ESMTPS id CFDE21FF573;
 Sun, 25 Oct 2020 16:24:46 +0100 (CET)
Received: from kaod.org (37.59.142.97) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Sun, 25 Oct
 2020 16:24:45 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002ef50abc6-4b1a-468b-8b77-ff00f373087a,
 5F9C93A9F3AD2D257DE4C2DCE7DBF4E7A6D9743C) smtp.auth=groug@kaod.org
Date: Sun, 25 Oct 2020 16:24:44 +0100
From: Greg Kurz <groug@kaod.org>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 4/5] spapr: Pass &error_abort when getting some PC DIMM
 properties
Message-ID: <20201025162444.0fdec88a@bahia.lan>
In-Reply-To: <20201023211509.5c316c01@redhat.com>
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
 <160309732180.2739814.7243774674998010907.stgit@bahia.lan>
 <20201023211509.5c316c01@redhat.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 11b92afa-85a7-4191-be27-9e4abac1a41e
X-Ovh-Tracer-Id: 11006234540100917752
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrkeeggdejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheprhhthhesthifihguughlvgdrnhgvth
Received-SPF: pass client-ip=87.98.187.244; envelope-from=groug@kaod.org;
 helo=10.mo52.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 11:24:50
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

On Fri, 23 Oct 2020 21:15:09 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Mon, 19 Oct 2020 10:48:41 +0200
> Greg Kurz <groug@kaod.org> wrote:
> 
> > Both PC_DIMM_SLOT_PROP and PC_DIMM_ADDR_PROP are defined in the
> > default property list of the PC DIMM device class:
> > 
> >     DEFINE_PROP_UINT64(PC_DIMM_ADDR_PROP, PCDIMMDevice, addr, 0),
> > 
> >     DEFINE_PROP_INT32(PC_DIMM_SLOT_PROP, PCDIMMDevice, slot,
> >                       PC_DIMM_UNASSIGNED_SLOT),
> > 
> > They should thus be always gettable for both PC DIMMs and NVDIMMs.
> > An error in getting them can only be the result of a programming
> > error. It doesn't make much sense to propagate the error in this
> > case. Abort instead.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
> TODO for future,
> get rid of local_err in spapr_memory_plug() altogether, it should not fail.
> it needs moving check from spapr_drc_attach() to spapr_memory_pre_plug() time.
> 
> that will clear up (a bit) road for dropping errp in spapr_memory_plug()

Igor,

I could find time to look a bit into attaching DRCs at pre-plug and I
think this isn't possible. The problem is that there doesn't seem to be
a reverse operation for pre-plug. If realize fails for the DIMM device,
spapr_drc_detach() wouldn't be called, which would be wrong.

Am I missing something ?

> > ---
> >  hw/ppc/spapr.c |   17 +++--------------
> >  1 file changed, 3 insertions(+), 14 deletions(-)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 1b173861152f..62f217a6b914 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3443,19 +3443,13 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >  
> >      if (!is_nvdimm) {
> >          addr = object_property_get_uint(OBJECT(dimm),
> > -                                        PC_DIMM_ADDR_PROP, &local_err);
> > -        if (local_err) {
> > -            goto out_unplug;
> > -        }
> > +                                        PC_DIMM_ADDR_PROP, &error_abort);
> >          spapr_add_lmbs(dev, addr, size,
> >                         spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
> >                         &local_err);
> >      } else {
> >          slot = object_property_get_int(OBJECT(dimm),
> > -                                       PC_DIMM_SLOT_PROP, &local_err);
> > -        if (local_err) {
> > -            goto out_unplug;
> > -        }
> > +                                       PC_DIMM_SLOT_PROP, &error_abort);
> >          /* We should have valid slot number at this point */
> >          g_assert(slot >= 0);
> >          spapr_add_nvdimm(dev, slot, &local_err);
> > @@ -3634,7 +3628,6 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
> >                                          DeviceState *dev, Error **errp)
> >  {
> >      SpaprMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
> > -    Error *local_err = NULL;
> >      PCDIMMDevice *dimm = PC_DIMM(dev);
> >      uint32_t nr_lmbs;
> >      uint64_t size, addr_start, addr;
> > @@ -3650,11 +3643,7 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
> >      nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
> >  
> >      addr_start = object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,
> > -                                         &local_err);
> > -    if (local_err) {
> > -        error_propagate(errp, local_err);
> > -        return;
> > -    }
> > +                                          &error_abort);
> >  
> >      /*
> >       * An existing pending dimm state for this DIMM means that there is an
> > 
> > 
> > 
> 


