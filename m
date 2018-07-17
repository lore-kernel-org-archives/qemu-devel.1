Received: from eggs.gnu.org ([2001:4830:134:3::10]:49752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffOUT-0003kF-5d
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffOUP-0003x1-5n
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:50:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37384 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ffOUO-0003wU-Ua
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:49:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7965481A4EAF
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 11:49:56 +0000 (UTC)
References: <20180717113402.5510-1-quintela@redhat.com>
	<20180717113402.5510-11-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <541329f1-ae37-dbc6-b4b4-b830bcb00f4e@redhat.com>
Date: Tue, 17 Jul 2018 13:49:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180717113402.5510-11-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/25] check: Only test ac97 when it is
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
> index 3d146310f0..af395b5f22 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -224,8 +224,8 @@ check-qtest-pci-$(CONFIG_NE2000_PCI) += tests/ne2000-test$(EXESUF)
>  gcov-files-pci-$(CONFIG_NE2000_PCI) += hw/net/ne2000.c
>  check-qtest-pci-y += tests/nvme-test$(EXESUF)
>  gcov-files-pci-y += hw/block/nvme.c
> -check-qtest-pci-y += tests/ac97-test$(EXESUF)
> -gcov-files-pci-y += hw/audio/ac97.c
> +check-qtest-pci-$(CONFIG_AC97) += tests/ac97-test$(EXESUF)
> +gcov-files-pci-$(CONFIG_AC97) += hw/audio/ac97.c
>  check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)
>  gcov-files-pci-$(CONFIG_ES1370) += hw/audio/es1370.c
>  check-qtest-pci-y += $(check-qtest-virtio-y)
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
