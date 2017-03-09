Received: from eggs.gnu.org ([2001:4830:134:3::10]:39727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clyQ0-0002Aa-Mt
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 08:47:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clyPz-0002kz-Rt
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 08:47:48 -0500
Date: Thu, 9 Mar 2017 14:47:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170309134731.GA4910@noname.redhat.com>
References: <20170308200216.5931-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170308200216.5931-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] block: Drop unmaintained
 'archipelago' driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, chris@include.gr, jcody@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, Markus Armbruster <armbru@redhat.com>

Am 08.03.2017 um 21:02 hat Eric Blake geschrieben:
> The driver has failed to build since commit da34e65, in qemu 2.6,
> due to a missing include of qapi/error.h for error_setg().
> Since no one has complained in three releases, it is easier to
> remove the dead code than to keep it around, especially since it
> is not being built by default and therefore prone to bitrot.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Thanks, applied to the block branch.

Kevin
