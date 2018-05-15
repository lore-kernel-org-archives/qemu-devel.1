Received: from eggs.gnu.org ([2001:4830:134:3::10]:42125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIajg-0002Tq-V9
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIajf-0000o4-Vf
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:15:28 -0400
Date: Tue, 15 May 2018 16:15:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180515141518.GF4442@localhost.localdomain>
References: <20180509162637.15575-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509162637.15575-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/42] Generic background jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

Am 09.05.2018 um 18:25 hat Kevin Wolf geschrieben:
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
> left for another series. With 42 patches, the series must be perfect and
> I can't add any more patches.

Thanks for the review, applied patches 1-6 in the hope of making v2 at
least a little bit shorter. :-)

Kevin
