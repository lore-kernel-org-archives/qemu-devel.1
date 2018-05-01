Received: from eggs.gnu.org ([2001:4830:134:3::10]:36974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fDYj3-0005ZE-25
	for qemu-devel@nongnu.org; Tue, 01 May 2018 13:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fDYiz-0000yI-T4
	for qemu-devel@nongnu.org; Tue, 01 May 2018 13:06:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fDYiz-0000xs-Mz
	for qemu-devel@nongnu.org; Tue, 01 May 2018 13:05:57 -0400
Date: Tue, 1 May 2018 11:05:51 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180501110551.55d88528@w520.home>
In-Reply-To: <152519378671.2439.1373788398394753477@71c20359a636>
References: <20180501162901.28940.1075.stgit@gimli.home>
	<152519378671.2439.1373788398394753477@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] vfio/quirks: ioeventfd support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, famz@redhat.com, eric.auger@redhat.com, peterx@redhat.com, kvm@vger.kernel.org

On Tue, 1 May 2018 09:56:27 -0700 (PDT)
no-reply@patchew.org wrote:

> Hi,
> 
> This series failed docker-build@min-glib build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> Type: series
> Message-id: 20180501162901.28940.1075.stgit@gimli.home
> Subject: [Qemu-devel] [PATCH v2 0/4] vfio/quirks: ioeventfd support
> ...
> /tmp/qemu-test/src/hw/vfio/pci-quirks.c: In function 'vfio_ioeventfd_exit':
> /tmp/qemu-test/src/hw/vfio/pci-quirks.c:300: error: storage size of 'vfio_ioeventfd' isn't known
> /tmp/qemu-test/src/hw/vfio/pci-quirks.c:309: error: 'VFIO_DEVICE_IOEVENTFD' undeclared (first use in this function)
> /tmp/qemu-test/src/hw/vfio/pci-quirks.c:309: error: (Each undeclared identifier is reported only once
> /tmp/qemu-test/src/hw/vfio/pci-quirks.c:309: error: for each function it appears in.)
> /tmp/qemu-test/src/hw/vfio/pci-quirks.c:300: warning: unused variable 'vfio_ioeventfd'
> /tmp/qemu-test/src/hw/vfio/pci-quirks.c: In function 'vfio_ioeventfd_init':
> /tmp/qemu-test/src/hw/vfio/pci-quirks.c:384: error: storage size of 'vfio_ioeventfd' isn't known
> /tmp/qemu-test/src/hw/vfio/pci-quirks.c:394: error: 'VFIO_DEVICE_IOEVENTFD' undeclared (first use in this function)
> /tmp/qemu-test/src/hw/vfio/pci-quirks.c:384: warning: unused variable 'vfio_ioeventfd'

Fails to build because of header dependency noted in the cover letter,
expected.  Thanks,

Alex
