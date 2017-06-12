Received: from eggs.gnu.org ([2001:4830:134:3::10]:33430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dave.hansen@intel.com>) id 1dKSQY-0006lH-Ax
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 12:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dave.hansen@intel.com>) id 1dKSQV-0005Ct-7H
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 12:42:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:52037)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dave.hansen@intel.com>)
	id 1dKSQU-0005BN-Ux
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 12:42:51 -0400
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>
	<20170612181354-mutt-send-email-mst@kernel.org>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <9d0900f3-9df5-ac63-4069-2d796f2a5bc7@intel.com>
Date: Mon, 12 Jun 2017 09:42:36 -0700
MIME-Version: 1.0
In-Reply-To: <20170612181354-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 4/6] mm: function to offer a page block
 on the free list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com

On 06/12/2017 09:28 AM, Michael S. Tsirkin wrote:
> 
>> The hypervisor is going to throw away the contents of these pages,
>> right?
> It should be careful and only throw away contents that was there before
> report_unused_page_block was invoked.  Hypervisor is responsible for not
> corrupting guest memory.  But that's not something an mm patch should
> worry about.

That makes sense.  I'm struggling to imagine how the hypervisor makes
use of this information, though.  Does it make the pages read-only
before this, and then it knows if there has not been a write *and* it
gets notified via this new mechanism that it can throw the page away?
