Received: from eggs.gnu.org ([2001:4830:134:3::10]:40683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g0N5U-0000sg-P3
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g0N5U-0001mq-0t
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:34:56 -0400
Date: Thu, 13 Sep 2018 16:34:49 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180913083449.GQ2526@lemon.usersys.redhat.com>
References: <20180913082952.3675-1-yuchenlin@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913082952.3675-1-yuchenlin@synology.com>
Subject: Re: [Qemu-devel] [PATCH v3] vmdk: align end of file to a sector
 boundary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin@synology.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, 09/13 16:29, yuchenlin@synology.com wrote:
> From: yuchenlin <yuchenlin@synology.com>
> 
> There is a rare case which the size of last compressed cluster
> is larger than the cluster size, which will cause the file is
> not aligned at the sector boundary.
> 
> There are three reasons to do it. First, if vmdk doesn't align at
> the sector boundary, there may be many undefined behaviors,
> such as, in vbox it will show VMDK: Compressed image is corrupted
> 'syno-vm-disk1.vmdk' (VERR_ZIP_CORRUPTED) when we try to import an
> ova with unaligned vmdk. Second, all the cluster_sector is aligned
> to sector, the last one should be like this, too. Third, it ease
> reading with sector based I/Os.
> 
> Signed-off-by: yuchenlin <yuchenlin@synology.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
