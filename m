Received: from eggs.gnu.org ([209.51.188.92]:39334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gn3K7-0003xn-3w
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:23:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gn3K6-0002w4-8R
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:23:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gn3K5-0002vO-Vx
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:23:14 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-8-git-send-email-pbonzini@redhat.com>
	<efa50ee0-381b-ae3b-f1c5-3182a205439f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <15bec654-a298-65ca-260c-65b350117131@redhat.com>
Date: Fri, 25 Jan 2019 16:23:03 +0100
MIME-Version: 1.0
In-Reply-To: <efa50ee0-381b-ae3b-f1c5-3182a205439f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/52] hw/arm/Makefile.objs: CONFIG_VIRT
 created for virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com

On 25/01/19 16:06, Thomas Huth wrote:
>> -obj-y += boot.o virt.o sysbus-fdt.o
>> +obj-y += boot.o sysbus-fdt.o
>> +obj-$(CONFIG_VIRT) += virt.o
>>  obj-$(CONFIG_ACPI) += virt-acpi-build.o
>>  obj-$(CONFIG_DIGIC) += digic_boards.o
>>  obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
> <bikeshedding>
> Maybe we should rather name that option CONFIG_ARM_VIRT, since other
> targets like riscv have also a "virt" machine?
> </bikeshedding>

Yes, why not, especially since CONFIG_* symbols are not namespaced
per-target.

Paolo
