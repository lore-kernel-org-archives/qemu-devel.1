Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDB7C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B702251F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B702251F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXPPN-0003Ri-OX
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:48:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iXPOR-0002nd-7X
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:47:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iXPOP-0004P8-UU
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:47:35 -0500
Received: from 14.mo7.mail-out.ovh.net ([178.33.251.19]:55930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iXPOP-0004OK-N9
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:47:33 -0500
Received: from player730.ha.ovh.net (unknown [10.108.57.139])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id D491213F89F
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 13:47:30 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player730.ha.ovh.net (Postfix) with ESMTPSA id 9A354C32ACCD;
 Wed, 20 Nov 2019 12:47:21 +0000 (UTC)
Date: Wed, 20 Nov 2019 13:47:20 +0100
From: Greg Kurz <groug@kaod.org>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] spapr: Fix VSMT mode when it is not supported by the
 kernel
Message-ID: <20191120134720.3221a6f4@bahia.lan>
In-Reply-To: <0c1f57ac-0823-4268-429b-d1aee8f7f8d5@redhat.com>
References: <20191108154035.12913-1-lvivier@redhat.com>
 <20191108174759.2d4040f1@bahia.lan>
 <20191119010012.GI5582@umbus.fritz.box>
 <caa35299-c928-a968-83b5-842d000f0242@redhat.com>
 <20191119164526.0e980a37@bahia.lan>
 <20191120043653.GG5582@umbus.fritz.box>
 <cb8f7dc7-d6db-6bd9-e825-1ade7d89cdd9@redhat.com>
 <0c1f57ac-0823-4268-429b-d1aee8f7f8d5@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3882665832943491366
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehtddggeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeftddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.251.19
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

On Wed, 20 Nov 2019 12:28:19 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

> On 20/11/2019 10:00, Laurent Vivier wrote:
> > On 20/11/2019 05:36, David Gibson wrote:
> >> On Tue, Nov 19, 2019 at 04:45:26PM +0100, Greg Kurz wrote:
> >>> On Tue, 19 Nov 2019 15:06:51 +0100
> >>> Laurent Vivier <lvivier@redhat.com> wrote:
> >>>
> >>>> On 19/11/2019 02:00, David Gibson wrote:
> >>>>> On Fri, Nov 08, 2019 at 05:47:59PM +0100, Greg Kurz wrote:
> >>>>>> On Fri,  8 Nov 2019 16:40:35 +0100
> >>>>>> Laurent Vivier <lvivier@redhat.com> wrote:
> >>>>>>
> >>>>>>> Commit 29cb4187497d sets by default the VSMT to smp_threads,
> >>>>>>> but older kernels (< 4.13) don't support that.
> >>>>>>>
> >>>>>>> We can reasonably restore previous behavior with this kernel
> >>>>>>> to allow to run QEMU as before.
> >>>>>>>
> >>>>>>> If VSMT is not supported, VSMT will be set to MAX(8, smp_threads)
> >>>>>>> as it is done for previous machine types (< pseries-4.2)
> >>>>>>>
> >>>>>>
> >>>>>> It is usually _bad_ to base the machine behavior on host capabilities.
> >>>>>> What happens if we migrate between an older kernel and a recent one ?
> >>>>>
> >>>>> Right.  We're really trying to remove instaces of such behaviour.  I'd
> >>>>> prefer to completely revert Greg's original patch than to re-introduce
> >>>>> host configuration dependency into the guest configuration..
> >>>>>
> >>>>>> I understand this is to fix tests/migration-test on older kernels.
> >>>>>> Couldn't this be achieved with migration-test doing some introspection
> >>>>>> and maybe pass vsmt=8 on the QEMU command line ?
> >>>>>
> >>>>> ..adjusting the test case like this might be a better idea, though.
> >>>>>
> >>>>> What's the test setup where we're using the old kernel?  I really only
> >>>>> applied the original patch on the guess that we didn't really care
> >>>>> about kernels that old.  The fact you've hit this in practice makes me
> >>>>> doubt that assumption.
> >>>>>
> >>>>
> >>>> The way to fix the tests is to add "-smp threads=8" on the command line
> >>>> (for all tests, so basically in qtest_init_without_qmp_handshake(), and
> >>>> it will impact all the machine types), and we have to check if it is
> >>>
> >>> Ohhh... it isn't possible to initialize Qtest with machine specific
> >>> properties ? That's a bit unfortunate :-\
> >>
> >> Uhh... I don't see why we can't.  Couldn't we just put either -machine
> >> vsmt=8 or -smp 8 into the cmd_src / cmd_dst printfs() in the
> >> strcmp(arch, "ppc64") case?
> > 
> > Yes, but we need to do that to all other tests that fail. test-migration
> > is not the only one impacted by the problem (we have also pxe-test), so
> > it's why I thought to fix the problem in a generic place.
> > 
> > But it seems there are only this couple of tests that are impacted so I
> > can modify both instead. I think only tests that really start CPU have
> > the problem.
> > 
> > I'm going to send a patch to fix that.
> 
> And again, it's a little bit more complicated than expected: setting
> vsmt to 8 works only with kvm_hv, but breaks in case of TCG or kvm_pr.
> So the test must check what is in use...
> 

AFAICT, migration-test explicitly skip tests if kvm_hv isn't present.

    /*
     * On ppc64, the test only works with kvm-hv, but not with kvm-pr and TCG
     * is touchy due to race conditions on dirty bits (especially on PPC for
     * some reason)
     */
    if (g_str_equal(qtest_get_arch(), "ppc64") &&
        access("/sys/module/kvm_hv", F_OK)) {
        g_test_message("Skipping test: kvm_hv not available");
        return g_test_run();
    }

and I don't see any error in pxe-test if I force tcg and vsmt=8.

What error do you see with your testing ?

> Thanks,
> Laurent
> 


