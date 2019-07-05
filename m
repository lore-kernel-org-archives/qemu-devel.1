Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BDFC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:46:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64AF3216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AF3216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjV6c-0000mS-Lj
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 16:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37374)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hjUxe-0002Qd-1h
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hjUxa-0005bM-As
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:37:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33448)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hjUxY-0005Vp-V3
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:37:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 25056307D846;
 Fri,  5 Jul 2019 20:37:30 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A08E5772D7;
 Fri,  5 Jul 2019 20:37:29 +0000 (UTC)
Date: Fri, 5 Jul 2019 17:37:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190705203728.GE5198@habkost.net>
References: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
 <1562079681-19204-2-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562079681-19204-2-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 05 Jul 2019 20:37:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/7] target/i386: handle filtered_features
 in a new function mark_unavailable_features
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
Cc: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 02, 2019 at 05:01:15PM +0200, Paolo Bonzini wrote:
> The next patch will add a different reason for filtering features, unrelated
> to host feature support.  Extract a new function that takes care of disabling
> the features and reporting them.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.c | 76 ++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 41 insertions(+), 35 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index da6eb67..9149d0d 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3236,17 +3236,39 @@ static char *feature_word_description(FeatureWordInfo *f, uint32_t bit)
>      return NULL;
>  }
>  
> -static void report_unavailable_features(FeatureWord w, uint32_t mask)
> +static bool x86_cpu_have_filtered_features(X86CPU *cpu)
>  {
> +    FeatureWord w;
> +
> +    for (w = 0; w < ARRAY_SIZE(feature_word_info); w++) {

I prefer to use FEATURE_WORDS instead of
ARRAY_SIZE(feature_word_info), for consistency.

I'm becoming more and more inclined to transform FeatureWordArray
into a bitmap.  We have too many "for (w; w < FEATURE_WORDS;
w++)" loops in the code that could be simplified using bitmap
operations.

But this is independent from this patch.


> +         if (cpu->filtered_features[w]) {
> +             return true;
> +         }
> +    }
> +
> +    return false;
> +}
> +
> +static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint32_t mask,
> +                                      const char *prefix)
> +{
> +    CPUX86State *env = &cpu->env;
>      FeatureWordInfo *f = &feature_word_info[w];
>      int i;
>      char *feat_word_str;
>  
> +    env->features[w] &= ~mask;
> +    cpu->filtered_features[w] |= mask;
> +
> +    if (!cpu->check_cpuid && !cpu->enforce_cpuid) {
> +        return;
> +    }
> +
>      for (i = 0; i < 32; ++i) {
>          if ((1UL << i) & mask) {
>              feat_word_str = feature_word_description(f, i);
> -            warn_report("%s doesn't support requested feature: %s%s%s [bit %d]",
> -                        accel_uses_host_cpuid() ? "host" : "TCG",
> +            warn_report("%s: %s%s%s [bit %d]",
> +                        prefix,
>                          feat_word_str,
>                          f->feat_names[i] ? "." : "",
>                          f->feat_names[i] ? f->feat_names[i] : "", i);

This seems to undo commit 8ca30e8673af ("target-i386: Move
warning code outside x86_cpu_filter_features()").

Filtering and reporting is separate because
x86_cpu_filter_features() is also called from a QMP command
handler that is not supposed to generate any warnings on stderr
(query-cpu-model-expansion).


> @@ -3691,7 +3713,7 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
>  }
>  
>  static void x86_cpu_expand_features(X86CPU *cpu, Error **errp);
> -static int x86_cpu_filter_features(X86CPU *cpu);
> +static void x86_cpu_filter_features(X86CPU *cpu);
>  
>  /* Build a list with the name of all features on a feature word array */
>  static void x86_cpu_list_feature_names(FeatureWordArray features,
> @@ -3923,15 +3945,6 @@ static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
>      return r;
>  }
>  
> -static void x86_cpu_report_filtered_features(X86CPU *cpu)
> -{
> -    FeatureWord w;
> -
> -    for (w = 0; w < FEATURE_WORDS; w++) {
> -        report_unavailable_features(w, cpu->filtered_features[w]);
> -    }
> -}
> -
>  static void x86_cpu_apply_props(X86CPU *cpu, PropValue *props)
>  {
>      PropValue *pv;
> @@ -5170,21 +5183,20 @@ out:
>   *
>   * Returns: 0 if all flags are supported by the host, non-zero otherwise.
>   */
> -static int x86_cpu_filter_features(X86CPU *cpu)
> +static void x86_cpu_filter_features(X86CPU *cpu)
>  {
>      CPUX86State *env = &cpu->env;
>      FeatureWord w;
> -    int rv = 0;
> +    const char *prefix = accel_uses_host_cpuid()
> +                         ? "host doesn't support requested feature"
> +                         : "TCG doesn't support requested feature";
>  
>      for (w = 0; w < FEATURE_WORDS; w++) {
>          uint32_t host_feat =
>              x86_cpu_get_supported_feature_word(w, false);
>          uint32_t requested_features = env->features[w];
> -        env->features[w] &= host_feat;
> -        cpu->filtered_features[w] = requested_features & ~env->features[w];
> -        if (cpu->filtered_features[w]) {
> -            rv = 1;
> -        }
> +        uint32_t unavailable_features = requested_features & ~host_feat;
> +        mark_unavailable_features(cpu, w, unavailable_features, prefix);
>      }
>  
>      if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
> @@ -5210,13 +5222,9 @@ static int x86_cpu_filter_features(X86CPU *cpu)
>               * host can't emulate the capabilities we report on
>               * cpu_x86_cpuid(), intel-pt can't be enabled on the current host.
>               */
> -            env->features[FEAT_7_0_EBX] &= ~CPUID_7_0_EBX_INTEL_PT;
> -            cpu->filtered_features[FEAT_7_0_EBX] |= CPUID_7_0_EBX_INTEL_PT;
> -            rv = 1;
> +            mark_unavailable_features(cpu, FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT, prefix);
>          }
>      }
> -
> -    return rv;
>  }
>  
>  static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
> @@ -5257,16 +5265,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>          goto out;
>      }
>  
> -    if (x86_cpu_filter_features(cpu) &&
> -        (cpu->check_cpuid || cpu->enforce_cpuid)) {
> -        x86_cpu_report_filtered_features(cpu);
> -        if (cpu->enforce_cpuid) {
> -            error_setg(&local_err,
> -                       accel_uses_host_cpuid() ?
> -                           "Host doesn't support requested features" :
> -                           "TCG doesn't support requested features");
> -            goto out;
> -        }
> +    x86_cpu_filter_features(cpu);
> +
> +    if (cpu->enforce_cpuid && x86_cpu_have_filtered_features(cpu)) {
> +        error_setg(&local_err,
> +                   accel_uses_host_cpuid() ?
> +                       "Host doesn't support requested features" :
> +                       "TCG doesn't support requested features");
> +        goto out;
>      }
>  
>      /* On AMD CPUs, some CPUID[8000_0001].EDX bits must match the bits on
> -- 
> 1.8.3.1
> 
> 
> 

-- 
Eduardo

