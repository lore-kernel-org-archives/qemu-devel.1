Received: from eggs.gnu.org ([2001:4830:134:3::10]:45801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fsQcX-0000Zj-Sh
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fsQVS-00008E-8g
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:36:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39964 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fsQVS-00007y-2R
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:36:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA75940241C5
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 10:36:53 +0000 (UTC)
References: <20180822095421.11765-1-quintela@redhat.com>
	<20180822095421.11765-10-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <08649d1f-bf87-65da-b855-4a45cf4c9481@redhat.com>
Date: Wed, 22 Aug 2018 12:36:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180822095421.11765-10-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 09/10] check: Move endianess test to
 common
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
> It is already protected by CONFIG_ISA_TESTDEV in all architectures.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/Makefile.include | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 91ffde3103..f646cd0524 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -249,8 +249,8 @@ check-qtest-pci-y += tests/megasas-test$(EXESUF)
>  gcov-files-pci-y += hw/scsi/megasas.c
>  check-qtest-$(CONFIG_VMXNET3_PCI) += tests/vmxnet3-test$(EXESUF)
>  gcov-files-$(CONFIG_VMXNET3_PCI) += hw/net/vmxnet3.c
> +check-qtest-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
>  
> -check-qtest-i386-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
>  check-qtest-i386-y += tests/fdc-test$(EXESUF)
>  gcov-files-i386-y = hw/block/fdc.c
>  check-qtest-i386-y += tests/ide-test$(EXESUF)
> @@ -324,13 +324,6 @@ check-qtest-microblaze-y = tests/boot-serial-test$(EXESUF)
>  
>  check-qtest-moxie-y = tests/boot-serial-test$(EXESUF)
>  
> -check-qtest-mips-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
> -
> -check-qtest-mips64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
> -
> -check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
> -
> -check-qtest-ppc-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
>  check-qtest-ppc-y += tests/boot-order-test$(EXESUF)
>  check-qtest-ppc-y += tests/prom-env-test$(EXESUF)
>  check-qtest-ppc-y += tests/drive_del-test$(EXESUF)
> @@ -361,16 +354,11 @@ check-qtest-ppc64-y += tests/numa-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
>  check-qtest-ppc64-y += tests/cpu-plug-test$(EXESUF)
>  
> -check-qtest-sh4-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
> -
> -check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
> -
>  check-qtest-sparc-y = tests/prom-env-test$(EXESUF)
>  check-qtest-sparc-y += tests/m48t59-test$(EXESUF)
>  gcov-files-sparc-y = hw/timer/m48t59.c
>  check-qtest-sparc-y += tests/boot-serial-test$(EXESUF)
>  
> -check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
>  check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
>  check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)

Reviewed-by: Thomas Huth <thuth@redhat.com>
