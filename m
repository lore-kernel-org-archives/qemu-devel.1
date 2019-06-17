Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E16C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D4220833
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D4220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48498 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctai-0001Hs-IC
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51689)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hcsz9-0002bH-Tg
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hcsz8-0003XZ-Ln
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:51:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hcsyo-0003N2-OS; Mon, 17 Jun 2019 10:51:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1935B356DA;
 Mon, 17 Jun 2019 14:51:28 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-99.ams2.redhat.com [10.36.117.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 263BA39BE;
 Mon, 17 Jun 2019 14:51:25 +0000 (UTC)
Date: Mon, 17 Jun 2019 16:51:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com,
 berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com
Message-ID: <20190617145124.GJ7397@linux.fritz.box>
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <20190617111504.GC7397@linux.fritz.box>
 <20190617121855.GB32624@rkaganb.sw.ru>
 <20190617125355.GH7397@linux.fritz.box>
 <20190617132043.GE32624@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617132043.GE32624@rkaganb.sw.ru>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 17 Jun 2019 14:51:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/7] iotests: exclude killed processes
 from running under Valgrind
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 17.06.2019 um 15:20 hat Roman Kagan geschrieben:
> On Mon, Jun 17, 2019 at 02:53:55PM +0200, Kevin Wolf wrote:
> > Am 17.06.2019 um 14:18 hat Roman Kagan geschrieben:
> > > On Mon, Jun 17, 2019 at 01:15:04PM +0200, Kevin Wolf wrote:
> > > > Am 11.06.2019 um 20:02 hat Andrey Shinkevich geschrieben:
> > > > > The Valgrind tool fails to manage its termination when QEMU raises the
> > > > > signal SIGKILL. Lets exclude such test cases from running under the
> > > > > Valgrind because there is no sense to check memory issues that way.
> > > > > 
> > > > > Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> > > > 
> > > > I don't fully understand the reasoning here. Most interesting memory
> > > > access errors happen before a process terminates. (I'm not talking about
> > > > leaks here, but use-after-free, buffer overflows, uninitialised memory
> > > > etc.)
> > > 
> > > Nothing of the above, and nothing in general, happens in the usermode
> > > process upon SIGKILL delivery.
> > 
> > My point is, the interesting part is what the program does before
> > SIGKILL happens. There is value in reporting memory errors as long as we
> > can, even if the final check doesn't happen because of SIGKILL.
> 
> Agreed in general, but here the testcases that include 'sigraise 9' only
> do simple operations before that which are covered elsewhere too.  So
> the extra effort on making valgrind work with these testcases arguably
> isn't worth the extra value to be gained.

Ok, fair enough.

> > > > However, I do see that running these test cases with -valgrind ends in a
> > > > hang because the valgrind process keeps hanging around as a zombie
> > > > process and the test case doesn't reap it. I'm not exactly sure why that
> > > > is, but it looks more like a problem with the parent process (i.e. the
> > > > bash script).
> > > 
> > > It rather looks like valgrind getting confused about what to do with
> > > raise(SIGKILL) in the multithreaded case.
> > 
> > Well, valgrind can't do anything with SIGKILL, obviously, because it's
> > killed immediately.
> 
> Right, but it can do whatever it wants with raise(SIGKILL).  I haven't
> looked at valgrind sources, but
> 
>   # strace -ff valgind qemu-io -c 'sigraise 9'
> 
> shows SIGKILL neither sent nor received by any thread; it just shows the
> main thread exit and the second thread getting stuck waiting on a futex.

Oh, I didn't see this! So there isn't even a real SIGKILL signal.

> > But maybe the kernel does get confused for some
> > reason. I get the main threads as a zombie, but a second is still
> > running. Sending SIGKILL to the second thread, too, makes the test case
> > complete successfully.
> > 
> > So I guess the main question is why the second thread isn't
> > automatically killed when the main thread receives SIGKILL.
> 
> I don't see any thread receive SIGKILL.  So I tend to think this is
> valgrind's bug/feature.
> 
> Anyway the problem is outside of QEMU, so I think we need to weigh the
> costs of investigating it and implementing a workaround with the
> potential benefit.

I'd suggest to file a bug against valgrind at least. And indeed just
disable valgrind here like this patch does.

Kevin

