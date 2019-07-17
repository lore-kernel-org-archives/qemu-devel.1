Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE1DC76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 645AF217D9
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645AF217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnZLb-0000yM-Et
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 22:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46296)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yan.y.zhao@intel.com>) id 1hnZLQ-0000Ze-Mx
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1hnZLO-0003cQ-NQ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:07:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:9869)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1hnZLM-0003YL-N8
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:06:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Jul 2019 19:06:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,272,1559545200"; d="scan'208";a="191113098"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by fmsmga004.fm.intel.com with ESMTP; 16 Jul 2019 19:06:48 -0700
Date: Tue, 16 Jul 2019 22:00:46 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Peter Xu <zhexu@redhat.com>
Message-ID: <20190717020046.GC8912@joy-OptiPlex-7040>
References: <1563261042-15974-1-git-send-email-yan.y.zhao@intel.com>
 <20190716072315.GA30980@xz-x1>
 <20190716072919.GA8912@joy-OptiPlex-7040>
 <20190716075025.GB30980@xz-x1>
 <20190716075749.GB8912@joy-OptiPlex-7040>
 <20190716103341.GC30980@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716103341.GC30980@xz-x1>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
Subject: Re: [Qemu-devel] [PATCH] migration: notify runstate immediately
 before vcpu stops
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 16, 2019 at 06:33:41PM +0800, Peter Xu wrote:
> On Tue, Jul 16, 2019 at 03:57:49AM -0400, Yan Zhao wrote:
> > On Tue, Jul 16, 2019 at 03:50:25PM +0800, Peter Xu wrote:
> > > On Tue, Jul 16, 2019 at 03:29:19AM -0400, Yan Zhao wrote:
> > > > On Tue, Jul 16, 2019 at 03:23:16PM +0800, Peter Xu wrote:
> > > > > On Tue, Jul 16, 2019 at 03:10:42PM +0800, Yan Zhao wrote:
> > > > > > for some devices to do live migration, it is needed to do something
> > > > > > immediately before vcpu stops. add a notification here.
> > > > > 
> > > > > Hi, Yan,
> > > > > 
> > > > > Could I ask for a more detailed commit message here?  E.g., what is
> > > > > "some devices"?  And, what's the problem behind?
> > > > >
> > > > hi Peter,
> > > > 
> > > > Some devices refer to assigned devices, like NICs.
> > > > For assigned devices to do live migration, it is sometimes required that
> > > > source device is stopped before stopping source vcpus. vcpus can do some
> > > > final cleanups (like handling interrupt) in that case.
> > > 
> > > I see, so this is a prerequisite of another work?
> > 
> > Yes.
> > > 
> > > IMHO it would make more sense to have this patch to be with that
> > > patchset, then it'll justify itself with reasoning.  Unless I
> > > misunderstood - this single patch seems to help nothing if as a
> > > standalone one.
> > 
> > It would be better. but this patch alone is also somewhat general,
> > as it only adds an extra notification and wouldn't impact others.
> > 
> > Only after this patch is upstreamed, can VFIO live migration have a
> > second choice for those devices of special requirements.
> > 
> > Hope it can get understanding from you:)
> 
> No you don't need my understanding, as long as the maintainer likes it
> it's good enough, so you probably only need to persuade the
> maintainers. :)
> 
> But again for me I would prefer patch like this to simply be the first
> patch of your live migration series.  There can be some exceptions
> like that when the prerequisite is too big so we'd better split them
> out to do things step by step, but this patch (which is a oneliner)
> should not be the case.
> 
> Thanks,
>

ok. Thank you, Peter :)

> > 
> > Or do you think I need to change the commit message a little to unbind
> > from migration?
> > 
> > Thanks
> > Yan
> > 
> 
> -- 
> Peter Xu

