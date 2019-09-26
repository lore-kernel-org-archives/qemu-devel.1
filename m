Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C4FC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 10:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078B0217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 10:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078B0217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDQeK-0000D0-Vn
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 06:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iDQcu-0007Zm-9g
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iDQct-0006kM-59
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:03:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iDQcs-0006kD-VU
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:03:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 26CAFC00A167;
 Thu, 26 Sep 2019 10:03:54 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD5CF60BE0;
 Thu, 26 Sep 2019 10:03:52 +0000 (UTC)
Message-ID: <a1997ec01e04140193c099c50105f8527848b868.camel@redhat.com>
Subject: Re: Questions about the real mode in kvm/qemu
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Li Qiang <liq3ea@gmail.com>
Date: Thu, 26 Sep 2019 13:03:51 +0300
In-Reply-To: <4a8d36ed-4a3b-fd12-303d-fc1ee50b2980@redhat.com>
References: <CAKXe6SJfZt8WcA43Vsh0=GT=jBedcAOUx9DNGZ4Bsvi10oCkog@mail.gmail.com>
 <644968ffb11c11fd580e96c1e67932501a633fe4.camel@redhat.com>
 <CAKXe6SK+cEytTtgKHw8KXY=jY4xv=27GBu55hTbTmbRyTPsfxg@mail.gmail.com>
 <3d3f3a0e6e796260348c66e69e859e1901501ee8.camel@redhat.com>
 <23789310-35fb-8c93-44f4-532bcd34007d@redhat.com>
 <7c019f3a5236daaa79e67467f64cde212ad05f35.camel@redhat.com>
 <4ed0f9ca-6cd1-fd8e-9abd-4098f85c7f9d@redhat.com>
 <f8a138f8c00df4886045d6771415336a7e43b887.camel@redhat.com>
 <4a8d36ed-4a3b-fd12-303d-fc1ee50b2980@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 26 Sep 2019 10:03:54 +0000 (UTC)
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
Cc: Qemu Developers <qemu-devel@nongnu.org>, Avi Kivity <avi.kivity@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-09-26 at 12:00 +0200, Paolo Bonzini wrote:
> On 26/09/19 11:41, Maxim Levitsky wrote:
> > > Thinking more about it, I suppose that saves memory (the same EPT page
> > > tables can now be used independent of guest CR0.PG), at the cost of
> > > making TLB misses a little slower.
> > 
> > Don't really understand what you mean. 
> > Isn't this always the case that EPT and guest paging
> > are independent (at least when no nesting is involved)?
> 
> There are two possibilities:
> 
> 1) emulate CR0.PG=0 with EPT + identity page
> 
> - advantage: the EPT pages will be reused once the guest sets CR0.PG=1
> 
> - disadvantage: TLB misses have to walk two levels of page tables
> 
> 2) emulate CR0.PG=0 with EPT disabled.  Similar to ept=0, CR3 will point
> to PAE page tables that do the HVA->GPA transition.
> 
> - advantage: faster TLB misses
> 
> - disadvantage: need to build separate page tables for CR0.PG=1 (EPT
> format) and CR0.PG=0 (PAE format), need to "waste" 4k of GPA space for
> the identity map
Thanks for the explanation!

Best regards,
	Maxim Levitsky





