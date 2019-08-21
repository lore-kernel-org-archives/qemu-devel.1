Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F74DC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5053422CE3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5053422CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Vhp-0007Hq-B8
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i0UUw-00063w-0F
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i0UUu-0004Pj-JR
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:34:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40344)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i0UUu-0004Og-Ba
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:34:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9833E7F762;
 Wed, 21 Aug 2019 17:34:11 +0000 (UTC)
Received: from work-vm (ovpn-117-245.ams2.redhat.com [10.36.117.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B682410013A1;
 Wed, 21 Aug 2019 17:34:09 +0000 (UTC)
Date: Wed, 21 Aug 2019 18:34:07 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Message-ID: <20190821173407.GK3309@work-vm>
References: <20190815200815.2cffc21b@luklap> <20190815185737.GC2883@work-vm>
 <20190815214804.69e4334f@luklap>
 <9CFF81C0F6B98A43A459C9EDAD400D780621F1B6@shsmsx102.ccr.corp.intel.com>
 <20190816202007.5577756b@luklap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816202007.5577756b@luklap>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Wed, 21 Aug 2019 17:34:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/3] colo: Add support for continious
 replication
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Wen Congyang <wencongyang2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Lukas Straub (lukasstraub2@web.de) wrote:
> On Fri, 16 Aug 2019 01:51:20 +0000
> "Zhang, Chen" <chen.zhang@intel.com> wrote:
> 
> > > -----Original Message-----
> > > From: Lukas Straub [mailto:lukasstraub2@web.de]
> > > Sent: Friday, August 16, 2019 3:48 AM
> > > To: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > Cc: qemu-devel <qemu-devel@nongnu.org>; Zhang, Chen
> > > <chen.zhang@intel.com>; Jason Wang <jasowang@redhat.com>; Xie
> > > Changlong <xiechanglong.d@gmail.com>; Wen Congyang
> > > <wencongyang2@huawei.com>
> > > Subject: Re: [Qemu-devel] [PATCH v2 0/3] colo: Add support for continious
> > > replication
> > >
> > > On Thu, 15 Aug 2019 19:57:37 +0100
> > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > >
> > > > * Lukas Straub (lukasstraub2@web.de) wrote:
> > > > > Hello Everyone,
> > > > > These Patches add support for continious replication to colo.
> > > > > Please review.
> > > >
> > > >
> > > > OK, for those who haven't followed COLO for so long; 'continuous
> > > > replication' is when after the first primary fails, you can promote
> > > > the original secondary to a new primary and start replicating again;
> > > >
> > > > i.e. current COLO gives you
> > > >
> > > > p<->s
> > > >     <primary fails>
> > > >     s
> > > >
> > > > with your patches you can do
> > > >
> > > >     s becomes p2
> > > >     p2<->s2
> > > >
> > > > and you're back to being resilient again.
> > > >
> > > > Which is great; because that was always an important missing piece.
> > > >
> > > > Do you have some test scripts/setup for this - it would be great to
> > > > automate some testing.
> > >
> > > My Plan is to write a Pacemaker Resource Agent[1] for qemu-colo and then do
> > > some long-term testing in my small cluster here. Writing standalone tests using
> > > that Resource Agent should be easy, it just needs to be provided with the right
> > > arguments and environment Variables.

Could you update tests/test-replication.c to test the extra steps?

Dave

> > Thanks Dave's explanation.
> > It looks good for me and I will test this series in my side.
> >
> > Another question: Is "Pacemaker Resource Agent[1] "  like a heartbeat module?
> 
> It's a bit more than that. Pacemaker itself is an Cluster Resource Manager, you can think of it like sysvinit but for clusters. It controls where in the cluster Resources run, what state (master/slave) and what to do in case of a Node or Resource failure. Now Resources can be anything like SQL-Server, Webserver, VM, etc. and Pacemaker itself doesn't directly control them, that's the Job of the Resource Agents. So a Resource Agent is like an init-script, but cluster-aware with more actions like start, stop, monitor, promote (to master) or migrate-to.
> 
> > I have wrote an internal heartbeat module running on Qemu, it make COLO can detect fail and trigger failover automatically, no need external APP to call the QMP command "x-colo-lost-heartbeat". If you need it, I can send a RFC version recently.
> 
> Cool, this should be faster to failover than with Pacemaker.
> What is the plan with cases like Primary-failover, which need to issue multiple commands?
> 
> > Thanks
> > Zhang Chen
> > >
> > > Regards,
> > > Lukas Straub
> > >
> > > [1] https://github.com/ClusterLabs/resource-agents/blob/master/doc/dev-guides/ra-dev-guide.asc#what-is-a-resource-agent
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

