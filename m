Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145F3C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 10:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1582083E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 10:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1582083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57651 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYpIB-0007NM-1j
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 06:06:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hYpHM-00074C-2N
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hYpHJ-0000fx-HO
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:05:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hYpHE-0000FT-Nw; Thu, 06 Jun 2019 06:05:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F802223881;
	Thu,  6 Jun 2019 10:05:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-165.ams2.redhat.com
	[10.36.117.165])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B37C2A2CE;
	Thu,  6 Jun 2019 10:05:11 +0000 (UTC)
Date: Thu, 6 Jun 2019 12:05:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190606100510.GA9241@localhost.localdomain>
References: <20190605123229.92848-1-vsementsov@virtuozzo.com>
	<20190605123229.92848-3-vsementsov@virtuozzo.com>
	<20190605171137.GC5491@linux.fritz.box>
	<1b1a0ec6-88c7-d7a5-3d95-bde310693580@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b1a0ec6-88c7-d7a5-3d95-bde310693580@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Thu, 06 Jun 2019 10:05:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/2] blockjob: use blk_new_pinned in
 block_job_create
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
Cc: "jsnow@redhat.com" <jsnow@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 05.06.2019 um 19:16 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 05.06.2019 20:11, Kevin Wolf wrote:
> > Am 05.06.2019 um 14:32 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> child_role job already has .stay_at_node=true, so on bdrv_replace_node
> >> operation these child are unchanged. Make block job blk behave in same
> >> manner, to avoid inconsistent intermediate graph states and workarounds
> >> like in mirror.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > 
> > This feels dangerous. It does what you want it to do if the only graph
> > change below the BlockBackend is the one in mirror_exit_common. But the
> > user could also take a snapshot, or in the future hopefully insert a
> > filter node, and you would then want the BlockBackend to move.
> > 
> > To be honest, even BdrvChildRole.stay_at_node is a bit of a hack. But at
> > least it's only used for permissions and not for the actual data flow.
> 
> Hmm. Than, may be just add a parameter to bdrv_replace_node, which parents
> to ignore? Would it work?

I would have to think a bit more about it, but it does sound safer.

Or we take a step back and ask why it's even a problem for the mirror
block job if the BlockBackend is moved to a different node. The main
reason I see is because of bs->job that is set for the root node of the
BlockBackend and needs to be unset for the same node.

Maybe we can just finally get rid of bs->job? It doesn't have many users
any more.

Kevin

