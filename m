Received: from eggs.gnu.org ([2001:4830:134:3::10]:44169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhdkC-0007EB-H2
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhdk7-0004iz-K2
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:27:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dhdk7-0004ib-DO
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:26:55 -0400
Date: Tue, 15 Aug 2017 17:26:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170815172643.423342d6.cohuck@redhat.com>
In-Reply-To: <1502431076-22849-3-git-send-email-thuth@redhat.com>
References: <1502431076-22849-1-git-send-email-thuth@redhat.com>
	<1502431076-22849-3-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11 2/2] tests/pxe: Check
 virtio-net-ccw on s390x
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

On Fri, 11 Aug 2017 07:57:56 +0200
Thomas Huth <thuth@redhat.com> wrote:

> Now that we've got a firmware that can do TFTP booting on s390x (i.e.
> the pc-bios/s390-netboot.img), we can enable the PXE tester for this
> architecture, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include |  1 +
>  tests/boot-sector.c    | 20 ++++++++++++++++++++
>  tests/pxe-test.c       |  7 +++++++
>  3 files changed, 28 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
