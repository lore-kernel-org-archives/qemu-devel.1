Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0547C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 08:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F0220644
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 08:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F0220644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgmK9-0007dy-Gf
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 04:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32932)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1hgmHr-0006iT-7A
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 04:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1hgmHq-0008U1-3a
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 04:31:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43390)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1hgmHn-0008Qw-Ir; Fri, 28 Jun 2019 04:31:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BEB4B308FC20;
 Fri, 28 Jun 2019 08:31:09 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9BD41001959;
 Fri, 28 Jun 2019 08:31:03 +0000 (UTC)
Date: Fri, 28 Jun 2019 10:31:01 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190628083101.2dk6henlyiukoz2k@kamzik.brq.redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-8-drjones@redhat.com>
 <be805987-250d-93a7-7d11-5204f0e16e7b@linaro.org>
 <20190628072739.5t2o2yqaejn6pyd5@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628072739.5t2o2yqaejn6pyd5@kamzik.brq.redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 28 Jun 2019 08:31:09 +0000 (UTC)
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

On Fri, Jun 28, 2019 at 09:27:39AM +0200, Andrew Jones wrote:
> On Thu, Jun 27, 2019 at 06:49:02PM +0200, Richard Henderson wrote:
> > On 6/21/19 6:34 PM, Andrew Jones wrote:
> > > +    /*
> > > +     * In sve_vq_map each set bit is a supported vector length of
> > > +     * (bit-number + 1) * 16 bytes, i.e. each bit number + 1 is the vector
> > > +     * length in quadwords. We need a map size twice the maximum
> > > +     * quadword length though because we use two bits for each vector
> > > +     * length in order to track three states: uninitialized, off, and on.
> > > +     */
> > > +    DECLARE_BITMAP(sve_vq_map, ARM_MAX_VQ * 2);
> > 
> > I don't see that having one continuous bitmap is more convenient than two.
> > Indeed, there appear to be several places that would be clearer with two.
> > 
> > > +static arm_vq_state arm_cpu_vq_map_get(ARMCPU *cpu, int vq)
> > > +{
> > > +    assert(vq <= ARM_MAX_VQ);
> > > +
> > > +    return test_bit(vq - 1, cpu->sve_vq_map) |
> > > +           test_bit(vq - 1 + ARM_MAX_VQ, cpu->sve_vq_map) << 1;
> > > +}
> > 
> > Neither easier nor more complex w/ one or two bitmaps.
> > 
> > > +static void arm_cpu_vq_map_init(ARMCPU *cpu)
> > > +{
> > > +    bitmap_zero(cpu->sve_vq_map, ARM_MAX_VQ * 2);
> > > +    bitmap_set(cpu->sve_vq_map, ARM_MAX_VQ, ARM_MAX_VQ);
> > > +}
> > 
> > Clearer with two bitmaps.
> > 
> > 	bitmap_zero(cpu->sve_vq_map, ARM_MAX_VQ);
> > 	bitmap_set(cpu->sve_vq_uninit_map, 0, ARM_MAX_VQ);
> > 
> > > +static bool arm_cpu_vq_map_is_finalized(ARMCPU *cpu)
> > > +{
> > > +    DECLARE_BITMAP(map, ARM_MAX_VQ * 2);
> > > +
> > > +    bitmap_zero(map, ARM_MAX_VQ * 2);
> > > +    bitmap_set(map, ARM_MAX_VQ, ARM_MAX_VQ);
> > > +    bitmap_and(map, map, cpu->sve_vq_map, ARM_MAX_VQ * 2);
> > > +
> > > +    return bitmap_empty(map, ARM_MAX_VQ * 2);
> > > +}
> > 
> > Definitely clearer w/ 2 bitmaps,
> > 
> > 	return bitmap_empty(cpu->sve_vq_uninit_map);
> 
> I guess I don't have a strong opinion on one or two bitmaps. I'm not a big
> fan of adding temporary variables to data structures (even if the same
> amount of storage is being allocated a different way), but I can change
> this for v3.

On second thought, since in this case there is storage savings (one less
long), then I'd rather we keep it a single bitmap. Maybe I can just add
some comments to these bitmap operations?

Thanks,
drew

