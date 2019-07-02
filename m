Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D462FC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:48:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE9921473
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE9921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiHGy-0006Fk-Uy
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 07:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34475)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hiHDW-0004ZE-1M
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hiHDT-0007F3-I1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:44:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49550)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hiHDT-0007E8-Bl
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:44:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC2283082B6B;
 Tue,  2 Jul 2019 11:44:54 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E63B1001DD1;
 Tue,  2 Jul 2019 11:44:53 +0000 (UTC)
Date: Tue, 2 Jul 2019 13:44:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190702134449.2b190981@redhat.com>
In-Reply-To: <CAFEAcA8Jnh=tu8s08Fu6n0sSmJJuVOx7YxyTR_ni5yW3DdMFkQ@mail.gmail.com>
References: <20190628184742.5961-1-ehabkost@redhat.com>
 <CAFEAcA8Jnh=tu8s08Fu6n0sSmJJuVOx7YxyTR_ni5yW3DdMFkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 02 Jul 2019 11:44:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL v2 00/29] Machine and x86 queue, 2019-06-28
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

On Tue, 2 Jul 2019 11:48:01 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 28 Jun 2019 at 19:47, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> > Changes v1 -> v2:
> > * Fix s390x build failure
> >
> > The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:
> >
> >   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
> >
> > for you to fetch changes up to b701bfd0634f24551449856cdc56fd13f35bd1f6:
> >
> >   vl.c: Add -smp, dies=* command line support and update doc (2019-06-28 15:34:12 -0300)
> >
> > ----------------------------------------------------------------
> > Machine and x86 queue, 2019-06-28
> >
> > * CPU die topology support (Like Xu)
> > * Deprecation of features (Igor Mammedov):
> >   * 'mem' parameter of '-numa node' option
> >   * implict memory distribution between NUMA nodes
> >   * deprecate -mem-path fallback to anonymous RAM
> > * Other i386 fixes  
> 
> Hi. This fills my build logs with warnings during 'make check':
> 
> qemu-system-i386: warning: Default splitting of RAM between nodes is
> deprecated, Use '-numa node,memdev' to explictly define RAM allocation
> per node
> qemu-system-i386: warning: Default splitting of RAM between nodes is
> deprecated, Use '-numa node,memdev' to explictly define RAM allocation
> per node
> qemu-system-i386: -numa node,mem=128: warning: Parameter -numa
> node,mem is deprecated, use -numa node,memdev instead
> qemu-system-i386: -numa node,mem=32M,nodeid=0: warning: Parameter
> -numa node,mem is deprecated, use -numa node,memdev instead
> qemu-system-i386: -numa node,mem=32M,nodeid=1: warning: Parameter
> -numa node,mem is deprecated, use -numa node,memdev instead
> qemu-system-i386: -numa node,mem=32M,nodeid=2: warning: Parameter
> -numa node,mem is deprecated, use -numa node,memdev instead
> qemu-system-i386: -numa node,mem=32M,nodeid=3: warning: Parameter
> -numa node,mem is deprecated, use -numa node,memdev instead
> [etc etc for hundreds of instances]
> 
> Can you either fix the tests not to warn or arrange for the warnings
> to be suppressed, please?
My bad,
 I'll prepare a patch to fix tests shortly

> 
> thanks
> -- PMM


