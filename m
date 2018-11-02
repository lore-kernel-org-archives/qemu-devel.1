Received: from eggs.gnu.org ([2001:4830:134:3::10]:44689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gIYxz-0000U0-HJ
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gIYxo-00063D-KW
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:54:20 -0400
References: <1541154621-22423-1-git-send-email-pmorel@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9d08961f-a29c-67e5-4ed4-3014d603b169@redhat.com>
Date: Fri, 2 Nov 2018 13:53:52 +0100
MIME-Version: 1.0
In-Reply-To: <1541154621-22423-1-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/5] s390x/vfio: VFIO-AP interrupt
 control interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc: cohuck@redhat.com, agraf@suse.de, rth@twiddle.net, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com

On 02.11.18 11:30, Pierre Morel wrote:
> The S390 APQP/AQIC instruction can be intercepted by the host
> to configure the AP queues interruption handling for and handle
> the ISC used by the host and the guest and the indicator address.
> 
> This patch series define the AQIC feature in the cpumodel,
> extend the APDevice type for per queue interrupt handling,
> intercept the APQP/AQIC instruction, uses the S390 adapter interface
> to setup the adapter and use a VFIO ioctl to let the VFIO-AP
> driver handle the host instruction associated with the intercepted
> guest instruction.
> 
> This patch serie can be tested with the Linux/KVM patch series
> for the VFIO-AP driver: "s390: vfio: ap: Using GISA for AP Interrupt"
> 
> Pierre Morel (5):
>   s390x/vfio: ap: Linux uapi VFIO place holder
>   s390x/cpumodel: Set up CPU model for AQIC interception
>   s390x/vfio: ap: Definition for AP Adapter type
>   s390x/vfio: ap: Intercepting AP Queue Interrupt Control
>   s390x/vfio: ap: Implementing AP Queue Interrupt Control
> 
>  hw/vfio/ap.c                    | 100 ++++++++++++++++++++++++++++++++
>  include/hw/s390x/ap-device.h    |  55 ++++++++++++++++++
>  include/hw/s390x/css.h          |   1 +
>  linux-headers/linux/vfio.h      |  22 +++++++
>  target/s390x/cpu_features.c     |   1 +
>  target/s390x/cpu_features_def.h |   1 +
>  target/s390x/cpu_models.c       |   1 +
>  target/s390x/kvm.c              |  20 +++++++
>  8 files changed, 201 insertions(+)
> 

I had a very quick high level look at it and it seems to be in general fine.

-- 

Thanks,

David / dhildenb
