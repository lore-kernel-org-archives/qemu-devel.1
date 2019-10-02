Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE790C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 08:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B82215EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 08:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B82215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFZfl-0006LQ-UB
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 04:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iFZf5-0005tq-0B
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 04:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iFZf2-0005mU-98
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 04:07:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46264)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iFZf2-0005lx-32
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 04:07:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4EDBA3090FCE;
 Wed,  2 Oct 2019 08:06:58 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C5C45D71C;
 Wed,  2 Oct 2019 08:06:54 +0000 (UTC)
Date: Wed, 2 Oct 2019 09:06:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: Arch info lost in "info cpus"
Message-ID: <20191002080652.GA2710@work-vm>
References: <87blv2i5ha.fsf@redhat.com> <20190930084551.GB2759@work-vm>
 <20191001194301.GK4084@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001194301.GK4084@habkost.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 02 Oct 2019 08:06:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: imammedo@redhat.com, tao3.xu@intel.com, qemu-devel@nongnu.org,
 Sergio Lopez <slp@redhat.com>, mihajlov@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eduardo Habkost (ehabkost@redhat.com) wrote:
> On Mon, Sep 30, 2019 at 09:45:51AM +0100, Dr. David Alan Gilbert wrote:
> > * Sergio Lopez (slp@redhat.com) wrote:
> > > Hi,
> > > 
> > > Commit 137b5cb6ab565cb3781d5337591e155932b4230e (hmp: change
> > > hmp_info_cpus to use query-cpus-fast) updated the "info cpus" commit to
> > > make it more lightweight, but also removed the ability to get the
> > > architecture specific status of each vCPU.
> > > 
> > > This information was really useful to diagnose certain Guest issues,
> > > without the need of using GDB, which is more intrusive and requires
> > > enabling it in advance.
> > > 
> > > Is there an alternative way of getting something equivalent to what
> > > "info cpus" provided previously (in 2.10)?
> > 
> > Even the qemp equivalent, query-cpus is deprecated.
> > (Although we do call the underlying query-cpus in 'info numa' as well)
> 
> Why exactly it has to be deprecated?  We have use cases that
> require `query-cpus-fast` to exist, but I don't see why the
> existence of a command that returns extended information is a bad
> thing.
> 
> Having a command that synchronizes CPU state is even a
> requirement if we want to eventually implement "info registers"
> using QMP.

Yes, agreed; it was useful to have the non-syncing version
but I don't see a reason to remove the full-fat version.

Dave
 
> -- 
> Eduardo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

