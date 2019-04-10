Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBB7C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 16:58:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F51620854
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 16:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F51620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34751 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEGYR-0007De-OG
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 12:58:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEGXi-0006wj-D4
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEGXh-0001Iy-2F
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:57:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:65398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hEGXg-0001IZ-NZ
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:57:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3B5F3084268;
	Wed, 10 Apr 2019 16:57:43 +0000 (UTC)
Received: from work-vm (ovpn-117-246.ams2.redhat.com [10.36.117.246])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D7109BA82;
	Wed, 10 Apr 2019 16:57:39 +0000 (UTC)
Date: Wed, 10 Apr 2019 17:57:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Catherine Ho <catherine.hecx@gmail.com>
Message-ID: <20190410165736.GG2980@work-vm>
References: <1554689945-18619-1-git-send-email-catherine.hecx@gmail.com>
	<20190408123542.1a4de426@redhat.com>
	<CAEn6zmGHg_Tb1jsvurfrovQNB0R5WZT3mLT7r8R+BEt_4bPbhA@mail.gmail.com>
	<20190410145908.GF2980@work-vm>
	<CAEn6zmGGLLJb_7JCZzz-yWYpzkoGN7Vxd4aQ5_pvsMM+Sz8vPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CAEn6zmGGLLJb_7JCZzz-yWYpzkoGN7Vxd4aQ5_pvsMM+Sz8vPw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 10 Apr 2019 16:57:43 +0000 (UTC)
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
Message-ID: <20190410165737.fzV7F6CRq83he7ZPNUPxS8zFvLfrG-VfCr5_LRidU00@z>

* Catherine Ho (catherine.hecx@gmail.com) wrote:
> Hi Dr. David
> 
> On Wed, 10 Apr 2019 at 22:59, Dr. David Alan Gilbert <dgilbert@redhat.com>
> wrote:
> 
> > * Catherine Ho (catherine.hecx@gmail.com) wrote:
> > > Hi Igor
> > >
> > >
> > > On Mon, 8 Apr 2019 at 18:35, Igor Mammedov <imammedo@redhat.com> wrote:
> > >
> > > > On Sun,  7 Apr 2019 22:19:05 -0400
> > > > Catherine Ho <catherine.hecx@gmail.com> wrote:
> > > >
> > > > > Currently it is not forbidden to use "-object
> > > > memory-backend-file,share=on"
> > > > > and together with "-incoming". But after incoming migration is
> > finished,
> > > > > the memory-backend-file will be definitely written if share=on. So
> > the
> > > > > memory-backend-file can only be used once, but failed in the 2nd time
> > > > > incoming.
> > > > >
> > > > > Thus it gives a warning and the users can run the qemu if they really
> > > > > want to do it.
> > > >
> > > > Shouldn't we add a migration blocker in such a case instead of warning
> > > > and letting qemu run wild?
> > > >
> > >
> > > IMO, it doesn't need to block this. With share=on and -incoming, the user
> > > can
> > > still save the device memory state into memory-backend file again if
> > > ignore-shared
> > > capability is on.
> > >
> > > If we block this, the user can't use the ignore-shared capability in
> > > incoming
> > > migration.
> >
> > -incomign with share=on is a perfectly normal thing to do - it just
> > depends who you are sharing the file with and the lifetime of that
> > shared file.
> >
> > For example; if you're just running a qemu with vhost-user then you
> > use share=on - however wyou typically select the backend file as
> > a new file from /dev/shm - it's not a file that you previously migrated
> > to.
> >
> Thanks,
> but using a new file from /dev/shm means kernel will start from
> start_kernel or early? Is it different from the x-ignore-shared case?
> If we remove the share=on in incoming migration, all the writting
> of ram will not be flush into the memory backend file. Thus we
> can use the base memory backend file for ever.
> e.g.
> 1) save the vm like a snapshot, current ram state is "kernel
> has been started, systemd has been started"
> 2) restore it with -incoming and *no* share=on flag
> 3) restore it with -incoming and *no* share=on again...
> In contrary, if we use share=on, the base backend file will
> be written at once after 1st time incoming.
> 
> So, IMO, no "share=on" is the proper usage of incoming migration
> when ignore-shared is on.
> Please correct me if sth is wrong, thanks:)

OK, I see what you're trying to do - you mean for the 'snapshotting'
case;  but that's not the only use.  Another use is for being able to
do a very quick upgrade of the running qemu to a new qemu binary
version; and in that case you want to be able to write to the shared
file so that you can repeatedly do the quick migrate.

Dave

> 
> B.R.
> Catherine
> 
> 
> > QEMU has no way to know about the provenance of the shared file it's
> > been given, so we can't really warn people about it.
> >
> > Dave
> >
> > > B.R.
> > > Catherine
> > >
> > > >
> > > >
> > > > > Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
> > > > > ---
> > > > >  backends/hostmem-file.c | 11 +++++++++++
> > > > >  1 file changed, 11 insertions(+)
> > > > >
> > > > > diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> > > > > index 37ac6445d2..59429ee0b4 100644
> > > > > --- a/backends/hostmem-file.c
> > > > > +++ b/backends/hostmem-file.c
> > > > > @@ -16,6 +16,7 @@
> > > > >  #include "sysemu/hostmem.h"
> > > > >  #include "sysemu/sysemu.h"
> > > > >  #include "qom/object_interfaces.h"
> > > > > +#include "migration/migration.h"
> > > > >
> > > > >  /* hostmem-file.c */
> > > > >  /**
> > > > > @@ -79,6 +80,16 @@ file_backend_memory_alloc(HostMemoryBackend
> > *backend,
> > > > Error **errp)
> > > > >          }
> > > > >      }
> > > > >
> > > > > +    /*
> > > > > +     * In ignore shared case, if share=on for host memory backend
> > file,
> > > > > +     * the ram might be written after incoming process is finished.
> > Thus
> > > > > +     * the memory backend can't be reused for 2nd/3rd... incoming
> > > > > +     */
> > > > > +    if (backend->share && migrate_ignore_shared()
> > > > > +                       && runstate_check(RUN_STATE_INMIGRATE))
> > > > > +        warn_report("share=on for memory backend file might be "
> > > > > +                        "conflicted with incoming in ignore shared
> > > > case");
> > > > > +
> > > > >      backend->force_prealloc = mem_prealloc;
> > > > >      name = host_memory_backend_get_name(backend);
> > > > >      memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
> > > >
> > > >
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

