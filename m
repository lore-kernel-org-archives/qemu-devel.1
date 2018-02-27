Received: from eggs.gnu.org ([2001:4830:134:3::10]:36881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eqjUe-0003h3-Hz
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eqjUb-0005ux-IB
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:56:48 -0500
References: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1519746259-27710-6-git-send-email-akrowiak@linux.vnet.ibm.com>
	<20180227172750.287cf563.cohuck@redhat.com>
	<603c3118-63b3-c144-56e1-3e6301936c9b@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1c35f4c2-2196-9192-1519-43729c153a0c@redhat.com>
Date: Tue, 27 Feb 2018 18:56:36 +0100
MIME-Version: 1.0
In-Reply-To: <603c3118-63b3-c144-56e1-3e6301936c9b@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/5] s390x/cpumodel: Set up CPU model
 for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

>> Hm, do you need this twice?
> 
> In my opinion this has only value if we assume that HW and/or KVM is buggy and
> we are running host model (or it's expansion).
> 

The "sanity" checks in KVM sensing code don't really hurt. But I agree,
sane KVM should not produce this.

> And even the we would get a warning, and nothing bad would happen with a linux
> guest.
> 
> While I'm not strongly opposing this, I would not mind it dropped. If we want
> to make sure things are consistent I would prefer the consistency check being
> generating an error (instead of a warning).
> 

We use a warning as it is helpful for development (e.g. under TCG you
can enable msa5, although we yield a warning due to a failing
consistency check).

-- 

Thanks,

David / dhildenb
