Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91D4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:55:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E0D0204EA
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0D0204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrO2F-0007Qj-S8
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jrO0L-0005l3-HE
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:53:33 -0400
Received: from 12.mo7.mail-out.ovh.net ([178.33.107.167]:52895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jrO0I-0004mu-Az
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:53:33 -0400
Received: from player774.ha.ovh.net (unknown [10.110.103.132])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id EAFBB170283
 for <qemu-devel@nongnu.org>; Fri,  3 Jul 2020 17:53:19 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player774.ha.ovh.net (Postfix) with ESMTPSA id 4A386141A6218;
 Fri,  3 Jul 2020 15:53:18 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001c059d96f-a904-4bfd-9a91-edef9b3f5995,935498C186F5E237E8FBD9F7C25273B8E078CCF0)
 smtp.auth=groug@kaod.org
Date: Fri, 3 Jul 2020 17:53:15 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v6 4/5] 9pfs: T_readdir latency optimization
Message-ID: <20200703175315.61461738@bahia.lan>
In-Reply-To: <5261112.usFQB0EGfy@silver>
References: <cover.1587309014.git.qemu_oss@crudebyte.com>
 <1814766.vrYqd63b1M@silver> <20200702173500.27f2b0a5@bahia.lan>
 <5261112.usFQB0EGfy@silver>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6084081622307477824
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrtdeigdelhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejfedtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepueefheevtdelleevgeejieffieeutefhgfevjeefvdegkeetledtgeejudegtdeknecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.33.107.167; envelope-from=groug@kaod.org;
 helo=12.mo7.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 11:53:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 02 Jul 2020 19:23:35 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Donnerstag, 2. Juli 2020 17:35:00 CEST Greg Kurz wrote:
> > > > It isn't readdir only, most requests span over multiple v9fs_co_*()
> > > > calls...> 
> > > Right, I know! And that's actually my root motivation to finally bring
> > > this
> > > patch set forward, since I am very aware that this patch set is just a
> > > small brick in the overall procecss of fixing similarly affected code
> > > portions. So yes, that's my plan to fix them with upcoming patch sets,
> > > too.
> > > 
> > > Having said that, could we probably try to make future reviews a bit more
> > > efficient at certain aspects? For instance it would help a lot if the
> > > patch
> > > set was reviewed entirely, and not stopped at the very first issue spotted
> > > and then suspended to ++version, as this creates large latencies in the
> > > overall review process?
> > 
> > Review of 9pfs is a best effort thing... I usually stop reviewing when I'm
> > fed up or when all the time I could reasonably invest is elapsed. Breaking
> > down the series in smaller patches is the usual improvement for that.
> 
> No need to defend, you do these things voluntarily. I am glad that you spend 
> time on this project at all. I would appreciate though if we could reduce the 
> overall time for a patch set a bit, and my suggestion trying to walk through 
> an entire set before re-posting a new version might indeed bring an 
> improvement without anybody having to invest more time, but rather less.
> 

I'll try to adjust but I think you should also try to split patches (like
you did eventually with the addition of patch 3).

> > > And likewise it would also help if review is prioritized on relevant
> > > behaviour aspects (concept, design) first before arguing about code style
> > > details like variable names or other details invisible to users.
> > 
> > I don't remember questioning the overall concept behind these changes
> > because it looks reasonable enough (even if I would appreciate to be
> > able to verify them with a working reproducer).
> 
> What exactly do you mean here with working reproducer?
> 

Some test program to be run in a real guest that gets improved performance
with this patch set for example.

> > Even if it is invisible to the users, coding style or how a series is
> > broken down in patches is important for developers.
> 
> Dedication for detail beyond a certain fine graded level is luxury, and for 
> that reason it is designated for projects which clearly can afford it. On 
> (sub)projects with low activity and high latency (like this one) it easily 
> leads to frustration, which is obviously contra productive.
> 

The only way to avoid frustration when things don't go to your pace
is to take control, as you decided to do :)

> I don't say don't care about code style, details et al., but caring a bit less 
> on reviews would not hurt, so to say. A bit of (invisible) tolerance avoids 
> friction and stagnancy.
> 

No, this friction and stagnancy is essentially the result of not sharing
the same agenda and different tastes also.

> > > And finally: compromises. As man power on 9p is very limited, it would
> > > make
> > > sense to limit patch sets at a certain extent and agree to postpone
> > > certain
> > > non-critical issues to subsequent patches (or sets of), otherwise a patch
> > > set will grow and grow and it will take ages to get forward.
> > 
> > FWIW this patchset was more than 10 patches and now it is only 5 :)
> 
> Hey, no misleading number crunching please. ;-) Three dropped patches were 
> never intended to be merged, they were pure benchmarks.
> 

Heh :)

> > The good news is that you'll soon be able to merge things by yourself.
> > I'll help you when I can but I won't be the gating factor anymore.
> > 
> > Hurrah !
> 
> Yep, I'll do my best to pursue your work, I appreciate what you did and that 
> you still volunteer to help!
> 

And if I'm to picky on reviews, feel free to ignore my remarks ;)

> > > > > > 2) basically means moving some logic from the frontend to the
> > > > > > backend, ie. called from v9fs_co_run_in_worker(). This implies
> > > > > > that a very long request (ie. one that would span on many calls
> > > > > > to readdir()) cannot be interrupted by the client anymore, as
> > > > > > opposed to what we have now BTW.
> > > > 
> > > > ... most likely to allow clients to interrupt a long request with a
> > > > Tflush. Have you considered this aspect in your changes ?
> > > 
> > > In this particular patch set, no, as for readdir this should not be an
> > > issue in practice for anybody. After this patch set is applied, even on
> > > huge directories, the fs driver's duration for readdir would barely be
> > > measurable. In fact the server's latency would always be much higher,
> > > yet.
> > 
> > Reproducer ? Numbers ? ;)
> 
> Well, you have already seen and run the benchmark in this series yourself. You 
> can easily hit several hundred ms server latency, which is very hard to top 
> with any fs driver reading a directory. Ok, maybe with a tape drive you could, 
> but that's pretty much it. :) With a 'normal' system the fs driver would 

Or some network file system on an extremely slow connection...

> rather block for something between <1ms .. 8ms, i.e. fs driver completes 
> before it would be able to actually see a flush request.
> 
> But to make it also clear: it would not bite with the new design either. If 
> someone really would see a necessity to abort readdir requests, that would be 
> possible without huge changes.
> 

Tflush requests are handled in the top-half exclusively by design, ie.
they rely on the worker thread handling the targeted request to yield
control back to the main I/O thread. Since this doesn't happen anymore
with your patches, I'm not sure how you be able to abort a _many readdir_ 
request once it's been fired into a worker thread.

A possible solution could be to break down a Treaddir into multiple
_many readdirs_ jobs, and have a knob or some logic to control the
latency ratio.

> > > > > > Then the whole seekdir/rewinddir/telldir/readdir sequence should
> > > > > > be called with a single v9fs_co_run_in_worker() invocation, in
> > > > > > which case the locking could just be something like:
> > > > > > 
> > > > > > int coroutine_fn v9fs_co_readdir_many(V9fsPDU *pdu, V9fsFidState
> > > > > > *fidp,
> > > > > > 
> > > > > >                                       struct V9fsDirEnt **entries,
> > > > > >                                       int32_t maxsize, bool dostat)
> > > > > > 
> > > > > > {
> > > > > > 
> > > > > >     int err = 0;
> > > > > >     
> > > > > >     if (v9fs_request_cancelled(pdu)) {
> > > > > >     
> > > > > >         return -EINTR;
> > > > > >     
> > > > > >     }
> > > > > >     
> > > > > >     v9fs_readdir_lock(&fidp->fs.dir);
> > > > > >     
> > > > > >     v9fs_co_run_in_worker({
> > > > > >     
> > > > > >         err = do_readdir_many(pdu, fidp, entries, maxsize, dostat);
> > > > > >     
> > > > > >     });
> > > > > >     
> > > > > >     v9fs_readdir_unlock(&fidp->fs.dir);
> > > > > >     return err;
> > > > > > 
> > > > > > }
> > > > > 
> > > > > That's exactly what should be prevented. The lock must be on driver
> > > > > thread
> > > > > side, not on main thread side. The goal is to reduce the time slice of
> > > > > individual locks. If the lock is on main thread, the time slice of a
> > > > > lock
> > > > > (even on huge directories with thousands of entries) is multiple
> > > > > factors
> > > > > larger than if the lock is on driver thread side. So that's not just
> > > > > few
> > > > > percent or so, it is huge.
> > > > 
> > > > Sorry I don't get it...  In a contention-less situation, which is the
> > > > case we really care for, qemu_co_mutex_lock() has no overhead.
> > > 
> > > Yes, it only kicks in if there is concurrency.
> > 
> > And we don't care to preserve performance for silly clients, do we ?
> 
> We don't necessarily need to preserve performance for them, that's right. But 
> it is already handled appropriately for them, so destroying it (i.e. slowing 
> them down) only makes sense if there is a good reason for that.
> 

Ending up with a mix of two different kind of mutexes for 9p2000.L and .u is
a good enough reason for me.

> > > > > > This would technically leave the locking in the main I/O thread,
> > > > > > but it isn't conceptually different from locking at the beginning
> > > > > > of do_readdir_lock() and unlocking before returning. My concern
> > > > > > is that I don't know how coroutine mutexes behave with multiple
> > > > > > worker threads...
> > > > > 
> > > > > Well, your Mutex -> CoMutex change was intended to fix a deadlock with
> > > > > the
> > > > > old readdir implementation. That deadlock could not happen with the
> > > > > new
> > > > > readdir implementation, which suggests that it probably makes sense to
> > > > > revert this change (i.e. CoMutex -> Mutex) for this new
> > > > > implementation.
> > > > 
> > > > No we can't because it is also used with 9p2000.u, that you said you
> > > > don't want to fix.
> > > 
> > > Yes and no, I did not say I don't want to fix readdir for 9p2000.u at all.
> > > What I said was I want to prioritize and concentrate on the most relevant
> > > issues first. 9p2000.L is the most commonly used protocol variant, so I
> > > would like to fix the most severe (e.g. performance) issues for 9p2000.L
> > > first before spending time on 9p2000.u which is AFAICS barely used in
> > > comparison, which I personally don't use at all, and which I am hence not
> > > testing in the same degree and cannot serve with the same quality as
> > > 9p2000.L right now.
> > > 
> > > Plus if there are really users caring for 9p2000.u, I can gladly assist
> > > them to address these issues for 9p2000.u as well, provided that they
> > > help at least with testing the required 9p2000.u changes.
> > 
> > I would personally do the opposite... again ;)
> > 
> > Like you say we essentially care for 9p2000.L and we only do limited
> > support for 9p2000.u. If we have a change that we really want for
> > 9p2000.L but it has an impact on 9p2000.u because of shared code,
> > it is fine to do the changes anyway, including changes to the 9p2000.u
> > specific code. Very basic testing of 9p2000.u (mount/ls or find/umount)
> > or maybe running pjd-fstest is enough IMHO. If we break someone's setup
> > and he complains, then we can ask him to test a fix before we merge it.
> 
> Well, so you want to handle the relevant 9p2000.u readdir optimizations by 
> yourself, and you would send it as follow-up patch set (after this set is 
> through), including test cases?
> 

Ah it wasn't my point. I was just saying that any valuable change for
9p2000.L prevails and if you have to change some common code (eg.
locking) that could impact the 9p2000.u experience, you can do it
anyway, even if you only do smoke testing with 9p2000.u.

> > > Back to the actual topic: so what do we do about the mutex then? CoMutex
> > > for 9p2000.u and Mutex for 9p2000.L? I know you find that ugly, but it
> > > would just be a transitional measure.
> > 
> > That would ruin my day...
> > 
> > More seriously, the recent fix for a deadlock condition that was present
> > for years proves that nobody seems to be using silly clients with QEMU.
> > So I think we should just dump the lock and add a one-time warning in
> > the top level handlers when we detect a duplicate readdir request on
> > the same fid. This should be a very simple patch (I can take care of
> > it right away).
> 
> Looks like we have a consensus! Then I wait for your patch removing the lock, 
> and for your feedback whether or not you see anything else in this patch set?
> 

I was ready to do that but now I'm reading you other mail... I'll
continue the discussion there.

> > > Best regards,
> > > Christian Schoenebeck
> > 
> > Cheers,
> > 
> > --
> > Greg
> 
> Best regards,
> Christian Schoenebeck
> 
> 


