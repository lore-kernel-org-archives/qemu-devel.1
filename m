Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2F7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:29:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023B72073E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023B72073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOYd-0005vl-9e
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jrOEt-0004fB-3J
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:08:35 -0400
Received: from 20.mo1.mail-out.ovh.net ([188.165.45.168]:51846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jrOEp-0001dX-Fo
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:08:34 -0400
Received: from player729.ha.ovh.net (unknown [10.110.171.250])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 449A91CE4F4
 for <qemu-devel@nongnu.org>; Fri,  3 Jul 2020 18:08:24 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player729.ha.ovh.net (Postfix) with ESMTPSA id 8FD90142B67FE;
 Fri,  3 Jul 2020 16:08:22 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G0051662cabc-42a5-4d58-8653-8167c182c452,935498C186F5E237E8FBD9F7C25273B8E078CCF0)
 smtp.auth=groug@kaod.org
Date: Fri, 3 Jul 2020 18:08:21 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v6 4/5] 9pfs: T_readdir latency optimization
Message-ID: <20200703180821.0416ebe8@bahia.lan>
In-Reply-To: <2036889.5PXCEd79iF@silver>
References: <cover.1587309014.git.qemu_oss@crudebyte.com>
 <20200702173500.27f2b0a5@bahia.lan> <5261112.usFQB0EGfy@silver>
 <2036889.5PXCEd79iF@silver>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6338535001485908288
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrtdeigdelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=188.165.45.168; envelope-from=groug@kaod.org;
 helo=20.mo1.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 12:08:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Fri, 03 Jul 2020 10:08:09 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Donnerstag, 2. Juli 2020 19:23:35 CEST Christian Schoenebeck wrote:
> > > > Back to the actual topic: so what do we do about the mutex then? CoMutex
> > > > for 9p2000.u and Mutex for 9p2000.L? I know you find that ugly, but it
> > > > would just be a transitional measure.
> > > 
> > > That would ruin my day...
> > > 
> > > More seriously, the recent fix for a deadlock condition that was present
> > > for years proves that nobody seems to be using silly clients with QEMU.
> > > So I think we should just dump the lock and add a one-time warning in
> > > the top level handlers when we detect a duplicate readdir request on
> > > the same fid. This should be a very simple patch (I can take care of
> > > it right away).
> > 
> > Looks like we have a consensus! Then I wait for your patch removing the
> > lock, and for your feedback whether or not you see anything else in this
> > patch set?
> 
> Please wait before you work on this patch. I really do think your patch should 
> be based on/after this optimization patch for one reason: if (and even though 
> it's a big if) somebody comes along with a silly client as you named it, then 
> your patch can simply be reverted, which would not be possible if it's next.
> 
> So I would really suggest I change this patch here to go the ugly way with 2 
> mutex types for readdir 9p2000.L vs 9p2000.L, and your patch would get rid of 
> that mess by removing the lock entirely, okay?
> 

If someones ever comes along with a silly client, she will get warnings
explaining that she might get silly results. If it turns out that we
really need to support that for valid reasons, it will be okay to focus
on the appropriate fix when the time comes, not now. So I don't say any
real benefit to postponing the removal of the lock after your series, but
I do at least see one benefit, it will reduce the level of noise.

> Best regards,
> Christian Schoenebeck
> 
> 


