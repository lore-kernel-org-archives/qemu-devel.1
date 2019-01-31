Received: from eggs.gnu.org ([209.51.188.92]:54717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gp8HG-0007md-Ly
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 04:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gp8HG-00086y-1X
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 04:04:54 -0500
Date: Thu, 31 Jan 2019 10:04:42 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190131090442.GD3950@localhost.localdomain>
References: <20190131022648.14264-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131022648.14264-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests/236: fix transaction kwarg order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 31.01.2019 um 03:26 hat John Snow geschrieben:
> It's not enough to order the kwargs for consistent QMP log output,
> we must also sort any sub-dictionaries in lists that appear as values.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>

Thanks, applied to the block branch.

Kevin
