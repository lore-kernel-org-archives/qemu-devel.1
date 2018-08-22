Received: from eggs.gnu.org ([2001:4830:134:3::10]:41369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fsQHS-0005O7-0w
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fsQHN-0005gZ-Tl
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:22:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37382 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fsQHN-0005fp-NJ
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:22:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6262F4023476
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 10:22:21 +0000 (UTC)
References: <20180822095421.11765-1-quintela@redhat.com>
	<20180822095421.11765-5-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8769cf31-6c0d-1b48-a096-6ea36605d67e@redhat.com>
Date: Wed, 22 Aug 2018 12:22:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180822095421.11765-5-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 04/10] check: Only test usb-xhci-nec
 when it is compiled in
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

On 2018-08-22 11:54, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/Makefile.include | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 15296be246..9a918f7655 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -290,8 +290,9 @@ endif
>  gcov-files-i386-$(CONFIG_USB_EHCI) += hw/usb/hcd-ehci.c
>  gcov-files-i386-y += hw/usb/dev-hid.c
>  gcov-files-i386-y += hw/usb/dev-storage.c
> -check-qtest-i386-y += tests/usb-hcd-xhci-test$(EXESUF)
> -gcov-files-i386-y += hw/usb/hcd-xhci.c
> +check-qtest-i386-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
> +gcov-files-i386-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci.c
> +gcov-files-i386-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci-nec.c
>  check-qtest-i386-y += tests/cpu-plug-test$(EXESUF)
>  check-qtest-i386-y += tests/q35-test$(EXESUF)
>  check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
> @@ -349,8 +350,8 @@ check-qtest-ppc64-$(CONFIG_USB_OHCI) += tests/usb-hcd-ohci-test$(EXESUF)
>  gcov-files-ppc64-$(CONFIG_USB_OHCI) += hw/usb/hcd-ohci.c
>  check-qtest-ppc64-$(CONFIG_USB_UHCI) += tests/usb-hcd-uhci-test$(EXESUF)
>  gcov-files-ppc64-$(CONFIG_USB_UHCI) += hw/usb/hcd-uhci.c
> -check-qtest-ppc64-y += tests/usb-hcd-xhci-test$(EXESUF)
> -gcov-files-ppc64-y += hw/usb/hcd-xhci.c
> +check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
> +gcov-files-ppc64-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci.c

Add hcd-xhci-nec.c here, too?

Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>
