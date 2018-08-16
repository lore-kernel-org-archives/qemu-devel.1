Received: from eggs.gnu.org ([2001:4830:134:3::10]:42478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqHOW-0005Od-Ha
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqHOR-0007gt-HE
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:28:52 -0400
Received: from mail-by2nam01on0116.outbound.protection.outlook.com
	([104.47.34.116]:37001
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fqHOR-0007fe-6q
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:28:47 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 16 Aug 2018 12:28:42 +0000
Message-ID: <BN7PR08MB486822802EC304ED642A8353C63E0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1534182832-554-62-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-62-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 61/87] elf: On elf loading,
 treat both EM_MIPS and EM_NANOMIPS as legal for MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 13, 2018 7:53 PM
>=20
> Subject: [PATCH v8 61/87] elf: On elf loading, treat both EM_MIPS and EM_=
NANOMIPS as legal for MIPS
>=20
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
>=20
> Modify load_elf32()/load_elf64() to treat EM_NANOMIPS as equal to
> EM_MIPS.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  include/hw/elf_ops.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index b6e19e3..81cecaf 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -327,6 +327,14 @@ static int glue(load_elf, SZ)(const char *name, int =
fd,
>                  }
>              }
>              break;
> +        case EM_MIPS:
> +        case EM_NANOMIPS:
> +            if ((ehdr.e_machine !=3D EM_MIPS) &&
> +                (ehdr.e_machine !=3D EM_NANOMIPS)) {
> +                ret =3D ELF_LOAD_WRONG_ARCH;
> +                goto fail;
> +            }
> +            break;
>          default:
>              if (elf_machine !=3D ehdr.e_machine) {
>                  ret =3D ELF_LOAD_WRONG_ARCH;
> --
> 2.7.4
>=20


Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=
