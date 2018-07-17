Received: from eggs.gnu.org ([2001:4830:134:3::10]:49212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffORb-0001KK-Gu
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffORW-0002KN-Hk
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:47:03 -0400
References: <20180717113402.5510-1-quintela@redhat.com>
	<20180717113402.5510-9-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fa109681-6838-6ed8-2640-4e2ed405bcf9@redhat.com>
Date: Tue, 17 Jul 2018 13:46:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180717113402.5510-9-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/25] check: Only test rtl8139 when it is
 compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, Qemu-s390x list <qemu-s390x@nongnu.org>

On 17.07.2018 13:33, Juan Quintela wrote:
> test-file-redirector uses rtl8139 in everything except s390.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/Makefile.include | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index a039b70f9b..c6156fe105 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -213,8 +213,8 @@ check-qtest-pci-y += tests/e1000-test$(EXESUF)
>  gcov-files-pci-y += hw/net/e1000.c
>  check-qtest-pci-y += tests/e1000e-test$(EXESUF)
>  gcov-files-pci-y += hw/net/e1000e.c hw/net/e1000e_core.c
> -check-qtest-pci-y += tests/rtl8139-test$(EXESUF)
> -gcov-files-pci-y += hw/net/rtl8139.c
> +check-qtest-pci-$(CONFIG_RTL8139_PCI) += tests/rtl8139-test$(EXESUF)
> +gcov-files-pci-$(CONFIG_RTL8139_PCI) += hw/net/rtl8139.c
>  check-qtest-pci-$(CONFIG_PCNET_PCI) += tests/pcnet-test$(EXESUF)
>  gcov-files-pci-$(CONFIG_PCNET_PCI) += hw/net/pcnet.c
>  gcov-files-pci-$(CONFIG_PCNET_PCI) += hw/net/pcnet-pci.c
> @@ -302,7 +302,7 @@ check-qtest-i386-$(CONFIG_TPM) += tests/tpm-tis-swtpm-test$(EXESUF)
>  check-qtest-i386-$(CONFIG_TPM) += tests/tpm-tis-test$(EXESUF)
>  check-qtest-i386-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
>  check-qtest-i386-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
> -check-qtest-i386-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
> +check-qtest-i386-$(CONFIG_RTL8139_PCI) += tests/test-filter-redirector$(EXESUF)
>  check-qtest-i386-y += tests/migration-test$(EXESUF)
>  check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
>  check-qtest-i386-y += tests/numa-test$(EXESUF)
> @@ -352,7 +352,7 @@ gcov-files-ppc64-y += hw/usb/hcd-xhci.c
>  check-qtest-ppc64-y += $(check-qtest-virtio-y)
>  check-qtest-ppc64-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
> -check-qtest-ppc64-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
> +check-qtest-ppc64-$(CONFIG_RTL8139_PCI) += tests/test-filter-redirector$(EXESUF)
>  check-qtest-ppc64-y += tests/display-vga-test$(EXESUF)
>  check-qtest-ppc64-y += tests/numa-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_IVSHMEM) += tests/ivshmem-test$(EXESUF)

Reviewed-by: Thomas Huth <thuth@redhat.com>
