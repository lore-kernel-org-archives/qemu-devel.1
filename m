Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF5CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 11:19:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D75720715
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 11:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D75720715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6BGx-0001rW-1W
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 07:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.rutland@arm.com>)
 id 1k6B7f-0000qg-Ls
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 07:10:15 -0400
Received: from foss.arm.com ([217.140.110.172]:46092)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.rutland@arm.com>) id 1k6B7c-0002pQ-KU
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 07:10:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07EC731B;
 Thu, 13 Aug 2020 04:10:11 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.38.123])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDFFA3F70D;
 Thu, 13 Aug 2020 04:10:09 -0700 (PDT)
Date: Thu, 13 Aug 2020 12:10:06 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 1/2] target/arm: Add cpu property to control pauth
Message-ID: <20200813111006.GC45195@C02TD0UTHF1T.local>
References: <20200812065339.2030527-1-richard.henderson@linaro.org>
 <20200812065339.2030527-2-richard.henderson@linaro.org>
 <20200812110049.ghtvl7dmtspkfdor@kamzik.brq.redhat.com>
 <2219f3f9-7894-f898-0cad-43eccaa2a70d@linaro.org>
 <20200812163107.lbubi6c7ei7i5hmw@kamzik.brq.redhat.com>
 <20200813060321.cbr2tun6cuq25yst@kamzik.brq.redhat.com>
 <20200813090504.GA45195@C02TD0UTHF1T.local>
 <20200813094907.y5253jvekiqbz7n2@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813094907.y5253jvekiqbz7n2@kamzik.brq.redhat.com>
Received-SPF: pass client-ip=217.140.110.172;
 envelope-from=mark.rutland@arm.com; helo=foss.arm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 05:05:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 13, 2020 at 11:49:07AM +0200, Andrew Jones wrote:
> On Thu, Aug 13, 2020 at 10:05:04AM +0100, Mark Rutland wrote:
> > On Thu, Aug 13, 2020 at 08:03:21AM +0200, Andrew Jones wrote:
> > > Thinking about this some more, maybe we don't need pauth-arch.
> > > If we don't, then it simplifies nicely to
> > > 
> > >  # Default (enabled with architected algorithm)
> > >  -cpu max[,pauth=on][,pauth-fast=off]
> > > 
> > >  # Select pauth-fast
> > >  -cpu max[,pauth=on],pauth-fast=on
> > 
> > One reason that users may wish to choose the IMP-DEF algorithm is for
> > functional testing regardless of speed (since APA+GPA / API+GPI depend
> > on whether the algo is architected or imp-def).
> > 
> > Given that, I think that "impdef" is a better option name than
> > "pauth-fast", and speed is a benefit but not the only reason to use the
> > option.
> 
> I was going with pauth-fast because in this case Richard identified a
> need for a fast version. If we identify another need later, then we may
> want to add another impdef version, e.g. pauth-foo. Maybe all the impdef
> versions should have impdef in their name to make that more explicit?
> 
>  pauth-impdef-fast
>  pauth-impdef-foo

Something like that is fine by me.

> > How about hacing a 'pauth-algo' option which defaults to architected,
> > e.g.
> > 
> > | -cpu max,pauth={on,off},pauth-algo={impdef,architected}
> > 
> > ... then in future the 'pauth={on,off}' bit could de extended to cover
> > FPAC version etc independently of the algorithm, but for now that can be
> > a boolean.
> 
> Keeping pauth a boolean, but creating a pauth-algo enum doesn't help us
> much, because probing will only be possible for pauth. The prober could
> only decide to enable pauth with the default algo or not. We could create
> a pauth-specific probe, similar to the gic-specific probe, but, IMO, it's
> really not necessary. If we need multiple pauth-* properties, then we can
> have them all. It just adds a few more lines of logic to the pauth
> finalize function.

I suspect that it will be necessary in future handle multiple options to
enumerate things like FPAC/EPAC separately from the algorithm used,
which is why I suggested the algo being its own option now.

I can live with whatever you folk decide on.

Thanks,
Mark.

