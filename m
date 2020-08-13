Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C19C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:45:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7677206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7677206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k67vR-0002ZX-T4
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 03:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1k67uA-0001Hl-HG; Thu, 13 Aug 2020 03:44:06 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:34783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1k67u8-0002OY-CI; Thu, 13 Aug 2020 03:44:06 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.44])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id B511756B4AAC;
 Thu, 13 Aug 2020 09:43:58 +0200 (CEST)
Received: from kaod.org (37.59.142.96) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 13 Aug
 2020 09:43:57 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001a338f13f-8b53-4c2c-ba13-6cfdcd9e7581,
 56FC6CFA6F9FB878813463EC2CBCCD0911300B36) smtp.auth=groug@kaod.org
Date: Thu, 13 Aug 2020 09:43:56 +0200
From: Greg Kurz <groug@kaod.org>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [for-5.2 v4 09/10] host trust limitation: Alter virtio default
 properties for protected guests
Message-ID: <20200813094356.651f323c@bahia.lan>
In-Reply-To: <20200727150514.GQ3040@work-vm>
References: <20200724025744.69644-1-david@gibson.dropbear.id.au>
 <20200724025744.69644-10-david@gibson.dropbear.id.au>
 <20200727150514.GQ3040@work-vm>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: f5836199-13f5-4a5c-840c-5c8b35579b5f
X-Ovh-Tracer-Id: 17239216424127404499
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrleefgdduvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegvhhgrsghkohhsthesrhgvughhrghtrdgtohhm
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:44:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia
 Huck <cohuck@redhat.com>, David
 Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, ehabkost@redhat.com,
 mdroth@linux.vnet.ibm.com, pasic@linux.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, pbonzini@redhat.com, Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jul 2020 16:05:14 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * David Gibson (david@gibson.dropbear.id.au) wrote:
> > The default behaviour for virtio devices is not to use the platforms normal
> > DMA paths, but instead to use the fact that it's running in a hypervisor
> > to directly access guest memory.  That doesn't work if the guest's memory
> > is protected from hypervisor access, such as with AMD's SEV or POWER's PEF.
> > 
> > So, if a host trust limitation mechanism is enabled, then apply the
> > iommu_platform=on option so it will go through normal DMA mechanisms.
> > Those will presumably have some way of marking memory as shared with the
> > hypervisor or hardware so that DMA will work.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Good, it's just too easy to forget them at the moment and get hopelessly
> confused.
> 
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> > ---
> >  hw/core/machine.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index b599b0ba65..2a723bf07b 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -28,6 +28,8 @@
> >  #include "hw/mem/nvdimm.h"
> >  #include "migration/vmstate.h"
> >  #include "exec/host-trust-limitation.h"
> > +#include "hw/virtio/virtio.h"
> > +#include "hw/virtio/virtio-pci.h"
> >  
> >  GlobalProperty hw_compat_5_0[] = {
> >      { "virtio-balloon-device", "page-poison", "false" },
> > @@ -1161,6 +1163,15 @@ void machine_run_board_init(MachineState *machine)
> >           * areas.
> >           */
> >          machine_set_mem_merge(OBJECT(machine), false, &error_abort);
> > +
> > +        /*
> > +         * Virtio devices can't count on directly accessing guest
> > +         * memory, so they need iommu_platform=on to use normal DMA
> > +         * mechanisms.  That requires disabling legacy virtio support
> > +         * for virtio pci devices
> > +         */
> > +        object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-legacy", "on");

What about non-transitional devices (eg. vhost-user-fs-pci) ? They don't know
about "disable-legacy" since they don't need it.

> > +        object_register_sugar_prop(TYPE_VIRTIO_DEVICE, "iommu_platform", "on");
> >      }
> >  
> >      machine_class->init(machine);
> > -- 
> > 2.26.2
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> 


