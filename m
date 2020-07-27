Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7F7C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:51:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249BF20672
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEEJBclF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249BF20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k05Pt-0004KL-Ts
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 11:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k05P9-0003kh-C9
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:51:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24156
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k05P7-0006W1-NL
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595865064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ARmbm4s+y+16lt5FdeIbOxsqNwbpuRKXPWXf6hvfytg=;
 b=UEEJBclFq+jewjcRrrju6J0vmG38xwgE0OixJuPnWChOD7frffPgIU6gd0sVJVAyxgBVNs
 Jgsf1GsgOBhqPClhOxmfFPakqV3QnKl1w7TyYS9GghP49les5ZK4Ghw+BoRcHuWSvbVx3S
 Bsw7zb9NJRg1MfHvLimdG+5h35jGoxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-Xhdf0Z5mPw-lOThKx1tpbw-1; Mon, 27 Jul 2020 11:50:59 -0400
X-MC-Unique: Xhdf0Z5mPw-lOThKx1tpbw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D60FE18FF67B;
 Mon, 27 Jul 2020 15:50:56 +0000 (UTC)
Received: from gondolin (ovpn-112-210.ams2.redhat.com [10.36.112.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C77685D9F3;
 Mon, 27 Jul 2020 15:50:44 +0000 (UTC)
Date: Mon, 27 Jul 2020 17:50:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [for-5.2 v4 10/10] s390: Recognize host-trust-limitation option
Message-ID: <20200727175040.7beca3dd.cohuck@redhat.com>
In-Reply-To: <20200724025744.69644-11-david@gibson.dropbear.id.au>
References: <20200724025744.69644-1-david@gibson.dropbear.id.au>
 <20200724025744.69644-11-david@gibson.dropbear.id.au>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 dgilbert@redhat.com, pasic@linux.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, pbonzini@redhat.com,
 Richard Henderson <rth@twiddle.net>, mdroth@linux.vnet.ibm.com,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jul 2020 12:57:44 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> At least some s390 cpu models support "Protected Virtualization" (PV),
> a mechanism to protect guests from eavesdropping by a compromised
> hypervisor.
> 
> This is similar in function to other mechanisms like AMD's SEV and
> POWER's PEF, which are controlled bythe "host-trust-limitation"
> machine option.  s390 is a slightly special case, because we already
> supported PV, simply by using a CPU model with the required feature
> (S390_FEAT_UNPACK).
> 
> To integrate this with the option used by other platforms, we
> implement the following compromise:
> 
>  - When the host-trust-limitation option is set, s390 will recognize
>    it, verify that the CPU can support PV (failing if not) and set
>    virtio default options necessary for encrypted or protected guests,
>    as on other platforms.  i.e. if host-trust-limitation is set, we
>    will either create a guest capable of entering PV mode, or fail
>    outright
> 
>  - If host-trust-limitation is not set, guest's might still be able to
>    enter PV mode, if the CPU has the right model.  This may be a
>    little surprising, but shouldn't actually be harmful.

This could be workable, I guess. Would like a second opinion, though.

> 
> To start a guest supporting Protected Virtualization using the new
> option use the command line arguments:
>     -object s390-pv-guest,id=pv0 -machine host-trust-limitation=pv0
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/s390x/pv.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
> index ab3a2482aa..4bf3b345b6 100644
> --- a/hw/s390x/pv.c
> +++ b/hw/s390x/pv.c
> @@ -14,8 +14,11 @@
>  #include <linux/kvm.h>
>  
>  #include "cpu.h"
> +#include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/kvm.h"
> +#include "qom/object_interfaces.h"
> +#include "exec/host-trust-limitation.h"
>  #include "hw/s390x/ipl.h"
>  #include "hw/s390x/pv.h"
>  
> @@ -111,3 +114,61 @@ void s390_pv_inject_reset_error(CPUState *cs)
>      /* Report that we are unable to enter protected mode */
>      env->regs[r1 + 1] = DIAG_308_RC_INVAL_FOR_PV;
>  }
> +
> +#define TYPE_S390_PV_GUEST "s390-pv-guest"
> +#define S390_PV_GUEST(obj)                              \
> +    OBJECT_CHECK(S390PVGuestState, (obj), TYPE_S390_PV_GUEST)
> +
> +typedef struct S390PVGuestState S390PVGuestState;
> +
> +/**
> + * S390PVGuestState:
> + *
> + * The S390PVGuestState object is basically a dummy used to tell the
> + * host trust limitation system to use s390's PV mechanism.  guest.
> + *
> + * # $QEMU \
> + *         -object s390-pv-guest,id=pv0 \
> + *         -machine ...,host-trust-limitation=pv0
> + */
> +struct S390PVGuestState {
> +    Object parent_obj;
> +};
> +
> +static int s390_pv_kvm_init(HostTrustLimitation *gmpo, Error **errp)
> +{
> +    if (!s390_has_feat(S390_FEAT_UNPACK)) {
> +        error_setg(errp,
> +                   "CPU model does not support Protected Virtualization");
> +        return -1;
> +    }
> +
> +    return 0;
> +}

So here's where I'm confused: If I follow the code correctly, the
->kvm_init callback is invoked before kvm_arch_init() is called. The
kvm_arch_init() implementation for s390x checks whether
KVM_CAP_S390_PROTECTED is available, which is a pre-req for
S390_FEAT_UNPACK. Am I missing something? Can someone with access to PV
hardware check whether this works as intended?

> +
> +static void s390_pv_guest_class_init(ObjectClass *oc, void *data)
> +{
> +    HostTrustLimitationClass *gmpc = HOST_TRUST_LIMITATION_CLASS(oc);
> +
> +    gmpc->kvm_init = s390_pv_kvm_init;
> +}
> +
> +static const TypeInfo s390_pv_guest_info = {
> +    .parent = TYPE_OBJECT,
> +    .name = TYPE_S390_PV_GUEST,
> +    .instance_size = sizeof(S390PVGuestState),
> +    .class_init = s390_pv_guest_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_HOST_TRUST_LIMITATION },
> +        { TYPE_USER_CREATABLE },
> +        { }
> +    }
> +};
> +
> +static void
> +s390_pv_register_types(void)
> +{
> +    type_register_static(&s390_pv_guest_info);
> +}
> +
> +type_init(s390_pv_register_types);


