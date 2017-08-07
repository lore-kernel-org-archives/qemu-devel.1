Received: from eggs.gnu.org ([2001:4830:134:3::10]:38198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dekb9-0004aj-J9
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dekb4-0007UN-P1
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:09:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dekb4-0007U3-I7
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:09:38 -0400
Date: Mon, 7 Aug 2017 18:09:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170807180930.23a719de@gondolin>
In-Reply-To: <1501767019-4989-1-git-send-email-thuth@redhat.com>
References: <1501767019-4989-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests/pxe: Check virtio-net-ccw on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Victor Kaplansky <victork@redhat.com>

On Thu,  3 Aug 2017 15:30:19 +0200
Thomas Huth <thuth@redhat.com> wrote:

> Now that we've got a firmware that can do TFTP booting on s390x (i.e.
> the pc-bios/s390-netboot.img), we can enable the PXE tester for this
> architecture, too.

I'll take this through the s390x tree, unless someone objects.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Since this only adds a test, I guess this could still be included
>  for 2.10 ... otherwise, I think it's also OK to simply postpone this
>  to 2.11 instead
>  
>  tests/Makefile.include |  1 +
>  tests/boot-sector.c    | 25 ++++++++++++++++++++++---
>  tests/pxe-test.c       |  7 +++++++
>  3 files changed, 30 insertions(+), 3 deletions(-)
