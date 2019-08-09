Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B89C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A052086A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A052086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7T5-0006Gm-OQ
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55971)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1hw7SU-0005NP-Rh
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1hw7ST-00027m-Jr
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:09:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44048)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1hw7SQ-00026B-Qk; Fri, 09 Aug 2019 12:09:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 322D5308421A;
 Fri,  9 Aug 2019 16:09:32 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E519760933;
 Fri,  9 Aug 2019 16:09:22 +0000 (UTC)
Date: Fri, 9 Aug 2019 18:09:20 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190809160920.f4sz72irkuj4pqr7@kamzik.brq.redhat.com>
References: <20190802122540.26385-1-drjones@redhat.com>
 <20190802122540.26385-4-drjones@redhat.com>
 <d0983bd5-c1a5-adf6-324d-2b199ca0e23c@linaro.org>
 <ec44ddad-c33c-918b-e94b-a534a2519a9e@linaro.org>
 <20190806122144.bb3klk7aaaqdhgwi@kamzik.brq.redhat.com>
 <39a4d205-d291-8962-2693-6bbcce89c332@linaro.org>
 <20190808085012.23aokly34zo4wxbk@kamzik.brq.redhat.com>
 <bb477706-e09a-c992-38f0-d3f8725bb4c5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb477706-e09a-c992-38f0-d3f8725bb4c5@linaro.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 09 Aug 2019 16:09:32 +0000 (UTC)
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

On Thu, Aug 08, 2019 at 11:37:01AM -0700, Richard Henderson wrote:
> On 8/8/19 1:50 AM, Andrew Jones wrote:
> > I'm not sure. Of course I'd need to experiment with it to be sure, but
> > I'm reluctant to go through that exercise, because I believe that a
> > deferred validation will result in less specific errors messages. For
> > example, how would the validator know in which order the sve<N> properties
> > were provided? Which is necessary to complain that one length is not
> > allowed when another has already been disabled, or vice versa.
> 
> My point is that we would not *need* to know in which order the properties are
> provided, and do not care.  Indeed, removing this ordering malarkey is a
> feature not a bug.
> 
> The error message would simply state, e.g., that sve256 may not be disabled
> while sve512 is enabled.  The error message does not need to reference the
> order in which they appeared.

OK, I agree it doesn't make much difference to the user whether the error
hint is the generic "sve256 required with sve512" verse

 sve256=off,sve512=on  "cannot enable sve512 with sve256 disabled"

or

 sve512=on,sve256=off  "cannot disable sve256 with sve512 enabled"

> 
> > Also with deferred validation I think I'd need more vq states, at least
> > for when KVM is enabled. For example, if 384-bit vector lengths are not
> > supported on the KVM host, but the user does sve384=on, and all we do
> > is record that, then we've lost the KVM unsupported information and won't
> > find out until we attempt to enable it later at kvm vcpu init time. We'd
> > need a kvm-unsupported-user-enabled state to track that, which also means
> > we're not blindly recording user input in cpu_arm_set_sve_vq() anymore,
> > but are instead applying logic to decide which state we transition to.
> 
> Or perhaps, less vq states.  You do not need to compute kvm states early.  You
> can wait to collect those until validation time and keep them in their own
> local bitmap.
> 
> bool validate_sve_properties(...)
> {
>     // Populate uninitialized bits in sve_vq_map from sve_max_vq.
>     // Populate uninitialized bits in sve_vq_map from on bits in sve_vq_map.

And disable uninitialized bits in sve_vq_map from OFF bits: auto-disabling

Also we can't do these populate uninitialized bits from on/off steps when
KVM is enabled without first getting the kvm-supported map.

>     // All remaining uninitialized bits are set to off.
>     // Reset sve_max_vq to the maximum bit set in sve_vq_map, plus 1.

I wouldn't always do this. If the user explicitly sets a maximum with
sve-max-vq, then we should generate errors when other inputs would change
that maximum. I would only assert they're the same when both input types
are provided. Of course we do the above when only map input is provided
though.

>     // Diagnose off bits in sve_vq_map from on bits in sve_vq_map.
> 
>     if (kvm_enabled()) {
>         DECLARE_BITMAP(test, ARM_MAX_VQ);
>         kvm_arm_sve_get_vls(CPU(cpu), test);
>         if (!bitmap_equal(test, s->sve_vq_map, s->sve_max_vq))  {
>             bitmap_xor(test, test, s->sve_vq_map, s->sve_max_vq);
>             // Diagnose the differences in TEST:
>             // test[i] & s->sve_vq_map[i] -> i is unsupported by kvm
>             // test[i] & !s->sve_vq_map[i] -> i is required by kvm
>         }
>     }
> }
> 
> If you prefer not to experiment with this, then I will.
>

Ah, the ol' I'll do it if you don't motivator... I do see some
potential for a reduction in complexity with this approach, but
I'm not sure we'll save many lines of code. I could do a quick
hack on top of this series, just to see how well the validator
function looks and works, but I can't get to it until midweek
next week. I won't complain if you beat me to it :-)

Thanks,
drew

