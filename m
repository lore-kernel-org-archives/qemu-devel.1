Received: from eggs.gnu.org ([2001:4830:134:3::10]:49310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffOS6-0001gy-JW
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffOS2-0002Xw-Ka
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:47:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33160 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ffOS2-0002Xk-Ds
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:47:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9FA07C6CA
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 11:47:29 +0000 (UTC)
References: <20180717113402.5510-1-quintela@redhat.com>
	<20180717113402.5510-7-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1f986919-059b-649a-028e-d56ccf6bb862@redhat.com>
Date: Tue, 17 Jul 2018 13:47:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180717113402.5510-7-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/25] check: Only test eepro100 when it is
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
> index ae77d26932..560f486416 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -218,8 +218,8 @@ gcov-files-pci-y += hw/net/rtl8139.c
>  check-qtest-pci-y += tests/pcnet-test$(EXESUF)
>  gcov-files-pci-y += hw/net/pcnet.c
>  gcov-files-pci-y += hw/net/pcnet-pci.c
> -check-qtest-pci-y += tests/eepro100-test$(EXESUF)
> -gcov-files-pci-y += hw/net/eepro100.c
> +check-qtest-pci-$(CONFIG_EEPRO100_PCI) += tests/eepro100-test$(EXESUF)
> +gcov-files-pci-$(CONFIG_EEPRO100_PCI) += hw/net/eepro100.c
>  check-qtest-pci-$(CONFIG_NE2000_PCI) += tests/ne2000-test$(EXESUF)
>  gcov-files-pci-$(CONFIG_NE2000_PCI) += hw/net/ne2000.c
>  check-qtest-pci-y += tests/nvme-test$(EXESUF)

Reviewed-by: Thomas Huth <thuth@redhat.com>
