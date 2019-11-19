Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCE6C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0936222CD
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0936222CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX5iL-0007jV-Tg
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 10:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iX5hI-00079l-Qo
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:45:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iX5hH-0007nX-J9
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:45:44 -0500
Received: from 7.mo179.mail-out.ovh.net ([46.105.61.94]:37239)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iX5hH-0007mj-DM
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:45:43 -0500
Received: from player746.ha.ovh.net (unknown [10.108.35.13])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 9CA2114B237
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 16:45:39 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player746.ha.ovh.net (Postfix) with ESMTPSA id 3B595C61C771;
 Tue, 19 Nov 2019 15:45:29 +0000 (UTC)
Date: Tue, 19 Nov 2019 16:45:26 +0100
From: Greg Kurz <groug@kaod.org>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] spapr: Fix VSMT mode when it is not supported by the
 kernel
Message-ID: <20191119164526.0e980a37@bahia.lan>
In-Reply-To: <caa35299-c928-a968-83b5-842d000f0242@redhat.com>
References: <20191108154035.12913-1-lvivier@redhat.com>
 <20191108174759.2d4040f1@bahia.lan>
 <20191119010012.GI5582@umbus.fritz.box>
 <caa35299-c928-a968-83b5-842d000f0242@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1018657941744949542
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegkedgkeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdduleehrddvuddvrddvledrudeiieenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeegiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.61.94
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
Cc: =?UTF-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org,
 clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 Nov 2019 15:06:51 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

> On 19/11/2019 02:00, David Gibson wrote:
> > On Fri, Nov 08, 2019 at 05:47:59PM +0100, Greg Kurz wrote:
> >> On Fri,  8 Nov 2019 16:40:35 +0100
> >> Laurent Vivier <lvivier@redhat.com> wrote:
> >>
> >>> Commit 29cb4187497d sets by default the VSMT to smp_threads,
> >>> but older kernels (< 4.13) don't support that.
> >>>
> >>> We can reasonably restore previous behavior with this kernel
> >>> to allow to run QEMU as before.
> >>>
> >>> If VSMT is not supported, VSMT will be set to MAX(8, smp_threads)
> >>> as it is done for previous machine types (< pseries-4.2)
> >>>
> >>
> >> It is usually _bad_ to base the machine behavior on host capabilities.
> >> What happens if we migrate between an older kernel and a recent one ?
> > 
> > Right.  We're really trying to remove instaces of such behaviour.  I'd
> > prefer to completely revert Greg's original patch than to re-introduce
> > host configuration dependency into the guest configuration..
> > 
> >> I understand this is to fix tests/migration-test on older kernels.
> >> Couldn't this be achieved with migration-test doing some introspection
> >> and maybe pass vsmt=8 on the QEMU command line ?
> > 
> > ..adjusting the test case like this might be a better idea, though.
> > 
> > What's the test setup where we're using the old kernel?  I really only
> > applied the original patch on the guess that we didn't really care
> > about kernels that old.  The fact you've hit this in practice makes me
> > doubt that assumption.
> > 
> 
> The way to fix the tests is to add "-smp threads=8" on the command line
> (for all tests, so basically in qtest_init_without_qmp_handshake(), and
> it will impact all the machine types), and we have to check if it is

Ohhh... it isn't possible to initialize Qtest with machine specific
properties ? That's a bit unfortunate :-\

> ppc64/pseries to do that, and there it becomes a little bit complicated
> for a so small piece of code.
> 
> So I think the best to do is to revert Greg's patch.
> 

I'm okay with that since this patch doesn't bring much for the moment.

But soon, ie. linux-5.5 hopefully, KVM will allow to configure the number
of presenters in the XIVE and XICS-on-XIVE devices on POWER9. Combined
with this patch, it will allow to drastically reduce the consumption of
resources in the XIVE HW, which currently limits the number of VMs that
can run concurrently with an in-kernel irqchip. So I hope the 'make check'
you're willing to fix is worth it :-), and BTW you didn't answer David's
question about the test setup.

Cheers,

--
Greg

> Thanks,
> Laurent
> 


