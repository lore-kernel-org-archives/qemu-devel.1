Received: from eggs.gnu.org ([2001:4830:134:3::10]:34603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHXDq-00063F-MY
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 10:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHXDn-0006W8-FS
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 10:45:58 -0500
Date: Wed, 22 Nov 2017 16:45:49 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171122164549.624d1fbf.cohuck@redhat.com>
In-Reply-To: <20171122142627.73170-1-borntraeger@de.ibm.com>
References: <20171122142627.73170-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] s390x fixes (post 2.11)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>

On Wed, 22 Nov 2017 15:26:25 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Christian Borntraeger (2):
>   s390x/migration: use zero flag parameter
>   pc-bios/s390-ccw: zero out bss section
> 
>  pc-bios/s390-ccw/start.S | 30 +++++++++++++++++++++++++++---
>  target/s390x/kvm.c       | 16 ++++++++--------
>  2 files changed, 35 insertions(+), 11 deletions(-)
> 

Thanks, queued to s390-next (with changed commit messages and bios
rebuild).

I will apply any further tags I get as well.
