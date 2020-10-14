Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F182EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CAD92173E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAD92173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSh2X-0005BM-5h
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 09:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kSh1T-0004LG-P4
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 09:40:55 -0400
Received: from relay68.bu.edu ([128.197.228.73]:59257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kSh1R-0007I1-CG
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 09:40:54 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 09EDeNR6023389
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 14 Oct 2020 09:40:27 -0400
Date: Wed, 14 Oct 2020 09:40:23 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH] fuzz: Disable QEMU's signal handlers
Message-ID: <20201014134023.l3ubsuvn3hpgnkvd@mozz.bu.edu>
References: <20201013152920.448335-1-alxndr@bu.edu> <m2r1q2m5nm.fsf@oracle.com>
 <20201013165246.GU70612@redhat.com> <m2lfg9maw9.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m2lfg9maw9.fsf@oracle.com>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 09:40:52
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.282, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 201014 1009, Darren Kenny wrote:
> On Tuesday, 2020-10-13 at 17:52:46 +01, Daniel P. Berrangé wrote:
> > On Tue, Oct 13, 2020 at 05:50:37PM +0100, Darren Kenny wrote:
> >> Hi Alex,
> >> 
> >> This mentions the use of atexit() to perform some cleanup, but I'm not
> >> seeing that being added here, should it be?
> >
> > The reference to atexit is strange, because it says the only way to
> > kill the fuzzer is SIGKILL, and that won't let atexit handlers run
> > anyway.
> >
> 
> OK, I understand the context now, it is in reference to Dima's patchset:
> 
> - https://lore.kernel.org/qemu-devel/cover.1602078083.git.dimastep@yandex-team.ru/
> 
> Where Alex suggested using atexit() to clean up the left over files from
> the test.
> 
> And with regard to SIGKILL, I believe it is that today, before Alex's
> patch that is the only way to stop the fuzzer running - which I can
> attest to since I've found it hard to stop in the past :)
> 
> Resetting these signal handlers to the default behaviour would allow the
> process to be terminated and an atexit() used, as Alex mentioned.
> 
> Alex, if you could clarify the commit message, then I feel this does
> make sent to change in the fuzz testing code, so:
> 

Yes - sorry about the confusion.
-Alex

> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> 
> Thanks,
> 
> Darren.
> 
> >> 
> >> Thanks,
> >> 
> >> Darren.
> >> 
> >> On Tuesday, 2020-10-13 at 11:29:20 -04, Alexander Bulekov wrote:
> >> > With the fuzzer, we never call main_loop_should_exit, since we manually
> >> > call main_loop_wait. This means that the only way to terminate the
> >> > fuzzer is with SIGKILL. Disable the signal handlers, so there are
> >> > reasonable ways to terminate the fuzzer and use atexit() to clean-up
> >> > after the fuzzer.
> >> >
> >> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> >> > ---
> >> >  tests/qtest/fuzz/fuzz.c | 8 ++++++++
> >> >  1 file changed, 8 insertions(+)
> >> >
> >> > diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> >> > index d926c490c5..eb0070437f 100644
> >> > --- a/tests/qtest/fuzz/fuzz.c
> >> > +++ b/tests/qtest/fuzz/fuzz.c
> >> > @@ -217,5 +217,13 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
> >> >      /* re-enable the rcu atfork, which was previously disabled in qemu_init */
> >> >      rcu_enable_atfork();
> >> >  
> >> > +    /*
> >> > +     * Disable QEMU's signal handlers, since we manually control the main_loop,
> >> > +     * and don't check for main_loop_should_exit
> >> > +     */
> >> > +    signal(SIGINT, SIG_DFL);
> >> > +    signal(SIGHUP, SIG_DFL);
> >> > +    signal(SIGTERM, SIG_DFL);
> >> > +
> >> >      return 0;
> >> >  }
> >> > -- 
> >> > 2.28.0
> >> 
> >
> > Regards,
> > Daniel
> > -- 
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> > |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

