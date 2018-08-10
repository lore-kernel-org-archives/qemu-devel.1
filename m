Received: from eggs.gnu.org ([2001:4830:134:3::10]:40650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo4X6-0000h9-Dh
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo4X2-0003Jv-Mh
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:20:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fo4X2-0003Hi-FW
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:20:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id e7-v6so7794152wrs.9
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 03:20:32 -0700 (PDT)
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-5-quintela@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b30ab0a9-8250-b0da-7c2c-c455db0dddcd@redhat.com>
Date: Fri, 10 Aug 2018 12:20:28 +0200
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

On 08/08/2018 13:48, Juan Quintela wrote:
> Once there, untangle endianness-test and boot-serial-test.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Emanuele's qos-test would do this automatically.  It would be nicer to
convert the whole ISA subsystem to use libqos and qos-test...

Paolo

> --
> 
> boot-serial-test don't depend on isa-testdev.  Thanks Thomas.
> 
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
> +
> +check-qtest-ppc-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
>  check-qtest-ppc-y += tests/boot-order-test$(EXESUF)
>  check-qtest-ppc-y += tests/prom-env-test$(EXESUF)
>  check-qtest-ppc-y += tests/drive_del-test$(EXESUF)
> @@ -360,16 +360,16 @@ check-qtest-ppc64-y += tests/numa-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_IVSHMEM) += tests/ivshmem-test$(EXESUF)
>  check-qtest-ppc64-y += tests/cpu-plug-test$(EXESUF)
>  
> -check-qtest-sh4-y = tests/endianness-test$(EXESUF)
> +check-qtest-sh4-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
>  
> -check-qtest-sh4eb-y = tests/endianness-test$(EXESUF)
> +check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
>  
>  check-qtest-sparc-y = tests/prom-env-test$(EXESUF)
>  check-qtest-sparc-y += tests/m48t59-test$(EXESUF)
>  gcov-files-sparc-y = hw/timer/m48t59.c
>  check-qtest-sparc-y += tests/boot-serial-test$(EXESUF)
>  
> -check-qtest-sparc64-y = tests/endianness-test$(EXESUF)
> +check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
>  check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
>  check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
>  
> 
