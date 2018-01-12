Received: from eggs.gnu.org ([2001:4830:134:3::10]:41196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ea5Im-00082P-Ui
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 14:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ea5Ii-0002C2-3v
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 14:47:45 -0500
Date: Fri, 12 Jan 2018 17:47:30 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180112194730.GQ18022@localhost.localdomain>
References: <20180108215007.46471-1-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180108215007.46471-1-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: fix memory corruption when all
 fw_cfg slots are used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, qemu-stable@nongnu.org, kraxel@redhat.com, lersek@redhat.com

On Mon, Jan 08, 2018 at 11:50:07PM +0200, Marcel Apfelbaum wrote:
> When all the fw_cfg slots are used, a write is made outside the
> bounds of the fw_cfg files array as part of the sort algorithm.
> 
> Fix it by avoiding an unnecessary array element move.
> Fix also an assert while at it.
> 
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>

Queued on machine-next, thanks!

-- 
Eduardo
