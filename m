Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B521AC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 19:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912C12075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 19:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912C12075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37438 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heOrH-0006oQ-LN
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 15:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48086)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1heOpt-0006Db-Uz
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 15:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1heOpr-0006c0-V5
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 15:04:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53000)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1heOpn-0006XH-BH; Fri, 21 Jun 2019 15:04:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CF516308A968;
 Fri, 21 Jun 2019 19:04:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-204.rdu2.redhat.com
 [10.10.120.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BC495C21A;
 Fri, 21 Jun 2019 19:04:22 +0000 (UTC)
Date: Fri, 21 Jun 2019 15:04:21 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190621190421.GA679@localhost.localdomain>
References: <20190620222314.2670-1-wainersm@redhat.com>
 <CAFEAcA92m9n7FR2a6=ecnr5bn-Sq97LZRxHRuzWO-OcbdgA4fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA92m9n7FR2a6=ecnr5bn-Sq97LZRxHRuzWO-OcbdgA4fw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 21 Jun 2019 19:04:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v2 PATCH] hw/arm/virt: makes virt a default
 machine type
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 21, 2019 at 11:33:10AM +0100, Peter Maydell wrote:
> On Thu, 20 Jun 2019 at 23:23, Wainer dos Santos Moschetta
> <wainersm@redhat.com> wrote:
> > I came across this when running the acceptance tests in an aarch64 host.
> > The arch-independent tests fail because, in general, they don't set a
> > machine type. In order to avoid treating arm targets as special cases
> > on avocado_qemu framework I prefered to attempt to promote virt as
> > default for ARM emulation. Moreover since it represents a generic hardware
> > and its used is broaden advised [1], I found it the right choice.
> 
> Not providing a default machine type for Arm is a deliberate
> choice: there is no single right answer and the user has
> to decide what their preference is. We used to have a default
> machine type set, and it caused a lot of user confusion as
> they expected Arm to be like x86 where everything will run
> fine on the default machine type and it did not, which is
> why we switched to not having a default.
> 
> thanks
> -- PMM

The experience acquired here deserves the highest consideration, but I
can't help myself to wonder if this isn't one of the (conceptual)
reasons for parameters such as '-nodefaults'.  I know QEMU doesn't
promise the same behavior across different targets, but that could
improve considerably with very cheap actions.

You can consider me biased (I do consider myself), but trying to wear
the hat of a user first interacting with QEMU, I would expect a (any)
reasonably capable environment that can represent the given target.
That will probably be a different environment than the one I may need,
and I think that's fine.

Now on the functional testing side, this means less code adjusting to
the specifics of each target, and overall, more test code that could
be reused across different targets.  I believe the same to be true
for management layer code.

Anyway, it'd be nice to just double check if keeping things as they
are is in this specific aspect is a firm yes.  If so, tests (and
management layers) will (continue to) have to adapat.

Best,
- Cleber.

