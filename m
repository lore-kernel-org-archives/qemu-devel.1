Received: from eggs.gnu.org ([2001:4830:134:3::10]:36293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gA9Ry-0005dj-TW
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gA9Rn-0000bZ-KP
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:02:33 -0400
Date: Wed, 10 Oct 2018 10:01:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181010100156.2679561b.cohuck@redhat.com>
In-Reply-To: <20181009175226.22138-2-akrowiak@linux.vnet.ibm.com>
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-2-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 1/6] linux-headers: linux header
 updates for AP support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, fiuczy@linux.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

On Tue,  9 Oct 2018 13:52:21 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> Updates the linux header files in preparation for introduction
> of the VFIO AP device:
> 
> * Added device attributes to the KVM_S390_VM_CRYPTO group
>   to indicate whether AP instructions are to be interpreted
> 
> * Added VFIO device information for AP devices
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  linux-headers/asm-s390/kvm.h | 2 ++
>  linux-headers/linux/vfio.h   | 2 ++
>  2 files changed, 4 insertions(+)

The needed changes are all in kvm/next, and we're near the next Linux
merge window, so I'll just replace this one with a proper header sync
against kvm/next.
