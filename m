Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B72C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 12:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64914206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 12:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64914206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huyU6-0003kJ-OK
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 08:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43791)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1huyTa-0003Fd-Tx
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 08:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1huyTZ-0005Mr-NG
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 08:22:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46182)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1huyTW-0005Ls-W3; Tue, 06 Aug 2019 08:21:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 526813008954;
 Tue,  6 Aug 2019 12:21:57 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9783661B65;
 Tue,  6 Aug 2019 12:21:46 +0000 (UTC)
Date: Tue, 6 Aug 2019 14:21:44 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190806122144.bb3klk7aaaqdhgwi@kamzik.brq.redhat.com>
References: <20190802122540.26385-1-drjones@redhat.com>
 <20190802122540.26385-4-drjones@redhat.com>
 <d0983bd5-c1a5-adf6-324d-2b199ca0e23c@linaro.org>
 <ec44ddad-c33c-918b-e94b-a534a2519a9e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec44ddad-c33c-918b-e94b-a534a2519a9e@linaro.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 06 Aug 2019 12:21:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 03/15] target/arm/monitor: Introduce
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, armbru@redhat.com,
 eric.auger@redhat.com, qemu-arm@nongnu.org, imammedo@redhat.com,
 alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 02, 2019 at 06:28:51PM -0700, Richard Henderson wrote:
> On 8/2/19 9:27 AM, Richard Henderson wrote:
> > On 8/2/19 5:25 AM, Andrew Jones wrote:
> >> Note, certainly more features may be added to the list of
> >> advertised features, e.g. 'vfp' and 'neon'. The only requirement
> >> is that their property set accessors fail when invalid
> >> configurations are detected. For vfp we would need something like
> >>
> >>  set_vfp()
> >>  {
> >>    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
> >>        cpu->has_vfp != cpu->has_neon)
> >>        error("AArch64 CPUs must have both VFP and Neon or neither")
> >>
> >> in its set accessor, and the same for neon, rather than doing that
> >> check at realize time, which isn't executed at qmp query time.
> > 
> > How could this succeed?  Either set_vfp or set_neon would be called first, at
> > which point the two features are temporarily out of sync, but the error would
> > trigger anyway.
> > 
> > This would seem to require some separate "qmp validate" step that is processed
> > after a collection of properties are set.
> > 
> > I was about to say something about this being moot until someone actually wants
> > to be able to disable vfp+neon on aarch64, but then...
> > 
> >> +A note about CPU feature dependencies
> >> +-------------------------------------
> >> +
> >> +It's possible for features to have dependencies on other features. I.e.
> >> +it may be possible to change one feature at a time without error, but
> >> +when attempting to change all features at once an error could occur
> >> +depending on the order they are processed.  It's also possible changing
> >> +all at once doesn't generate an error, because a feature's dependencies
> >> +are satisfied with other features, but the same feature cannot be changed
> >> +independently without error.  For these reasons callers should always
> >> +attempt to make their desired changes all at once in order to ensure the
> >> +collection is valid.
> > 
> > ... this language makes me think that you've already encountered an ordering
> > problem that might be better solved with a separate validate step?
> 
> It appears to me that we can handle both use cases with a single function to
> handle validation of the cross-dependent properties.
> 
> It would need to be called at the beginning of arm_cpu_realizefn, for the case
> in which we are building a cpu that we wish to instantiate, and
> 
> > +        if (!err) {
> > +            visit_check_struct(visitor, &err);
> > +        }
> 
> here, inside qmp_query_cpu_model_expansion for the query case.
> 
> Looking at the validation code scattered across multiple functions, across 4
> patches, convinces me that the code will be smaller and more readable if we
> consolidate them into a single validation function.
>

That's a reasonable suggestion. I do like having self-contained
validation, self-contained, but when cross-dependencies arise, then
it does make sense to have a master validation function, rather
than interconnecting too much. That said, for this series we only
enable the qmp query for aarch64, pmu, and sve* properties. aarch64
and pmu are independent, and thus self-contained, and I consider
all sve* properties one big entity, so their validation is also
self-contained. If we add vfp and neon, then indeed I was wrong
with my suggestion in the commit message. They would need a later
validation check. Should we just cross that bridge when we get there
though? Or would you like me to see how that would work within this
series?

Thanks,
drew

