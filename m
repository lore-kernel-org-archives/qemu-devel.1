Received: from eggs.gnu.org ([2001:4830:134:3::10]:52707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ef08a-0005QH-JO
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 04:17:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ef08X-00028x-Ez
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 04:17:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ef08X-00028W-90
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 04:17:29 -0500
References: <20180122060244.29368-1-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <05508ddd-ec2f-389f-18de-bcd359d69f00@redhat.com>
Date: Fri, 26 Jan 2018 10:17:13 +0100
MIME-Version: 1.0
In-Reply-To: <20180122060244.29368-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] memory/vfio: notify region_del()
 when unregister listeners
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 22/01/2018 07:02, Peter Xu wrote:
> v2
> - add begin() hooks [Paolo]
> - move vfio patch to front [Paolo]
> - one more patch for arm devlistener unregister [Paolo]
> - one more patch for vhost traces
> - removing RFC tag
> 
> This series fixes bug reported here:
> 
>   https://bugzilla.redhat.com/show_bug.cgi?id=1531393
> 
> The first patch only adds traces for vhost, with which I tested on
> vhost to make sure that my last patch works as expected with vhost.
> Please pick it if anyone wants, or ignore it if no one likes it.
> 
> The 2nd patch is the arm fix for preparation of the last patch.
> 
> The 3rd patch is the vfio fix for preparation of the last patch.
> 
> The 4th patch is the core fix of the problem.
> 
> Please review, thanks.
> 
> Thanks.
> 
> Peter Xu (4):
>   vhost: add traces for memory listeners
>   arm: postpone device listener unregister
>   vfio: listener unregister before unset container
>   memory: do explicit cleanup when remove listeners
> 
>  hw/vfio/common.c       | 16 ++++++++++++----
>  hw/virtio/trace-events |  6 ++++++
>  hw/virtio/vhost.c      | 11 +++++++----
>  memory.c               | 27 +++++++++++++++++++++++++++
>  target/arm/kvm.c       |  2 +-
>  5 files changed, 53 insertions(+), 9 deletions(-)
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Alex, Peter, can you ack or apply patches 2/3?

Thanks,

Paolo
