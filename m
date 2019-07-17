Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B007EC76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:14:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F2F2077C
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F2F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnf4r-0005ed-QU
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 04:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40837)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1hnf4g-00058d-EN
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1hnf4f-0006t3-FO
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:14:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1hnf4d-0006lu-2W; Wed, 17 Jul 2019 04:14:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A5C1308338E;
 Wed, 17 Jul 2019 08:14:01 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 152EB5C232;
 Wed, 17 Jul 2019 08:13:56 +0000 (UTC)
Date: Wed, 17 Jul 2019 10:13:54 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190717081354.adoflwxpvxxt7iwi@kamzik.brq.redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-8-drjones@redhat.com>
 <be805987-250d-93a7-7d11-5204f0e16e7b@linaro.org>
 <20190628072739.5t2o2yqaejn6pyd5@kamzik.brq.redhat.com>
 <4e7e78a6-1e6f-4190-4b15-12f443d9be78@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e7e78a6-1e6f-4190-4b15-12f443d9be78@linaro.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 17 Jul 2019 08:14:01 +0000 (UTC)
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

On Sat, Jun 29, 2019 at 02:10:28AM +0200, Richard Henderson wrote:
> On 6/28/19 9:27 AM, Andrew Jones wrote:
> > Also, while it's true we can always
> > get the max vq with next-smaller(ARM_MAX_VQ + 1), having it cached in
> > cpu->sve_max_vq is convenient. That said, I think we'd rather keep it.
> 
> When is it convenient, and for what?

It's used for the upper boundary in several loops in target/arm/kvm64.c

> 
> Certainly the only thing that we check after boot is the largest enabled vq not
> larger than x.  And for that I don't see that sve_max_vq is relevant at all.
> 
> Oh, something that we should also think about is -cpu foo, where foo is one of
> the Fujitsu thingumies.  We should be able to default sve_vq_map to that which
> a real bit of hw actually supports.  I, for one, welcome our typedef long
> overlords.  ;-)

I don't think we need to implement an A64FX cpu model with this series,
although that's a nice idea for people that focus on TCG to do as a
follow-up series. This series fully enables the guest to use SVE on the
A64FX when KVM is enabled, without the need to special case it in any way.

Thanks,
drew

