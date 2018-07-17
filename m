Received: from eggs.gnu.org ([2001:4830:134:3::10]:47835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffOMs-0005Ru-Cb
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffOMp-0008Am-9f
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:42:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36874 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ffOMp-0008Ad-3X
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:42:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 84228401EF11
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 11:42:06 +0000 (UTC)
References: <20180717113402.5510-1-quintela@redhat.com>
	<20180717113402.5510-5-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dc3e7994-bdfb-7149-2b8b-d333e1955c83@redhat.com>
Date: Tue, 17 Jul 2018 13:42:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180717113402.5510-5-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/25] check: Only test vmxnet3 when it is
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
>  tests/Makefile.include | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 47aea32193..e9dd3e8928 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -270,8 +270,8 @@ check-qtest-i386-y += tests/tco-test$(EXESUF)
>  gcov-files-i386-y += hw/watchdog/watchdog.c hw/watchdog/wdt_ib700.c
>  check-qtest-i386-y += $(check-qtest-pci-y)
>  gcov-files-i386-y += $(gcov-files-pci-y)
> -check-qtest-i386-y += tests/vmxnet3-test$(EXESUF)
> -gcov-files-i386-y += hw/net/vmxnet3.c
> +check-qtest-i386-$(CONFIG_VMXNET3_PCI) += tests/vmxnet3-test$(EXESUF)
> +gcov-files-i386-$(CONFIG_VMXNET3_PCI) += hw/net/vmxnet3.c
>  gcov-files-i386-y += hw/net/net_rx_pkt.c
>  gcov-files-i386-y += hw/net/net_tx_pkt.c
>  check-qtest-i386-y += tests/pvpanic-test$(EXESUF)
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
