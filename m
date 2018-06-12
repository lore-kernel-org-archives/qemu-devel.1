Received: from eggs.gnu.org ([2001:4830:134:3::10]:58962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fSmMt-00085c-SE
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fSmMt-00042G-2b
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:42:03 -0400
Date: Tue, 12 Jun 2018 18:41:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180612164155.GH4355@localhost.localdomain>
References: <20180612125821.4229-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612125821.4229-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/18] block: Configuration fixes and rbd
 authentication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, jcody@redhat.com, eblake@redhat.com

Am 12.06.2018 um 14:58 hat Markus Armbruster geschrieben:
> PATCH 01-17 are configuration fixes and cleanup, in particular
> -blockdev driver=nfs,... and -drive driver=(nbd|sheepdog|ssh),... with
> non-string scalars.
> 
> PATCH 18-19 provide support for configuring rbd authentication.
> 
> I'm happy to split the series if that helps.
> 
> Since the RFC post, I amended the documentation of the rbd
> authentication parameters, and squashed PATCH 04 into 03.
> 
> Jeff Cody tested the RFC on his Ceph rig.  All results match
> expectations.
> 
> The series clashes with Max's "[PATCH 00/13] block: Try to create well
> typed json:{} filenames", but Max has rebased his work on mine.

I had minor, but still non-trivial comments for patches 9 and 12. The
rest is:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
