Received: from eggs.gnu.org ([209.51.188.92]:37262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gx7Ok-0003pl-18
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gx7Oj-0000KN-38
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:45:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gx7Oi-0000E5-72
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:45:36 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8FBA78635
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 09:45:30 +0000 (UTC)
Date: Fri, 22 Feb 2019 17:45:20 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190222094520.GN8904@xz-x1>
References: <20190222031413.20250-1-peterx@redhat.com>
	<4c74698e-3d3b-be12-1f60-cacf0c3421ef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c74698e-3d3b-be12-1f60-cacf0c3421ef@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] iothread: create gcontext
 unconditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri, Feb 22, 2019 at 10:28:57AM +0100, Paolo Bonzini wrote:
> On 22/02/19 04:14, Peter Xu wrote:
> > And if this patchset can survive... how about running gcontext
> > directly in iothread_run()?  I believe there could be a bit more
> > things to clean but I'll see.
> 
> Do you mean instead of aio_poll?

Yes.

> The problem is that GMainContext is
> quite a bit slower than aio_poll.

That's really what I wanted to know; so it's about performance.

We should mention it somewhere in iothread_run.  I can do that after I
know how this series will go.

> 
> Frediano and I tried to bring some of the optimizations of aio_poll to
> GMainContext
> (https://github.com/GNOME/glib/commit/e91c11841808ccca408da96136f433a82b2e2145),
> but they broke webkit. :(

What a pity!

-- 
Peter Xu
