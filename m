Received: from eggs.gnu.org ([2001:4830:134:3::10]:43429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e5BDC-0008VU-95
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e5BD7-0000pc-Vh
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:50:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41564
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e5BD7-0000oF-Q9
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:50:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9JDmbTL139775
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 09:50:06 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dpu4295n7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 09:50:05 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 19 Oct 2017 14:50:04 +0100
References: <1508336428-20511-1-git-send-email-thuth@redhat.com>
	<1508336428-20511-3-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 19 Oct 2017 15:49:59 +0200
MIME-Version: 1.0
In-Reply-To: <1508336428-20511-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9b7cc5f1-3ae5-4a84-c5e8-2412a3977bdb@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 2/2] tests: Enable the very
 simple virtio tests on s390x, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, Eric Blake <eblake@redhat.com>, Amit Shah <amit@kernel.org>, Michael S Tsirkin <mst@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

On 10/18/2017 04:20 PM, Thomas Huth wrote:
> These tests can easily be used on s390x, too. We just have to make
> sure to use the virtio-xxx-ccw devices instead of virtio-xxx-pci.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include      |  9 ++++++---
>  tests/virtio-balloon-test.c |  8 +++++---
>  tests/virtio-console-test.c | 19 +++++++++++--------
>  tests/virtio-serial-test.c  | 10 ++++++----
>  4 files changed, 28 insertions(+), 18 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 4ca15e6..70dc711 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -367,6 +367,9 @@ check-qtest-s390x-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
>  check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
>  check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
>  check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
> +check-qtest-s390x-y += tests/virtio-balloon-test$(EXESUF)
> +check-qtest-s390x-y += tests/virtio-console-test$(EXESUF)
> +check-qtest-s390x-y += tests/virtio-serial-test$(EXESUF)
> 
>  check-qtest-generic-y += tests/qom-test$(EXESUF)
>  check-qtest-generic-y += tests/test-hmp$(EXESUF)
> @@ -754,14 +757,14 @@ tests/vmxnet3-test$(EXESUF): tests/vmxnet3-test.o
>  tests/ne2000-test$(EXESUF): tests/ne2000-test.o
>  tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
>  tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
> -tests/virtio-balloon-test$(EXESUF): tests/virtio-balloon-test.o
> +tests/virtio-balloon-test$(EXESUF): tests/virtio-balloon-test.o $(libqos-virtio-obj-y)
>  tests/virtio-blk-test$(EXESUF): tests/virtio-blk-test.o $(libqos-virtio-obj-y)
>  tests/virtio-net-test$(EXESUF): tests/virtio-net-test.o $(libqos-pc-obj-y) $(libqos-virtio-obj-y)
>  tests/virtio-rng-test$(EXESUF): tests/virtio-rng-test.o $(libqos-pc-obj-y)
>  tests/virtio-scsi-test$(EXESUF): tests/virtio-scsi-test.o $(libqos-virtio-obj-y)
>  tests/virtio-9p-test$(EXESUF): tests/virtio-9p-test.o $(libqos-virtio-obj-y)
> -tests/virtio-serial-test$(EXESUF): tests/virtio-serial-test.o
> -tests/virtio-console-test$(EXESUF): tests/virtio-console-test.o
> +tests/virtio-serial-test$(EXESUF): tests/virtio-serial-test.o $(libqos-virtio-obj-y)
> +tests/virtio-console-test$(EXESUF): tests/virtio-console-test.o $(libqos-virtio-obj-y)
>  tests/tpci200-test$(EXESUF): tests/tpci200-test.o
>  tests/display-vga-test$(EXESUF): tests/display-vga-test.o
>  tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
> diff --git a/tests/virtio-balloon-test.c b/tests/virtio-balloon-test.c
> index 0d0046b..0a07e03 100644
> --- a/tests/virtio-balloon-test.c
> +++ b/tests/virtio-balloon-test.c
> @@ -9,9 +9,10 @@
> 
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
> +#include "libqos/virtio.h"
> 
>  /* Tests only initialization so far. TODO: Replace with functional tests */
> -static void pci_nop(void)
> +static void balloon_nop(void)
>  {
>  }
> 
> @@ -20,9 +21,10 @@ int main(int argc, char **argv)
>      int ret;
> 
>      g_test_init(&argc, &argv, NULL);
> -    qtest_add_func("/virtio/balloon/pci/nop", pci_nop);
> +    qtest_add_func("/virtio/balloon/nop", balloon_nop);
> 
> -    qtest_start("-device virtio-balloon-pci");
> +    global_qtest = qtest_startf("-device virtio-balloon-%s",
> +                                qvirtio_get_dev_type());
>      ret = g_test_run();
> 
>      qtest_end();
> diff --git a/tests/virtio-console-test.c b/tests/virtio-console-test.c
> index 1c3de07..945bae5 100644
> --- a/tests/virtio-console-test.c
> +++ b/tests/virtio-console-test.c
> @@ -9,27 +9,30 @@
> 
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
> +#include "libqos/virtio.h"
> 
>  /* Tests only initialization so far. TODO: Replace with functional tests */
> -static void console_pci_nop(void)
> +static void console_nop(void)
>  {
> -    qtest_start("-device virtio-serial-pci,id=vser0 "
> -                "-device virtconsole,bus=vser0.0");
> +    global_qtest = qtest_startf("-device virtio-serial-%s,id=vser0 "
> +                                "-device virtconsole,bus=vser0.0",
> +                                qvirtio_get_dev_type());
>      qtest_end();
>  }
> 
> -static void serialport_pci_nop(void)
> +static void serialport_nop(void)
>  {
> -    qtest_start("-device virtio-serial-pci,id=vser0 "
> -                "-device virtserialport,bus=vser0.0");
> +    global_qtest = qtest_startf("-device virtio-serial-%s,id=vser0 "
> +                                "-device virtserialport,bus=vser0.0",
> +                                qvirtio_get_dev_type());
>      qtest_end();
>  }
> 
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> -    qtest_add_func("/virtio/console/pci/nop", console_pci_nop);
> -    qtest_add_func("/virtio/serialport/pci/nop", serialport_pci_nop);
> +    qtest_add_func("/virtio/console/nop", console_nop);
> +    qtest_add_func("/virtio/serialport/nop", serialport_nop);
> 
>      return g_test_run();
>  }
> diff --git a/tests/virtio-serial-test.c b/tests/virtio-serial-test.c
> index 7d1517d..7cc7060 100644
> --- a/tests/virtio-serial-test.c
> +++ b/tests/virtio-serial-test.c
> @@ -9,9 +9,10 @@
> 
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
> +#include "libqos/virtio.h"
> 
>  /* Tests only initialization so far. TODO: Replace with functional tests */
> -static void pci_nop(void)
> +static void virtio_serial_nop(void)
>  {
>  }
> 
> @@ -27,10 +28,11 @@ int main(int argc, char **argv)
>      int ret;
> 
>      g_test_init(&argc, &argv, NULL);
> -    qtest_add_func("/virtio/serial/pci/nop", pci_nop);
> -    qtest_add_func("/virtio/serial/pci/hotplug", hotplug);
> +    qtest_add_func("/virtio/serial/nop", virtio_serial_nop);
> +    qtest_add_func("/virtio/serial/hotplug", hotplug);
> 
> -    qtest_start("-device virtio-serial-pci");
> +    global_qtest = qtest_startf("-device virtio-serial-%s",
> +                                qvirtio_get_dev_type());
>      ret = g_test_run();
> 
>      qtest_end();
> 
