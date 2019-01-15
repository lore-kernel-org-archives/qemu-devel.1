Received: from eggs.gnu.org ([209.51.188.92]:39412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gjVis-0004OU-MP
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:54:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gjVd2-0005iM-1C
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:48:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gjVd1-0005by-DW
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:48:07 -0500
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-12-git-send-email-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <4c0d5fdb-7bf7-81ca-77c3-c387bd40ab3f@redhat.com>
Date: Tue, 15 Jan 2019 21:47:49 +0100
MIME-Version: 1.0
In-Reply-To: <1547566866-129386-12-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/14] tests: acpi: add AVMF firmware blobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

On 01/15/19 16:41, Igor Mammedov wrote:
> Add firmware blobs built with PcdAcpiTestSupport=TRUE,
> that puts RSDP address in RAM after 1Mb aligned GUID
>   AB87A6B1-2034-BDA0-71BD-375007757785
> so that tests could scan and find it in RAM once firmware's
> initialized ACPI tables.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  Makefile              |   3 ++-
>  pc-bios/avmf.img      | Bin 0 -> 2097152 bytes
>  pc-bios/avmf_vars.img | Bin 0 -> 786432 bytes
>  3 files changed, 2 insertions(+), 1 deletion(-)
>  create mode 100644 pc-bios/avmf.img
>  create mode 100644 pc-bios/avmf_vars.img

"AVMF" is not a great name. "AAVMF" is a downstream name alright, but
many dislike it in upstream use. "edk2-aarch64" or "edk2-ArmVirtQemu"
would be more precise, but those are verbose. Sigh, why are names so
hard. What does everyone think?

Also, do you have to care about the license of firmware images built
from edk2 when bundling such images? Since edk2 commit 9a67ba261fe9
("ArmVirtPkg: Replace obsoleted network drivers from platform DSC/FDF.",
2018-12-14), you cannot build the ArmVirtQemu (aka AAVMF) firmware
without OpenSSL. Thus, the resultant license is 2-BSDL + OpenSSL -- for
now anyway.

Because, in the near future, that might change again. edk2 is in the
process of moving to Apache-2.0, and OpenSSL will also move (AFAICT) to
Apache-2.0 starting with release 3.0.0. (See commit 151333164ece,
"Change license to the Apache License v2.0", 2018-12-06.)

Thanks
Laszlo
