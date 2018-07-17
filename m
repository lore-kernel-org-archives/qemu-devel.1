Received: from eggs.gnu.org ([2001:4830:134:3::10]:55760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffQWX-0000wB-68
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffQWT-0001wx-DI
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:00:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43868 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ffQWT-0001wK-7B
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:00:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 693BA738E6
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 14:00:12 +0000 (UTC)
References: <20180717113402.5510-1-quintela@redhat.com>
	<20180717113402.5510-20-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e01dc565-14dd-702d-47fa-68fe2c646e61@redhat.com>
Date: Tue, 17 Jul 2018 16:00:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180717113402.5510-20-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/25] check: Only test nvme when it is
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
> index 31d124ee44..b3e707e8c3 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -222,8 +222,8 @@ check-qtest-pci-$(CONFIG_EEPRO100_PCI) += tests/eepro100-test$(EXESUF)
>  gcov-files-pci-$(CONFIG_EEPRO100_PCI) += hw/net/eepro100.c
>  check-qtest-pci-$(CONFIG_NE2000_PCI) += tests/ne2000-test$(EXESUF)
>  gcov-files-pci-$(CONFIG_NE2000_PCI) += hw/net/ne2000.c
> -check-qtest-pci-y += tests/nvme-test$(EXESUF)
> -gcov-files-pci-y += hw/block/nvme.c
> +check-qtest-pci-$(CONFIG_NVME_PCI) += tests/nvme-test$(EXESUF)
> +gcov-files-pci-$(CONFIG_NVME_PCI) += hw/block/nvme.c
>  check-qtest-pci-$(CONFIG_AC97) += tests/ac97-test$(EXESUF)
>  gcov-files-pci-$(CONFIG_AC97) += hw/audio/ac97.c
>  check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)

Reviewed-by: Thomas Huth <thuth@redhat.com>
