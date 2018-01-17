Received: from eggs.gnu.org ([2001:4830:134:3::10]:47772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebojr-0004gC-VB
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:30:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebojn-0004hy-V9
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:30:51 -0500
References: <20180117141849.65757-1-borntraeger@de.ibm.com>
	<20180117141849.65757-3-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <bd0d62c3-9243-931b-a539-b32b3fc19cf9@redhat.com>
Date: Wed, 17 Jan 2018 15:30:38 +0100
MIME-Version: 1.0
In-Reply-To: <20180117141849.65757-3-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] s390x/kvm: Handle bpb feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

On 17.01.2018 15:18, Christian Borntraeger wrote:
> We need to handle the bpb control on reset and migration. Normally
> stfle.82 is transparent (and the normal guest part works without
> hypervisor activity). To prevent any issues we require full
> host kernel support for this feature.

Actually it is not transparent because we need hypervisor support to get
VSIE running... or what am I missing? (or were you talking about bit 81?)


-- 

Thanks,

David / dhildenb
