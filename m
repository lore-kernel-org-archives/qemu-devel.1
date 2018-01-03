Received: from eggs.gnu.org ([2001:4830:134:3::10]:35131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWfX1-0008W4-4c
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:40:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWfWy-0008Fn-23
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:40:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWfWx-0008F8-Ro
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:40:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 07F32C02C01C
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 09:40:15 +0000 (UTC)
Date: Wed, 3 Jan 2018 17:40:11 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180103094011.GI2557@xz-mi>
References: <20180103054043.25719-1-peterx@redhat.com>
	<20180103054043.25719-7-peterx@redhat.com>
	<87o9mb2tqa.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o9mb2tqa.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH 06/11] migration: introduce
 vm_down_start_time
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

On Wed, Jan 03, 2018 at 10:10:21AM +0100, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > Introduce MigrationState.vm_down_start_time to replace the local
> > variable "start_time" in migration_thread to avoid passing things around.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> But I would suggest renaming the variable?
> 
> Later, Juan.
> 
> 
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 0f5df2367c..3ab5506233 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -107,6 +107,8 @@ struct MigrationState
> >      int64_t mig_start_time;
> >      /* Total time used by latest migration (ms) */
> >      int64_t mig_total_time;
> > +    /* Timestamp when VM is down (ms) to migrate the last stuff */
> > +    int64_t vm_down_start_time;
> 
> downtime_start?

Will do.

-- 
Peter Xu
