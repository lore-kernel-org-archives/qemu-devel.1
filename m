Received: from eggs.gnu.org ([2001:4830:134:3::10]:52184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fnNBa-0006Vc-DJ
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fnNBW-0008GZ-Gp
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37266 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fnNBW-0008GE-B3
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9BBB40216E6
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 12:03:25 +0000 (UTC)
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-5-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <da2b32e2-cf14-6ecb-0aaf-ef155891580d@redhat.com>
Date: Wed, 8 Aug 2018 14:03:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180808114830.7169-5-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/22] check: Only test isa-testdev when
 it is compiled in
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

On 08/08/2018 01:48 PM, Juan Quintela wrote:
> Once there, untangle endianness-test and boot-serial-test.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> 
> boot-serial-test don't depend on isa-testdev.  Thanks Thomas.

So remove it from the patch description, too?

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/Makefile.include | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 2016c353e3..4e5f47aac0 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -248,7 +248,7 @@ gcov-files-pci-y += hw/misc/ivshmem.c
>  check-qtest-pci-y += tests/megasas-test$(EXESUF)
>  gcov-files-pci-y += hw/scsi/megasas.c
>  
> -check-qtest-i386-y = tests/endianness-test$(EXESUF)
> +check-qtest-i386-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
>  check-qtest-i386-y += tests/fdc-test$(EXESUF)
>  gcov-files-i386-y = hw/block/fdc.c
>  check-qtest-i386-y += tests/ide-test$(EXESUF)
> @@ -321,15 +321,15 @@ check-qtest-m68k-y = tests/boot-serial-test$(EXESUF)
>  
>  check-qtest-microblaze-y = tests/boot-serial-test$(EXESUF)
>  
> -check-qtest-mips-y = tests/endianness-test$(EXESUF)
> -
> -check-qtest-mips64-y = tests/endianness-test$(EXESUF)
> -
> -check-qtest-mips64el-y = tests/endianness-test$(EXESUF)
> -
>  check-qtest-moxie-y = tests/boot-serial-test$(EXESUF)
>  
> -check-qtest-ppc-y = tests/endianness-test$(EXESUF)
> +check-qtest-mips-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
> +
> +check-qtest-mips64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
> +
> +check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)

I think it would be good to try to keep the alphabetical order of the
entries, i.e. keep mips before moxie?

 Thomas
