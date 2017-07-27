Received: from eggs.gnu.org ([2001:4830:134:3::10]:40473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dae84-0005LR-Av
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dae81-0005Gi-0M
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:26:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dae80-0005GL-Qf
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:26:40 -0400
Date: Thu, 27 Jul 2017 10:26:36 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170727102636.43d6a789@gondolin>
In-Reply-To: <20170725224442.13383-1-pasic@linux.vnet.ibm.com>
References: <20170725224442.13383-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] ccw interpretation AR compliance
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Wed, 26 Jul 2017 00:44:40 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> There were some missing checks. There might be some more missing.  For details,
> see the individual patches.

The checks are not perfect? Colour me shocked ;)

> 
> Regarding testing: did not do much more than a simple smoke test
> with virtio-ccw.

I think we need a way to throw random channel programs at a channel
device...

> 
> Halil Pasic (2):
>   s390x/css: check ccw address validity
>   s390x/css: fix bits must be zero check for TIC
> 
>  hw/s390x/css.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
