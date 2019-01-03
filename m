Received: from eggs.gnu.org ([208.118.235.92]:42609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1geyYt-0008K5-4V
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 03:41:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1geyYo-0008AZ-PW
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 03:41:06 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:40957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1geyYk-0007jc-MD
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 03:41:00 -0500
Received: by mail-wr1-f54.google.com with SMTP id p4so32799877wrt.7
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 00:40:49 -0800 (PST)
References: <154644248841.9907.3575860441558700867@02a1dbf831e2>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bbf44838-0e4f-0824-07cf-942ef0fd00c8@redhat.com>
Date: Thu, 3 Jan 2019 09:40:46 +0100
MIME-Version: 1.0
In-Reply-To: <154644248841.9907.3575860441558700867@02a1dbf831e2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/5] Fix strncpy() warnings for GCC8 new
 -Wstringop-truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: fam@euphon.net, thuth@redhat.com, quintela@redhat.com, david@redhat.com, dgilbert@redhat.com, armbru@redhat.com, marcandre.lureau@redhat.com, mst@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On 1/2/19 4:21 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20181228173356.15359-1-philmd@redhat.com/
[...]> === OUTPUT BEGIN ===
> Checking PATCH 1/5: qemu/compiler: Define QEMU_NONSTRING...
> WARNING: architecture specific defines should be avoided
> #53: FILE: include/qemu/compiler.h:163:
> +#if __has_attribute(nonstring)

I assume this one is OK, this is consistent with the file.

> Checking PATCH 3/5: hw/acpi: Use QEMU_NONSTRING for non NUL-terminated arrays...
> ERROR: space prohibited before open square bracket '['
> #82: FILE: include/hw/acpi/acpi-defs.h:60:
> +    uint8_t  oem_id [6] \

I wanted to respect the maintainer previous indentation, but I'll fix.

> 
> WARNING: Block comments use a leading /* on a separate line
> #83: FILE: include/hw/acpi/acpi-defs.h:61:
> +                 QEMU_NONSTRING;     /* OEM identification */ \

Eh this is a multi-line macro... I don't think we can split this
comment. I will keep it that way.

> Checking PATCH 5/5: migration: Use strnlen() for fixed-size string...
> WARNING: Block comments use a leading /* on a separate line
> #49: FILE: migration/global_state.c:94:
> +        /* This condition should never happen during migration, because

Well, this is not a comment describing a function but within a code
block. I find it cleaner this way, but matter of taste, so I'll fix.

Regards,

Phil.
