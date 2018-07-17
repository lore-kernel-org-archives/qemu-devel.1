Received: from eggs.gnu.org ([2001:4830:134:3::10]:50035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffOVD-0004Rj-R1
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffOVC-0004gC-Vm
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:50:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37062 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ffOVC-0004fx-Om
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:50:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E095401EF05
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 11:50:46 +0000 (UTC)
References: <20180717113402.5510-1-quintela@redhat.com>
	<20180717113402.5510-18-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <34f8fb1a-85af-1bf8-6f6a-48258881a7c6@redhat.com>
Date: Tue, 17 Jul 2018 13:50:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180717113402.5510-18-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/25] check: Only test wdt_ib700 when it
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
> index 868a41986b..f635517a68 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -265,9 +265,9 @@ check-qtest-i386-y += tests/ipmi-bt-test$(EXESUF)
>  check-qtest-i386-y += tests/i440fx-test$(EXESUF)
>  check-qtest-i386-y += tests/fw_cfg-test$(EXESUF)
>  check-qtest-i386-y += tests/drive_del-test$(EXESUF)
> -check-qtest-i386-y += tests/wdt_ib700-test$(EXESUF)
> +check-qtest-i386-$(CONFIG_WDT_IB700) += tests/wdt_ib700-test$(EXESUF)
>  check-qtest-i386-y += tests/tco-test$(EXESUF)
> -gcov-files-i386-y += hw/watchdog/watchdog.c hw/watchdog/wdt_ib700.c
> +gcov-files-i386-$(CONFIG_WDT_IB700) += hw/watchdog/watchdog.c hw/watchdog/wdt_ib700.c
>  check-qtest-i386-y += $(check-qtest-pci-y)
>  gcov-files-i386-y += $(gcov-files-pci-y)
>  check-qtest-i386-$(CONFIG_VMXNET3_PCI) += tests/vmxnet3-test$(EXESUF)

In case you respin: Move the two ib700 lines next to each other again
while you're at it?

Reviewed-by: Thomas Huth <thuth@redhat.com>
