Received: from eggs.gnu.org ([2001:4830:134:3::10]:37970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e2ZCW-0003NF-1E
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 04:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e2ZCR-0001cA-2X
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 04:50:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1e2ZCQ-0001bZ-Rz
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 04:50:38 -0400
Date: Thu, 12 Oct 2017 09:50:31 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171012085031.GA1959@stefanha-x1.localdomain>
References: <20171011185146.20295-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171011185146.20295-1-pagupta@redhat.com>
Subject: Re: [Qemu-devel] [RFC] KVM "fake DAX" device flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, linux-mm@kvack.org, jack@suse.cz, dan.j.williams@intel.com, riel@redhat.com, haozhong.zhang@intel.com, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, ross.zwisler@intel.com, david@redhat.com, xiaoguangrong.eric@gmail.com

On Thu, Oct 12, 2017 at 12:21:46AM +0530, Pankaj Gupta wrote:
> We are sharing the prototype version of 'fake DAX' flushing
> interface for the initial feedback. This is still work in progress
> and not yet ready for merging.
> 
> Protoype right now just implements basic functionality without advanced
> features with two major parts:
> 
> - Qemu virtio-pmem device
>   It exposes a persistent memory range to KVM guest which at host side is file
>   backed memory and works as persistent memory device. In addition to this it
>   provides a virtio flushing interface for KVM guest to do a Qemu side sync for
>   guest DAX persistent memory range.

Please post a draft VIRTIO device specification.

The VIRTIO Technical Committee resources and mailing lists are here:

https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback

Stefan
