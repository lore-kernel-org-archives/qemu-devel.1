Received: from eggs.gnu.org ([2001:4830:134:3::10]:46831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxPG6-0002Jh-PM
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 23:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxPG2-00076t-Qn
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 23:13:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxPG2-00076l-KY
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 23:13:02 -0400
Date: Thu, 28 Sep 2017 11:12:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170928031255.GE17044@pxdev.xzpeter.org>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-29-git-send-email-peterx@redhat.com>
	<20170922201149.GL2620@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170922201149.GL2620@work-vm>
Subject: Re: [Qemu-devel] [RFC v2 28/33] migration: return incoming task tag
 for sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Fri, Sep 22, 2017 at 09:11:50PM +0100, Dr. David Alan Gilbert wrote:

[...]

> > -void tcp_start_incoming_migration(const char *host_port, Error **errp)
> > +guint tcp_start_incoming_migration(const char *host_port, Error **errp)
> >  {
> >      Error *err = NULL;
> >      SocketAddress *saddr = tcp_build_address(host_port, &err);
> > +    guint tag;
> > +
> >      if (!err) {
> > -        socket_start_incoming_migration(saddr, &err);
> > +        tag = socket_start_incoming_migration(saddr, &err);
> >      }
> 
> I'd be tempted to initialise that tag = 0   for the case where
> there's an error; but OK.

Yeh, I think it worths a touch-up.

> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Will take the r-b after fixing above.  Thanks!

-- 
Peter Xu
