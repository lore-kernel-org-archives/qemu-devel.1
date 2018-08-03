Received: from eggs.gnu.org ([2001:4830:134:3::10]:58994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1flYBQ-0007FJ-7B
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1flYBN-0003hH-0j
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:23:48 -0400
Received: from mail-eopbgr700100.outbound.protection.outlook.com
	([40.107.70.100]:51383
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
	id 1flYBM-0003gh-Mk
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:23:44 -0400
From: Aleksandar Rikalo <arikalo@wavecomp.com>
Date: Fri, 3 Aug 2018 11:23:40 +0000
Message-ID: <CY4PR08MB2486543AECEBFAEE4D608EF1D2230@CY4PR08MB2486.namprd08.prod.outlook.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
	<1533219424-7627-78-git-send-email-stefan.markovic@rt-rk.com>,
	<0a43387a-f475-874d-2846-46ce38d9d812@vivier.eu>
In-Reply-To: <0a43387a-f475-874d-2846-46ce38d9d812@vivier.eu>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 77/77] linux-user: Add nanoMIPS support
 in scripts/qemu-binfmt-conf.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

Hi, Laurent,

Thank You for the explanation.

We will correct this in the next version.
We will also fix family values for the regular mips architectures in separa=
te patch.


Best Regards,

Aleksandar Rikalo



________________________________
From: Laurent Vivier <laurent@vivier.eu>
Sent: Thursday, August 2, 2018 9:47:02 PM
To: Stefan Markovic; qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi; philippe.mathieu.daude@gmail.com; aurelien@aurel32.=
net; richard.henderson@linaro.org; Aleksandar Markovic; Stefan Markovic; Pe=
tar Jovanovic; Paul Burton; Aleksandar Rikalo
Subject: Re: [PATCH v6 77/77] linux-user: Add nanoMIPS support in scripts/q=
emu-binfmt-conf.sh

Le 02/08/2018 =E0 16:17, Stefan Markovic a =E9crit :
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
>
> Add support for nanomips[eb] variant in scripts/qemu-binfmt-conf.sh.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  scripts/qemu-binfmt-conf.sh | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index b0dc8a7..ecde0c2 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -2,7 +2,7 @@
>  # Enable automatic program execution by the kernel.
>
>  qemu_target_list=3D"i386 i486 alpha arm armeb sparc32plus ppc ppc64 ppc6=
4le m68k \
> -mips mipsel mipsn32 mipsn32el mips64 mips64el \
> +mips mipsel mipsn32 mipsn32el mips64 mips64el nanomips nanomipseb \
>  sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64 xtensa xtensaeb =
\
>  microblaze microblazeel or1k"
>
> @@ -76,6 +76,14 @@ mips64el_magic=3D'\x7fELF\x02\x01\x01\x00\x00\x00\x00\=
x00\x00\x00\x00\x00\x02\x00\
>  mips64el_mask=3D'\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xf=
f\xff\xff\xfe\xff\xff\xff'
>  mips64el_family=3Dmips
>
> +nanomips_magic=3D'\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x0=
0\x02\x00\xf9\x00'
> +nanomips_mask=3D'\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xf=
f\xff\xff\xff\xff\xff\xff'
> +nanomips_family=3Dmips
> +
> +nanomipseb_magic=3D'\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\=
x00\x00\x02\x00\xf9'
> +nanomipseb_mask=3D'\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\=
xff\xff\xff\xff\xff\xff\xff'
> +nanomipseb_family=3Dmips

The goal of the family value is not to register the interpreter if the
kernel can execute the executable directly (without qemu).
For instance a ppc64 kernel can execute a ppc executable, an x86_64
kernel can execute a i386 binary.

If you put nanomips in the mips family it means a mips kernel can
execute directly a nanomips executable: Is that the case?
If not, I think you can use "nanomips_family=3Dnanomips", and if a
nanomips kernel cannot execute a nanomipseb executable, you need also a
nanomipseb family.

Thanks,
Laurent
