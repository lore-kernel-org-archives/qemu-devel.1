Received: from eggs.gnu.org ([2001:4830:134:3::10]:40578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fkpbN-0001qR-Rs
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fkpbK-0007vx-Or
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:47:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55210 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fkpbK-0007vd-I8
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:47:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 117067DAC7
	for <qemu-devel@nongnu.org>; Wed,  1 Aug 2018 11:47:34 +0000 (UTC)
References: <20180801110952.5590-1-quintela@redhat.com>
	<20180801110952.5590-19-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d5aa6904-10d8-32b5-6b12-fde40dc766af@redhat.com>
Date: Wed, 1 Aug 2018 13:47:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180801110952.5590-19-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [[PATH for 3.1] v2 18/18] check: Only test
 usb-ehci when it is compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

On 08/01/2018 01:09 PM, Juan Quintela wrote:
> The ehci test also test uhci.  Welcome to the worderfull world of USB.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/Makefile.include | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index f3f8ba48fb..d6f5cc9ccc 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -286,8 +286,10 @@ check-qtest-i386-$(CONFIG_USB_OHCI) += tests/usb-hcd-ohci-test$(EXESUF)
>  gcov-files-i386-$(CONFIG_USB_OHCI) += hw/usb/hcd-ohci.c
>  check-qtest-i386-$(CONFIG_USB_UHCI) += tests/usb-hcd-uhci-test$(EXESUF)
>  gcov-files-i386-$(CONFIG_USB_UHCI) += hw/usb/hcd-uhci.c
> +ifeq ($(CONFIG_USB_ECHI)$(CONFIG_USB_UHCI),yy)
>  check-qtest-i386-y += tests/usb-hcd-ehci-test$(EXESUF)
> -gcov-files-i386-y += hw/usb/hcd-ehci.c
> +endif
> +gcov-files-i386-$(CONFIG_USB_EHCI) += hw/usb/hcd-ehci.c
>  gcov-files-i386-y += hw/usb/dev-hid.c
>  gcov-files-i386-y += hw/usb/dev-storage.c
>  check-qtest-i386-y += tests/usb-hcd-xhci-test$(EXESUF)
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
