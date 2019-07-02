Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27020C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31BE2146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31BE2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGis-0005YD-35
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 07:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53932)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hiGbp-0006fh-Sr
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hiGbo-0006hu-D3
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:06:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hiGbn-0005am-Jc; Tue, 02 Jul 2019 07:06:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CF3B12F8BDE;
 Tue,  2 Jul 2019 11:05:22 +0000 (UTC)
Received: from gondolin (dhcp-192-192.str.redhat.com [10.33.192.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFD5919C5B;
 Tue,  2 Jul 2019 11:05:16 +0000 (UTC)
Date: Tue, 2 Jul 2019 13:05:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Message-ID: <20190702130514.60b67dbf.cohuck@redhat.com>
In-Reply-To: <7a47fc60-e490-3c95-66f5-3e16a2ad9da7@linux.ibm.com>
References: <1561475829-19202-1-git-send-email-walling@linux.ibm.com>
 <1561475829-19202-3-git-send-email-walling@linux.ibm.com>
 <20190626143324.6f359cd0.cohuck@redhat.com>
 <7a47fc60-e490-3c95-66f5-3e16a2ad9da7@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 02 Jul 2019 11:05:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 2/2] s390: diagnose 318 info reset and
 migration support
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
Cc: david@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Jun 2019 10:07:39 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> On 6/26/19 8:33 AM, Cornelia Huck wrote:
> > On Tue, 25 Jun 2019 11:17:09 -0400
> > Collin Walling <walling@linux.ibm.com> wrote:
> >   
> >> DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
> >> be intercepted by SIE and handled via KVM. Let's introduce some
> >> functions to communicate between QEMU and KVM via ioctls. These
> >> will be used to get/set the diag318 information.
> >>
> >> The availability of this instruction is determined by byte 134, bit 0
> >> of the Read Info block. This coincidentally expands into the space used
> >> for CPU entries, which means VMs running with the diag318 capability
> >> will have a reduced maximum CPU count. Let's reduce the maximum CPU
> >> count from 248 to 247.
> >>
> >> In order to simplify the migration and system reset requirements of
> >> the diag318 data, let's introduce it as a device class and include
> >> a VMStateDescription.
> >>
> >> Diag318 is set to 0 during modified clear and load normal resets.
> >>
> >> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> >> ---
> >>   hw/s390x/Makefile.objs          |  1 +
> >>   hw/s390x/diag318.c              | 80 +++++++++++++++++++++++++++++++++++++++++
> >>   hw/s390x/diag318.h              | 38 ++++++++++++++++++++
> >>   hw/s390x/s390-virtio-ccw.c      | 17 +++++++++
> >>   hw/s390x/sclp.c                 |  3 ++
> >>   include/hw/s390x/sclp.h         |  2 ++
> >>   target/s390x/cpu.h              |  8 ++++-
> >>   target/s390x/cpu_features.c     |  3 ++
> >>   target/s390x/cpu_features.h     |  1 +
> >>   target/s390x/cpu_features_def.h |  3 ++
> >>   target/s390x/gen-features.c     |  1 +
> >>   target/s390x/kvm-stub.c         | 10 ++++++
> >>   target/s390x/kvm.c              | 29 +++++++++++++++
> >>   target/s390x/kvm_s390x.h        |  2 ++
> >>   14 files changed, 197 insertions(+), 1 deletion(-)
> >>   create mode 100644 hw/s390x/diag318.c
> >>   create mode 100644 hw/s390x/diag318.h  
> > 
> > (...)
> >   
> >> diff --git a/hw/s390x/diag318.c b/hw/s390x/diag318.c
> >> new file mode 100644
> >> index 0000000..0eb80fe
> >> --- /dev/null
> >> +++ b/hw/s390x/diag318.c
> >> @@ -0,0 +1,80 @@
> >> +/*
> >> + * DIAGNOSE 0x318 functions for reset and migration
> >> + *
> >> + * Copyright IBM, Corp. 2019
> >> + *
> >> + * Authors:
> >> + *  Collin Walling <walling@linux.ibm.com>
> >> + *
> >> + * This work is licensed under the terms of the GNU GPL, version 2 or (at your
> >> + * option) any later version. See the COPYING file in the top-level directory.
> >> + */
> >> +
> >> +#include "hw/s390x/diag318.h"
> >> +#include "qapi/error.h"
> >> +#include "kvm_s390x.h"
> >> +#include "sysemu/kvm.h"
> >> +
> >> +static int diag318_post_load(void *opaque, int version_id)
> >> +{
> >> +    DIAG318State *d = opaque;
> >> +
> >> +    kvm_s390_set_diag318_info(d->info);  
> > 
> > Shouldn't we at least moan if something goes wrong here?
> >   
> 
> What are some things that might go wrong at this point? We
> should only call this if the diag318 feature is enabled. If
> we try to toggle that feature on a machine that cannot support
> it, the guest will fail to start, stating (paraphrased) "some
> features are not available in the configuration: diag318"
> 
> Is there some sort of issue that could arise from QEMU that I'm not
> considering?

The function might return an error; so I suspected that something may
possibly go wrong... checking seems like good practice in general.

> 
> >> +    return 0;
> >> +}
> >> +
> >> +static int diag318_pre_save(void *opaque)
> >> +{
> >> +    DIAG318State *d = opaque;
> >> +
> >> +    kvm_s390_get_diag318_info(&d->info);
> >> +    return 0;
> >> +}
> >> +
> >> +static bool diag318_needed(void *opaque)
> >> +{
> >> +    return s390_has_feat(S390_FEAT_DIAG318);  
> > 
> > What happens if we emulate diag 318 in tcg and set this feature bit? We
> > probably don't want to call kvm_ functions in that case.
> >   
> 
> I have not tested on tcg.

Well, it is not implemented right now :) My point is that we should not
tie this to *kvm* functions, but rather more generic functions.

> 
> >> +}
> >> +
> >> +const VMStateDescription vmstate_diag318 = {
> >> +    .name = "vmstate_diag318",
> >> +    .post_load = diag318_post_load,
> >> +    .pre_save = diag318_pre_save,
> >> +    .version_id = 1,
> >> +    .minimum_version_id = 1,
> >> +    .needed = diag318_needed,
> >> +    .fields = (VMStateField[]) {
> >> +        VMSTATE_UINT64(info, DIAG318State),
> >> +        VMSTATE_END_OF_LIST()
> >> +    }
> >> +};
> >> +
> >> +static void s390_diag318_reset(DeviceState *dev)
> >> +{
> >> +    kvm_s390_set_diag318_info(0);  
> > 
> > Same here; we probably need a s390_set_diag318_info() function that
> > either calls the kvm_ function or resets some internal state.
> >   
> 
> Hmm okay. I recall doing this for the TOD-clock stuff way-back. I'll
> include these functions next round.

Just a simple wrapper will suffice; we can then add any possible tcg
stuff whenever we get around to it (or never ;)

> 
> >> +}
> >> +
> >> +static void s390_diag318_class_init(ObjectClass *klass, void *data)
> >> +{
> >> +    DeviceClass *dc = DEVICE_CLASS(klass);
> >> +
> >> +    dc->reset = s390_diag318_reset;
> >> +    dc->vmsd = &vmstate_diag318;
> >> +    dc->hotpluggable = false;
> >> +    /* Reason: Set automatically during IPL */  
> > 
> > "Created automatically during machine instantiation" ?
> >   
> 
> I like it.
> 
> >> +    dc->user_creatable = false;
> >> +}
> >> +
> >> +static const TypeInfo s390_diag318_info = {
> >> +    .class_init = s390_diag318_class_init,
> >> +    .parent = TYPE_DEVICE,
> >> +    .name = TYPE_S390_DIAG318,
> >> +    .instance_size = sizeof(DIAG318State),
> >> +};
> >> +
> >> +static void s390_diag318_register_types(void)
> >> +{
> >> +    type_register_static(&s390_diag318_info);
> >> +}
> >> +
> >> +type_init(s390_diag318_register_types)  
> > 
> > (..)
> >   
> >> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> >> index 87b2039..54230c7 100644
> >> --- a/hw/s390x/s390-virtio-ccw.c
> >> +++ b/hw/s390x/s390-virtio-ccw.c
> >> @@ -38,6 +38,7 @@
> >>   #include "cpu_models.h"
> >>   #include "hw/nmi.h"
> >>   #include "hw/s390x/tod.h"
> >> +#include "hw/s390x/diag318.h"
> >>   
> >>   S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
> >>   {
> >> @@ -94,6 +95,7 @@ static const char *const reset_dev_types[] = {
> >>       "s390-sclp-event-facility",
> >>       "s390-flic",
> >>       "diag288",
> >> +    TYPE_S390_DIAG318,  
> > 
> > This looks a bit odd, although it is not wrong :)
> >   
> 
> It's cut-off here, but TYPE_VIRTUAL_CSS_BRIDGE is also in the list :)

Hah, better :)


