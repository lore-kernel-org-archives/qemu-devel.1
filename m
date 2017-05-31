Received: from eggs.gnu.org ([2001:4830:134:3::10]:53683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dFx3K-0001Li-3g
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dFx3E-0001Xd-Ts
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:24:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:52538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dFx3E-0001Wl-Jr
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:24:12 -0400
Date: Wed, 31 May 2017 14:24:07 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20170531062407.ejyylcimoxkfhhrn@hz-desktop>
References: <20170526022438.17478-1-haozhong.zhang@intel.com>
	<20170526022438.17478-2-haozhong.zhang@intel.com>
	<20170530091624.GE11362@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170530091624.GE11362@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH 2/2] hostmem-file: add an attribute 'align'
 to set its alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <guangrong.xiao@gmail.com>, Dan Williams <dan.j.williams@intel.com>

On 05/30/17 10:16 +0100, Stefan Hajnoczi wrote:
> On Fri, May 26, 2017 at 10:24:38AM +0800, Haozhong Zhang wrote:
> > file_ram_alloc() currently maps the backend file via mmap to a virtual
> > address aligned to the value returned by qemu_fd_getpagesize(). When a
> > DAX device (e.g. /dev/dax0.0) is used as the backend file, its kernel
> > mmap implementation may require an alignment larger than what
> > qemu_fd_get_pagesize() returns (e.g. 2MB vs. 4KB), and mmap may fail.
> > 
> > This commit adds an attribute 'align' to hostmem-file, so that users
> > can specify a proper alignment that satisfies the kernel requirement.
> > 
> > If 'align' is not specified or is 0, the value returned by
> > qemu_fd_get_pagesize() will be used as before.
> 
> How are users supposed to determine alignment requirements?

As discussed in another thread [1,2], the alignment of device-dax can
be got from /sys/dev/char/$major:$minor/device/align, and I'll let
QEMU read the value from it instead of user input.

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg06235.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg06189.html

Haozhong
