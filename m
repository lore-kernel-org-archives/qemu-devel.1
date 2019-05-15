Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D41C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 08:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9BA20675
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 08:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9BA20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33111 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQouW-0007pL-VG
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 04:05:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1hQotX-0007TJ-75
	for qemu-devel@nongnu.org; Wed, 15 May 2019 04:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1hQotW-0003b8-3e
	for qemu-devel@nongnu.org; Wed, 15 May 2019 04:04:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>)
	id 1hQotO-0003Hi-IF; Wed, 15 May 2019 04:04:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91FC3307E04E;
	Wed, 15 May 2019 08:04:01 +0000 (UTC)
Received: from kinshicho (unknown [10.43.2.73])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E2FBA19C69;
	Wed, 15 May 2019 08:03:59 +0000 (UTC)
Message-ID: <a24b6d34b99835ea38b021896a57c7af8bf4747c.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, Andrew Jones
	<drjones@redhat.com>
Date: Wed, 15 May 2019 10:03:58 +0200
In-Reply-To: <1cd94ba6-2bfa-645e-1034-dd05e8a77000@linaro.org>
References: <20190512083624.8916-1-drjones@redhat.com>
	<9f57bfa56715b3128c1823150457ddb866e6054c.camel@redhat.com>
	<20190513123656.6iu7ebu7zucn5mxt@kamzik.brq.redhat.com>
	<e38aac8cb33c5782499b4ca0356c43267f05dc5e.camel@redhat.com>
	<20190514125329.mi7ctaoujirwm6gs@kamzik.brq.redhat.com>
	<1857a74ef586a4e41d93b184498cfcf6c2927cec.camel@redhat.com>
	<1cd94ba6-2bfa-645e-1034-dd05e8a77000@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 15 May 2019 08:04:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 00/13] target/arm/kvm: enable SVE in guests
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, armbru@redhat.com,
	qemu-arm@nongnu.org, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-05-14 at 13:14 -0700, Richard Henderson wrote:
> On 5/14/19 9:03 AM, Andrea Bolognani wrote:
> > On Tue, 2019-05-14 at 14:53 +0200, Andrew Jones wrote:
> > > We already have sve-max-vq, so I'm not sure we want to rename it.
> > 
> > Oh, I didn't realize that was the case. And of course it already
> > takes a number of quadwords as argument, I suppose? That's pretty
> > unfortunate :(
> > 
> > Perhaps we could consider deprecating it in favor of a user-friendly
> > variant that's actually suitable for regular humans, like the one I
> > suggest above?
> 
> Why is =4 less user-friendly than =512?
> 
> I don't actually see "total bits in vector" as more user-friendly than "number
> of quadwords" when it comes to non-powers-of-2 like =7 vs =896 or =13 vs =1664.

I would wager most people are intimately familiar with bits, bytes
and multiples due to having to work with them daily. Quadwords, not
so much.

-- 
Andrea Bolognani / Red Hat / Virtualization


