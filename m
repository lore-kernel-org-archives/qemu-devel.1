Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8133C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 16:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8497220652
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 16:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8497220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52816 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfRXK-00027j-Qx
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 12:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53440)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Dave.Martin@arm.com>) id 1hfRR7-0006Rg-3U
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 12:03:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Dave.Martin@arm.com>) id 1hfRR6-0007dd-1Y
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 12:03:16 -0400
Received: from foss.arm.com ([217.140.110.172]:52750)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <Dave.Martin@arm.com>)
 id 1hfRR3-0007ad-Hw; Mon, 24 Jun 2019 12:03:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DE2B2B;
 Mon, 24 Jun 2019 09:03:12 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C67833F71E;
 Mon, 24 Jun 2019 09:03:10 -0700 (PDT)
Date: Mon, 24 Jun 2019 17:03:08 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Andrew Jones <drjones@redhat.com>
Message-ID: <20190624160308.GT2790@e103592.cambridge.arm.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-6-drjones@redhat.com>
 <20190624110507.GG2790@e103592.cambridge.arm.com>
 <20190624113037.m5onedluc4x7c5ej@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624113037.m5onedluc4x7c5ej@kamzik.brq.redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.140.110.172
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

On Mon, Jun 24, 2019 at 12:30:37PM +0100, Andrew Jones wrote:
> On Mon, Jun 24, 2019 at 12:05:07PM +0100, Dave Martin wrote:
> > On Fri, Jun 21, 2019 at 05:34:13PM +0100, Andrew Jones wrote:
> > 
> > The purpose of this check should probably at least be described in a
> > comment -- i.e., what actually depends on this?
> 
> I was thinking the already present "Bits other than [3:0] are RAZ/WI."
> explained that, but how about this for an improvement?
> 
> /*
>  * Only the lowest 4 bits of ZCR_ELx may be used to constrain the vector
>  * length, the rest of the bits are RAZ/WI. Since the vector length of
>  * 128-bits (1 in quadwords) is represented as zero in ZCR_ELx, and all
>  * vector lengths are represented as their length in quadwords minus 1,
>  * then four bits allow up to quadword 16 to be selected.
>  */

No, maybe the existing comment is enough.

I thought there might be more code elsewhere that assumes that checks
sve_max_vq <= ARM_MAX_VQ then then assumes that sve_max_vq <= 16.  But
if not, we probably don't need an additional comment here.

I haven't tried to understand all the code in the series beyond the
user/kernel interactions, so maybe I was just paranoid.

[...]

Cheers
---Dave

