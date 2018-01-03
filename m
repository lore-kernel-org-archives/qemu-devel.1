Received: from eggs.gnu.org ([2001:4830:134:3::10]:59509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWfMo-0002Ba-51
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWfMl-00038z-0y
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:29:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWfMk-00037j-QX
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:29:42 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A726D4A706
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 09:29:41 +0000 (UTC)
Date: Wed, 3 Jan 2018 17:29:37 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180103092937.GG2557@xz-mi>
References: <20180103054043.25719-1-peterx@redhat.com>
	<20180103054043.25719-5-peterx@redhat.com>
	<87wp0z2ual.fsf@secure.laptop> <20180103090433.GE2557@xz-mi>
	<87a7xv2t94.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a7xv2t94.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH 04/11] migration: split use of
 MigrationState.total_time
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

On Wed, Jan 03, 2018 at 10:20:39AM +0100, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Wed, Jan 03, 2018 at 09:58:10AM +0100, Juan Quintela wrote:
> >> Peter Xu <peterx@redhat.com> wrote:
> >> > It was used either to:
> >> >
> >> > 1. store initial timestamp of migration start, and
> >> > 2. store total time used by last migration
> >> >
> >> > Let's provide two parameters for each of them.  Mix use of the two is
> >> > slightly misleading.
> >> >
> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
> >> 
> >> Reviewed-by: Juan Quintela <quintela@redhat.com>
> >
> > Thanks!
> >
> >> 
> >> If you have to respin, I would like to use the names:
> >
> > (I think it very possible :-)
> >
> >> 
> >> start_time and total_time, i.e. without the mig_ preffix, because they
> >> are in an struct that is clearly named migration O:-)
> >
> > Oh, it's my bad (or good?) habit of keeping some prefix so that cscope
> > won't mix these variables with others.  I think the problem is that
> > cscope is always using a global namespace for variables.  Considering
> > this do you still like me to change? :) Any suggestions on better
> > usage of cscope would be greatly welcomed too!
> 
> I only use cscope very ocassionally, so I can't comment about its usage.
> As said, I put the reviewed-by anyways.  But if you dont want to use
> generic names like start_time/total_time, then please use the full name:
> 
> - migration_start_time
> - migration_total_time
> 
> It is only used a couple of times, and clearer to read.  I normally only
> put _prefixes_ if context don't make clear what the variable means.  If
> I need *context* I tend to use the full name of things, not
> abbreviations.  But yes, not all the code is coherent/consistent.

I'll use the shorter ones.  Thanks!

-- 
Peter Xu
