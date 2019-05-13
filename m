Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189B4C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 18:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9031208C3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 18:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9031208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33152 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQFbE-00074H-2U
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 14:22:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQFZQ-0005iF-EJ
	for qemu-devel@nongnu.org; Mon, 13 May 2019 14:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQFT4-0006QT-77
	for qemu-devel@nongnu.org; Mon, 13 May 2019 14:14:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hQFT3-0006Ox-2E; Mon, 13 May 2019 14:14:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 736273082B55;
	Mon, 13 May 2019 18:14:27 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-151.ams2.redhat.com
	[10.36.116.151])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A3FB060C4D;
	Mon, 13 May 2019 18:14:24 +0000 (UTC)
Date: Mon, 13 May 2019 20:14:21 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190513181421.g25e2zqlkks7ntxb@kamzik.brq.redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-6-drjones@redhat.com>
	<20190513123110.GE28398@e103592.cambridge.arm.com>
	<e35ba07e-2844-fe2d-ca4a-0f795a1485b1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e35ba07e-2844-fe2d-ca4a-0f795a1485b1@linaro.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 13 May 2019 18:14:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 05/13] target/arm/kvm: Add
 kvm_arch_get/put_sve
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"armbru@redhat.com" <armbru@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"abologna@redhat.com" <abologna@redhat.com>,
	"alex.bennee@linaro.org" <alex.bennee@linaro.org>,
	Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 13, 2019 at 09:40:29AM -0700, Richard Henderson wrote:
> On 5/13/19 5:31 AM, Dave Martin wrote:
> > On Sun, May 12, 2019 at 09:36:16AM +0100, Andrew Jones wrote:
> >> These are the SVE equivalents to kvm_arch_get/put_fpsimd.
> >>
> >> Signed-off-by: Andrew Jones <drjones@redhat.com>
> >> ---
> >>  target/arm/kvm64.c | 127 +++++++++++++++++++++++++++++++++++++++++++--
> >>  1 file changed, 123 insertions(+), 4 deletions(-)
> > 
> > [...]
> > 
> >> +static int kvm_arch_put_sve(CPUState *cs)
> >> +{
> >> +    ARMCPU *cpu = ARM_CPU(cs);
> >> +    CPUARMState *env = &cpu->env;
> >> +    struct kvm_one_reg reg;
> >> +    int n, ret;
> >> +
> >> +    for (n = 0; n < KVM_ARM64_SVE_NUM_ZREGS; n++) {
> >> +        uint64_t *q = aa64_vfp_qreg(env, n);
> >> +#ifdef HOST_WORDS_BIGENDIAN
> >> +        uint64_t d[ARM_MAX_VQ * 2];
> >> +        int i;
> >> +        for (i = 0; i < cpu->sve_max_vq * 2; i++) {
> >> +            d[i] = q[cpu->sve_max_vq * 2 - 1 - i];
> >> +        }
> > 
> > Out of interest, why do all this swabbing?  It seems expensive.
> 
> Indeed, to me this seems to be the wrong kind of swabbing here.  Exactly what
> format is KVM expecting?  Surely it should be the one used by the unpredicated
> LDR/STR instructions.  Anything else would seem to be working against the
> architecture.
> 
> If so, the format is, architecturally, a stream of bytes in index order, which
> corresponds to a little-endian stream of words.  So the loop I'd expect to see
> here is
> 
>     for (i = 0, n = cpu->sve_max_vq; i < n; ++i) {
>         d[i] = bswap64(q[i]);
>     }

That's the opposite of what we do for fpsimd registers though. I'm
fine with doing whatever KVM/TCG needs, but so far I was just following
the same pattern we already have.

Thanks,
drew

