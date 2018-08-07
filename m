Received: from eggs.gnu.org ([2001:4830:134:3::10]:36083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fn0mv-0004Pp-B9
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fn0ms-00052C-4g
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:08:33 -0400
Received: from mail-co1nam05on0705.outbound.protection.outlook.com
	([2a01:111:f400:fe50::705]:64404
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fn0mr-00051h-Ml
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:08:30 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 7 Aug 2018 12:08:06 +0000
Message-ID: <BN7PR08MB4868CEA9F27663DBF189EDF0C6270@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1533574847-19294-80-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1533574847-19294-80-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 79/80] qemu-doc: Amend MIPS-related items
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paul Burton <pburton@wavecomp.com>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "thuth@redhat.com" <thuth@redhat.com>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "armbru@redhat.com" <armbru@redhat.com>

Paul, Richard, Thomas,

Can some of you review this patch (https://lists.gnu.org/archive/html/qemu-=
devel/2018-08/msg00777.html) and another (https://lists.gnu.org/archive/htm=
l/qemu-devel/2018-08/msg00783.html)?

Those are just very basic statements in our user documentation, related to =
earlier MIPS platforms, and the new nanoMIPS.

I find it important for a new feature to be mentioned in the docs, even wit=
h just a short statement like these.

I can't review the patches since I am their author.

Yours,
Aleksandar Markovic

P.S. Paul, perhaps a section on Boston board would fitt in well in this fil=
e?


> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 6, 2018 7:00 PM
>=20
> Subject: [PATCH v7 79/80] qemu-doc: Amend MIPS-related items
>=20
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> Amend MIPS-related items in qemu-doc.texi
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  qemu-doc.texi | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index abfd2db..8ea6bfa 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2693,8 +2693,17 @@ The binary format is detected automatically.
>  @command{qemu-microblaze} TODO.
>=20
>  @cindex user mode (MIPS)
> -@command{qemu-mips} TODO.
> -@command{qemu-mipsel} TODO.
> +@command{qemu-mips} executes 32-bit big endian MIPS binaries (MIPS O32 A=
BI).
> +
> +@command{qemu-mipsel} executes 32-bit little endian MIPS binaries (MIPS =
O32 ABI).
> +
> +@command{qemu-mips64} executes 64-bit big endian MIPS binaries (MIPS O64=
 ABI).
> +
> +@command{qemu-mips64el} executes 64-bit little endian MIPS binaries (MIP=
S O64 ABI).
> +
> +@command{qemu-mipsn32} executes 32-bit big endian MIPS binaries (MIPS N3=
2 ABI).
> +
> +@command{qemu-mipsn32el} executes 32-bit little endian MIPS binaries (MI=
PS N32 ABI).
>=20
>  @cindex user mode (NiosII)
>  @command{qemu-nios2} TODO.
> --
> 2.7.4
>=20
