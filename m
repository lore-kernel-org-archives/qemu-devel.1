Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E76C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 08:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A4492173C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 08:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4492173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hve8L-0001bX-Qc
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 04:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42375)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1hve7s-0000hC-1s
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 04:50:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1hve7r-0003DC-1h
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 04:50:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45706)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1hve7o-0003CD-MU; Thu, 08 Aug 2019 04:50:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B0DD0C00A168;
 Thu,  8 Aug 2019 08:50:18 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 826365C226;
 Thu,  8 Aug 2019 08:50:14 +0000 (UTC)
Date: Thu, 8 Aug 2019 10:50:12 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190808085012.23aokly34zo4wxbk@kamzik.brq.redhat.com>
References: <20190802122540.26385-1-drjones@redhat.com>
 <20190802122540.26385-4-drjones@redhat.com>
 <d0983bd5-c1a5-adf6-324d-2b199ca0e23c@linaro.org>
 <ec44ddad-c33c-918b-e94b-a534a2519a9e@linaro.org>
 <20190806122144.bb3klk7aaaqdhgwi@kamzik.brq.redhat.com>
 <39a4d205-d291-8962-2693-6bbcce89c332@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39a4d205-d291-8962-2693-6bbcce89c332@linaro.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 08 Aug 2019 08:50:18 +0000 (UTC)
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

On Wed, Aug 07, 2019 at 08:22:07AM -0700, Richard Henderson wrote:
> On 8/6/19 5:21 AM, Andrew Jones wrote:
> > That's a reasonable suggestion. I do like having self-contained
> > validation, self-contained, but when cross-dependencies arise, then
> > it does make sense to have a master validation function, rather
> > than interconnecting too much. That said, for this series we only
> > enable the qmp query for aarch64, pmu, and sve* properties. aarch64
> > and pmu are independent, and thus self-contained...
> 
> Agreed.
> 
> > and I consider
> > all sve* properties one big entity, so their validation is also
> > self-contained. If we add vfp and neon, then indeed I was wrong
> > with my suggestion in the commit message. They would need a later
> > validation check. Should we just cross that bridge when we get there
> > though? Or would you like me to see how that would work within this
> > series?
> 
> While the sve* properties are handled by one function, they are not handled as
> "one big entity".  You examine then apply or diagnose the effects of sve384=on
> before you separately examine the effects of sve512=on.
> 
> I think it would be easiest to merely record facts while processing sve<N> and
> sve-max-vq, with no side effects.  Then in the common validation function see
> the required side effects and diagnose errors all at once.
>

I'm not sure. Of course I'd need to experiment with it to be sure, but
I'm reluctant to go through that exercise, because I believe that a
deferred validation will result in less specific errors messages. For
example, how would the validator know in which order the sve<N> properties
were provided? Which is necessary to complain that one length is not
allowed when another has already been disabled, or vice versa.

Also with deferred validation I think I'd need more vq states, at least
for when KVM is enabled. For example, if 384-bit vector lengths are not
supported on the KVM host, but the user does sve384=on, and all we do
is record that, then we've lost the KVM unsupported information and won't
find out until we attempt to enable it later at kvm vcpu init time. We'd
need a kvm-unsupported-user-enabled state to track that, which also means
we're not blindly recording user input in cpu_arm_set_sve_vq() anymore,
but are instead applying logic to decide which state we transition to.

Thanks,
drew

