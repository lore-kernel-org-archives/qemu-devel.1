Received: from eggs.gnu.org ([2001:4830:134:3::10]:37061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evlc1-0002P8-BL
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evlbw-0001PV-Av
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:13:13 -0400
Date: Tue, 13 Mar 2018 16:12:54 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180313151254.GE4642@localhost.localdomain>
References: <20180313144730.2184-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313144730.2184-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/8] block: .bdrv_co_create for format
 drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Am 13.03.2018 um 15:47 hat Kevin Wolf geschrieben:
> This series adds a .bdrv_co_create implementation to almost all format
> drivers that support creating images where its still missing. The only
> exception is VMDK because its support for extents will make the QAPI
> design a bit more complicated.
> 
> The other format driver not covered in this series are qcow2 (already
> merged) and luks (already posted in a separate series).
> 
> v2:
> - Rebased, the vdi patch consists just of some cosmetic cleanups now
> - vhdx, vpc: Don't do any silent rounding in .bdrv_co_create, error out
>   if the passed size isn't properly aligned yet. The legacy code paths
>   compensate for this.

Applied to the block branch.

Kevin
