Received: from eggs.gnu.org ([2001:4830:134:3::10]:44331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewVvg-0004TH-Fh
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:40:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewVvf-0000rT-OF
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:40:36 -0400
Date: Thu, 15 Mar 2018 17:40:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180315164018.GB3876@localhost.localdomain>
References: <20180315034507.6341-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315034507.6341-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vvfat: Fix inherit_options flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, stefanha@redhat.com

Am 15.03.2018 um 04:45 hat Fam Zheng geschrieben:
> Overriding flags violates the precedence rules of
> bdrv_reopen_queue_child. Just like the read-only option, no-flush should
> be put into the options. The same is done in bdrv_temp_snapshot_options.
> 
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, applied to the block branch.

Kevin
