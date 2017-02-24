Received: from eggs.gnu.org ([2001:4830:134:3::10]:44256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ch6u8-0005Ie-O6
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 22:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ch6u7-0005xF-Qw
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 22:50:48 -0500
Date: Thu, 23 Feb 2017 22:50:39 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170224035039.GA2613@localhost.localdomain>
References: <1487349541-10201-1-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487349541-10201-1-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH 0/2] block/nfs optimizations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

On Fri, Feb 17, 2017 at 05:38:59PM +0100, Peter Lieven wrote:
> Peter Lieven (2):
>   block/nfs: convert to preadv / pwritev
>   block/nfs: try to avoid the bounce buffer in pwritev
> 
>  block/nfs.c | 50 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 22 deletions(-)
> 
> -- 
> 1.9.1
> 

Thanks,

Applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc.git block

-Jeff
