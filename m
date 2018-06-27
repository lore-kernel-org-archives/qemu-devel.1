Received: from eggs.gnu.org ([2001:4830:134:3::10]:35147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY3dx-0006Uc-V6
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY3du-0004k0-R3
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:09:29 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:37672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY3du-0004jV-JE
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:09:26 -0400
Received: by mail-pl0-x243.google.com with SMTP id 31-v6so537305plc.4
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 23:09:26 -0700 (PDT)
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-11-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fe9a73fb-9cd5-e772-c6c5-c9ef6383bb8a@linaro.org>
Date: Tue, 26 Jun 2018 23:09:22 -0700
MIME-Version: 1.0
In-Reply-To: <20180625124238.25339-11-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 10/46] hw/smbios: Use the IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

On 06/25/2018 05:42 AM, Philippe Mathieu-Daudé wrote:
> It eases code review, unit is explicit.
> 
> Patch generated using:
> 
>   $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/
> 
> and modified manually.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/smbios/smbios.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> @@ -640,7 +637,7 @@ static void smbios_build_type_16_table(unsigned dimm_cnt)
>      t->location = 0x01; /* Other */
>      t->use = 0x03; /* System memory */
>      t->error_correction = 0x06; /* Multi-bit ECC (for Microsoft, per SeaBIOS) */
> -    size_kb = QEMU_ALIGN_UP(ram_size, ONE_KB) / ONE_KB;
> +    size_kb = QEMU_ALIGN_UP(ram_size, KiB) / KiB;

Perhaps for a different patch set, but DIV_ROUND_UP.


r~
