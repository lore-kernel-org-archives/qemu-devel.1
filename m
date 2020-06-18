Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ED0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FDB5207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDB5207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlwDD-0006tt-QQ
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 11:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jlwAP-0002rs-Ar
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:09:25 -0400
Received: from relay64.bu.edu ([128.197.228.104]:55106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jlwAN-0001La-04
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:09:24 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 05IF8Rt7012914
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 18 Jun 2020 11:08:31 -0400
Date: Thu, 18 Jun 2020 11:08:27 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v8 13/21] main: keep rcu_atfork callback enabled for qtest
Message-ID: <20200618150827.igxpcyu7bmsngjen@mozz.bu.edu>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-14-alxndr@bu.edu>
 <199e36b2-a509-00ed-94a7-0624753eb53f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <199e36b2-a509-00ed-94a7-0624753eb53f@redhat.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 11:09:20
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200618 0934, Thomas Huth wrote:
> On 29/01/2020 06.34, Bulekov, Alexander wrote:
> > The qtest-based fuzzer makes use of forking to reset-state between
> > tests. Keep the callback enabled, so the call_rcu thread gets created
> > within the child process.
> > 
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > ---
> >  vl.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/vl.c b/vl.c
> > index bb77935f04..cf8e2d3ebb 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -3794,7 +3794,14 @@ void qemu_init(int argc, char **argv, char **envp)
> >      set_memory_options(&ram_slots, &maxram_size, machine_class);
> >  
> >      os_daemonize();
> > -    rcu_disable_atfork();
> > +
> > +    /*
> > +     * If QTest is enabled, keep the rcu_atfork enabled, since system processes
> > +     * may be forked testing purposes (e.g. fork-server based fuzzing)
> > +     */
> > +    if (!qtest_enabled()) {
> > +        rcu_disable_atfork();
> > +    }
> >  
> >      if (pid_file && !qemu_write_pidfile(pid_file, &err)) {
> >          error_reportf_err(err, "cannot create PID file: ");
> 
>  Hi Alexander,
> 
> I think this patch might maybe not work as expected: The qtest_enabled()
> has been added before configure_accelerators() is called in main(). So
> qtest_enabled() should always return "false" and thus
> rcu_disabled_fork() is still called in any case... could you please
> double-check whether it works for you and I just made a mistake, or
> whether this is a bug indeed?
Hi,
This is a problem.. I think we can work around this by calling
rcu_enable_atfork from the fuzzer, after qemu_init. I'll send a patch
soon.
Thanks
-Alex

>  Thanks,
>   Thomas
> 

