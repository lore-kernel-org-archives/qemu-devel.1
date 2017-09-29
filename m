Received: from eggs.gnu.org ([2001:4830:134:3::10]:55329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxrMv-00040Q-Ns
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxrMv-0002VH-0P
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:14:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dxrMu-0002UY-Pf
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:14:00 -0400
Date: Fri, 29 Sep 2017 11:13:54 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170929111354.13499275.cohuck@redhat.com>
In-Reply-To: <20170928134609.16985-1-david@redhat.com>
References: <20170928134609.16985-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/5] s390x: CPU related cleanups and one
 fix
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>
List-ID: <qemu-devel.nongnu.org>

On Thu, 28 Sep 2017 15:46:04 +0200
David Hildenbrand <david@redhat.com> wrote:

> Patch 2-5 are split out from the series "[PATCH v1 00/27] s390x: SMP for
> TCG (+ cleanups)"
> 
> They make sense even without the SMP TCG changes, which could still take
> a while.
> 
> David Hildenbrand (5):
>   MAINTAINERS: use KVM s390x maintainers for kvm-stubs.c and kvm_s390x.h
>   s390x: raise CPU hotplug irq after really hotplugged
>   s390x/cpumodel: fix max STFL(E) bit number
>   target/s390x: get rid of next_core_id
>   s390x: introduce and use S390_MAX_CPUS
> 
>  MAINTAINERS                 |  2 ++
>  hw/s390x/s390-virtio-ccw.c  |  6 +++++-
>  target/s390x/cpu-qom.h      |  2 --
>  target/s390x/cpu.c          | 22 +++++++---------------
>  target/s390x/cpu.h          |  4 ++++
>  target/s390x/cpu_features.c |  2 +-
>  target/s390x/cpu_models.c   |  2 ++
>  7 files changed, 21 insertions(+), 19 deletions(-)
> 

Thanks, applied.
