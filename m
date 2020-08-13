Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24AFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 12:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B395F20791
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 12:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7DDK4vC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B395F20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Cmv-0004hZ-Vo
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 08:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k6CmK-00049j-RJ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 08:56:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27958
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k6CmI-00072R-Hl
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 08:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597323376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t/TnqbXhNdsOww0JThDbjZ9iE+V0EXwwbrcxTGAe91c=;
 b=I7DDK4vCK3M+WoccW5Hdeqxh+7z3Jd0H/G675TWRHQGn8zx/qvRCM6GB9QAEPTN8WdfwF+
 izpKcpNR0vdw79n9WkB8Akx/HH9DbX2ntBRBYgxXvWrYhF1HdmdVdDNXQbbjVYeTb/lDae
 eYnl7lbeuC99jFc+6L6ULTToLVZxHlQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-N6k44IzyMwm3NyjZHZinWQ-1; Thu, 13 Aug 2020 08:56:15 -0400
X-MC-Unique: N6k44IzyMwm3NyjZHZinWQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BA7C425CB;
 Thu, 13 Aug 2020 12:56:14 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95E3160C11;
 Thu, 13 Aug 2020 12:56:05 +0000 (UTC)
Date: Thu, 13 Aug 2020 14:56:02 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peng Liang <liangpeng10@huawei.com>
Subject: Re: [RFC 7/9] target/arm: Add CPU features to
 query-cpu-model-expansion
Message-ID: <20200813125602.drapo7wyzg57k3jy@kamzik.brq.redhat.com>
References: <20200813102657.2588720-1-liangpeng10@huawei.com>
 <20200813102657.2588720-8-liangpeng10@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200813102657.2588720-8-liangpeng10@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 08:00:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com, mst@redhat.com,
 cohuck@redhat.com, qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 13, 2020 at 06:26:55PM +0800, Peng Liang wrote:
> Add CPU features to the result of query-cpu-model-expansion so that
> other applications (such as libvirt) can know the supported CPU
> features.
> 
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Peng Liang <liangpeng10@huawei.com>
> ---
>  target/arm/cpu.c     | 41 +++++++++++++++++++++++++++++++++++++++++
>  target/arm/cpu.h     |  2 ++
>  target/arm/monitor.c |  2 ++
>  3 files changed, 45 insertions(+)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 3fc54cb3a4..0f620e8afe 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -25,6 +25,8 @@
>  #include "qemu/module.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qom/qom-qobject.h"
>  #include "cpu.h"
>  #include "internals.h"
>  #include "exec/exec-all.h"
> @@ -1515,6 +1517,45 @@ static const CPUFeatureDep feature_dependencies[] = {
>      },
>  };
>  
> +static char *strtolower(char *src)
> +{
> +    char *start = src;
> +
> +    for (; *src; ++src) {
> +        *src = tolower(*src);
> +    }
> +
> +    return start;
> +}

Shouldn't need this. The CPU property names should already be lowercase.

> +
> +void arm_cpu_features_to_dict(ARMCPU *cpu, QDict *features)
> +{
> +    Object *obj = OBJECT(cpu);
> +    const char *name;
> +    ObjectProperty *prop;
> +    bool is_32bit = !arm_feature(&cpu->env, ARM_FEATURE_AARCH64);
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(cpu_features); ++i) {
> +        if (is_32bit != cpu_features[i].is_32bit) {
> +            continue;
> +        }
> +
> +        name = cpu_features[i].name;
> +        prop = object_property_find(obj, name, NULL);
> +        if (prop) {
> +            QObject *value;
> +            g_autofree char *tmp;
> +
> +            assert(prop->get);
> +            value = object_property_get_qobject(obj, name, &error_abort);
> +            tmp = strtolower(g_strdup(name));
> +
> +            qdict_put_obj(features, tmp, value);
> +        }
> +    }
> +}
> +
>  static void arm_cpu_get_bit_prop(Object *obj, Visitor *v, const char *name,
>                                   void *opaque, Error **errp)
>  {
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 5d8074d03b..da68b7f8f4 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3933,4 +3933,6 @@ static inline bool isar_feature_any_tts2uxn(const ARMISARegisters *id)
>  #define cpu_isar_feature(name, cpu) \
>      ({ ARMCPU *cpu_ = (cpu); isar_feature_##name(&cpu_->isar); })
>  
> +void arm_cpu_features_to_dict(ARMCPU *cpu, QDict *features);
> +
>  #endif
> diff --git a/target/arm/monitor.c b/target/arm/monitor.c
> index ba6e01abd0..f8eb29efec 100644
> --- a/target/arm/monitor.c
> +++ b/target/arm/monitor.c
> @@ -225,6 +225,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>          }
>      }
>  
> +    arm_cpu_features_to_dict(ARM_CPU(obj), qdict_out);

Since nobody is looking for these features in qdict_in, then none
of these features can be changed by QMP user. How does the QMP
user probe whether or not the feature will work when enabled?

Thanks,
drew

> +
>      if (!qdict_size(qdict_out)) {
>          qobject_unref(qdict_out);
>      } else {
> -- 
> 2.18.4
> 


