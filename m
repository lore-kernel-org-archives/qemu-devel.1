Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D24C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1ED2086D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1ED2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg79g-0007Ie-KP
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54833)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hg77n-0006FR-7B
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hg77k-0006xQ-F3
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:34:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57726)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hg77k-0006vS-49; Wed, 26 Jun 2019 08:34:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BD27D31628EF;
 Wed, 26 Jun 2019 12:33:41 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55D6D608C1;
 Wed, 26 Jun 2019 12:33:27 +0000 (UTC)
Date: Wed, 26 Jun 2019 14:33:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Message-ID: <20190626143324.6f359cd0.cohuck@redhat.com>
In-Reply-To: <1561475829-19202-3-git-send-email-walling@linux.ibm.com>
References: <1561475829-19202-1-git-send-email-walling@linux.ibm.com>
 <1561475829-19202-3-git-send-email-walling@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 26 Jun 2019 12:33:55 +0000 (UTC)
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

On Tue, 25 Jun 2019 11:17:09 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
> be intercepted by SIE and handled via KVM. Let's introduce some
> functions to communicate between QEMU and KVM via ioctls. These
> will be used to get/set the diag318 information.
> 
> The availability of this instruction is determined by byte 134, bit 0
> of the Read Info block. This coincidentally expands into the space used
> for CPU entries, which means VMs running with the diag318 capability
> will have a reduced maximum CPU count. Let's reduce the maximum CPU
> count from 248 to 247.
> 
> In order to simplify the migration and system reset requirements of
> the diag318 data, let's introduce it as a device class and include
> a VMStateDescription.
> 
> Diag318 is set to 0 during modified clear and load normal resets.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  hw/s390x/Makefile.objs          |  1 +
>  hw/s390x/diag318.c              | 80 +++++++++++++++++++++++++++++++++++++++++
>  hw/s390x/diag318.h              | 38 ++++++++++++++++++++
>  hw/s390x/s390-virtio-ccw.c      | 17 +++++++++
>  hw/s390x/sclp.c                 |  3 ++
>  include/hw/s390x/sclp.h         |  2 ++
>  target/s390x/cpu.h              |  8 ++++-
>  target/s390x/cpu_features.c     |  3 ++
>  target/s390x/cpu_features.h     |  1 +
>  target/s390x/cpu_features_def.h |  3 ++
>  target/s390x/gen-features.c     |  1 +
>  target/s390x/kvm-stub.c         | 10 ++++++
>  target/s390x/kvm.c              | 29 +++++++++++++++
>  target/s390x/kvm_s390x.h        |  2 ++
>  14 files changed, 197 insertions(+), 1 deletion(-)
>  create mode 100644 hw/s390x/diag318.c
>  create mode 100644 hw/s390x/diag318.h

(...)

> diff --git a/hw/s390x/diag318.c b/hw/s390x/diag318.c
> new file mode 100644
> index 0000000..0eb80fe
> --- /dev/null
> +++ b/hw/s390x/diag318.c
> @@ -0,0 +1,80 @@
> +/*
> + * DIAGNOSE 0x318 functions for reset and migration
> + *
> + * Copyright IBM, Corp. 2019
> + *
> + * Authors:
> + *  Collin Walling <walling@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at your
> + * option) any later version. See the COPYING file in the top-level directory.
> + */
> +
> +#include "hw/s390x/diag318.h"
> +#include "qapi/error.h"
> +#include "kvm_s390x.h"
> +#include "sysemu/kvm.h"
> +
> +static int diag318_post_load(void *opaque, int version_id)
> +{
> +    DIAG318State *d = opaque;
> +
> +    kvm_s390_set_diag318_info(d->info);

Shouldn't we at least moan if something goes wrong here?

> +    return 0;
> +}
> +
> +static int diag318_pre_save(void *opaque)
> +{
> +    DIAG318State *d = opaque;
> +
> +    kvm_s390_get_diag318_info(&d->info);
> +    return 0;
> +}
> +
> +static bool diag318_needed(void *opaque)
> +{
> +    return s390_has_feat(S390_FEAT_DIAG318);

What happens if we emulate diag 318 in tcg and set this feature bit? We
probably don't want to call kvm_ functions in that case.

> +}
> +
> +const VMStateDescription vmstate_diag318 = {
> +    .name = "vmstate_diag318",
> +    .post_load = diag318_post_load,
> +    .pre_save = diag318_pre_save,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = diag318_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64(info, DIAG318State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void s390_diag318_reset(DeviceState *dev)
> +{
> +    kvm_s390_set_diag318_info(0);

Same here; we probably need a s390_set_diag318_info() function that
either calls the kvm_ function or resets some internal state.

> +}
> +
> +static void s390_diag318_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = s390_diag318_reset;
> +    dc->vmsd = &vmstate_diag318;
> +    dc->hotpluggable = false;
> +    /* Reason: Set automatically during IPL */

"Created automatically during machine instantiation" ?

> +    dc->user_creatable = false;
> +}
> +
> +static const TypeInfo s390_diag318_info = {
> +    .class_init = s390_diag318_class_init,
> +    .parent = TYPE_DEVICE,
> +    .name = TYPE_S390_DIAG318,
> +    .instance_size = sizeof(DIAG318State),
> +};
> +
> +static void s390_diag318_register_types(void)
> +{
> +    type_register_static(&s390_diag318_info);
> +}
> +
> +type_init(s390_diag318_register_types)

(..)

> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 87b2039..54230c7 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -38,6 +38,7 @@
>  #include "cpu_models.h"
>  #include "hw/nmi.h"
>  #include "hw/s390x/tod.h"
> +#include "hw/s390x/diag318.h"
>  
>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>  {
> @@ -94,6 +95,7 @@ static const char *const reset_dev_types[] = {
>      "s390-sclp-event-facility",
>      "s390-flic",
>      "diag288",
> +    TYPE_S390_DIAG318,

This looks a bit odd, although it is not wrong :)

>  };
>  
>  static void subsystem_reset(void)
> @@ -258,6 +260,17 @@ static void s390_create_sclpconsole(const char *type, Chardev *chardev)
>      qdev_init_nofail(dev);
>  }
>  
> +static void s390_init_diag318(void)
> +{
> +    Object *new = object_new(TYPE_S390_DIAG318);
> +    DeviceState *dev = DEVICE(new);
> +
> +    object_property_add_child(qdev_get_machine(), TYPE_S390_DIAG318,
> +                              new, NULL);
> +    object_unref(new);
> +    qdev_init_nofail(dev);
> +}
> +
>  static void ccw_init(MachineState *machine)
>  {
>      int ret;
> @@ -315,6 +328,9 @@ static void ccw_init(MachineState *machine)
>  
>      /* init the TOD clock */
>      s390_init_tod();
> +
> +    /* init object used for migrating diag318 info */
> +    s390_init_diag318();
>  }
>  
>  static void s390_cpu_plug(HotplugHandler *hotplug_dev,
> @@ -583,6 +599,7 @@ static void machine_set_loadparm(Object *obj, const char *val, Error **errp)
>          ms->loadparm[i] = ' '; /* pad right with spaces */
>      }
>  }
> +

unrelated whitespace change :)

>  static inline void s390_machine_initfn(Object *obj)
>  {
>      object_property_add_bool(obj, "aes-key-wrap",

(...)

> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index f64f581..77a1df5 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -127,6 +127,9 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("pfmfi", S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT, 9, "SIE: PFMF interpretation facility"),
>      FEAT_INIT("ibs", S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-suppression facility"),
>  
> +    /* SCLP SCCB Byte 134 */
> +    FEAT_INIT("diag318", S390_FEAT_TYPE_SCLP_BYTE_134, 0, "Control program name and version codes"),
> +
>      FEAT_INIT("sief2", S390_FEAT_TYPE_SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)"),
>      FEAT_INIT("skey", S390_FEAT_TYPE_SCLP_CPU, 5, "SIE: Storage-key facility"),
>      FEAT_INIT("gpereh", S390_FEAT_TYPE_SCLP_CPU, 10, "SIE: Guest-PER enhancement facility"),
> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
> index da695a8..954544e 100644
> --- a/target/s390x/cpu_features.h
> +++ b/target/s390x/cpu_features.h
> @@ -23,6 +23,7 @@ typedef enum {
>      S390_FEAT_TYPE_STFL,
>      S390_FEAT_TYPE_SCLP_CONF_CHAR,
>      S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
> +    S390_FEAT_TYPE_SCLP_BYTE_134,
>      S390_FEAT_TYPE_SCLP_CPU,
>      S390_FEAT_TYPE_MISC,
>      S390_FEAT_TYPE_PLO,
> diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
> index 292b17b..4f2c23e 100644
> --- a/target/s390x/cpu_features_def.h
> +++ b/target/s390x/cpu_features_def.h
> @@ -115,6 +115,9 @@ typedef enum {
>      S390_FEAT_SIE_PFMFI,
>      S390_FEAT_SIE_IBS,
>  
> +    /* Sclp Byte 134 */
> +    S390_FEAT_DIAG318,
> +
>      /* Sclp Cpu */
>      S390_FEAT_SIE_F2,
>      S390_FEAT_SIE_SKEY,
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index dc320a0..cdd1875 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -521,6 +521,7 @@ static uint16_t full_GEN12_GA1[] = {
>      S390_FEAT_AP_QUERY_CONFIG_INFO,
>      S390_FEAT_AP_FACILITIES_TEST,
>      S390_FEAT_AP,
> +    S390_FEAT_DIAG318,
>  };
>  
>  static uint16_t full_GEN12_GA2[] = {

The feature bit stuff probably needs some (easy) adaption on top of my
s390-next branch.

