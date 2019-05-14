Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A70CC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 13:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2731B20881
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 13:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2731B20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48330 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQXZ1-0006pW-6U
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 09:33:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQXXO-0005uK-9T
	for qemu-devel@nongnu.org; Tue, 14 May 2019 09:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQXXK-0005dP-AX
	for qemu-devel@nongnu.org; Tue, 14 May 2019 09:32:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48049)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hQXXK-0005Oj-4t
	for qemu-devel@nongnu.org; Tue, 14 May 2019 09:32:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F6FC314F302;
	Tue, 14 May 2019 13:31:42 +0000 (UTC)
Received: from work-vm (ovpn-117-232.ams2.redhat.com [10.36.117.232])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EEFF600C5;
	Tue, 14 May 2019 13:31:41 +0000 (UTC)
Date: Tue, 14 May 2019 14:31:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190514133135.GD8632@work-vm>
References: <20190326055726.10539-1-richardw.yang@linux.intel.com>
	<20190327202421.GH2636@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327202421.GH2636@work-vm>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Tue, 14 May 2019 13:31:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: remove not used field xfer_limit
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> * Wei Yang (richardw.yang@linux.intel.com) wrote:
> > MigrationState->xfer_limit is only set to 0 in migrate_init().
> > 
> > Remove this unnecessary field.
> > 
> > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> 
> Nice; I think that field has been unneeded since 1964a397063967
> just over 5 years ago :-)
> 
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Queued

> 
> > ---
> >  migration/migration.c | 1 -
> >  migration/migration.h | 1 -
> >  2 files changed, 2 deletions(-)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index e88acab53b..533c2102c7 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1682,7 +1682,6 @@ void migrate_init(MigrationState *s)
> >       * locks.
> >       */
> >      s->bytes_xfer = 0;
> > -    s->xfer_limit = 0;
> >      s->cleanup_bh = 0;
> >      s->to_dst_file = NULL;
> >      s->rp_state.from_dst_file = NULL;
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 99e99e56bd..852eb3c4e9 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -117,7 +117,6 @@ struct MigrationState
> >  
> >      /*< public >*/
> >      size_t bytes_xfer;
> > -    size_t xfer_limit;
> >      QemuThread thread;
> >      QEMUBH *cleanup_bh;
> >      QEMUFile *to_dst_file;
> > -- 
> > 2.19.1
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

