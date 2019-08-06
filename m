Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2D9C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 12:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A01C2206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 12:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01C2206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huyWI-0004pt-W7
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 08:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44101)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1huyVf-0004Km-2u
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 08:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1huyVe-00068K-2F
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 08:24:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51162)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1huyVb-00065n-TQ; Tue, 06 Aug 2019 08:24:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0725530EA1A9;
 Tue,  6 Aug 2019 12:24:07 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C50095DA8C;
 Tue,  6 Aug 2019 12:24:02 +0000 (UTC)
Date: Tue, 6 Aug 2019 14:24:00 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190806122400.omu4b6l6c3s6aquv@kamzik.brq.redhat.com>
References: <20190802122540.26385-1-drjones@redhat.com>
 <20190802122540.26385-12-drjones@redhat.com>
 <e41ee1a4-9514-8fe9-8761-f208c9bdcbf3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e41ee1a4-9514-8fe9-8761-f208c9bdcbf3@linaro.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 06 Aug 2019 12:24:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 11/15] target/arm/kvm64: Add
 kvm_arch_get/put_sve
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

On Fri, Aug 02, 2019 at 11:07:54AM -0700, Richard Henderson wrote:
> On 8/2/19 5:25 AM, Andrew Jones wrote:
> > +/*
> > + * SVE registers are encoded in KVM's memory in an endianness-invariant format.
> > + * The byte at offset i from the start of the in-memory representation contains
> > + * the bits [(7 + 8 * i) : (8 * i)] of the register value. As this means the
> > + * lowest offsets are stored in the lowest memory addresses, then that nearly
> > + * matches QEMU's representation, which is to use an array of host-endian
> > + * uint64_t's, where the lower offsets are at the lower indices. To complete
> > + * the translation we just need to byte swap the uint64_t's on big-endian hosts.
> > + */
> > +#ifdef HOST_WORDS_BIGENDIAN
> > +static uint64_t *sve_bswap64(uint64_t *dst, uint64_t *src, int nr)
> > +{
> > +    int i;
> > +
> > +    for (i = 0; i < nr; ++i) {
> > +        dst[i] = bswap64(src[i]);
> > +    }
> > +
> > +    return dst;
> > +}
> > +#endif
> 
> Maybe better as
> 
> static uint64_t *sve_bswap64(uint64_t *tmp, uint64_t *src, int nr)
> {
> #ifdef HOST_WORDS_BIGENDIAN
>     int i;
> 
>     for (i = 0; i < nr; ++i) {
>         tmp[i] = bswap64(src[i]);
>     }
> 
>     return tmp;
> #else
>     return src;
> #endif
> }
> 
> and then the rest of the ifdefs can be removed.

Will do for v4.

> 
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!

drew

