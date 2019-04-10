Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FEEC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 15:00:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE862082E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 15:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE862082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32859 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEEiE-0008Em-AC
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 11:00:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEEh4-0007TU-OX
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEEh2-0002ef-Gg
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:59:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hEEh2-0002eH-5v
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:59:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79B3A3082E0F;
	Wed, 10 Apr 2019 14:59:15 +0000 (UTC)
Received: from work-vm (ovpn-117-246.ams2.redhat.com [10.36.117.246])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A25825D961;
	Wed, 10 Apr 2019 14:59:11 +0000 (UTC)
Date: Wed, 10 Apr 2019 15:59:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Catherine Ho <catherine.hecx@gmail.com>
Message-ID: <20190410145908.GF2980@work-vm>
References: <1554689945-18619-1-git-send-email-catherine.hecx@gmail.com>
	<20190408123542.1a4de426@redhat.com>
	<CAEn6zmGHg_Tb1jsvurfrovQNB0R5WZT3mLT7r8R+BEt_4bPbhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CAEn6zmGHg_Tb1jsvurfrovQNB0R5WZT3mLT7r8R+BEt_4bPbhA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Wed, 10 Apr 2019 14:59:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hostmem-file: warn when
 memory-backend-file, share=on and in incoming migration
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
Cc: Juan Quintela <quintela@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410145909.wj0Lkf4uG1nothXNMKUH5DsQu9GYn_drPoG7OUXatbQ@z>

* Catherine Ho (catherine.hecx@gmail.com) wrote:
> Hi Igor
> 
> 
> On Mon, 8 Apr 2019 at 18:35, Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Sun,  7 Apr 2019 22:19:05 -0400
> > Catherine Ho <catherine.hecx@gmail.com> wrote:
> >
> > > Currently it is not forbidden to use "-object
> > memory-backend-file,share=on"
> > > and together with "-incoming". But after incoming migration is finished,
> > > the memory-backend-file will be definitely written if share=on. So the
> > > memory-backend-file can only be used once, but failed in the 2nd time
> > > incoming.
> > >
> > > Thus it gives a warning and the users can run the qemu if they really
> > > want to do it.
> >
> > Shouldn't we add a migration blocker in such a case instead of warning
> > and letting qemu run wild?
> >
> 
> IMO, it doesn't need to block this. With share=on and -incoming, the user
> can
> still save the device memory state into memory-backend file again if
> ignore-shared
> capability is on.
> 
> If we block this, the user can't use the ignore-shared capability in
> incoming
> migration.

-incomign with share=on is a perfectly normal thing to do - it just
depends who you are sharing the file with and the lifetime of that
shared file.

For example; if you're just running a qemu with vhost-user then you
use share=on - however wyou typically select the backend file as
a new file from /dev/shm - it's not a file that you previously migrated
to.

QEMU has no way to know about the provenance of the shared file it's
been given, so we can't really warn people about it.

Dave

> B.R.
> Catherine
> 
> >
> >
> > > Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
> > > ---
> > >  backends/hostmem-file.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> > > index 37ac6445d2..59429ee0b4 100644
> > > --- a/backends/hostmem-file.c
> > > +++ b/backends/hostmem-file.c
> > > @@ -16,6 +16,7 @@
> > >  #include "sysemu/hostmem.h"
> > >  #include "sysemu/sysemu.h"
> > >  #include "qom/object_interfaces.h"
> > > +#include "migration/migration.h"
> > >
> > >  /* hostmem-file.c */
> > >  /**
> > > @@ -79,6 +80,16 @@ file_backend_memory_alloc(HostMemoryBackend *backend,
> > Error **errp)
> > >          }
> > >      }
> > >
> > > +    /*
> > > +     * In ignore shared case, if share=on for host memory backend file,
> > > +     * the ram might be written after incoming process is finished. Thus
> > > +     * the memory backend can't be reused for 2nd/3rd... incoming
> > > +     */
> > > +    if (backend->share && migrate_ignore_shared()
> > > +                       && runstate_check(RUN_STATE_INMIGRATE))
> > > +        warn_report("share=on for memory backend file might be "
> > > +                        "conflicted with incoming in ignore shared
> > case");
> > > +
> > >      backend->force_prealloc = mem_prealloc;
> > >      name = host_memory_backend_get_name(backend);
> > >      memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
> >
> >
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

