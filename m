Received: from eggs.gnu.org ([2001:4830:134:3::10]:33420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTm6s-00081r-0O
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTm6r-0007n8-CL
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:37:38 -0400
Date: Fri, 15 Jun 2018 12:37:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180615103730.GC5187@localhost.localdomain>
References: <20180614191443.14361-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614191443.14361-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/18] block: Configuration fixes and
 rbd authentication
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

Am 14.06.2018 um 21:14 hat Markus Armbruster geschrieben:
> PATCH 01-17 are configuration fixes and cleanup, in particular
> -blockdev driver=nfs,... and -drive driver=(nbd|sheepdog|ssh),... with
> non-string scalars.
> 
> PATCH 18-19 provide support for configuring rbd authentication.
> 
> I'm happy to split the series if that helps.
> 
> Jeff Cody tested the RFC on his Ceph rig.  All results match
> expectations.  Since code changes since then have been minimal, I
> believe his test results remain valid.
> 
> v2:
> * PATCH 03+05: Fix typos and pastos in commit message [Kevin]
> * PATCH 09: Fix error handling [Kevin]
> * PATCH 12: Redo for clarity [Kevin]

Thanks, applied to the block branch.

Kevin
