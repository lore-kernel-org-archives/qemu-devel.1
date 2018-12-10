Received: from eggs.gnu.org ([2001:4830:134:3::10]:46013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWHdh-0000Gd-Kq
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 04:14:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWHde-0008LX-Tt
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 04:14:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gWHde-0008Ja-JR
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 04:14:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so9611339wrx.9
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 01:14:05 -0800 (PST)
References: <20181207170400.5129-1-philmd@redhat.com>
	<20181207170400.5129-3-philmd@redhat.com>
	<20181207125716-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5137aa75-6ca3-8779-1320-8e46bacefb7d@redhat.com>
Date: Mon, 10 Dec 2018 10:14:01 +0100
MIME-Version: 1.0
In-Reply-To: <20181207125716-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/6] hw/arm: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

Hi Michael, Peter.

On 12/7/18 6:57 PM, Michael S. Tsirkin wrote:
> On Fri, Dec 07, 2018 at 06:03:56PM +0100, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/arm/virt-acpi-build.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 5785fb697c..98d7f7cf20 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -35,7 +35,6 @@
>>  #include "target/arm/cpu.h"
>>  #include "hw/acpi/acpi-defs.h"
>>  #include "hw/acpi/acpi.h"
>> -#include "hw/nvram/fw_cfg.h"
>>  #include "hw/acpi/bios-linker-loader.h"
>>  #include "hw/loader.h"
>>  #include "hw/hw.h"
> 
> 
> This file uses fw_cfg_add_file, looks wrong.

Previously I thought if another include (here hw/loader.h) already pulls
this header, we can drop it, but Peter Maydell explained me this not
safe for refactors:

  Generally I think that if a .c file directly uses function X declared
  in header Y it should #include Y, even if it happens that it already
  includes other header Z that includes Y. Otherwise if we refactor Z
  later such that it no longer needs to include Y, it will break
  compilation of the .c file. (That is, Z including Y is a detail of
  the implementation of Z, not a guarantee made by Z to its users.)

https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02460.html

I'm sorry I forgot to update this in the series :/

Regards,

Phil.
