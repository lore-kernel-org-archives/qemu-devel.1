Received: from eggs.gnu.org ([2001:4830:134:3::10]:59884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ficMf-00022u-2c
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 05:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ficMb-0000Wm-GZ
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 05:15:16 -0400
Date: Thu, 26 Jul 2018 11:15:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180726111506.6256947b.cohuck@redhat.com>
In-Reply-To: <1532521224-27235-2-git-send-email-thuth@redhat.com>
References: <1532521224-27235-1-git-send-email-thuth@redhat.com>
	<1532521224-27235-2-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 01/10] hw/s390x/virtio-ccw:
 Consolidate calls to virtio_ccw_unrealize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

On Wed, 25 Jul 2018 14:20:15 +0200
Thomas Huth <thuth@redhat.com> wrote:

> Currently, every virtio-ccw device explicitely sets its unrealize
> function to virtio_ccw_unrealize() in its class_init function.
> We can simplify this by using a common unrealize function, just like
> it is already done for the realize functions.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/virtio-ccw.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)

LGTM now :)
