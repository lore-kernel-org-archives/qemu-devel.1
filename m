Received: from eggs.gnu.org ([2001:4830:134:3::10]:42342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1e6dfd-0006kX-G5
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1e6dfc-000492-Q9
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:25:37 -0400
Date: Mon, 23 Oct 2017 08:30:01 -0600
From: Keith Busch <keith.busch@intel.com>
Message-ID: <20171023143001.GC30713@localhost.localdomain>
References: <1508568856-17545-1-git-send-email-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508568856-17545-1-git-send-email-minwoo.im.dev@gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block][PATCH] qemu-block: add support HMB
 with feature commands.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org

On Sat, Oct 21, 2017 at 03:54:16PM +0900, Minwoo Im wrote:
> Add support HMB(Host Memory Block) with feature commands(Get Feature, Set Feature).
> nvme-4.14 tree supports HMB features.
> This patch will make nvme controller to return 32MiB preferred size of HMB to host via identify command.
> Set Feature, Get Feature implemented for HMB.
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>

Nak; this patch doesn't have a use for host memory. It's just advertising
the need without ever accessing it.
