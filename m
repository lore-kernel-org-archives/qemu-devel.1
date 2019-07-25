Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C93C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A5F21901
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A5F21901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqYkR-0007tS-J0
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 04:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38255)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hqYkE-00077V-9w
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hqYkC-0003QV-LB
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:04:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hqYk8-0003OM-1N; Thu, 25 Jul 2019 04:04:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EE444A836;
 Thu, 25 Jul 2019 08:04:49 +0000 (UTC)
Received: from [10.36.116.102] (ovpn-116-102.ams2.redhat.com [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A60A1001DE0;
 Thu, 25 Jul 2019 08:04:47 +0000 (UTC)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-4-drjones@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d3f489ac-8e2c-cba7-7c0d-c71e23882b4a@redhat.com>
Date: Thu, 25 Jul 2019 10:04:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190621163422.6127-4-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 25 Jul 2019 08:04:50 +0000 (UTC)
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Drew,

On 6/21/19 6:34 PM, Andrew Jones wrote:
> Add support for the query-cpu-model-expansion QMP command to Arm. We
> do this selectively, only exposing CPU properties which represent
> optional CPU features which the user may want to enable/disable. Also,
> for simplicity, we restrict the list of queryable cpu models to 'max',
> 'host', or the current type when KVM is in use, even though there
> may exist KVM hosts where other types would also work. For example on a
> seattle you could use 'host' for the current type, but then attempt to
> query 'cortex-a57', which is also a valid CPU type to use with KVM on
> seattle hosts, but that query will fail with our simplifications. This
> shouldn't be an issue though as management layers and users have been
> preferring the 'host' CPU type for use with KVM for quite some time.
> Additionally, if the KVM-enabled QEMU instance running on a seattle
> host is using the cortex-a57 CPU type, then querying 'cortex-a57' will
> work. Finally, we only implement expansion type 'full', as Arm does not
> yet have a "base" CPU type. Below are some example calls and results
> (to save character clutter they're not in json, but are still json-ish
> to give the idea)
> 
>  # expand the 'max' CPU model
>  query-cpu-model-expansion: type:full, model:{ name:max }
> 
>  return: model:{ name:max, props:{ 'aarch64': true, 'pmu': true }}
> 
>  # attempt to expand the 'max' CPU model with pmu=off
>  query-cpu-model-expansion:
>    type:full, model:{ name:max, props:{ 'pmu': false }}
> 
>  return: model:{ name:max, props:{ 'aarch64': true, 'pmu': false }}
> 
>  # attempt to expand the 'max' CPU model with aarch64=off
>  query-cpu-model-expansion:
>    type:full, model:{ name:max, props:{ 'aarch64': false }}
> 
>  error: "'aarch64' feature cannot be disabled unless KVM is enabled
>          and 32-bit EL1 is supported"

I struggled quite a lot to get the right syntax to test with qmp-shell
(which I think is the most user friendly way to run those commands). In
the commit message, you may add an example such as:

(QEMU) query-cpu-model-expansion type=full
model={"name":"host","props":{"aarch64":true,"pmu":true}}
{"return": {"model": {"name": "host", "props": {"aarch64": true, "pmu":
true}}}}

(QEMU) query-cpu-model-expansion type=full model={"name":"host"}
{"return": {"model": {"name": "host", "props": {"aarch64": true, "pmu":
true}}}}

Thanks

Eric


> 
> In the last example KVM was not in use so an error was returned.
> 
> Note1: It's possible for features to have dependencies on other
> features. I.e. it may be possible to change one feature at a time
> without error, but when attempting to change all features at once
> an error could occur depending on the order they are processed. It's
> also possible changing all at once doesn't generate an error, because
> a feature's dependencies are satisfied with other features, but the
> same feature cannot be changed independently without error. For these
> reasons callers should always attempt to make their desired changes
> all at once in order to ensure the collection is valid.
> 
> Note2: Certainly more features may be added to the list of
> advertised features, e.g. 'vfp' and 'neon'. The only requirement
> is that their property set accessors fail when invalid
> configurations are detected. For vfp we would need something like
> 
>  set_vfp()
>  {
>    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
>        cpu->has_vfp != cpu->has_neon)
>        error("AArch64 CPUs must have both VFP and Neon or neither")
> 
> in its set accessor, and the same for neon, rather than doing that
> check at realize time, which isn't executed at qmp query time.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  qapi/target.json     |   6 +-
>  target/arm/monitor.c | 132 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 135 insertions(+), 3 deletions(-)
> 
> diff --git a/qapi/target.json b/qapi/target.json
> index 1d4d54b6002e..edfa2f82b916 100644
> --- a/qapi/target.json
> +++ b/qapi/target.json
> @@ -408,7 +408,7 @@
>  ##
>  { 'struct': 'CpuModelExpansionInfo',
>    'data': { 'model': 'CpuModelInfo' },
> -  'if': 'defined(TARGET_S390X) || defined(TARGET_I386)' }
> +  'if': 'defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM)' }
>  
>  ##
>  # @query-cpu-model-expansion:
> @@ -433,7 +433,7 @@
>  #   query-cpu-model-expansion while using these is not advised.
>  #
>  # Some architectures may not support all expansion types. s390x supports
> -# "full" and "static".
> +# "full" and "static". Arm only supports "full".
>  #
>  # Returns: a CpuModelExpansionInfo. Returns an error if expanding CPU models is
>  #          not supported, if the model cannot be expanded, if the model contains
> @@ -447,7 +447,7 @@
>    'data': { 'type': 'CpuModelExpansionType',
>              'model': 'CpuModelInfo' },
>    'returns': 'CpuModelExpansionInfo',
> -  'if': 'defined(TARGET_S390X) || defined(TARGET_I386)' }
> +  'if': 'defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM)' }
>  
>  ##
>  # @CpuDefinitionInfo:
> diff --git a/target/arm/monitor.c b/target/arm/monitor.c
> index 41b32b94b258..19e3120eef95 100644
> --- a/target/arm/monitor.c
> +++ b/target/arm/monitor.c
> @@ -23,7 +23,13 @@
>  #include "qemu/osdep.h"
>  #include "hw/boards.h"
>  #include "kvm_arm.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
> +#include "qapi/qobject-input-visitor.h"
>  #include "qapi/qapi-commands-target.h"
> +#include "qapi/qmp/qerror.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qom/qom-qobject.h"
>  
>  static GICCapability *gic_cap_new(int version)
>  {
> @@ -82,3 +88,129 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
>  
>      return head;
>  }
> +
> +static const char *cpu_model_advertised_features[] = {
> +    "aarch64", "pmu",
> +    NULL
> +};
> +
> +CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
> +                                                     CpuModelInfo *model,
> +                                                     Error **errp)
> +{
> +    CpuModelExpansionInfo *expansion_info;
> +    const QDict *qdict_in = NULL;
> +    QDict *qdict_out;
> +    ObjectClass *oc;
> +    Object *obj;
> +    const char *name;
> +    int i;
> +
> +    if (type != CPU_MODEL_EXPANSION_TYPE_FULL) {
> +        error_setg(errp, "The requested expansion type is not supported.");
> +        return NULL;
> +    }
> +
> +    if (!kvm_enabled() && !strcmp(model->name, "host")) {
> +        error_setg(errp, "The CPU definition '%s' requires KVM", model->name);
> +        return NULL;
> +    }
> +
> +    oc = cpu_class_by_name(TYPE_ARM_CPU, model->name);
> +    if (!oc) {
> +        error_setg(errp, "The CPU definition '%s' is unknown.", model->name);
> +        return NULL;
> +    }
> +
> +    if (kvm_enabled()) {
> +        const char *cpu_type = current_machine->cpu_type;
> +        int len = strlen(cpu_type) - strlen(ARM_CPU_TYPE_SUFFIX);
> +        bool supported = false;
> +
> +        if (!strcmp(model->name, "host") || !strcmp(model->name, "max")) {
> +            /* These are kvmarm's recommended cpu types */
> +            supported = true;
> +        } else if (strlen(model->name) == len &&
> +                   !strncmp(model->name, cpu_type, len)) {
> +            /* KVM is enabled and we're using this type, so it works. */
> +            supported = true;
> +        }
> +        if (!supported) {
> +            error_setg(errp, "The CPU definition '%s' cannot "
> +                             "be used with KVM on this host", model->name);
> +            return NULL;
> +        }
> +    }
> +
> +    if (model->props) {
> +        qdict_in = qobject_to(QDict, model->props);
> +        if (!qdict_in) {
> +            error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "props", "dict");
> +            return NULL;
> +        }
> +    }
> +
> +    obj = object_new(object_class_get_name(oc));
> +
> +    if (qdict_in) {
> +        Visitor *visitor;
> +
> +        visitor = qobject_input_visitor_new(model->props);
> +        visit_start_struct(visitor, NULL, NULL, 0, errp);
> +        if (*errp) {
> +            object_unref(obj);
> +            return NULL;
> +        }
> +
> +        i = 0;
> +        while ((name = cpu_model_advertised_features[i++]) != NULL) {
> +            if (qdict_get(qdict_in, name)) {
> +                object_property_set(obj, visitor, name, errp);
> +                if (*errp) {
> +                    break;
> +                }
> +            }
> +        }
> +
> +        if (!*errp) {
> +            visit_check_struct(visitor, errp);
> +        }
> +        visit_end_struct(visitor, NULL);
> +        visit_free(visitor);
> +        if (*errp) {
> +            object_unref(obj);
> +            return NULL;
> +        }
> +    }
> +
> +    expansion_info = g_new0(CpuModelExpansionInfo, 1);
> +    expansion_info->model = g_malloc0(sizeof(*expansion_info->model));
> +    expansion_info->model->name = g_strdup(model->name);
> +
> +    qdict_out = qdict_new();
> +
> +    i = 0;
> +    while ((name = cpu_model_advertised_features[i++]) != NULL) {
> +        ObjectProperty *prop = object_property_find(obj, name, NULL);
> +        if (prop) {
> +            QObject *value;
> +
> +            assert(prop->get);
> +            value = object_property_get_qobject(obj, name, errp);
> +            assert(!*errp);
> +
> +            qdict_put_obj(qdict_out, name, value);
> +        }
> +    }
> +
> +    if (!qdict_size(qdict_out)) {
> +        qobject_unref(qdict_out);
> +    } else {
> +        expansion_info->model->props = QOBJECT(qdict_out);
> +        expansion_info->model->has_props = true;
> +    }
> +
> +    object_unref(obj);
> +
> +    return expansion_info;
> +}
> 

