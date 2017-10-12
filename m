Received: from eggs.gnu.org ([2001:4830:134:3::10]:39233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1e2kJa-0004x9-8N
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1e2kJZ-0002vr-FU
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:42:46 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:44795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1e2kJZ-0002uJ-9f
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:42:45 -0400
Received: by mail-oi0-x233.google.com with SMTP id v132so10439903oie.1
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 13:42:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171012155027.3277-2-pagupta@redhat.com>
References: <20171012155027.3277-1-pagupta@redhat.com>
	<20171012155027.3277-2-pagupta@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 12 Oct 2017 13:42:42 -0700
Message-ID: <CAPcyv4jdWUeoF1PxWhXx3vciLmOL9AyW_yPq0W6DRFe3RP2fkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 1/2] pmem: Move reusable code to base header
 files
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

On Thu, Oct 12, 2017 at 8:50 AM, Pankaj Gupta <pagupta@redhat.com> wrote:
>  This patch moves common code to base header files
>  so that it can be used for both ACPI pmem and VIRTIO pmem
>  drivers. More common code needs to be moved out in future
>  based on functionality required for virtio_pmem driver and
>  coupling of code with existing ACPI pmem driver.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
[..]
> diff --git a/include/linux/pmem_common.h b/include/linux/pmem_common.h
> new file mode 100644
> index 000000000000..e2e718c74b3f
> --- /dev/null
> +++ b/include/linux/pmem_common.h

This should be a common C file, not a header.
