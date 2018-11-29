Received: from eggs.gnu.org ([2001:4830:134:3::10]:57231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSJng-0001Lo-A0
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:44:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSJne-0005uE-DC
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:44:04 -0500
References: <1543488180-13687-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <788e805b-62c1-4d45-12a6-18e9bb0844ef@redhat.com>
Date: Thu, 29 Nov 2018 11:43:57 +0100
MIME-Version: 1.0
In-Reply-To: <1543488180-13687-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0] tests/Makefile: Use some more
 CONFIG switches for ppc tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, mrezanin@redhat.com, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org

On 29/11/18 11:43, Thomas Huth wrote:
> To be able to build and test QEMU binaries where certain devices or machines
> are disabled, we have to use the right CONFIG_* switches to run certain tests
> only if the corresponding device or machine really has been compiled into
> the binary.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index d87b403..9b26116 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -242,22 +242,22 @@ check-qtest-ppc-y += tests/boot-order-test$(EXESUF)
>  check-qtest-ppc-y += tests/prom-env-test$(EXESUF)
>  check-qtest-ppc-y += tests/drive_del-test$(EXESUF)
>  check-qtest-ppc-y += tests/boot-serial-test$(EXESUF)
> -check-qtest-ppc-y += tests/m48t59-test$(EXESUF)
> +check-qtest-ppc-$(CONFIG_M48T59) += tests/m48t59-test$(EXESUF)
>  
>  check-qtest-ppc64-y += $(check-qtest-ppc-y)
> -check-qtest-ppc64-y += tests/spapr-phb-test$(EXESUF)
> -check-qtest-ppc64-y += tests/pnv-xscom-test$(EXESUF)
> +check-qtest-ppc64-$(CONFIG_PSERIES) += tests/spapr-phb-test$(EXESUF)
> +check-qtest-ppc64-$(CONFIG_POWERNV) += tests/pnv-xscom-test$(EXESUF)
>  check-qtest-ppc64-y += tests/migration-test$(EXESUF)
> -check-qtest-ppc64-y += tests/rtas-test$(EXESUF)
> +check-qtest-ppc64-$(CONFIG_PSERIES) += tests/rtas-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_USB_OHCI) += tests/usb-hcd-ohci-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_USB_UHCI) += tests/usb-hcd-uhci-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
> -check-qtest-ppc64-y += $(check-qtest-virtio-y)
> +check-qtest-ppc64-$(CONFIG_VIRTIO) += $(check-qtest-virtio-y)
>  check-qtest-ppc64-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_RTL8139_PCI) += tests/test-filter-redirector$(EXESUF)
> -check-qtest-ppc64-y += tests/display-vga-test$(EXESUF)
> +check-qtest-ppc64-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
>  check-qtest-ppc64-y += tests/numa-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
>  check-qtest-ppc64-y += tests/cpu-plug-test$(EXESUF)
> 

Same here for CONFIG_VIRTIO and spapr-phb-test.

Thanks,

Paolo
