Received: from eggs.gnu.org ([2001:4830:134:3::10]:52192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cGo4u-0000J0-VU
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cGo4r-00056E-1i
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:29:12 -0500
References: <20161212040603.27295-1-david@gibson.dropbear.id.au>
	<20161212040603.27295-3-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <4431c63f-7ecc-d38b-df05-a428c0b98a63@redhat.com>
Date: Tue, 13 Dec 2016 15:29:05 +0100
MIME-Version: 1.0
In-Reply-To: <20161212040603.27295-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv3 2/5] pseries: Stubs for HPT resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org, sjitindarsingh@gmail.com
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, thuth@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org



On 12/12/2016 05:06, David Gibson wrote:
> This introduces stub implementations of the H_RESIZE_HPT_PREPARE and
> H_RESIZE_HPT_COMMIT hypercalls which we hope to add in a PAPR
> extension to allow run time resizing of a guest's hash page table.  It
> also adds a new machine property for controlling whether this new
> facility is available, and logic to check that against availability
> with KVM (only supported with KVM PR for now).
> 
> Finally, it adds a new string to the hypertas property in the device
> tree, advertising to the guest the availability of the HPT resizing
> hypercalls.  This is a tentative suggested value, and would need to be
> standardized by PAPR before being merged.

Could you explain somewhere what is the aim of the "flags" parameter?
It could help to understand why we have it as it is not used.

Thanks,
Laurent
