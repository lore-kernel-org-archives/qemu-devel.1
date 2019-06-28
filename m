Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D286C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 07:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 123802064A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 07:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123802064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hglJh-0001W1-Bo
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 03:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48392)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1hglIV-0000zQ-Sv
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 03:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1hglIU-00081o-Kx
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 03:27:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58378)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1hglIR-0007zd-Ug; Fri, 28 Jun 2019 03:27:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5AC953082A27;
 Fri, 28 Jun 2019 07:27:46 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EAB160BE0;
 Fri, 28 Jun 2019 07:27:42 +0000 (UTC)
Date: Fri, 28 Jun 2019 09:27:39 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190628072739.5t2o2yqaejn6pyd5@kamzik.brq.redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-8-drjones@redhat.com>
 <be805987-250d-93a7-7d11-5204f0e16e7b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be805987-250d-93a7-7d11-5204f0e16e7b@linaro.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 28 Jun 2019 07:27:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 07/14] target/arm/cpu64: max cpu:
 Introduce sve<vl-bits> properties
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

On Thu, Jun 27, 2019 at 06:49:02PM +0200, Richard Henderson wrote:
> On 6/21/19 6:34 PM, Andrew Jones wrote:
> > +    /*
> > +     * In sve_vq_map each set bit is a supported vector length of
> > +     * (bit-number + 1) * 16 bytes, i.e. each bit number + 1 is the vector
> > +     * length in quadwords. We need a map size twice the maximum
> > +     * quadword length though because we use two bits for each vector
> > +     * length in order to track three states: uninitialized, off, and on.
> > +     */
> > +    DECLARE_BITMAP(sve_vq_map, ARM_MAX_VQ * 2);
> 
> I don't see that having one continuous bitmap is more convenient than two.
> Indeed, there appear to be several places that would be clearer with two.
> 
> > +static arm_vq_state arm_cpu_vq_map_get(ARMCPU *cpu, int vq)
> > +{
> > +    assert(vq <= ARM_MAX_VQ);
> > +
> > +    return test_bit(vq - 1, cpu->sve_vq_map) |
> > +           test_bit(vq - 1 + ARM_MAX_VQ, cpu->sve_vq_map) << 1;
> > +}
> 
> Neither easier nor more complex w/ one or two bitmaps.
> 
> > +static void arm_cpu_vq_map_init(ARMCPU *cpu)
> > +{
> > +    bitmap_zero(cpu->sve_vq_map, ARM_MAX_VQ * 2);
> > +    bitmap_set(cpu->sve_vq_map, ARM_MAX_VQ, ARM_MAX_VQ);
> > +}
> 
> Clearer with two bitmaps.
> 
> 	bitmap_zero(cpu->sve_vq_map, ARM_MAX_VQ);
> 	bitmap_set(cpu->sve_vq_uninit_map, 0, ARM_MAX_VQ);
> 
> > +static bool arm_cpu_vq_map_is_finalized(ARMCPU *cpu)
> > +{
> > +    DECLARE_BITMAP(map, ARM_MAX_VQ * 2);
> > +
> > +    bitmap_zero(map, ARM_MAX_VQ * 2);
> > +    bitmap_set(map, ARM_MAX_VQ, ARM_MAX_VQ);
> > +    bitmap_and(map, map, cpu->sve_vq_map, ARM_MAX_VQ * 2);
> > +
> > +    return bitmap_empty(map, ARM_MAX_VQ * 2);
> > +}
> 
> Definitely clearer w/ 2 bitmaps,
> 
> 	return bitmap_empty(cpu->sve_vq_uninit_map);

I guess I don't have a strong opinion on one or two bitmaps. I'm not a big
fan of adding temporary variables to data structures (even if the same
amount of storage is being allocated a different way), but I can change
this for v3.

> 
> 
> As for how sve-max-vq=Y and sveX={on,off} interoperate...  I wonder if we can
> just remove cpu->sve_max_vq.  That might simplify your code a bit.
> 
> What if sve-max-vq=Y "expands" to
> 
> 	for (X = 1; X <= Y; X++) { sve(X*128)=on }
> 
> Then you've got a reasonable in-order definition of how those two sets of
> switches interoperate.
> 
> The uses of cpu->sve_max_vq within cpu.c and cpu64.c are all initialization
> stuff that you're replacing.

Hmm, I can look at removing cpu->sve_max_vq, by keeping the property and
expanding it, as you suggest. However I still need a few initialization
states to track what the default vq value should be, so I'm not sure
how I'd implement that without it or some other cpu state, which would
be another temporary cpu state member. Also, while it's true we can always
get the max vq with next-smaller(ARM_MAX_VQ + 1), having it cached in
cpu->sve_max_vq is convenient. That said, I think we'd rather keep it.

> 
> The use within sve_zcr_len_for_el can be replaced by AVR_MAX_VQ.  Your "select
> supported vector size not larger than" code goes at the end of that function,
> such that we select a supported maximum no larger than the raw .LEN values.
> 
> The use within aarch64_sve_narrow_vq should in fact assert that the given vq is
> set within cpu->sve_vq_map.

Yeah, I'm glad Eric pointed out that I had a bug there in the emulation.
I'll get that fixed for v3.

Thanks,
drew

