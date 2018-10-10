Received: from eggs.gnu.org ([2001:4830:134:3::10]:36149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gAD3x-0004s1-4d
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:54:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gAD3s-0003BJ-4K
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:54:01 -0400
Date: Wed, 10 Oct 2018 13:53:42 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181010135342.28e756d6.cohuck@redhat.com>
In-Reply-To: <1bad0d3d-4c6e-4330-b0f1-90a411edb27f@linux.ibm.com>
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-4-akrowiak@linux.vnet.ibm.com>
	<1bad0d3d-4c6e-4330-b0f1-90a411edb27f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, david@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, pbonzini@redhat.com

On Wed, 10 Oct 2018 13:38:51 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 10/09/2018 07:52 PM, Tony Krowiak wrote:

> > +static void kvm_s390_configure_apie(bool interpret)
> > +{
> > +    uint64_t attr = interpret ? KVM_S390_VM_CRYPTO_ENABLE_APIE :
> > +                                KVM_S390_VM_CRYPTO_DISABLE_APIE;
> > +
> > +    if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, attr)) {  
> 
> Not sure this check is necessary, and that the behavior if it fails
> is intuitive, but whatever.

It's not an uncommon pattern, and this is not a call where performance
matters, so it's fine with me.

> 
> > +        kvm_s390_set_attr(attr);
> > +    }
> > +}
> > +
