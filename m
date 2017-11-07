Received: from eggs.gnu.org ([2001:4830:134:3::10]:52653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eBy9D-0005qo-9W
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 02:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eBy98-0001QJ-CF
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 02:18:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eBy98-0001Q1-5l
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 02:18:06 -0500
Date: Tue, 7 Nov 2017 15:17:57 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171107071757.GO16355@lemon>
References: <20171106094643.14881-1-peterx@redhat.com>
	<20171106094643.14881-12-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171106094643.14881-12-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3 11/27] monitor: allow to use IO thread for
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, 11/06 17:46, Peter Xu wrote:
> For each Monitor, add one field "use_io_thr" to show whether it will be
> using the dedicated monitor IO thread to handle input/output.  When set,
> monitor IO parsing work will be offloaded to dedicated monitor IO
> thread, rather than the original main loop thread.
> 
> This only works for QMP.  HMP will always be run on main loop thread.
> 
> Currently we're still keeping use_io_thr to off always.  Will turn it on
> later at some point.
> 
> One thing to mention is that we cannot set use_io_thr for every QMP
> monitors.  The problem is that MUXed typed chardevs may not work well
> with it now. When MUX is used, frontend of chardev can be the monitor
> plus something else.  The only thing we know would be safe to be run
> outside main thread so far is the monitor frontend. All the rest of the
> frontends should still be run in main thread only.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
