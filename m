Received: from eggs.gnu.org ([2001:4830:134:3::10]:58532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffOsM-0005jw-IY
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffOsJ-0006Cr-9S
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:14:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47752 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ffOsJ-0006CN-3w
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:14:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B36C440AC6DE
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:14:38 +0000 (UTC)
References: <20180717113402.5510-1-quintela@redhat.com>
	<20180717113402.5510-16-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5c3d87f3-f693-6a92-97ae-33a9a500b3a7@redhat.com>
Date: Tue, 17 Jul 2018 14:14:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180717113402.5510-16-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/25] check: Only test i82801b11 when it
 is compiled in
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
>  tests/Makefile.include | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3b555660bd..b0aa79909b 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -276,8 +276,8 @@ gcov-files-i386-y += hw/net/net_rx_pkt.c
>  gcov-files-i386-y += hw/net/net_tx_pkt.c
>  check-qtest-i386-y += tests/pvpanic-test$(EXESUF)
>  gcov-files-i386-y += i386-softmmu/hw/misc/pvpanic.c
> -check-qtest-i386-y += tests/i82801b11-test$(EXESUF)
> -gcov-files-i386-y += hw/pci-bridge/i82801b11.c
> +check-qtest-i386-$(CONFIG_I82801B11) += tests/i82801b11-test$(EXESUF)
> +gcov-files-i386-$(CONFIG_I82801B11) += hw/pci-bridge/i82801b11.c
>  check-qtest-i386-$(CONFIG_IOH3420) += tests/ioh3420-test$(EXESUF)
>  gcov-files-i386-$(CONFIG_IOH3420) += hw/pci-bridge/ioh3420.c
>  check-qtest-i386-y += tests/usb-hcd-ohci-test$(EXESUF)

Reviewed-by: Thomas Huth <thuth@redhat.com>
