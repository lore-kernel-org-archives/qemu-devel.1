Received: from eggs.gnu.org ([2001:4830:134:3::10]:47893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cxrwT-0002V7-Ks
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cxrwO-0005Nx-6j
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:18:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cxrwN-0005Nc-WA
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:18:24 -0400
References: <1491612336-31066-1-git-send-email-anthony.xu@intel.com>
	<1491612336-31066-5-git-send-email-anthony.xu@intel.com>
	<e6089f9a-a90a-33f7-1e62-9d941619b983@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A589E5@ORSMSX112.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fadbd646-7477-58bc-ea6d-e4ae60020668@redhat.com>
Date: Tue, 11 Apr 2017 17:18:19 +0800
MIME-Version: 1.0
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A589E5@ORSMSX112.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] pam: setup pc.bios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 11/04/2017 09:42, Xu, Anthony wrote:
>> I think this is wrong, the high copy should remain read-only or pflash
>> stops working when you remove PAM.
> 
> I tried to set pc.bios as read-only and isa.bios as read&write,
> it doesn't work. render_memory_region doesn't honor readonly
> field of alias MemoryRegion. 
> 
> Two FlatRanges created for pc.bios and isa.bios point to the same
> MemoryRegion pc.bios. Both get readonly from pc.bios.
> Is this a bug or by design?

Read-write can use an alias to become read-only, but read-only cannot
use an alias to become read-write.

Let's sort this out later.

> Pc.bios and isa.bios are backed by the same memory block,
> so it may cause CPU TLB alias, any issue here?

No, it's okay.

Paolo
