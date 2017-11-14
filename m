Received: from eggs.gnu.org ([2001:4830:134:3::10]:45439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEccm-00009H-0U
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEcck-0005T5-Qr
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:55:40 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171110203111.7666-3-mreitz@redhat.com>
References: <20171110203111.7666-1-mreitz@redhat.com>
	<20171110203111.7666-3-mreitz@redhat.com>
Date: Tue, 14 Nov 2017 15:55:30 +0100
Message-ID: <w514lpw29lp.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.11 2/5] qcow2: Unaligned zero cluster
 in handle_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On Fri 10 Nov 2017 09:31:08 PM CET, Max Reitz wrote:
> We should check whether the cluster offset we are about to use is
> actually valid; that is, whether it is aligned to cluster boundaries.
>
> Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1728643
> Buglink: https://bugs.launchpad.net/qemu/+bug/1728657
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
