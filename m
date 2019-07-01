Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E28C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 20:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3785220665
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 20:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3785220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45199 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi32g-00063p-CZ
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 16:36:50 -0400
Received: from [2001:470:142:3::10] (port=54307 helo=eggs.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hi2yo-0003ZL-FV
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hi2ya-0002Lw-D6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:32:43 -0400
Received: from [209.132.183.28] (port=47844 helo=mx1.redhat.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hi2ya-0002HC-6x
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:32:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6A363316291C
 for <qemu-devel@nongnu.org>; Mon,  1 Jul 2019 20:14:39 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34415379F;
 Mon,  1 Jul 2019 20:14:32 +0000 (UTC)
Date: Mon, 1 Jul 2019 15:34:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190701183451.GF5198@habkost.net>
References: <20190628150217.32659-1-wainersm@redhat.com>
 <20190628150217.32659-4-wainersm@redhat.com>
 <20190628201846.GK1862@habkost.net>
 <20190630173933.GB2820@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190630173933.GB2820@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 01 Jul 2019 20:14:39 +0000 (UTC)
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

On Sun, Jun 30, 2019 at 01:39:33PM -0400, Cleber Rosa wrote:
> On Fri, Jun 28, 2019 at 05:18:46PM -0300, Eduardo Habkost wrote:
> > On Fri, Jun 28, 2019 at 11:02:17AM -0400, Wainer dos Santos Moschetta wrote:
> > > Until now the suite of acceptance tests doesn't exercise
> > > QEMU with kvm enabled. So this introduces a simple test
> > > that boots the Linux kernel and checks it boots on the
> > > accelerator correctly.
> > > 
> > > Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> > 
> > Why not just change the existing test_x86_64_pc() test case to
> > use KVM by default?  We can use "accel=kvm:tcg" to allow it to
> > fall back to TCG if KVM is not available.
> > 
> > -- 
> > Eduardo
> 
> I though of something similar, but not exactly the same.  An example
> can be seen here:
> 
>   https://travis-ci.org/clebergnu/qemu/jobs/551437429#L3350
> 
> IMO, it's a good practice to be able to briefly describe what a test
> does, given its name.  It's also very important for the test to
> attempt to exercise the same behavior across executions.
> 
> I'm saying that because I don't think we should fallback to TCG if KVM
> is not available, but instead, have two different tests that do each a
> simpler and more predictable set of checks.  This would make it
> simpler to find KVM issues when a given test fails but the TCG
> continues to pass.  The tags (and other mechanisms) can be used to
> select the tests that a given job should run though.

Agreed that kvm:tcg fallback I suggested isn't a good idea.
However, do we really want to require a separate test method to
be written just because we want to use a different accelerator or
other QEMU option?

This patch may be the simplest solution short term, but can we
have something that doesn't require so much code duplication and
boilerplate code in the future?

-- 
Eduardo

