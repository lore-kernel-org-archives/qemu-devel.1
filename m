Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815B6C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D722077C
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D722077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hngCJ-00083p-JH
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 05:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34892)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1hngC8-0007Yn-MW
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1hngC7-0000KP-Ou
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:25:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53038)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1hngC5-0000Iv-HZ; Wed, 17 Jul 2019 05:25:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A3A22302245A;
 Wed, 17 Jul 2019 09:25:48 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0B2660BE2;
 Wed, 17 Jul 2019 09:25:44 +0000 (UTC)
Date: Wed, 17 Jul 2019 11:25:42 +0200
From: Andrew Jones <drjones@redhat.com>
To: Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190717092542.hkzcukvc3bwgvvk5@kamzik.brq.redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-11-drjones@redhat.com>
 <1e0bc93f-42e3-087f-a4b5-d356879cb806@linaro.org>
 <20190627105911.GD2790@e103592.cambridge.arm.com>
 <3e935f36-1065-b82e-86e0-f3e4cd11f95e@linaro.org>
 <20190627150224.GH2790@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627150224.GH2790@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 17 Jul 2019 09:25:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 10/14] target/arm/kvm64: Add
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 04:02:24PM +0100, Dave Martin wrote:
> Either way, it's entirely reasonable for userspace not to try to support
> additional slices for now.  We'll have plenty of time to plan away
> across that bridge when we spot it on the horizon...

Which makes me inclined to keep the get/put register code the way it is
in this patch, at least with regards to the hard coded number of slices
and the build-bug. The way it's written (to me) serves to document the
state of things, rather than truly implement anything, but also (to me)
it's easier to understand that code than would be a couple of paragraphs
of actual documentation trying to explain it.

> > Within QEMU, it has so far made sense to keep the data in 64-bit hunks in
> > host-endian order.  That's how the AdvSIMD code was written originally, and it
> > turned out to be easy enough to continue that for SVE.
> 
> Fair enough.  It's entirely up to QEMU to decide -- I just wanted to
> check that there was no misunderstanding about this issue in the ABI.

We do need to use/swap-to host-endian when we implement the monitor's
dump-guest-memory command, at it also creates ELF notes for the general
and VFP (and, coming soon, SVE) registers. Implementing those ELF notes
for SVE is on my TODO, right after this series.

Thanks,
drew

