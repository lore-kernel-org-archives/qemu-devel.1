Received: from eggs.gnu.org ([2001:4830:134:3::10]:39765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmFvM-0007Qs-1h
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 05:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmFvI-0007Tq-V3
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 05:01:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dmFvI-0007TU-OW
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 05:01:32 -0400
Date: Mon, 28 Aug 2017 17:01:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170828090126.GO14174@pxdev.xzpeter.org>
References: <20170825141940.20740-1-dgilbert@redhat.com>
	<20170825141940.20740-2-dgilbert@redhat.com>
	<CAFEAcA9kOQ-WYaDSatWKYX82FM=zGb1LJ1a0iu9C2-nu3S=o+A@mail.gmail.com>
	<20170825155128.GK2090@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170825155128.GK2090@work-vm>
Subject: Re: [Qemu-devel] [PATCH 1/2] migration: Reset rather than destroy
 main_thread_load_event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, shorne@gmail.com, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On Fri, Aug 25, 2017 at 04:51:29PM +0100, Dr. David Alan Gilbert wrote:

[...]

> > PS, in migration_incoming_get_current() we do
> >         mis_current.state = MIGRATION_STATUS_NONE;
> >         memset(&mis_current, 0, sizeof(MigrationIncomingState));
> > 
> > and the first line there is pointless because the memset
> > blasts zeroes over it anyway.
> 
> Hmm yes.

I'll include this cleanup within my (future) patch to init incoming
migration object in migration_object_init() as well.  Thanks,

-- 
Peter Xu
