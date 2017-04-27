Received: from eggs.gnu.org ([2001:4830:134:3::10]:48952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1d3fuN-0007yh-GL
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1d3fuM-0007SP-Lw
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:40:19 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:35364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1d3fuM-0007SG-HS
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:40:18 -0400
Received: by mail-oi0-x22a.google.com with SMTP id j201so31119948oih.2
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 02:40:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170426161439.GG2098@work-vm>
References: <CAJ2SuL=qbGqwt0JCLOLZ41fLTLwKDb0KjDANLTBTb7uLK+5m-w@mail.gmail.com>
	<20170426161439.GG2098@work-vm>
From: Pradeep Kiruvale <pradeepkiruvale@gmail.com>
Date: Thu, 27 Apr 2017 11:40:17 +0200
Message-ID: <CAJ2SuLn_WowVfOLvjTnUr=houp0BQrNjMdbiHkvLt8WCagpTLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] VM-Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, quintela@redhat.com

On 26 April 2017 at 18:14, Dr. David Alan Gilbert <dgilbert@redhat.com>
wrote:

> * Pradeep Kiruvale (pradeepkiruvale@gmail.com) wrote:
> > Hi All,
> >
> > Is it possible to enable/disable to migration features on the fly for a
> > qemu VM?
> > I mean through qmp interface kind of a interface?
> >
> > I am asking this because keeping the dirty memory list, this could
> consume
> > some
> > compute and memory. So, the plan is to enable when the VM needs to be
> > migrated.
> >
> > Please clarify.
>
> These bitmaps should already only be allocated during the migration
> process,
> so you shouldn't be seeing any overhead during normal running.
>
> See migration/ram.c ram_save_setup->ram_state_init which allocates
> ram_bitmap and that only happens at the start of migration.
> ram_state_init also calls memory_global_dirty_log_start which does
> the kernel side of it.
>
>
Thanks for the clarification Dave!.

-Pradeep

Dave
>
> > Regards,
> > Pradeep
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
