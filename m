Received: from eggs.gnu.org ([2001:4830:134:3::10]:55832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e2Gzf-000173-N0
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e2Gza-0004uE-Mv
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:24:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e2Gza-0004t0-HR
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:24:10 -0400
References: <cover.1507557166.git.alifm@linux.vnet.ibm.com>
	<6a8ea4c503ee32c2ca7fa608b5f2f547009be8ee.1507557166.git.alifm@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9e5604bb-f4b7-9fe7-e079-6fdcf0330551@redhat.com>
Date: Wed, 11 Oct 2017 15:24:06 +0200
MIME-Version: 1.0
In-Reply-To: <6a8ea4c503ee32c2ca7fa608b5f2f547009be8ee.1507557166.git.alifm@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Farhan Ali <alifm@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, pasic@linux.vnet.ibm.com

On 09.10.2017 16:01, Farhan Ali wrote:
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

Looks fine to me.

Reviewed-by: Thomas Huth <thuth@redhat.com>
