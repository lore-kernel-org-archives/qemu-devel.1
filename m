Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC77EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57B625313
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57B625313
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSNiU-0003lh-UO
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 13:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kSNhi-0003Iq-P1
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 13:03:14 -0400
Received: from relay64.bu.edu ([128.197.228.104]:38153)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kSNhg-0007L6-PD
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 13:03:14 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 09DH2Kdk012845
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 13 Oct 2020 13:02:25 -0400
Date: Tue, 13 Oct 2020 13:02:20 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH] fuzz: Disable QEMU's signal handlers
Message-ID: <20201013170220.h5a25lpaqpgslzug@mozz.bu.edu>
References: <20201013152920.448335-1-alxndr@bu.edu> <m2r1q2m5nm.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2r1q2m5nm.fsf@oracle.com>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 11:31:40
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.44, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 201013 1750, Darren Kenny wrote:
> Hi Alex,
> 
> This mentions the use of atexit() to perform some cleanup, but I'm not
> seeing that being added here, should it be?
> 

That sentence was not clear.. I meant that the developer can
(optionally) use atexit when writing a new fuzz-target to perform
cleanup. For example see:
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg03735.html
It would be nice to clean-up the drive files created in that fuzzer with
atexit. However, right now that will not do any good, since clean exit
signals are ignored.
-Alex

> Thanks,
> 
> Darren.
> 
> On Tuesday, 2020-10-13 at 11:29:20 -04, Alexander Bulekov wrote:
> > With the fuzzer, we never call main_loop_should_exit, since we manually
> > call main_loop_wait. This means that the only way to terminate the
> > fuzzer is with SIGKILL. Disable the signal handlers, so there are
> > reasonable ways to terminate the fuzzer and use atexit() to clean-up
> > after the fuzzer.
> >
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > ---
> >  tests/qtest/fuzz/fuzz.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> > index d926c490c5..eb0070437f 100644
> > --- a/tests/qtest/fuzz/fuzz.c
> > +++ b/tests/qtest/fuzz/fuzz.c
> > @@ -217,5 +217,13 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
> >      /* re-enable the rcu atfork, which was previously disabled in qemu_init */
> >      rcu_enable_atfork();
> >  
> > +    /*
> > +     * Disable QEMU's signal handlers, since we manually control the main_loop,
> > +     * and don't check for main_loop_should_exit
> > +     */
> > +    signal(SIGINT, SIG_DFL);
> > +    signal(SIGHUP, SIG_DFL);
> > +    signal(SIGTERM, SIG_DFL);
> > +
> >      return 0;
> >  }
> > -- 
> > 2.28.0

