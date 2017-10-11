Received: from eggs.gnu.org ([2001:4830:134:3::10]:59314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1e2Mak-0002Dr-3Q
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1e2Mai-0001na-VE
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:22:54 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:47027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1e2Mai-0001jr-QS
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:22:52 -0400
Received: by mail-oi0-x233.google.com with SMTP id n82so4829406oig.3
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 12:22:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171011185146.20295-1-pagupta@redhat.com>
References: <20171011185146.20295-1-pagupta@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 11 Oct 2017 12:22:41 -0700
Message-ID: <CAPcyv4iav2gjHR63UfZmzp5u6mZciszarqrn=QXnvf+zjjgEUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Rik van Riel <riel@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Nitesh Narayan Lal <nilal@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Zwisler, Ross" <ross.zwisler@intel.com>, David Hildenbrand <david@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

On Wed, Oct 11, 2017 at 11:51 AM, Pankaj Gupta <pagupta@redhat.com> wrote:
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
>
> - Guest virtio-pmem driver
>   Reads persistent memory range from paravirt device and reserves system memory map.
>   It also allocates a block device corresponding to the pmem range which is accessed
>   by DAX capable file systems. (file system support is still pending).
>
> We shared the project idea for 'fake DAX' flushing interface here [1].
> Based on suggestions here [2], we implemented guest 'virtio-pmem'
> driver and Qemu paravirt device.
>
> [1] https://www.spinics.net/lists/kvm/msg149761.html
> [2] https://www.spinics.net/lists/kvm/msg153095.html
>
> Work yet to be done:
>
> - Separate out the common code used by ACPI pmem interface and
>   reuse it.
>
> - In pmem device memmap allocation and working. There is some parallel work
>   going on upstream related to 'memory_hotplug restructuring' [3] and also hitting
>   a memory section alignment issue [4].
>
>   [3] https://lwn.net/Articles/712099/
>   [4] https://www.mail-archive.com/linux-nvdimm@lists.01.org/msg02978.html
>
> - Provide DAX capable file-system(ext4 & XFS) support.
> - Qemu device flush functionality.
> - Qemu live migration work when host page cache is used.
> - Multiple virtio-pmem disks support.
>
> Prototype implementation for feedback:
>
> Kernel: https://github.com/pagupta/linux/commit/d15cf90074eae91aeed7a228da3faf319566dd40

Please send this as a patch so it can be reviewed over email.
