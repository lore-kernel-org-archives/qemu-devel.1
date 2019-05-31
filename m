Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7130AC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 19:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB9B26995
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 19:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB9B26995
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47939 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWmtY-0002zR-Hz
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 15:08:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hWmsk-0002e2-OS
	for qemu-devel@nongnu.org; Fri, 31 May 2019 15:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hWmsj-000845-N7
	for qemu-devel@nongnu.org; Fri, 31 May 2019 15:08:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hWmsj-00083A-HE
	for qemu-devel@nongnu.org; Fri, 31 May 2019 15:08:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8A483066800;
	Fri, 31 May 2019 19:07:58 +0000 (UTC)
Received: from work-vm (ovpn-117-254.ams2.redhat.com [10.36.117.254])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B4AD608CA;
	Fri, 31 May 2019 19:07:56 +0000 (UTC)
Date: Fri, 31 May 2019 20:07:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190531190753.GO3169@work-vm>
References: <20190523094433.30297-1-yury-kotov@yandex-team.ru>
	<87k1ebdsbm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1ebdsbm.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Fri, 31 May 2019 19:07:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] monitor: Fix return type of
 monitor_fdset_dup_fd_find
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
Cc: Yury Kotov <yury-kotov@yandex-team.ru>, Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> David, got anything queued for the monitor?  If yes, can you stick this
> in?  If not, I can handle it.

I've not got anything else, so please take it;
am I right in thinking this supercedes

  'monitor: Fix fdset_id & fd types for corresponding QMP commands'

Thanks,

Dave


> Yury Kotov <yury-kotov@yandex-team.ru> writes:
> 
> > monitor_fdset_dup_fd_find_remove() and monitor_fdset_dup_fd_find()
> > return mon_fdset->id which is int64_t. Downcasting from int64_t to int
> > leads to a bug with removing fd from fdset with id >= 2^32.
> > So, fix return types for these function.
> >
> > Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >  include/monitor/monitor.h | 2 +-
> >  monitor.c                 | 4 ++--
> >  stubs/fdset.c             | 2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> > index 86656297f1..51f048d61f 100644
> > --- a/include/monitor/monitor.h
> > +++ b/include/monitor/monitor.h
> > @@ -45,6 +45,6 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
> >  int monitor_fdset_get_fd(int64_t fdset_id, int flags);
> >  int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd);
> >  void monitor_fdset_dup_fd_remove(int dup_fd);
> > -int monitor_fdset_dup_fd_find(int dup_fd);
> > +int64_t monitor_fdset_dup_fd_find(int dup_fd);
> >  
> >  #endif /* MONITOR_H */
> > diff --git a/monitor.c b/monitor.c
> > index 6428eb3b7e..a0e637f7d6 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -2602,7 +2602,7 @@ err:
> >      return -1;
> >  }
> >  
> > -static int monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
> > +static int64_t monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
> >  {
> >      MonFdset *mon_fdset;
> >      MonFdsetFd *mon_fdset_fd_dup;
> > @@ -2630,7 +2630,7 @@ err:
> >      return -1;
> >  }
> >  
> > -int monitor_fdset_dup_fd_find(int dup_fd)
> > +int64_t monitor_fdset_dup_fd_find(int dup_fd)
> >  {
> >      return monitor_fdset_dup_fd_find_remove(dup_fd, false);
> >  }
> > diff --git a/stubs/fdset.c b/stubs/fdset.c
> > index 4f3edf2ea4..a1b8f41f62 100644
> > --- a/stubs/fdset.c
> > +++ b/stubs/fdset.c
> > @@ -7,7 +7,7 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd)
> >      return -1;
> >  }
> >  
> > -int monitor_fdset_dup_fd_find(int dup_fd)
> > +int64_t monitor_fdset_dup_fd_find(int dup_fd)
> >  {
> >      return -1;
> >  }
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

