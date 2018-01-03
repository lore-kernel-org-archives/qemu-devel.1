Received: from eggs.gnu.org ([2001:4830:134:3::10]:45989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWglD-0001v3-DB
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWglA-0003rB-9j
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:59:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWglA-0003qj-3L
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:59:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 23AE2356DB
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 10:58:59 +0000 (UTC)
Date: Wed, 3 Jan 2018 18:58:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180103105854.GN2557@xz-mi>
References: <20180103054043.25719-1-peterx@redhat.com>
	<20180103054043.25719-10-peterx@redhat.com>
	<87608j2r0u.fsf@secure.laptop> <20180103105529.GM2557@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180103105529.GM2557@xz-mi>
Subject: Re: [Qemu-devel] [PATCH 09/11] migration: cleanup stats update into
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Jan 03, 2018 at 06:55:29PM +0800, Peter Xu wrote:
> On Wed, Jan 03, 2018 at 11:08:49AM +0100, Juan Quintela wrote:
> > Peter Xu <peterx@redhat.com> wrote:
> > > We have quite a few lines in migration_thread() that calculates some
> > > statistics for the migration interations.  Isolate it into a single
> > > function to improve readability.
> > >
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > 
> > 
> > 
> > > +static void migration_update_statistics(MigrationState *s,
> > 
> > 
> > migration_update_counters()?
> 
> Sure, or...
> 
> > 
> > statistics for me mean that they are only used for informative
> > purposes.  Here we *act* on that values.
> > 
> > 
> > >  
> > > -            qemu_file_reset_rate_limit(s->to_dst_file);
> > > -            initial_time = current_time;
> > > -            initial_bytes = qemu_ftell(s->to_dst_file);
> > > -        }
> > > +        /* Conditionally update statistics */
> > 
> > No need for the comment.  If we think it is needed just rename the
> > function to:
> >    conditionally_update_statistics()?
> > 
> > I still preffer the:
> >    migration_update_counters.
> 
> ... migration_update_counters_conditionally()?

Forget that... It's too long to be liked.

I'll use migration_update_counters.  Thanks,

-- 
Peter Xu
