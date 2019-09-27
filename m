Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91495C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660B520872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660B520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDk8x-0003bq-Lk
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 02:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iDk0T-0003gk-ML
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iDk0S-0007ZA-Gc
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:45:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39192)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1iDk0O-0007QE-OM; Fri, 27 Sep 2019 02:45:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 28080315C01F;
 Fri, 27 Sep 2019 06:45:27 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07475600C6;
 Fri, 27 Sep 2019 06:45:22 +0000 (UTC)
Date: Fri, 27 Sep 2019 08:45:20 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 4/9] target/arm/cpu64: max cpu: Introduce sve<N>
 properties
Message-ID: <20190927064520.o2sghq5hye4tvycf@kamzik.brq.redhat.com>
References: <20190924113105.19076-1-drjones@redhat.com>
 <20190924113105.19076-5-drjones@redhat.com>
 <2beb840f-99cf-d928-0926-c284933c78d9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2beb840f-99cf-d928-0926-c284933c78d9@linaro.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 27 Sep 2019 06:45:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, armbru@redhat.com,
 eric.auger@redhat.com, qemu-arm@nongnu.org, imammedo@redhat.com,
 alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 26, 2019 at 12:07:54PM -0700, Richard Henderson wrote:
> On 9/24/19 4:31 AM, Andrew Jones wrote:
> > +static uint32_t sve_zcr_get_valid_len(ARMCPU *cpu, uint32_t start_len)
> > +{
> > +    uint32_t start_vq = (start_len & 0xf) + 1;
> > +
> > +    return arm_cpu_vq_map_next_smaller(cpu, start_vq + 1) - 1;
> > +}
> > +
> >  /*
> >   * Given that SVE is enabled, return the vector length for EL.
> >   */
> > @@ -5360,13 +5367,13 @@ uint32_t sve_zcr_len_for_el(CPUARMState *env, int el)
> >      uint32_t zcr_len = cpu->sve_max_vq - 1;
> >  
> >      if (el <= 1) {
> > -        zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[1]);
> > +        zcr_len = sve_zcr_get_valid_len(cpu, env->vfp.zcr_el[1]);
> >      }
> >      if (el <= 2 && arm_feature(env, ARM_FEATURE_EL2)) {
> > -        zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[2]);
> > +        zcr_len = sve_zcr_get_valid_len(cpu, env->vfp.zcr_el[2]);
> >      }
> >      if (arm_feature(env, ARM_FEATURE_EL3)) {
> > -        zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[3]);
> > +        zcr_len = sve_zcr_get_valid_len(cpu, env->vfp.zcr_el[3]);
> 
> This has lost the MIN relation between these 3 registers.
> One possible solution is to keep these 3 if statements as-is,
> but make one call
> 
>     zcr_len = arm_cpu_vq_map_next_smaller(cpu, zcr_len);
> 
> at the end.

Argh. I obviously didn't look closely enough at this function when I was
modifying it. I must have interpreted it as an if-else-if sequence...

I'll fix this as you suggest.

> 
> > +#if __SIZEOF_LONG__ == 8
> > +#define BIT(n) (1UL << (n))
> > +#else
> > +#define BIT(n) (1ULL << (n))
> > +#endif
> 
> There's no reason not to always use 1ULL is there?

Indeed ULL == UL for AArch64. I'll drop the #if... stuff.

Thanks,
drew

