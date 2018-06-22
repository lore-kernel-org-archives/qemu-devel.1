Received: from eggs.gnu.org ([2001:4830:134:3::10]:52213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fWBlN-0004em-2B
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 22:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fWBlM-0007fZ-62
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 22:25:25 -0400
Date: Fri, 22 Jun 2018 10:25:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180622022512.GB5449@lemon.usersys.redhat.com>
References: <20180621222143.27266-1-naravamudan@digitalocean.com>
	<20180621222143.27266-3-naravamudan@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621222143.27266-3-naravamudan@digitalocean.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] block/file-posix: reconfigure aio
 on iothread start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

On Thu, 06/21 15:21, Nishanth Aravamudan wrote:
> When the AioContext changes, we need to associate a LinuxAioState with
> the new AioContext. Use the bdrv_attach_aio_context callback and call
> the new aio_setup_linux_aio(), which will allocate a new AioContext if
> needed, and return errors on failures. If it fails for any reason,
> fallback to threaded AIO with an error message, as the device is already
> in-use by the guest.
> 
> Signed-off-by: Nishanth Aravamudan <naravamudan@digitalocean.com>
> ---
> Note this patch didn't exist in v2, but is a result of feedback to that
> posting.

This should be squashed into patch 1, no?

Fam
