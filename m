Received: from eggs.gnu.org ([2001:4830:134:3::10]:60940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWQG3-0006Gk-Gs
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:26:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWQG0-0001Uf-6R
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:26:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gWQFz-0001TX-Ux
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:26:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id f81so12297538wmd.4
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 10:26:15 -0800 (PST)
References: <1544465415-207855-1-git-send-email-imammedo@redhat.com>
	<1544465415-207855-2-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a5a6fc6f-c7c6-4e00-1692-af3d0055204a@redhat.com>
Date: Mon, 10 Dec 2018 19:26:12 +0100
MIME-Version: 1.0
In-Reply-To: <1544465415-207855-2-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/9] tests: acpi: remove not used
 ACPI_READ_GENERIC_ADDRESS macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 12/10/18 7:10 PM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/acpi-utils.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
> index 4f4899d..c8844a2 100644
> --- a/tests/acpi-utils.h
> +++ b/tests/acpi-utils.h
> @@ -70,14 +70,6 @@ typedef struct {
>      g_assert_cmpstr(ACPI_ASSERT_CMP_str, ==, expected); \
>  } while (0)
>  
> -#define ACPI_READ_GENERIC_ADDRESS(field, addr)       \
> -    do {                                             \
> -        ACPI_READ_FIELD((field).space_id, addr);     \
> -        ACPI_READ_FIELD((field).bit_width, addr);    \
> -        ACPI_READ_FIELD((field).bit_offset, addr);   \
> -        ACPI_READ_FIELD((field).access_width, addr); \
> -        ACPI_READ_FIELD((field).address, addr);      \
> -    } while (0)
>  
>  
>  uint8_t acpi_calc_checksum(const uint8_t *data, int len);
> 
