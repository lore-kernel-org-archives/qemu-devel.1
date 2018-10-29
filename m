Received: from eggs.gnu.org ([2001:4830:134:3::10]:59735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHBLj-0006YB-GZ
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHBLf-0004rh-Eq
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:29:11 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181029162441.31631-1-sameo@linux.intel.com>
Date: Mon, 29 Oct 2018 18:28:48 +0100
In-Reply-To: <20181029162441.31631-1-sameo@linux.intel.com> (Samuel Ortiz's
	message of "Mon, 29 Oct 2018 17:24:22 +0100")
Message-ID: <874ld4mzlb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 00/19] ACPI reorganization for
 hardware-reduced support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org

You neglected to cc: maintainers.  I'm doing that for you now.
scripts/get_maintainer.pl can help you finding maintainers.

Samuel Ortiz <sameo@linux.intel.com> writes:

> This patch set provides an ACPI code reorganization in preparation for
> adding hardware-reduced support to QEMU.
>
> The changes are coming from the NEMU [1] project where we're defining
> a new x86 machine type: i386/virt. This is an EFI only, ACPI
> hardware-reduced platform and as such we had to implement support
> for the latter.
>
> As a preliminary for adding hardware-reduced support to QEMU, we did
> some ACPI code reorganization with the following goals:
>
> * Share as much as possible of the current ACPI build APIs between
>   legacy and hardware-reduced ACPI.
> * Share the ACPI build code across machine types and architectures and
>   remove the typical PC machine type dependency.
>   Eventually we hope to see arm/virt also re-use much of that code.
>
> The patches are also available in their own git branch [2].
>
> [1] https://github.com/intel/nemu
> [2] https://github.com/intel/nemu/tree/topic/upstream/acpi
>
> v1 -> v2:
>    * Drop the hardware-reduced implementation for now. Our next patch set
>      will add hardware-reduced and convert arm/virt to it.
>    * Implement the ACPI build methods as a QOM Interface Class and convert
>      the PC machine type to it.
[...]
