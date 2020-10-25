Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5D0C4363A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 21:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB902225B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 21:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB902225B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWne7-0000lj-Dw
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 17:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kWncL-0008HI-V3
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 17:31:57 -0400
Received: from 10.mo52.mail-out.ovh.net ([87.98.187.244]:50227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kWncJ-0004YC-O6
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 17:31:57 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.194])
 by mo52.mail-out.ovh.net (Postfix) with ESMTPS id 789971FF1B7;
 Sun, 25 Oct 2020 22:31:50 +0100 (CET)
Received: from kaod.org (37.59.142.96) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Sun, 25 Oct
 2020 22:31:49 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001b2d30bea-7591-48cb-8f1c-3457a5ffd96b,
 5F9C93A9F3AD2D257DE4C2DCE7DBF4E7A6D9743C) smtp.auth=groug@kaod.org
Date: Sun, 25 Oct 2020 22:31:48 +0100
From: Greg Kurz <groug@kaod.org>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 1/5] pc-dimm: Drop @errp argument of pc_dimm_plug()
Message-ID: <20201025223148.2822fcf9@bahia.lan>
In-Reply-To: <20201023211919.77377cb9@redhat.com>
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
 <160309728447.2739814.12831204841251148202.stgit@bahia.lan>
 <20201023211919.77377cb9@redhat.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: b828ecb5-1de6-40e7-ac94-febefb3b8004
X-Ovh-Tracer-Id: 17205439427372751352
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrkeeggdduhedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegurghvihgusehgihgsshhonhdrughrohhpsggvrghrrdhiugdrrghu
Received-SPF: pass client-ip=87.98.187.244; envelope-from=groug@kaod.org;
 helo=10.mo52.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 17:31:52
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
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Oct 2020 21:19:19 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Mon, 19 Oct 2020 10:48:04 +0200
> Greg Kurz <groug@kaod.org> wrote:
> 
> > pc_dimm_plug() doesn't use it. It only aborts on error.
> > 
> > Drop @errp and adapt the callers accordingly.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
> arguably the same should be done in spapr.
> 

As explained in another mail, we have to keep spapr_drc_attach()
at plug time and this can legitimately fail if an unplug operation
is pending for the device. We certainly prefer to report this as
an error rather than aborting.

> > ---
> >  hw/arm/virt.c            |    9 +--------
> >  hw/i386/pc.c             |    8 +-------
> >  hw/mem/pc-dimm.c         |    2 +-
> >  hw/ppc/spapr.c           |    5 +----
> >  include/hw/mem/pc-dimm.h |    2 +-
> >  5 files changed, 5 insertions(+), 21 deletions(-)
> > 
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index e465a988d683..27dbeb549ef1 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -2261,12 +2261,8 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
> >      VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> >      MachineState *ms = MACHINE(hotplug_dev);
> >      bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
> > -    Error *local_err = NULL;
> >  
> > -    pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), &local_err);
> > -    if (local_err) {
> > -        goto out;
> > -    }
> > +    pc_dimm_plug(PC_DIMM(dev), MACHINE(vms));
> >  
> >      if (is_nvdimm) {
> >          nvdimm_plug(ms->nvdimms_state);
> > @@ -2274,9 +2270,6 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
> >  
> >      hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
> >                           dev, &error_abort);
> > -
> > -out:
> > -    error_propagate(errp, local_err);
> >  }
> >  
> >  static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index e87be5d29a01..38b1be78e707 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1265,24 +1265,18 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >  static void pc_memory_plug(HotplugHandler *hotplug_dev,
> >                             DeviceState *dev, Error **errp)
> >  {
> > -    Error *local_err = NULL;
> >      PCMachineState *pcms = PC_MACHINE(hotplug_dev);
> >      X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
> >      MachineState *ms = MACHINE(hotplug_dev);
> >      bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
> >  
> > -    pc_dimm_plug(PC_DIMM(dev), MACHINE(pcms), &local_err);
> > -    if (local_err) {
> > -        goto out;
> > -    }
> > +    pc_dimm_plug(PC_DIMM(dev), MACHINE(pcms));
> >  
> >      if (is_nvdimm) {
> >          nvdimm_plug(ms->nvdimms_state);
> >      }
> >  
> >      hotplug_handler_plug(x86ms->acpi_dev, dev, &error_abort);
> > -out:
> > -    error_propagate(errp, local_err);
> >  }
> >  
> >  static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
> > diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> > index c30351070bb8..2ffc986734df 100644
> > --- a/hw/mem/pc-dimm.c
> > +++ b/hw/mem/pc-dimm.c
> > @@ -64,7 +64,7 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
> >                             errp);
> >  }
> >  
> > -void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine, Error **errp)
> > +void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine)
> >  {
> >      PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
> >      MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index ee716a12af73..4edd31b86915 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3438,10 +3438,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >  
> >      size = memory_device_get_region_size(MEMORY_DEVICE(dev), &error_abort);
> >  
> > -    pc_dimm_plug(dimm, MACHINE(ms), &local_err);
> > -    if (local_err) {
> > -        goto out;
> > -    }
> > +    pc_dimm_plug(dimm, MACHINE(ms));
> >  
> >      if (!is_nvdimm) {
> >          addr = object_property_get_uint(OBJECT(dimm),
> > diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> > index aec9527fdd96..3d3db82641f8 100644
> > --- a/include/hw/mem/pc-dimm.h
> > +++ b/include/hw/mem/pc-dimm.h
> > @@ -72,6 +72,6 @@ struct PCDIMMDeviceClass {
> >  
> >  void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
> >                        const uint64_t *legacy_align, Error **errp);
> > -void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine, Error **errp);
> > +void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine);
> >  void pc_dimm_unplug(PCDIMMDevice *dimm, MachineState *machine);
> >  #endif
> > 
> > 
> > 
> 
> 


