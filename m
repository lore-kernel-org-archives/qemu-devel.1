Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09B4C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 09:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A375E2084F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 09:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A375E2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34215 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQqOD-00062d-Oh
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 05:39:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQqN1-0005Ru-CT
	for qemu-devel@nongnu.org; Wed, 15 May 2019 05:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQqN0-0007Bb-Cx
	for qemu-devel@nongnu.org; Wed, 15 May 2019 05:38:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hQqN0-0007AP-5n
	for qemu-devel@nongnu.org; Wed, 15 May 2019 05:38:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2228B308421A;
	Wed, 15 May 2019 09:38:41 +0000 (UTC)
Received: from work-vm (ovpn-117-193.ams2.redhat.com [10.36.117.193])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E4A05D71F;
	Wed, 15 May 2019 09:38:39 +0000 (UTC)
Date: Wed, 15 May 2019 10:38:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190515093837.GD2668@work-vm>
References: <20190424004700.12766-1-richardw.yang@linux.intel.com>
	<20190424004700.12766-3-richardw.yang@linux.intel.com>
	<0eb5e5a5-593e-f4a2-7e2d-a9fed481ab6c@gmail.com>
	<20190426005133.GB25513@richard> <20190514151813.GL2753@work-vm>
	<20190515063827.GB11845@richard> <20190515070341.GA24741@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515070341.GA24741@richard>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 15 May 2019 09:38:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/4] migration/savevm: use
 migration_is_blocked to validate
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
	quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> On Wed, May 15, 2019 at 02:38:27PM +0800, Wei Yang wrote:
> >On Tue, May 14, 2019 at 04:18:14PM +0100, Dr. David Alan Gilbert wrote:
> >>* Wei Yang (richardw.yang@linux.intel.com) wrote:
> >>> 
> >>> Well, when you look into the source side of migration:
> >>> 
> >>> qmp_migrate
> >>>   migrate_prepare
> >>>     migration_is_blocked
> >>> 
> >>> This means if migration_is_blocked fails, the source will not start migration.
> >>> And it is the same as save_snapshot.
> >>> 
> >>> From my understanding, when we load a vm, it should check the same
> >>> requirement.
> >>
> >>I've been thinking about this, and I think I agree with Daniel on this.
> >>The 'migration_blockers' list tells you that something about the
> >>*current* state of a device means that it can't be migrated - e.g.
> >>a 9pfs with a mounted filesystem can't be migrated.
> >>
> >>If we're about to reload the state from a snapshot, then the saved
> >>snapshot's state must have been migratable, so that's OK.
> >>
> >
> >The situation is on a vm with 'migration_blockers' still could reload from a
> >snapshot.
> >
> >This sounds reasonable. Thanks :-)
> >
> 
> Well, this is still a little strange. The means source vm and destination vm
> could have different configuration. Is this common?

It's not different configuration that I'm worried about here; but it's different runtime state.
Items can get added/removed from migration_blockers dynamically
depending on the behaviour of the guest; e.g. a device might only
migratable in certain states.

Dave


> -- 
> Wei Yang
> Help you, Help me
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

