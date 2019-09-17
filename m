Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4875C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D9E206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D9E206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAGb6-0004Ks-GD
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 12:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iAGX2-000143-GP
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iAGX0-0004Tv-W8
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:40:48 -0400
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:59711)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iAGX0-0004T2-PT
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:40:46 -0400
Received: from player690.ha.ovh.net (unknown [10.108.54.36])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 060B378BBA
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 18:40:45 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player690.ha.ovh.net (Postfix) with ESMTPSA id B105E9CEC431;
 Tue, 17 Sep 2019 16:40:09 +0000 (UTC)
Date: Tue, 17 Sep 2019 18:40:08 +0200
From: Greg Kurz <groug@kaod.org>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190917184008.577fcccb@bahia.lan>
In-Reply-To: <20190917144631.GF4824@localhost.localdomain>
References: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
 <156871564329.196432.5930574495661947805.stgit@bahia.lan>
 <19e78ae8-96dc-6154-6572-d7176057eeb7@redhat.com>
 <20190917144631.GF4824@localhost.localdomain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 904097628508363016
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeigdejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.44.197
Subject: Re: [Qemu-devel] [PATCH 02/17] block: Pass local error object
 pointer to error_append_hint()
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yuval Shaia <yuval.shaia@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Sep 2019 16:46:31 +0200
Kevin Wolf <kwolf@redhat.com> wrote:

> Am 17.09.2019 um 16:39 hat Eric Blake geschrieben:
> > On 9/17/19 5:20 AM, Greg Kurz wrote:
> > > Ensure that hints are added even if errp is &error_fatal or &error_abort.
> > > 
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  block/backup.c       |    7 +++++--
> > >  block/dirty-bitmap.c |    7 +++++--
> > >  block/file-posix.c   |   20 +++++++++++++-------
> > >  block/gluster.c      |   23 +++++++++++++++--------
> > >  block/qcow.c         |   10 ++++++----
> > >  block/qcow2.c        |    7 +++++--
> > >  block/vhdx-log.c     |    7 +++++--
> > >  block/vpc.c          |    7 +++++--
> > >  8 files changed, 59 insertions(+), 29 deletions(-)
> > > 
> > > diff --git a/block/backup.c b/block/backup.c
> > > index 763f0d7ff6db..d8c422a0e3bc 100644
> > > --- a/block/backup.c
> > > +++ b/block/backup.c
> > > @@ -602,11 +602,14 @@ static int64_t backup_calculate_cluster_size(BlockDriverState *target,
> > >                      BACKUP_CLUSTER_SIZE_DEFAULT);
> > >          return BACKUP_CLUSTER_SIZE_DEFAULT;
> > >      } else if (ret < 0 && !target->backing) {
> > > -        error_setg_errno(errp, -ret,
> > > +        Error *local_err = NULL;
> > 
> > Can we go with the shorter name 'err' instead of 'local_err'?  I know,
> > we aren't consistent (both styles appear throughout the tree), but the
> > shorter style is more appealing to me.
> 
> I like local_err better because it's easier to distinguish from errp.
> The compiler might catch it if you use the wrong one because one is
> Error* and the other is Error**, but as a reviewer, I can still get
> confused.
> 

I'll favor the official maintainer, hence keeping local_err :)

> Kevin


