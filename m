Received: from eggs.gnu.org ([2001:4830:134:3::10]:53759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eqitm-0000eg-O1
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eqitl-0002RC-U6
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:18:42 -0500
Date: Tue, 27 Feb 2018 18:18:33 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180227171833.GE5269@localhost.localdomain>
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223235142.21501-3-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [RFC v4 02/21] blockjobs: model single jobs as
 transactions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

Am 24.02.2018 um 00:51 hat John Snow geschrieben:
> model all independent jobs as single job transactions.
> 
> It's one less case we have to worry about when we add more states to the
> transition machine. This way, we can just treat all job lifetimes exactly
> the same. This helps tighten assertions of the STM graph and removes some
> conditionals that would have been needed in the coming commits adding a
> more explicit job lifetime management API.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
