Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29145C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F74208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F74208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57826 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQBTl-0001XG-AO
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 09:58:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQBQG-000747-Sx
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQBQF-0000ve-Sr
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:55:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58219)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hQBQC-0000rZ-VK; Mon, 13 May 2019 09:55:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB0A0301EABA;
	Mon, 13 May 2019 13:55:13 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-151.ams2.redhat.com
	[10.36.116.151])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1471563BBA;
	Mon, 13 May 2019 13:55:09 +0000 (UTC)
Date: Mon, 13 May 2019 15:55:01 +0200
From: Andrew Jones <drjones@redhat.com>
To: Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190513135501.ztggqdac57qbpuft@kamzik.brq.redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-6-drjones@redhat.com>
	<20190513123110.GE28398@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513123110.GE28398@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Mon, 13 May 2019 13:55:13 +0000 (UTC)
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
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"abologna@redhat.com" <abologna@redhat.com>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 13, 2019 at 01:31:11PM +0100, Dave Martin wrote:
> On Sun, May 12, 2019 at 09:36:16AM +0100, Andrew Jones wrote:
> > These are the SVE equivalents to kvm_arch_get/put_fpsimd.
> > 
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  target/arm/kvm64.c | 127 +++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 123 insertions(+), 4 deletions(-)
> 
> [...]
> 
> > +static int kvm_arch_put_sve(CPUState *cs)
> > +{
> > +    ARMCPU *cpu = ARM_CPU(cs);
> > +    CPUARMState *env = &cpu->env;
> > +    struct kvm_one_reg reg;
> > +    int n, ret;
> > +
> > +    for (n = 0; n < KVM_ARM64_SVE_NUM_ZREGS; n++) {
> > +        uint64_t *q = aa64_vfp_qreg(env, n);
> > +#ifdef HOST_WORDS_BIGENDIAN
> > +        uint64_t d[ARM_MAX_VQ * 2];
> > +        int i;
> > +        for (i = 0; i < cpu->sve_max_vq * 2; i++) {
> > +            d[i] = q[cpu->sve_max_vq * 2 - 1 - i];
> > +        }
> 
> Out of interest, why do all this swabbing?  It seems expensive.
>

QEMU keeps its 128-bit and larger words in the same order (least
significant word first) for both host endian types. We need to
do word swapping every time we set/get them to/from KVM.

Thanks,
drew

