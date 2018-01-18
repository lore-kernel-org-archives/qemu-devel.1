Received: from eggs.gnu.org ([2001:4830:134:3::10]:55087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ec8l8-0003yZ-EW
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:53:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ec8l7-0000Rv-7W
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:53:30 -0500
Date: Thu, 18 Jan 2018 12:53:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180118125322.252929dc.cohuck@redhat.com>
In-Reply-To: <20180118085628.40798-1-borntraeger@de.ibm.com>
References: <20180118085628.40798-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] s390x/kvm: implement new
 hardware/firmware features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

On Thu, 18 Jan 2018 09:56:25 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> We want to provide more hw features to guests, namely the new bpb
> control as well as other transparent facilities that might be
> introduced by firmware updates (e.g. the stfle facility 81).
> 
> See the kernel discussion for the KVM side
> https://www.spinics.net/lists/kernel/msg2700551.html
> 
> v2->v3: - use bool for bpbc
> 	- sort cpu facilities
> v1->v2: - style and comment fixes
> 	- drop transparent facility patch
> 	- add patch to introduce facility 81
> 
> Christian Borntraeger (3):
>   header sync
>   s390x/kvm: Handle bpb feature
>   s390x/kvm: provide stfle.81
> 
>  linux-headers/asm-s390/kvm.h    |  9 ++++-----
>  linux-headers/linux/kvm.h       |  5 +++--
>  target/s390x/cpu.c              |  1 +
>  target/s390x/cpu.h              |  1 +
>  target/s390x/cpu_features.c     |  2 ++
>  target/s390x/cpu_features_def.h |  2 ++
>  target/s390x/gen-features.c     |  2 ++
>  target/s390x/kvm.c              | 14 ++++++++++++++
>  target/s390x/machine.c          | 17 +++++++++++++++++
>  9 files changed, 46 insertions(+), 7 deletions(-)
> 

Thanks, I've queued this. Once the bpb code lands in Linux, I'll
replace patch 1 with a proper header sync and push to s390-next.
