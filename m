Received: from eggs.gnu.org ([2001:4830:134:3::10]:36232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2Ir4-0001Lw-1C
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2Ir3-0007K4-9c
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:23:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e2Ir3-0007Jr-4u
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:23:29 -0400
Date: Wed, 11 Oct 2017 17:23:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171011172323.766ef9f2.cohuck@redhat.com>
In-Reply-To: <6a8ea4c503ee32c2ca7fa608b5f2f547009be8ee.1507557166.git.alifm@linux.vnet.ibm.com>
References: <cover.1507557166.git.alifm@linux.vnet.ibm.com>
	<6a8ea4c503ee32c2ca7fa608b5f2f547009be8ee.1507557166.git.alifm@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] virtio-ccw: Add the virtio-input
 devices for CCW bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, thuth@redhat.com

On Mon,  9 Oct 2017 10:01:50 -0400
Farhan Ali <alifm@linux.vnet.ibm.com> wrote:

> Wire up the virtio-input HID devices (keyboard, mouse, tablet)
> for the CCW bus. The virtio-input is a virtio-1 device,
> so disable legacy revision 0.
> 
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/virtio-ccw.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/s390x/virtio-ccw.h |  22 +++++++++++
>  2 files changed, 122 insertions(+)

Finally, a keyboard and a mouse on the mainframe - a dream has come
true 8)

Thanks, applied.
