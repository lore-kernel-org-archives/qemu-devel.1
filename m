Received: from eggs.gnu.org ([2001:4830:134:3::10]:49988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e84jm-0001eD-3j
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e84ji-0003U3-Vz
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:31:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e84ji-0003Tb-QR
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:31:46 -0400
Date: Fri, 27 Oct 2017 15:31:36 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171027153136.5e5eeb62.cohuck@redhat.com>
In-Reply-To: <b76b2832-8e14-43fe-ea9b-23e6bf330bf6@de.ibm.com>
References: <20171020145437.18549-1-borntraeger@de.ibm.com>
	<c76678f3-70df-e963-12b8-208c5c2a1578@linux.vnet.ibm.com>
	<b40f75d4-2280-fc66-b92f-34717b51ed47@linux.vnet.ibm.com>
	<b76b2832-8e14-43fe-ea9b-23e6bf330bf6@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/QEMU] s390x/kvm: use cpu_model_available
 for guarded storage on compat machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, jjherne@linux.vnet.ibm.com, Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, libvir-list@redhat.com, Jiri Denemark <jdenemar@redhat.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On Fri, 27 Oct 2017 14:42:57 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Yes, we should also replace that with
> 
>  return s390_has_feat(S390_FEAT_GUARDED_STORAGE)
> 
> I can fixup my patch or provide a 2nd one.
> 

Consider a fixed up patch acked by me.
