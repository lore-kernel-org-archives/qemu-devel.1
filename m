Received: from eggs.gnu.org ([2001:4830:134:3::10]:56082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNBfT-000314-Sv
	for qemu-devel@nongnu.org; Mon, 28 May 2018 02:30:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNBfO-0000QN-C6
	for qemu-devel@nongnu.org; Mon, 28 May 2018 02:30:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37566 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fNBfO-0000Px-7I
	for qemu-devel@nongnu.org; Mon, 28 May 2018 02:30:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D33FF402243B
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 06:30:01 +0000 (UTC)
Date: Mon, 28 May 2018 14:29:56 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180528062956.GD2584@xz-mi>
References: <20180524043952.11245-1-peterx@redhat.com>
	<20180524043952.11245-5-peterx@redhat.com>
	<20180524092837.GD20733@stefanha-x1.localdomain>
	<20180525033022.GK12122@xz-mi>
	<20180525090157.GB14757@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180525090157.GB14757@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v7 4/4] monitor: add lock to protect
 mon_fdsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, May 25, 2018 at 10:01:57AM +0100, Stefan Hajnoczi wrote:
> On Fri, May 25, 2018 at 11:30:22AM +0800, Peter Xu wrote:
> > On Thu, May 24, 2018 at 10:28:37AM +0100, Stefan Hajnoczi wrote:
> > > On Thu, May 24, 2018 at 12:39:52PM +0800, Peter Xu wrote:
> > > >  int monitor_fdset_get_fd(int64_t fdset_id, int flags)
> > > >  {
> > > > -#ifndef _WIN32
> > > > +#ifdef _WIN32
> > > > +    return -ENOENT;
> > > 
> > > stubs/fdset.c:monitor_fdset_get_fd() should return -ENOENT instead of -1
> > > now.
> > 
> > Yes that's intended.  That's actually a suggestion from Markus since
> > changing the return code will simplify the code.
> 
> No, I understand that part.  I'm pointing out that
> stubs/fdset.c:monitor_fdset_get_fd() still returns -1 because it was not
> updated by this patch.
> 
> Since this patch changes the return value to -errno, the stub function
> should be updated to return a sensible -errno value too.

Sorry I overlooked.  You are right, I'll touch that up.

Regards,

-- 
Peter Xu
