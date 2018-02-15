Received: from eggs.gnu.org ([2001:4830:134:3::10]:44995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1emGCM-0000Tl-3t
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1emGCL-0000QK-B2
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:51:26 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1emGCL-0000OY-3J
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:51:25 -0500
Received: by mail-wm0-x242.google.com with SMTP id 141so26630720wme.3
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 01:51:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180215042900.16078-30-f4bug@amsat.org>
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-30-f4bug@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 15 Feb 2018 10:51:23 +0100
Message-ID: <CAJ+F1CLcYqhjk2xh3Bd0HQh73F4QhbY0QC8-J5tqbL-hq4m7yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 29/30] tpm: use the BYTE-based definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On Thu, Feb 15, 2018 at 5:28 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> It ease code review, unit is explicit.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  include/hw/acpi/tpm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index 96fd3a92f7..751567a73a 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -71,7 +71,7 @@ REG32(CRB_DATA_BUFFER, 0x80)
>  #define TPM_CRB_ADDR_CTRL           (TPM_CRB_ADDR_BASE + A_CRB_CTRL_REQ)
>  #define TPM_CRB_R_MAX               R_CRB_DATA_BUFFER
>
> -#define TPM_LOG_AREA_MINIMUM_SIZE   (64 * 1024)
> +#define TPM_LOG_AREA_MINIMUM_SIZE   (64 * K_BYTE)
>
>  #define TPM_TCPA_ACPI_CLASS_CLIENT  0
>  #define TPM_TCPA_ACPI_CLASS_SERVER  1
> --
> 2.16.1
>
>



--=20
Marc-Andr=C3=A9 Lureau
