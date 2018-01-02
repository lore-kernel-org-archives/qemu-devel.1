Received: from eggs.gnu.org ([2001:4830:134:3::10]:35899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eWJSl-0003Wi-2F
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 05:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eWJSh-0000Sy-2F
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 05:06:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eWJSg-0000RV-RV
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 05:06:22 -0500
References: <20180102092359.GA14311@yangzhon-Virtual>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2f7eeac4-759d-627a-d9e6-b991264b5949@redhat.com>
Date: Tue, 2 Jan 2018 11:06:16 +0100
MIME-Version: 1.0
In-Reply-To: <20180102092359.GA14311@yangzhon-Virtual>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] About the patch for Memory: use memory address
 space for cpu-memory!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: qemu-devel@nongnu.org, anthony.xu@intel.com

On 02/01/2018 10:23, Yang Zhong wrote:
> Hello Paolo,
> 
> Happy New Years!
> 
> Did you have plan to implement below your patch into latest Qemu?
> http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg04438.html
> 
> Maybe this patch is still valuable for reducing memory footprint and the bootup time. thanks!

It should not be needed anymore in 2.11, because FlatView and
AddressSpaceDispatch data structures are now shared.  This way, the CPU
address space can share space and time cost with address_space_memory.

Thanks,

Paolo
