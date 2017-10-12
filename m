Received: from eggs.gnu.org ([2001:4830:134:3::10]:39393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e2d41-0006RJ-Bd
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e2d3w-0006vo-H8
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:58:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1e2d3w-0006vd-Bq
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:58:08 -0400
Date: Thu, 12 Oct 2017 13:57:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171012125755.GH5957@stefanha-x1.localdomain>
References: <20170929033844.26935-1-peterx@redhat.com>
	<20170929033844.26935-17-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170929033844.26935-17-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 16/22] monitor: enable IO thread for (qmp
 & !mux) typed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Sep 29, 2017 at 11:38:38AM +0800, Peter Xu wrote:
> Start to use dedicate IO thread for QMP monitors that are not using
> MUXed chardev.
> 
> We excluded MUXed chardev because when mux is used, frontend can be the
> monitor plus something else.  The only thing we know would be safe to be
> run outside main thread is the monitor frontend, all the rest of the
> frontends should still be run in main thread only.

Please move this explanation into a comment so it's immediately visible
when reading the code.
