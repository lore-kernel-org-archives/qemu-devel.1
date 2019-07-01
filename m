Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5D2C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C7220B7C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C7220B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi2zA-0003UK-B1
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 16:33:12 -0400
Received: from [2001:470:142:3::10] (port=54052 helo=eggs.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hi2wy-0002bk-3L
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hi2wf-00022Q-Mg
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:30:47 -0400
Received: from [209.132.183.28] (port=37542 helo=mx1.redhat.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hi2wf-0001y2-GW
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:30:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6D8E85D5E6
 for <qemu-devel@nongnu.org>; Mon,  1 Jul 2019 20:30:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-124-195.rdu2.redhat.com
 [10.10.124.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5F984250;
 Mon,  1 Jul 2019 20:29:46 +0000 (UTC)
Date: Mon, 1 Jul 2019 16:29:44 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190701202910.GA26789@localhost.localdomain>
References: <20190628150217.32659-1-wainersm@redhat.com>
 <20190628150217.32659-4-wainersm@redhat.com>
 <20190628201846.GK1862@habkost.net>
 <20190630173933.GB2820@localhost.localdomain>
 <20190701183451.GF5198@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701183451.GF5198@habkost.net>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 01 Jul 2019 20:30:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] tests/acceptance: Add boot linux with
 kvm test
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
Cc: philmd@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 01, 2019 at 03:34:51PM -0300, Eduardo Habkost wrote:
> 
> Agreed that kvm:tcg fallback I suggested isn't a good idea.
> However, do we really want to require a separate test method to
> be written just because we want to use a different accelerator or
> other QEMU option?
>

No, in the short term we want to have tests that can respond to a
number of well known parameters, such as "accel".  But to actually
have tests (names) that are meaningful enough, we need to:

 1) Add a varianter implementation (or usage)
 2) Drop the duplicate tests

#1 is needed because:

 a) it doesn't feel right to name tests based on simple command
    line parameters (the ones given with -p, say, "-p accel=kvm"
    will add to the test name "accel_kvm".

 b) a variant *name* is added to the test ID, which then can be
    kept consistent.

Then we can proceed to #2, and drop the duplicate tests, say:

 - test_x86_64_pc, test_x86_64_pc_kvm => test_x86_64_pc

On a further iteration, it may even make sense to consolidate:

 - test_x86_64_pc, test_x86_64_q35 => test_x86_64

Time will tell.

> This patch may be the simplest solution short term, but can we
> have something that doesn't require so much code duplication and
> boilerplate code in the future?

Yes, the new implementation of the Varianter CIT is now generally
available on Avocado 70.0, so I'm working on a file that hopefully
will suite the acceptance tests.

> 
> -- 
> Eduardo

Best,
- Cleber.

