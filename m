Received: from eggs.gnu.org ([2001:4830:134:3::10]:49450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffOSl-000298-H0
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffOSk-0002td-MD
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:48:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33168 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ffOSk-0002tE-FC
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:48:14 -0400
References: <20180717113402.5510-1-quintela@redhat.com>
	<20180717113402.5510-17-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b4fc572c-f777-d7b5-2ac6-e2b39250ae12@redhat.com>
Date: Tue, 17 Jul 2018 13:48:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180717113402.5510-17-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/25] check: Only test sdhci when it is
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
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 17.07.2018 13:33, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/Makefile.include | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index b0aa79909b..868a41986b 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -307,7 +307,7 @@ check-qtest-i386-y += tests/migration-test$(EXESUF)
>  check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
>  check-qtest-i386-y += tests/numa-test$(EXESUF)
>  check-qtest-x86_64-y += $(check-qtest-i386-y)
> -check-qtest-x86_64-y += tests/sdhci-test$(EXESUF)
> +check-qtest-x86_64-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
>  gcov-files-i386-y += i386-softmmu/hw/timer/mc146818rtc.c
>  gcov-files-x86_64-y = $(subst i386-softmmu/,x86_64-softmmu/,$(gcov-files-i386-y))
>  
> @@ -381,10 +381,10 @@ gcov-files-arm-y += arm-softmmu/hw/block/virtio-blk.c
>  check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
>  gcov-files-arm-y += hw/timer/arm_mptimer.c
>  check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
> -check-qtest-arm-y += tests/sdhci-test$(EXESUF)
> +check-qtest-arm-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
>  
>  check-qtest-aarch64-y = tests/numa-test$(EXESUF)
> -check-qtest-aarch64-y += tests/sdhci-test$(EXESUF)
> +check-qtest-aarch64-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
>  check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
>  
>  check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
