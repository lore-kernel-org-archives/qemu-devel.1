Received: from eggs.gnu.org ([2001:4830:134:3::10]:41212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dsS7J-0002ZZ-Uc
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dsS7F-000160-81
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:15:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dsS7F-00014x-1U
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:15:29 -0400
Date: Thu, 14 Sep 2017 13:15:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170914131524.3a24ff46.cohuck@redhat.com>
In-Reply-To: <20170914105535.47941-1-pasic@linux.vnet.ibm.com>
References: <20170914105535.47941-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio-ccw: remove stale comments on
 endiannes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Thu, 14 Sep 2017 12:55:35 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> We have two stale comments suggesting one should think about virtio
> config space endiannes a bit longer. We have just done that, and came to
> the conclusion we are fine as is: it's the responsibility of the virtio
> device and not of the transport (and that is how it works now). Putting
> the responsibility into the transport isn't even possible, because the
> transport would have to know about the config space layout of each
> device.

s/endianes/endianess/

> Let us remove the stale comments.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/virtio-ccw.c | 2 --
>  1 file changed, 2 deletions(-)

Thanks, applied.
