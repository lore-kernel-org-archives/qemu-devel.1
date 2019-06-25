Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F99C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 06:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBFFC205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 06:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFFC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56780 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfegv-00031o-Pm
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 02:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47550)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1hfegC-0002Sh-Tm
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 02:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1hfegB-00050w-Sx
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 02:11:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48042)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1hfeg9-0004wn-Ms; Tue, 25 Jun 2019 02:11:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7AD4E7FDCC;
 Tue, 25 Jun 2019 06:11:38 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 629AD600CD;
 Tue, 25 Jun 2019 06:11:30 +0000 (UTC)
Date: Tue, 25 Jun 2019 08:11:27 +0200
From: Andrew Jones <drjones@redhat.com>
To: Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190625061127.jvrbee6eyxf4meem@kamzik.brq.redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-6-drjones@redhat.com>
 <20190624110507.GG2790@e103592.cambridge.arm.com>
 <20190624113037.m5onedluc4x7c5ej@kamzik.brq.redhat.com>
 <20190624160308.GT2790@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624160308.GT2790@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 25 Jun 2019 06:11:41 +0000 (UTC)
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

On Mon, Jun 24, 2019 at 05:03:08PM +0100, Dave Martin wrote:
> On Mon, Jun 24, 2019 at 12:30:37PM +0100, Andrew Jones wrote:
> > On Mon, Jun 24, 2019 at 12:05:07PM +0100, Dave Martin wrote:
> > > On Fri, Jun 21, 2019 at 05:34:13PM +0100, Andrew Jones wrote:
> > > 
> > > The purpose of this check should probably at least be described in a
> > > comment -- i.e., what actually depends on this?
> > 
> > I was thinking the already present "Bits other than [3:0] are RAZ/WI."
> > explained that, but how about this for an improvement?
> > 
> > /*
> >  * Only the lowest 4 bits of ZCR_ELx may be used to constrain the vector
> >  * length, the rest of the bits are RAZ/WI. Since the vector length of
> >  * 128-bits (1 in quadwords) is represented as zero in ZCR_ELx, and all
> >  * vector lengths are represented as their length in quadwords minus 1,
> >  * then four bits allow up to quadword 16 to be selected.
> >  */
> 
> No, maybe the existing comment is enough.
> 
> I thought there might be more code elsewhere that assumes that checks
> sve_max_vq <= ARM_MAX_VQ then then assumes that sve_max_vq <= 16.  But
> if not, we probably don't need an additional comment here.

I suppose there is some assumption that if sve_max_vq > 0 then it is
also <= ARM_MAX_VQ elsewhere in QEMU. However here in zcr_write I don't
think that assumption is being used. Here we're simply enforcing a limit
of 16 within the emulation, without checking sve_max_vq at all. So I like
the suggestion for a build bug like the one this patch adds, because
otherwise we have 16 in two separate places; the ARM_MAX_VQ definition
and the '& 0xf'.

> 
> I haven't tried to understand all the code in the series beyond the
> user/kernel interactions, so maybe I was just paranoid.

Paranoia is good for the soul. Or something like that...

Thanks,
drew

