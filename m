Received: from eggs.gnu.org ([2001:4830:134:3::10]:58561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffQfn-0003EO-33
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffQfi-00075u-0p
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:09:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41816 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ffQfh-00075h-PV
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:09:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6FA0540122B9
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 14:09:45 +0000 (UTC)
References: <20180717113402.5510-1-quintela@redhat.com>
	<20180717113402.5510-22-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5ce0c5c3-5689-2f85-7990-a121a749acb4@redhat.com>
Date: Tue, 17 Jul 2018 16:09:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180717113402.5510-22-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 21/25] check: Only test usb-ohci when it is
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
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 17.07.2018 13:33, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/Makefile.include | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index ccf71bddcc..3a78ada070 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -280,8 +280,8 @@ check-qtest-i386-$(CONFIG_I82801B11) += tests/i82801b11-test$(EXESUF)
>  gcov-files-i386-$(CONFIG_I82801B11) += hw/pci-bridge/i82801b11.c
>  check-qtest-i386-$(CONFIG_IOH3420) += tests/ioh3420-test$(EXESUF)
>  gcov-files-i386-$(CONFIG_IOH3420) += hw/pci-bridge/ioh3420.c
> -check-qtest-i386-y += tests/usb-hcd-ohci-test$(EXESUF)
> -gcov-files-i386-y += hw/usb/hcd-ohci.c
> +check-qtest-i386-$(CONFIG_USB_OHCI) += tests/usb-hcd-ohci-test$(EXESUF)
> +gcov-files-i386-$(CONFIG_USB_OHCI) += hw/usb/hcd-ohci.c
>  check-qtest-i386-y += tests/usb-hcd-uhci-test$(EXESUF)
>  gcov-files-i386-y += hw/usb/hcd-uhci.c
>  check-qtest-i386-y += tests/usb-hcd-ehci-test$(EXESUF)
> @@ -343,8 +343,8 @@ check-qtest-ppc64-y += tests/pnv-xscom-test$(EXESUF)
>  check-qtest-ppc64-y += tests/migration-test$(EXESUF)
>  check-qtest-ppc64-y += tests/rtas-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
> -check-qtest-ppc64-y += tests/usb-hcd-ohci-test$(EXESUF)
> -gcov-files-ppc64-y += hw/usb/hcd-ohci.c
> +check-qtest-ppc64-$(CONFIG_USB_OHCI) += tests/usb-hcd-ohci-test$(EXESUF)
> +gcov-files-ppc64-$(CONFIG_USB_OHCI) += hw/usb/hcd-ohci.c
>  check-qtest-ppc64-y += tests/usb-hcd-uhci-test$(EXESUF)
>  gcov-files-ppc64-y += hw/usb/hcd-uhci.c
>  check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)

Reviewed-by: Thomas Huth <thuth@redhat.com>
