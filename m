Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA232C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 18:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 952AD20879
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 18:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952AD20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33148 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQFag-0006TC-O6
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 14:22:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQFYv-0005I7-HI
	for qemu-devel@nongnu.org; Mon, 13 May 2019 14:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQFXh-0000ym-Ic
	for qemu-devel@nongnu.org; Mon, 13 May 2019 14:19:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hQFXf-0000xo-IJ; Mon, 13 May 2019 14:19:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C7E2F307D863;
	Mon, 13 May 2019 18:19:14 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-151.ams2.redhat.com
	[10.36.116.151])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 158125D706;
	Mon, 13 May 2019 18:19:11 +0000 (UTC)
Date: Mon, 13 May 2019 20:19:08 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190513181908.cpep23i7x77gsgai@kamzik.brq.redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-8-drjones@redhat.com>
	<50d07a50-d780-2c73-d9d8-f6eeff6a17c8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50d07a50-d780-2c73-d9d8-f6eeff6a17c8@linaro.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 13 May 2019 18:19:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 07/13] target/arm/kvm: max cpu: Allow sve
 max vector length setting
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, armbru@redhat.com,
	qemu-arm@nongnu.org, abologna@redhat.com, alex.bennee@linaro.org,
	Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 13, 2019 at 10:19:25AM -0700, Richard Henderson wrote:
> On 5/12/19 1:36 AM, Andrew Jones wrote:
> > @@ -292,7 +292,7 @@ static void aarch64_max_initfn(Object *obj)
> >  
> >      if (kvm_enabled()) {
> >          kvm_arm_set_cpu_features_from_host(cpu);
> > -        cpu->sve_max_vq = ARM_MAX_VQ;
> > +        cpu->sve_max_vq = -1; /* set in kvm_arch_init_vcpu() */
> 
> Perhaps a better comment is "unspecified, to be finalized in ..."

OK

> 
> > +    object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_vq,
> > +                        cpu_max_set_sve_vq, NULL, NULL, &error_fatal);
> 
> as one can set it here, via the command-line.
> 
> > @@ -644,6 +702,24 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >      }
> >  
> >      if (cpu->sve_max_vq) {
> > +        uint64_t sve_vls[KVM_ARM64_SVE_VLS_WORDS];
> > +        ret = kvm_arm_get_sve_vls(cs, sve_vls);
> > +        if (ret < 0) {
> > +            return ret;
> > +        }
> > +        if (cpu->sve_max_vq == -1) {
> > +            cpu->sve_max_vq = ret;
> 
> You still cannot set a value larger than ARM_MAX_VQ, as that is the fixed
> amount of space allocated within the cpu structure.
>

Good point. I should check against ARM_MAX_VQ here.

Thanks,
drew 

