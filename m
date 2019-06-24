Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68362C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:33:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E46520674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E46520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50054 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfNE1-0001Gj-AD
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 07:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33978)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1hfNCF-0000ds-7f
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1hfNCD-0006Xo-2c
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:31:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13387)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1hfNC7-0005S0-1T; Mon, 24 Jun 2019 07:31:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C9B87E437;
 Mon, 24 Jun 2019 11:30:48 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D874D60BF7;
 Mon, 24 Jun 2019 11:30:39 +0000 (UTC)
Date: Mon, 24 Jun 2019 13:30:37 +0200
From: Andrew Jones <drjones@redhat.com>
To: Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190624113037.m5onedluc4x7c5ej@kamzik.brq.redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-6-drjones@redhat.com>
 <20190624110507.GG2790@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624110507.GG2790@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 24 Jun 2019 11:30:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 05/14] target/arm/helper: zcr: Add build
 bug next to value range assumption
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 24, 2019 at 12:05:07PM +0100, Dave Martin wrote:
> On Fri, Jun 21, 2019 at 05:34:13PM +0100, Andrew Jones wrote:
> 
> The purpose of this check should probably at least be described in a
> comment -- i.e., what actually depends on this?

I was thinking the already present "Bits other than [3:0] are RAZ/WI."
explained that, but how about this for an improvement?

/*
 * Only the lowest 4 bits of ZCR_ELx may be used to constrain the vector
 * length, the rest of the bits are RAZ/WI. Since the vector length of
 * 128-bits (1 in quadwords) is represented as zero in ZCR_ELx, and all
 * vector lengths are represented as their length in quadwords minus 1,
 * then four bits allow up to quadword 16 to be selected.
 */

Thanks,
drew

> 
> Cheers
> ---Dave
> 
> > Suggested-by: Dave Martin <Dave.Martin@arm.com>
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  target/arm/helper.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index df4276f5f6ca..edba94004e0b 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -5319,6 +5319,7 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> >      int new_len;
> >  
> >      /* Bits other than [3:0] are RAZ/WI.  */
> > +    QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
> >      raw_write(env, ri, value & 0xf);
> >  
> >      /*
> > -- 
> > 2.20.1
> > 
> 

