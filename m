Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21980C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 06:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791B1239E5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 06:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyXe4Iu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791B1239E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKc6f-0004jH-8l
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 02:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kKc5b-0003TI-8F
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 02:47:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32878
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kKc5X-0002ze-KJ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 02:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600757262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhOcDQ1lvvR+efObwJGVLqFrzT33JblnsiTZD1T5cSM=;
 b=KyXe4Iu4LAtO0EhP3acJSKUho4YhWg6u8P6+N0pMqPMUdB3HGvCcndzYdgc1/e+MKjjlH5
 jkAaTKSzTO7hlyPhBFmTCdV5gqobitxDDdFq7PkTLSSLCJJ+Te42twVGyhfu9ffpG9ZwnA
 +lClF1UgGObhjQx7Dse7DGROwYhqGmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-oNkRJr0-PUKgBD6XvFnw6w-1; Tue, 22 Sep 2020 02:47:40 -0400
X-MC-Unique: oNkRJr0-PUKgBD6XvFnw6w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0248780572E;
 Tue, 22 Sep 2020 06:47:40 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B6C85DEC1;
 Tue, 22 Sep 2020 06:47:35 +0000 (UTC)
Date: Tue, 22 Sep 2020 08:47:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 14/24] i386: Register feature bit properties as class
 properties
Message-ID: <20200922084734.15f0bda6@redhat.com>
In-Reply-To: <20200921221045.699690-15-ehabkost@redhat.com>
References: <20200921221045.699690-1-ehabkost@redhat.com>
 <20200921221045.699690-15-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:27:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Sep 2020 18:10:35 -0400
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Class properties make QOM introspection simpler and easier, as
> they don't require an object to be instantiated.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/i386/cpu.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 66792f28ba7..1aba87e0a5b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6819,16 +6819,17 @@ static void x86_cpu_release_bit_prop(Object *obj, const char *name,
>   * multiple bits in the same FeatureWord. In that case, the getter will return
>   * true only if all bits are set.
>   */
> -static void x86_cpu_register_bit_prop(X86CPU *cpu,
> +static void x86_cpu_register_bit_prop(X86CPUClass *xcc,
>                                        const char *prop_name,
>                                        FeatureWord w,
>                                        int bitnr)
>  {
> +    ObjectClass *oc = OBJECT_CLASS(xcc);
>      BitProperty *fp;
>      ObjectProperty *op;
>      uint64_t mask = (1ULL << bitnr);
>  
> -    op = object_property_find(OBJECT(cpu), prop_name, NULL);
> +    op = object_class_property_find(oc, prop_name, NULL);
>      if (op) {
>          fp = op->opaque;
>          assert(fp->w == w);
> @@ -6837,14 +6838,14 @@ static void x86_cpu_register_bit_prop(X86CPU *cpu,
>          fp = g_new0(BitProperty, 1);
>          fp->w = w;
>          fp->mask = mask;
> -        object_property_add(OBJECT(cpu), prop_name, "bool",
> -                            x86_cpu_get_bit_prop,
> -                            x86_cpu_set_bit_prop,
> -                            x86_cpu_release_bit_prop, fp);
> +        object_class_property_add(oc, prop_name, "bool",
> +                                  x86_cpu_get_bit_prop,
> +                                  x86_cpu_set_bit_prop,
> +                                  x86_cpu_release_bit_prop, fp);
>      }
>  }
>  
> -static void x86_cpu_register_feature_bit_props(X86CPU *cpu,
> +static void x86_cpu_register_feature_bit_props(X86CPUClass *xcc,
>                                                 FeatureWord w,
>                                                 int bitnr)
>  {
> @@ -6863,7 +6864,7 @@ static void x86_cpu_register_feature_bit_props(X86CPU *cpu,
>      /* aliases don't use "|" delimiters anymore, they are registered
>       * manually using object_property_add_alias() */
>      assert(!strchr(name, '|'));
> -    x86_cpu_register_bit_prop(cpu, name, w, bitnr);
> +    x86_cpu_register_bit_prop(xcc, name, w, bitnr);
>  }
>  
>  #if !defined(CONFIG_USER_ONLY)
> @@ -6917,7 +6918,6 @@ static void x86_cpu_initfn(Object *obj)
>      X86CPU *cpu = X86_CPU(obj);
>      X86CPUClass *xcc = X86_CPU_GET_CLASS(obj);
>      CPUX86State *env = &cpu->env;
> -    FeatureWord w;
>  
>      env->nr_dies = 1;
>      cpu_set_cpustate_pointers(cpu);
> @@ -6929,14 +6929,6 @@ static void x86_cpu_initfn(Object *obj)
>                          x86_cpu_get_feature_words,
>                          NULL, NULL, (void *)cpu->filtered_features);
>  
> -    for (w = 0; w < FEATURE_WORDS; w++) {
> -        int bitnr;
> -
> -        for (bitnr = 0; bitnr < 64; bitnr++) {
> -            x86_cpu_register_feature_bit_props(cpu, w, bitnr);
> -        }
> -    }
> -
>      object_property_add_alias(obj, "sse3", obj, "pni");
>      object_property_add_alias(obj, "pclmuldq", obj, "pclmulqdq");
>      object_property_add_alias(obj, "sse4-1", obj, "sse4.1");
> @@ -7221,6 +7213,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
>      X86CPUClass *xcc = X86_CPU_CLASS(oc);
>      CPUClass *cc = CPU_CLASS(oc);
>      DeviceClass *dc = DEVICE_CLASS(oc);
> +    FeatureWord w;
>  
>      device_class_set_parent_realize(dc, x86_cpu_realizefn,
>                                      &xcc->parent_realize);
> @@ -7310,6 +7303,12 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
>                                x86_cpu_get_crash_info_qom, NULL, NULL, NULL);
>  #endif
>  
> +    for (w = 0; w < FEATURE_WORDS; w++) {
> +        int bitnr;
> +        for (bitnr = 0; bitnr < 64; bitnr++) {
> +            x86_cpu_register_feature_bit_props(xcc, w, bitnr);
> +        }
> +    }
>  }
>  
>  static const TypeInfo x86_cpu_type_info = {


