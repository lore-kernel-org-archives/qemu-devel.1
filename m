Received: from eggs.gnu.org ([2001:4830:134:3::10]:58281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffOrV-0004xU-TJ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffOrT-0005bZ-MY
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:13:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34272 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ffOrT-0005b1-Gn
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:13:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A26F7D84D
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:13:47 +0000 (UTC)
References: <20180717113402.5510-1-quintela@redhat.com>
	<20180717113402.5510-15-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <67d897c2-8066-35d2-4453-94b16532c34e@redhat.com>
Date: Tue, 17 Jul 2018 14:13:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180717113402.5510-15-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/25] check: Only test ioh3420 when it is
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
> index a56d423303..3b555660bd 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -278,8 +278,8 @@ check-qtest-i386-y += tests/pvpanic-test$(EXESUF)
>  gcov-files-i386-y += i386-softmmu/hw/misc/pvpanic.c
>  check-qtest-i386-y += tests/i82801b11-test$(EXESUF)
>  gcov-files-i386-y += hw/pci-bridge/i82801b11.c
> -check-qtest-i386-y += tests/ioh3420-test$(EXESUF)
> -gcov-files-i386-y += hw/pci-bridge/ioh3420.c
> +check-qtest-i386-$(CONFIG_IOH3420) += tests/ioh3420-test$(EXESUF)
> +gcov-files-i386-$(CONFIG_IOH3420) += hw/pci-bridge/ioh3420.c
>  check-qtest-i386-y += tests/usb-hcd-ohci-test$(EXESUF)
>  gcov-files-i386-y += hw/usb/hcd-ohci.c
>  check-qtest-i386-y += tests/usb-hcd-uhci-test$(EXESUF)

Reviewed-by: Thomas Huth <thuth@redhat.com>
