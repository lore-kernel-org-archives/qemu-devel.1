Received: from eggs.gnu.org ([2001:4830:134:3::10]:33221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gRKqN-0003qH-CW
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gRKqM-0003oB-P7
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:38:47 -0500
Date: Mon, 26 Nov 2018 18:38:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181126173838.GD6612@localhost.localdomain>
References: <20181126171745.4673-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126171745.4673-1-keith.busch@intel.com>
Subject: Re: [Qemu-devel] [PATCH] nvme: Fix spurious interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keith Busch <keith.busch@intel.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Guenter Roeck <linux@roeck-us.net>

Am 26.11.2018 um 18:17 hat Keith Busch geschrieben:
> The code had asserted an interrupt every time it was requested to check
> for new completion queue entries.This can result in spurious interrupts
> seen by the guest OS.
> 
> Fix this by asserting an interrupt only if there are un-acknowledged
> completion queue entries available.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Thanks, applied to the block branch.

Kevin
