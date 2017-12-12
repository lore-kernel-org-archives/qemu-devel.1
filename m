Received: from eggs.gnu.org ([2001:4830:134:3::10]:34940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOiDC-0000a4-7T
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 05:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOiD9-0005mG-5O
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 05:54:58 -0500
References: <20171211134740.8235-1-david@redhat.com>
	<20171211134740.8235-5-david@redhat.com>
	<20171211181754.4a3b847d.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d8f736b5-ef43-9e10-0339-1246c6f42e93@redhat.com>
Date: Tue, 12 Dec 2017 11:54:51 +0100
MIME-Version: 1.0
In-Reply-To: <20171211181754.4a3b847d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2-12 04/15] s390x/flic: simplify
 flic initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>

> 
> Do we want to switch to the same pattern for the storage attribute
> device as well?
> 

Unfortunately not that easy due to the KVM capability check. Will leave
it as is for now.

> Change looks fine to me.
> 


-- 

Thanks,

David / dhildenb
