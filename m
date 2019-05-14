Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AD9C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB5D20863
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB5D20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50852 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQaBx-0003ZF-Nt
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 12:22:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQaAG-0002Kn-MM
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQaAF-0004jF-Ga
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:20:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>)
	id 1hQaAC-0004d0-Qf; Tue, 14 May 2019 12:20:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DDABE300183D;
	Tue, 14 May 2019 16:20:23 +0000 (UTC)
Received: from work-vm (ovpn-117-232.ams2.redhat.com [10.36.117.232])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EFA2608AB;
	Tue, 14 May 2019 16:20:19 +0000 (UTC)
Date: Tue, 14 May 2019 17:20:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Thomas Huth <thuth@redhat.com>, armbru@redhat.com
Message-ID: <20190514162016.GQ2753@work-vm>
References: <20190124122525.145968-1-vsementsov@virtuozzo.com>
	<f92a06b5-6af6-dfe3-6e78-c4448e6a9cd0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f92a06b5-6af6-dfe3-6e78-c4448e6a9cd0@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Tue, 14 May 2019 16:20:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] fix qmp-cont vs migration-finish
 race-crash
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org,
	lcapitulino@redhat.com, mreitz@redhat.com,
	Karen Mezick <kmezick@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Thomas Huth (thuth@redhat.com) wrote:
> On 24/01/2019 13.25, Vladimir Sementsov-Ogievskiy wrote:
> > Hi.
> > 
> > It's a simple fix for problems reported in "Aborts in iotest 169"
> > by Max:
> > https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg05907.html
> > 
> > In thread Kevin described that a problem itself is bigger and needs
> > more effort:
> > https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06136.html
> > 
> > So, we may continue discussion in "Aborts in iotest 169", and in
> > parallel apply these patches at least as a temporary fix.
> > 
> > The problem of this fix is that we finally have a bit weird interface:
> > 
> > User gets event MIGRATION_COMPLETED, and after it he can get error
> > message "Migration is not finalized yet". 
> > 
> > But it is better than crash, anyway.
> > 
> > Vladimir Sementsov-Ogievskiy (2):
> >   qmp: forbid qmp_cont in RUN_STATE_FINISH_MIGRATE
> >   iotest: fix 169: do not run qmp_cont in RUN_STATE_FINISH_MIGRATE
> 
> What happened to these two patches? As far as I can see, they've never
> got applied? Has another fix for 169 included instead?

Hmm not sure; they've slipped between the maintainers if not.
1/2 is a qmp.c so while it fixes a migration corner case it's probably
armbru that should take it.

Dave

>  Thomas
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

