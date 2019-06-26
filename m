Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEB7C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 13:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E863214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 13:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E863214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg8Ml-0008Ee-Dn
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 09:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46871)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1hg8MF-0007kQ-8m
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 09:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1hg8ME-0004WI-4B
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 09:53:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60758)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1hg8MB-0004TK-N8; Wed, 26 Jun 2019 09:53:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 95032C1EB1E1;
 Wed, 26 Jun 2019 13:52:52 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41C795D719;
 Wed, 26 Jun 2019 13:52:47 +0000 (UTC)
Date: Wed, 26 Jun 2019 15:52:44 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190626135244.2jt6alr7lh2v43nu@kamzik.brq.redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-7-drjones@redhat.com>
 <c794d810-fbaf-ff81-9833-3e40fb5a951d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c794d810-fbaf-ff81-9833-3e40fb5a951d@linaro.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 26 Jun 2019 13:52:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 06/14] target/arm: Allow SVE to be
 disabled via a CPU property
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

On Wed, Jun 26, 2019 at 12:20:29PM +0200, Richard Henderson wrote:
> On 6/21/19 6:34 PM, Andrew Jones wrote:
> > Since 97a28b0eeac14 ("target/arm: Allow VFP and Neon to be disabled via
> > a CPU property") we can disable the 'max' cpu model's VFP and neon
> > features, but there's no way to disable SVE. Add the 'sve=on|off'
> > property to give it that flexibility. We also rename
> > cpu_max_get/set_sve_vq to cpu_max_get/set_sve_max_vq in order for them
> > to follow the typical *_get/set_<property-name> pattern.
> 
> I think perhaps the new property should not be overloaded on cpu->sve_max_vq.
> 
> At present you are generating an error for
> 
>     -cpu max,sve=off,sve_max_vq=2
> 
> but not for
> 
>     -cpu max,sve_max_vq=2,sve=off
> 
> and then there's the issue of
> 
>     -cpu max,sve_max_vq=2,sve=off,sve=on
> 
> discarding the earlier sve_max_vq setting.

Yeah, it might be best to add a new boolean in order for that last example
to work as expected. At least my expectation would be that we'd set the
max vq to 2, when sve is disabled nothing happens to it, but then when sve
is reenabled we'll still have that max vq 2. I'm guessing you're expecting
that too, since you brought it up. I think the other two examples above
are behaving as I'd expect them to.

> 
> 
> > @@ -1129,6 +1129,14 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
> >          cpu->isar.mvfr0 = u;
> >      }
> >  
> > +    if (!cpu->sve_max_vq) {
> > +        uint64_t t;
> > +
> > +        t = cpu->isar.id_aa64pfr0;
> > +        t = FIELD_DP64(t, ID_AA64PFR0, SVE, 0);
> > +        cpu->isar.id_aa64pfr0 = t;
> > +    }
> 
> 
> I suppse the isar bits are initialized too late for you to be able to re-use
> the ID_AA64PFR0.SVE field *as* the property?

Hmm, that's probably worth trying. Also reworking vfp and neon to use the
fields as the properties, putting the sanity checks directly in the
property set accessor may work too. pmu and aarch64 could work like that
too, but those still have ARM_FEATURE_* bits, so they're not really the
same [yet].

> 
> 
> >  static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> >                        uint64_t value)
> >  {
> > +    ARMCPU *cpu = env_archcpu(env);
> >      int cur_el = arm_current_el(env);
> > -    int old_len = sve_zcr_len_for_el(env, cur_el);
> > -    int new_len;
> > +    int old_len, new_len;
> > +
> > +    assert(cpu->sve_max_vq);
> 
> Certainly there's no reason for this assert, given the above.

Yeah, I'll remove for v3.

Thanks,
drew

