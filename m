Received: from eggs.gnu.org ([2001:4830:134:3::10]:42667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLSvZ-0005fG-Pv
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:31:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLSvZ-0006VO-1u
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:31:37 -0400
Date: Wed, 23 May 2018 14:31:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180523123124.GF7523@localhost.localdomain>
References: <20180518132114.4070-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518132114.4070-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/40] Generic background jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

Am 18.05.2018 um 15:20 hat Kevin Wolf geschrieben:
> Before we can make x-blockdev-create a background job, we need to
> generalise the job infrastructure so that it can be used without any
> associated block node.
> 
> This series extracts a Job object from the block job infrastructure,
> which should contain everything related to jobs that doesn't require the
> block layer to be involved.
> 
> Job creation with a centralised job-create command (if we even want
> this) as well as the actual conversion of x-blockdev-create to Job is
> left for another series.

Applied to the block branch.

Kevin
