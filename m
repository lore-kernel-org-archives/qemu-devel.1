Received: from eggs.gnu.org ([2001:4830:134:3::10]:40963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dsVvH-0001sC-W7
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dsVvF-0002T3-BI
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:19:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dsVvF-0002LJ-4d
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:19:21 -0400
Date: Thu, 14 Sep 2017 16:19:11 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170914151911.GB7370@stefanha-x1.localdomain>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<CAJ+F1CL1CekcYq2xnrkhsjyx17FDSgppP1C+YqL0iNgv8HbwYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CL1CekcYq2xnrkhsjyx17FDSgppP1C+YqL0iNgv8HbwYQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 00/15] QMP: out-of-band (OOB) execution
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Sep 14, 2017 at 01:15:09PM +0200, Marc-Andr=E9 Lureau wrote:
> There should be a limit in the number of requests the thread can
> queue. Before the patch, the limit was enforced by system socket
> buffering I think. Now, should oob commands still be processed even if
> the queue is full? If so, the thread can't be suspended.

I agree.

Memory usage must be bounded.  The number of requests is less important
than the amount of memory consumed by them.

Existing QMP clients that send multiple QMP commands without waiting for
replies need to rethink their strategy because OOB commands cannot be
processed if queued non-OOB commands consume too much memory.

Stefan
