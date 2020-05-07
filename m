Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA85C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 16:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C4F20659
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 16:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C4F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWiys-0003a4-RR
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 12:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jWiwO-0001sr-1b
 for qemu-devel@nongnu.org; Thu, 07 May 2020 12:00:04 -0400
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:57260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jWiwM-00044F-6J
 for qemu-devel@nongnu.org; Thu, 07 May 2020 12:00:03 -0400
Received: from player690.ha.ovh.net (unknown [10.110.115.67])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 16B2C20EA14
 for <qemu-devel@nongnu.org>; Thu,  7 May 2020 17:59:55 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player690.ha.ovh.net (Postfix) with ESMTPSA id 75F1D12041965;
 Thu,  7 May 2020 15:59:54 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001e8d9f1e8-1641-4944-be00-424590eaca86,AF032C7111AD4BAD20ACDD539227CED07D4E1059)
 smtp.auth=groug@kaod.org
Date: Thu, 7 May 2020 17:59:52 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v6 3/5] 9pfs: add new function v9fs_co_readdir_many()
Message-ID: <20200507175952.119eae30@bahia.lan>
In-Reply-To: <4330996.EtvE2UMZrz@silver>
References: <cover.1587309014.git.qemu_oss@crudebyte.com>
 <5819799.mbObChnQ2B@silver> <20200504111834.117c98d9@bahia.lan>
 <4330996.EtvE2UMZrz@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3493385936021330240
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrkedtgdelfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.56.136; envelope-from=groug@kaod.org;
 helo=1.mo6.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 11:59:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Thu, 07 May 2020 14:16:43 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Montag, 4. Mai 2020 11:18:34 CEST Greg Kurz wrote:
> > On Fri, 01 May 2020 16:04:41 +0200
> > 
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > On Donnerstag, 30. April 2020 15:30:49 CEST Greg Kurz wrote:
> > > > > > I agree that a client that issues concurrent readdir requests on the
> > > > > > same fid is probably asking for troubles, but this permitted by the
> > > > > > spec. Whether we should detect such conditions and warn or even fail
> > > > > > is discussion for another thread.
> > > > > > 
> > > > > > The locking is only needed to avoid concurrent accesses to the
> > > > > > dirent
> > > > > > structure returned by readdir(), otherwise we could return partially
> > > > > > overwritten file names to the client. It must be done for each
> > > > > > individual
> > > > > > call to readdir(), but certainly not for multiple calls.
> > > > > 
> > > > > Yeah, that would resolve this issue more appropriately for 9p2000.L,
> > > > > since
> > > > > Treaddir specifies an offset, but for 9p2000.u the result of a
> > > > > concurrent
> > > > > read on a directory (9p2000.u) would still be undefined.
> > > > 
> > > > The bad client behavior you want to tackle has nothing to do with
> > > > the locking itself. Since all the code in 9p.c runs serialized in
> > > > the context of the QEMU main loop, concurrent readdir requests could
> > > > easily be detected up-front with a simple flag in the fid structure.
> > > 
> > > Well, it's fine with me. I don't really see an issue here right now. But
> > > that all the code was serialized is not fully true. Most of the 9p.c code
> > > is still heavily dispatching between main thread and worker threads back
> > > and forth. And for that reason the order of request processing might
> > > change quite arbitrarily in between. Just keep that in mind.
> > 
> > Just to make things clear. The code in 9p.c is ALWAYS exclusively run by
> > the main thread. Only the code called under v9fs_co_run_in_worker() is
> > dispatched on worker threads. So, yes the order of individual backend
> > operations may change, but the start of a new client request is necessarily
> > serialized with the completion of pending ones, which is the only thing
> > we care for actually.
> 
> I just looked at this. 9p.c code is called by main I/O thread only, that's 
> clear. The start of requests come also in in order, yes, but it seems you 
> would think that main I/O thread would not grab the next client request from 
> queue before completing the current/previous client request (that is not 
> before transmitting result to client). If yes, I am not so sure about this 
> claim:
> 

Hrm... I don't think I've ever said anything like that :)

What I'm saying is that, thanks to the serialization of
request start and completion, v9fs_readdir() and v9fs_read()
can:
- flag the fid as being involved in a readdir request
- clear the flag when the request is complete or failed
- directly fail or print a warning if the fid already
  has the flag set (ie. a previous request hasn't
  completed yet)

But again, I'm not a big fan of adding code to handle
such an unlikely situation which is even not explicitly
forbidden by the 9p spec.

> For instance v9fs_path_write_lock() is using a co-mutex, right? So an 
> unsuccesful lock would cause main I/O thread to grab the next request before 
> completing the current/previous request.
> 

An unsuccessful lock would cause the main I/O thread to switch
to some other task.

> And what happens on any run_in_worker({}) call? If there is another client 
> request in the queue, main I/O thread would pull that request from the queue 
> before waiting for the worker thread to complete its task, wouldn't it?
> 

The main I/O thread won't wait for anything, so, yes, it will probably
start handling the new request until it yields.

> Just looked at the code so far, haven't tested it yet ...
> 
> Best regards,
> Christian Schoenebeck
> 
> 


