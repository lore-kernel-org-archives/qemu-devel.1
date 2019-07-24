Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7213C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF2821850
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF2821850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52299 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqIVf-0008IT-RN
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 10:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34964)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1hqIVT-0007n5-TQ
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1hqIVS-0005eL-Mz
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:44:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47344)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1hqIVQ-0005cT-3l; Wed, 24 Jul 2019 10:44:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 510C230A695C;
 Wed, 24 Jul 2019 14:44:35 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81BFF61F21;
 Wed, 24 Jul 2019 14:44:30 +0000 (UTC)
Date: Wed, 24 Jul 2019 16:44:28 +0200
From: Andrew Jones <drjones@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190724144428.plozynk3t5mdahvx@kamzik.brq.redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-4-drjones@redhat.com>
 <fec0d7af-a25f-2395-64df-79f2de9579d9@redhat.com>
 <20190626132627.oh2d3qteemgqb6u2@kamzik.brq.redhat.com>
 <848513be-d5c1-7eda-cfc8-bd9836c2ed1d@redhat.com>
 <20190724140502.3ipk2ekr4nyyop2z@kamzik.brq.redhat.com>
 <af580f76-7542-d5a4-7c8f-f75d441ee8e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af580f76-7542-d5a4-7c8f-f75d441ee8e3@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 24 Jul 2019 14:44:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 03/14] target/arm/monitor: Introduce
 qmp_query_cpu_model_expansion
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, armbru@redhat.com, qemu-arm@nongnu.org,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 24, 2019 at 04:25:32PM +0200, Auger Eric wrote:
> >>>>> diff --git a/target/arm/monitor.c b/target/arm/monitor.c
> >>>>> index 41b32b94b258..19e3120eef95 100644
> >>>>> --- a/target/arm/monitor.c
> >>>>> +++ b/target/arm/monitor.c
> >>>>> @@ -23,7 +23,13 @@
> >>>>>  #include "qemu/osdep.h"
> >>>>>  #include "hw/boards.h"
> >>>>>  #include "kvm_arm.h"
> >>>>> +#include "qapi/error.h"
> >>>>> +#include "qapi/visitor.h"
> >>>>> +#include "qapi/qobject-input-visitor.h"
> >>>>>  #include "qapi/qapi-commands-target.h"
> >>>>> +#include "qapi/qmp/qerror.h"
> >>>>> +#include "qapi/qmp/qdict.h"
> >>>>> +#include "qom/qom-qobject.h"
> >>>>>  
> >>>>>  static GICCapability *gic_cap_new(int version)
> >>>>>  {
> >>>>> @@ -82,3 +88,129 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
> >>>>>  
> >>>>>      return head;
> >>>>>  }
> >>>>> +
> >>>>> +static const char *cpu_model_advertised_features[] = {
> >>>>> +    "aarch64", "pmu",
> >>>>> +    NULL
> >>>>> +};
> >>>>> +
> >>>>> +CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
> >>>>> +                                                     CpuModelInfo *model,
> >>>>> +                                                     Error **errp)
> >>>>> +{
> >>>>> +    CpuModelExpansionInfo *expansion_info;
> >>>>> +    const QDict *qdict_in = NULL;
> >>>>> +    QDict *qdict_out;
> >>>>> +    ObjectClass *oc;
> >>>>> +    Object *obj;
> >>>>> +    const char *name;
> >>>>> +    int i;
> >>>>> +
> >>>>> +    if (type != CPU_MODEL_EXPANSION_TYPE_FULL) {
> >>>>> +        error_setg(errp, "The requested expansion type is not supported.");
> >>>>> +        return NULL;
> >>>>> +    }
> >>>>> +
> >>>>> +    if (!kvm_enabled() && !strcmp(model->name, "host")) {
> >>>>> +        error_setg(errp, "The CPU definition '%s' requires KVM", model->name);
> >>>>> +        return NULL;
> >>>>> +    }
> >>>>> +
> >>>>> +    oc = cpu_class_by_name(TYPE_ARM_CPU, model->name);
> >>>>> +    if (!oc) {
> >>>>> +        error_setg(errp, "The CPU definition '%s' is unknown.", model->name);
> >>>>> +        return NULL;
> >>>>> +    }
> >>>>> +
> >>>>> +    if (kvm_enabled()) {
> >>>>> +        const char *cpu_type = current_machine->cpu_type;
> >>>>> +        int len = strlen(cpu_type) - strlen(ARM_CPU_TYPE_SUFFIX);
> >>>>> +        bool supported = false;
> >>>>> +
> >>>>> +        if (!strcmp(model->name, "host") || !strcmp(model->name, "max")) {
> >>>>> +            /* These are kvmarm's recommended cpu types */
> >>>>> +            supported = true;
> >>>>> +        } else if (strlen(model->name) == len &&
> >>>>> +                   !strncmp(model->name, cpu_type, len)) {
> >>>>> +            /* KVM is enabled and we're using this type, so it works. */
> >>>>> +            supported = true;
> >>>>> +        }
> >>>>> +        if (!supported) {
> >>>>> +            error_setg(errp, "The CPU definition '%s' cannot "
> >>>> use model name instead of CPU definition?
> >>>
> >>> I took that wording from s390x, but maybe I prefer "The CPU type..."
> >>> better. I'll change it for v3.>> This CPU type is not recognized as an ARM CPU type?
> > 
> > That's not what this error message is stating. The CPU type may well be an
> > ARM CPU type, but it's not one you can expect to use with KVM enabled. I
> > currently have
> > 
> >   "The CPU type '%s' cannot "
> >   "be used with KVM on this host", model->name)
> > 
> > queued up for v3.
> 
> decidedly, I meant the error message associated to:
> 
> +    oc = cpu_class_by_name(TYPE_ARM_CPU, model->name);
> +    if (!oc) {
> +        error_setg(errp, "The CPU definition '%s' is unknown.",
> model->name);
> +        return NULL;
> +    }

Ah, OK. Yeah I can change that one too. Of course if we deviate from
s390x's generic error messages for common errors, then we're assuming
the messages aren't being parsed by upper layers using code that we'd
like to easily adopt to ARM. But, I think that assumption is reasonable.

> 
> Why am I always looking at your series when we suffer heat wave?
>

Climate change generates too many heat waves. Or I generate too much
code that requires comments. Or both.

Thanks,
drew

