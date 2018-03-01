Received: from eggs.gnu.org ([2001:4830:134:3::10]:52255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1erJpL-0007KT-64
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:44:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1erJpF-0006aN-R4
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:44:34 -0500
References: <20180228195320.165230-1-borntraeger@de.ibm.com>
	<79f7059b-f2d3-a758-6bb9-29433b31b313@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3e73ea6e-d8c0-4d10-ce9f-a000498df345@redhat.com>
Date: Thu, 1 Mar 2018 09:44:25 +0100
MIME-Version: 1.0
In-Reply-To: <79f7059b-f2d3-a758-6bb9-29433b31b313@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] s390/kvm: implement clearing part of
 IPL clear
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 01/03/2018 04:58, Thomas Huth wrote:
>> When a guests reboots with diagnose 308 subcode 3 it requests the memory
>> to be cleared. We did not do it so far. This does not only violate the
>> architecture, it also misses the chance to free up that memory on
>> reboot, which would help on host memory over commitment.  By using
>> ram_block_discard_range we can cover both cases.
> 
> Sounds like a good idea. I wonder whether that release_all_ram()
> function should maybe rather reside in exec.c, so that other machines
> that want to clear all RAM at reset time can use it, too?

Either way is fine for me.  With s/rams/ram/ the s390-only patch is ok.

Paolo
