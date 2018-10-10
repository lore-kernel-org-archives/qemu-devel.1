Received: from eggs.gnu.org ([2001:4830:134:3::10]:54914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gA8mG-0004cb-5D
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 03:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gA8mE-0004d2-Km
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 03:19:28 -0400
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-4-akrowiak@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bca568dd-b2f1-883d-3aec-7e43955efb34@redhat.com>
Date: Wed, 10 Oct 2018 09:19:12 +0200
MIME-Version: 1.0
In-Reply-To: <20181009175226.22138-4-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v10 3/6] s390x/kvm: enable AP
 instruction interpretation for guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, cohuck@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, pbonzini@redhat.com

On 2018-10-09 19:52, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Let's use the KVM_SET_DEVICE_ATTR ioctl to enable hardware
> interpretation of AP instructions executed on the guest.
> If the S390_FEAT_AP feature is switched on for the guest,
> AP instructions must be interpreted by default; otherwise,
> they will be intercepted.
> 
> This attribute setting may be overridden by a device. For example,
> a device may want to provide AP instructions to the guest (i.e.,
> S390_FEAT_AP turned on), but it may want to emulate them. In this
> case, the AP instructions executed on the guest must be
> intercepted; so when the device is realized, it must disable
> interpretation.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Tested-by: Pierre Morel<pmorel@linux.ibm.com>
> ---
>  target/s390x/kvm.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>
