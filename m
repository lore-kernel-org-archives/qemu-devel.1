Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D76C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 06:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4FA218DE
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 06:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4FA218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIRkw-00072M-Ep
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 02:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iIRkD-0006YK-O8
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 02:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iIRkC-0003qa-J9
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 02:16:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55726)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1iIRk9-0003kT-5U; Thu, 10 Oct 2019 02:16:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4706530043E1;
 Thu, 10 Oct 2019 06:16:07 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BCA85D9E2;
 Thu, 10 Oct 2019 06:16:02 +0000 (UTC)
Date: Thu, 10 Oct 2019 08:16:00 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] target/arm/arch_dump: Add SVE notes
Message-ID: <20191010061600.pwhos4huazbsv6kn@kamzik.brq.redhat.com>
References: <20191004120313.5347-1-drjones@redhat.com>
 <f23153f2-35be-f74d-ad7b-d9c324cba1cf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f23153f2-35be-f74d-ad7b-d9c324cba1cf@linaro.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 10 Oct 2019 06:16:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 qemu-arm@nongnu.org, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 09, 2019 at 08:39:21PM -0400, Richard Henderson wrote:
> On 10/4/19 8:03 AM, Andrew Jones wrote:
> > +#ifdef TARGET_AARCH64
> > +static off_t sve_zreg_offset(uint32_t vq, int n)
> > +{
> > +    off_t off = sizeof(struct aarch64_user_sve_header);
> > +    return ROUND_UP(off, 16) + vq * 16 * n;
> > +}
> > +static off_t sve_preg_offset(uint32_t vq, int n)
> > +{
> > +    return sve_zreg_offset(vq, 32) + vq * 16 / 8 * n;
> > +}
> > +static off_t sve_fpsr_offset(uint32_t vq)
> > +{
> > +    off_t off = sve_preg_offset(vq, 17) + offsetof(struct aarch64_note, sve);
> > +    return ROUND_UP(off, 16) - offsetof(struct aarch64_note, sve);
> > +}
> > +static off_t sve_fpcr_offset(uint32_t vq)
> > +{
> > +    return sve_fpsr_offset(vq) + sizeof(uint32_t);
> > +}
> > +static uint32_t sve_current_vq(CPUARMState *env)
> > +{
> > +    return sve_zcr_len_for_el(env, arm_current_el(env)) + 1;
> > +}
> > +static size_t sve_size_vq(uint32_t vq)
> > +{
> > +    off_t off = sve_fpcr_offset(vq) + sizeof(uint32_t) +
> > +                offsetof(struct aarch64_note, sve);
> > +    return ROUND_UP(off, 16) - offsetof(struct aarch64_note, sve);
> > +}
> > +static size_t sve_size(CPUARMState *env)
> > +{
> > +    return sve_size_vq(sve_current_vq(env));
> > +}
> 
> Watch the missing spaces between functions.

I'll put in the blank lines

> 
> > +    for (i = 0; i < 32; ++i) {
> > +#ifdef HOST_WORDS_BIGENDIAN
> > +        uint64_t d[vq * 2];
> > +        int j;
> > +
> > +        for (j = 0; j < vq * 2; ++j) {
> > +            d[j] = bswap64(env->vfp.zregs[i].d[j]);
> > +        }
> > +#else
> > +        uint64_t *d = &env->vfp.zregs[i].d[0];
> > +#endif
> > +        memcpy(&buf[sve_zreg_offset(vq, i)], &d[0], vq * 16);
> > +    }
> 
> We should avoid the variable sized array here.
> 
> It might be best to avoid the ifdef altogether:
> 
>     for (i = 0; i < 32; ++i) {
>         uint64_t *d = (uint64_t *)&buf[sve_zreg_offset(vq, i)];
>         for (j = 0; j < vq * 2; ++j) {
>             d[j] = cpu_to_le64(env->vfp.zregs[i].d[j]);
>         }
>     }
> 
> The compiler may well transform the inner loop to memcpy for little-endian
> host, but even if it doesn't core dumping is hardly performance sensitive.

True. I even had something like the above at first, but then
overcomplicated it with the #ifdef-ing.

Thanks,
drew

