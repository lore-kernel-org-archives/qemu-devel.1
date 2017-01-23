Received: from eggs.gnu.org ([2001:4830:134:3::10]:51382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1cVcL1-0008Dx-Sx
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1cVcKy-0005Y7-OY
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:59:04 -0500
Received: from mx6-phx2.redhat.com ([209.132.183.39]:43379)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1cVcKy-0005Xp-FP
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:59:00 -0500
Date: Mon, 23 Jan 2017 05:58:57 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <79146319.14895991.1485169137641.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170123091725.GB2098@work-vm>
References: <1485069471-3680-1-git-send-email-pagupta@redhat.com>
	<20170123091725.GB2098@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Change name of live migration thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, amit shah <amit.shah@redhat.com>


Hi Dave,

> > Change the name of live migration thread from 'migration'
> > to 'qemu_vm_migration' to identify it clearly. 'migration'
> > is a generic word and kernel also has  tasks for process
> > migration with the name 'migration/cpu#'.
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  migration/migration.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index f498ab8..6ebd606 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1969,7 +1969,7 @@ void migrate_fd_connect(MigrationState *s)
> >      }
> >  
> >      migrate_compress_threads_create();
> > -    qemu_thread_create(&s->thread, "migration", migration_thread, s,
> > +    qemu_thread_create(&s->thread, "qemu_vm_migration", migration_thread,
> > s,
> >                         QEMU_THREAD_JOINABLE);
> 
> Are you sure that works?  For me it doesn't change the name.
> 
> There's a maximum length that I think is somewhere around 16 characters and
> that
> name is too long.
> 
> Changing it to "qemu_migration" seems to work.

Thanks for pointing out.
I will send a v2.

> 
> Dave
> 
> >      s->migration_thread_running = true;
> >  }
> > --
> > 2.7.4
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
