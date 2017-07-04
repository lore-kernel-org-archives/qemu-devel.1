Received: from eggs.gnu.org ([2001:4830:134:3::10]:51583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSPke-0003Xf-AT
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSPkd-0007M5-GB
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:28:32 -0400
Date: Tue, 4 Jul 2017 17:28:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170704152820.GK4253@noname.str.redhat.com>
References: <20170627192458.15519-1-eblake@redhat.com>
	<20170627192458.15519-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170627192458.15519-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 02/20] trace: Show blockjob actions via
 bytes, not sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 27.06.2017 um 21:24 hat Eric Blake geschrieben:
> Upcoming patches are going to switch to byte-based interfaces
> instead of sector-based.  Even worse, trace_backup_do_cow_enter()
> had a weird mix of cluster and sector indices.
> 
> The trace interface is low enough that there are no stability
> guarantees, and therefore nothing wrong with changing our units,
> even in cases like trace_backup_do_cow_skip() where we are not
> changing the trace output.  So make the tracing uniformly use
> bytes.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
