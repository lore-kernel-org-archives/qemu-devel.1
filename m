Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB8BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7989420722
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7989420722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqZgx-0007yw-Nd
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 06:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jqZgN-0007WJ-CA
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:09:35 -0400
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:52657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jqZgK-0003nW-Dx
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:09:35 -0400
Received: from player732.ha.ovh.net (unknown [10.110.208.44])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id C18839760F
 for <qemu-devel@nongnu.org>; Wed,  1 Jul 2020 12:09:29 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player732.ha.ovh.net (Postfix) with ESMTPSA id B038113D1F084;
 Wed,  1 Jul 2020 10:09:25 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0026d2cc685-e630-413e-ae59-51a83fd6ed82,EF6FC975B06A46128E02C0B478BB3EF643A8B18B)
 smtp.auth=groug@kaod.org
Date: Wed, 1 Jul 2020 12:09:24 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v6 4/5] 9pfs: T_readdir latency optimization
Message-ID: <20200701120924.617532a3@bahia.lan>
In-Reply-To: <4716485.3Xd2u1jlTO@silver>
References: <cover.1587309014.git.qemu_oss@crudebyte.com>
 <33906767.5Uf7ihArhA@silver> <20200630183957.38b63719@bahia.lan>
 <4716485.3Xd2u1jlTO@silver>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6978609100792699200
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrtddvgddvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.56.233; envelope-from=groug@kaod.org;
 helo=8.mo69.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 06:09:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Tue, 30 Jun 2020 20:00:08 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Dienstag, 30. Juni 2020 18:39:57 CEST Greg Kurz wrote:
> > On Tue, 30 Jun 2020 17:16:40 +0200
> > 
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > On Montag, 29. Juni 2020 18:39:02 CEST Greg Kurz wrote:
> > > > On Wed, 03 Jun 2020 19:16:08 +0200
> > > > 
> > > > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > > > On Sonntag, 19. April 2020 17:06:17 CEST Christian Schoenebeck wrote:
> > > > > > Make top half really top half and bottom half really bottom half:
> > > > > > 
> > > > > > Each T_readdir request handling is hopping between threads (main
> > > > > > I/O thread and background I/O driver threads) several times for
> > > > > > every individual directory entry, which sums up to huge latencies
> > > > > > for handling just a single T_readdir request.
> > > > > > 
> > > > > > Instead of doing that, collect now all required directory entries
> > > > > > (including all potentially required stat buffers for each entry) in
> > > > > > one rush on a background I/O thread from fs driver by calling the
> > > > > > previously added function v9fs_co_readdir_many() instead of
> > > > > > v9fs_co_readdir(), then assemble the entire resulting network
> > > > > > response message for the readdir request on main I/O thread. The
> > > > > > fs driver is still aborting the directory entry retrieval loop
> > > > > > (on the background I/O thread inside of v9fs_co_readdir_many())
> > > > > > as soon as it would exceed the client's requested maximum R_readdir
> > > > > > response size. So this will not introduce a performance penalty on
> > > > > > another end.
> > > > > > 
> > > > > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > > > > ---
> > > > > > 
> > > > > >  hw/9pfs/9p.c | 122
> > > > > >  +++++++++++++++++++++++----------------------------
> > > > > >  1 file changed, 55 insertions(+), 67 deletions(-)
> > > > > 
> > > > > Ping. Anybody?
> > > > > 
> > > > > I would like to roll out this patch set soon and this is the only
> > > > > patch in
> > > > > this series missing a review yet.
> > > > 
> > > > Hi Christian,
> > > 
> > > Hi Greg,
> > > 
> > > > Sorry for getting back to this only now :-\
> > > > 
> > > > So I still have some concerns about the locking of the directory stream
> > > > pointer a fid. It was initially introduced to avoid concurrent accesses
> > > > by multiple threads to the corresponding internal glibc object, as
> > > > recommended in the readdir(3) manual page. Now, this patch considerably
> > > > extends the critical section to also contain calls to telldir() and all
> > > > the _many_ readdir()... so I'm not sure exactly what's the purpose of
> > > > that mutex right now. Please provide more details.
> > > 
> > > The intention of this lock is to prevent concurrent r/w (i.e. telldir()/
> > > readdir()) of the dir stream position by two or more active readdir
> > > requests handled in parallel, provided that they would use the same FID.
> > > Due to the latter requirement for this to become relevant, we already
> > > agreed that this is not something that would usually happen with a Linux
> > > 9p client, but there is nothing from protocol point of view that would
> > > prohibit this to be done by a client, so the resulting undefined
> > > behaviour should be prevented, which this lock does.
> > 
> > Makes sense. The dir stream position is no different from glibc's internal
> > dirent in that respect: it shouldn't be used by concurrent threads.
> 
> Exactly, it is a conceptual issue per se in general, independent of whether 
> glibc is used and independent of the fs driver.
> 
> > > What's your precise concern?
> > 
> > My overall concern is still the same. The patches are big and I've
> > been away for too long, so I need some more discussion to reassemble
> > my thoughts and the puzzle :)
> 
> Np, if you have questions, just come along.
> 
> > But now that I'm starting to understand why it's a good thing to
> > extend the critical section, I realize it should be extended
> > even more: we also have calls to seekdir() and rewindir() in
> > v9fs_readdir() and friends that could _theoretically_ cause the
> > very same kind of undefined behavior you're mentioning.
> 
> You are talking about the "old" code now. Yes, it is wrong and I did not 

No I'm talking about code that isn't changed by this series:

    if (initial_offset == 0) {
        v9fs_co_rewinddir(pdu, fidp);
    } else {
        v9fs_co_seekdir(pdu, fidp, initial_offset);
    }
    count = v9fs_do_readdir(pdu, fidp, max_count);

Leaving these outside the critical section seems to negate
your arguments... please clarify.

> bother to fix the "old" implementation, since this optimized readdir 
> implementation fixed this issue as well in one rush, but also note ...
> 
> > I think the change is important enough that it deserves its
> > own patch. I expect that moving the locking to the top-level
> > handler might also simplify the existing code, and thus your
> > series as well.
> 
> ... please reconsider if you really want to open that box. The "old" readdir 
> implementation on main thread is inherently wrong, and handling the lock there 
> and error pathes is extremely cumbersome and error prone.
> 

There are indeed several issues with the current readdir:

1) potential inconsistency on concurrent Treaddir requests

2) excessive dispatching to worker threads

So we agreed that 1) should never happen with a regular linux
client (we could even dump the lock actually) but we want to
make it clear in the code anyway that actions on the directory
stream are serialized.

2) basically means moving some logic from the frontend to the
backend, ie. called from v9fs_co_run_in_worker(). This implies
that a very long request (ie. one that would span on many calls
to readdir()) cannot be interrupted by the client anymore, as
opposed to what we have now BTW.

I tend to think that addressing both issues in one "rush" is
as much "error prone".

> Also: it does not make sense to move locking on this series from fs driver 
> back to main I/O thread. Atomicity must retain on driver side, not on top 
> half.
> 

Then the whole seekdir/rewinddir/telldir/readdir sequence should
be called with a single v9fs_co_run_in_worker() invocation, in
which case the locking could just be something like:

int coroutine_fn v9fs_co_readdir_many(V9fsPDU *pdu, V9fsFidState *fidp,
                                      struct V9fsDirEnt **entries,
                                      int32_t maxsize, bool dostat)
{
    int err = 0;

    if (v9fs_request_cancelled(pdu)) {
        return -EINTR;
    }

    v9fs_readdir_lock(&fidp->fs.dir);

    v9fs_co_run_in_worker({
        err = do_readdir_many(pdu, fidp, entries, maxsize, dostat);
    });

    v9fs_readdir_unlock(&fidp->fs.dir);
    return err;
}

This would technically leave the locking in the main I/O thread,
but it isn't conceptually different from locking at the beginning
of do_readdir_lock() and unlocking before returning. My concern
is that I don't know how coroutine mutexes behave with multiple
worker threads...

> Best regards,
> Christian Schoenebeck
> 
> 

Cheers,

--
Greg

