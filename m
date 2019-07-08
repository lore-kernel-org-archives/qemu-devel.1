Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A64C606AF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 12:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D60120665
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 12:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D60120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkT1c-00081Y-I4
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 08:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40008)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hkT0E-00071Z-3P
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 08:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hkT0C-0002qX-S0
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 08:44:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hkT0C-0002pj-Ll
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 08:44:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 50838307D923;
 Mon,  8 Jul 2019 12:44:13 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12DF25D70D;
 Mon,  8 Jul 2019 12:44:10 +0000 (UTC)
Date: Mon, 8 Jul 2019 14:44:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190708144410.23de5e70@redhat.com>
In-Reply-To: <CAFEAcA-sJ0VDvxUgWO6H6E1kgCU8RVrygcJYpbk_341wwW+H2A@mail.gmail.com>
References: <20190705221504.25166-1-ehabkost@redhat.com>
 <CAFEAcA-sJ0VDvxUgWO6H6E1kgCU8RVrygcJYpbk_341wwW+H2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 08 Jul 2019 12:44:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL v6 00/42] Machine and x86 queue, 2019-07-05
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 8 Jul 2019 10:26:05 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 5 Jul 2019 at 23:15, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> > Changes v5 -> v6:
> > * Rebase and solve conflicts with other pull requests
> >   (for the 4th time)
> > * Included Cascadelake-Server-v2 update
> >
> > Changes v4 -> v5:
> > * Rebase and solve conflicts with commit 374f63f6810a ("Merge remote-tracking
> >   branch 'remotes/armbru/tags/pull-monitor-2019-07-02-v2' into staging")
> >
> > Changes v3 -> v4:
> > * Fix ppc64 "make check" failure
> >
> > Changes v2 -> v3:
> > * Fix "make check" warnings (Igor Mammedov)
> > * Fix conflicts of "hw/arm: Replace global smp variables with
> >   machine smp properties" with recent arm changes (Eduardo Habkost)
> > * x86 versioned CPU models (Eduardo Habkost)
> > * SnowRidge CPU model (Paul Lai)
> > * Add deprecation information to query-machines (Eduardo Habkost)
> >
> > Changes v1 -> v2:
> > * Fix s390x build failure
> >
> > The following changes since commit d2c5f91ca944aaade642624397e1853801bbc744:
> >
> >   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-07-05 16:16:15 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
> >
> > for you to fetch changes up to af135030e3405af5ce234a9f92cf8cc4e55fec96:
> >
> >   tests: use -numa memdev option in tests instead of legacy 'mem' option (2019-07-05 17:12:45 -0300)
> >
> > ----------------------------------------------------------------
> > Machine and x86 queue, 2019-07-05
> >
> > * CPU die topology support (Like Xu)
> > * Deprecation of features (Igor Mammedov):
> >   * 'mem' parameter of '-numa node' option
> >   * implict memory distribution between NUMA nodes
> >   * deprecate -mem-path fallback to anonymous RAM
> > * x86 versioned CPU models (Eduardo Habkost)
> > * SnowRidge CPU model (Paul Lai)
> > * Add deprecation information to query-machines (Eduardo Habkost)
> > * Other i386 fixes
> >  
> 
> 
> Applied, thanks.
> 
> Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
> for any user-visible changes.
Updated "Miscellaneous" + "New deprecated options and features"
with NUMA related changes.

> 
> -- PMM
> 


