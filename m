Received: from eggs.gnu.org ([2001:4830:134:3::10]:55000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dXQOI-0005WP-4X
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:10:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dXQOD-0006x2-6g
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:10:10 -0400
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-20-f4bug@amsat.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <61936111-d9d8-a472-1689-bf7c0bd32779@msgid.tls.msk.ru>
Date: Tue, 18 Jul 2017 14:09:54 +0300
MIME-Version: 1.0
In-Reply-To: <20170718061005.29518-20-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 19/29] disas: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

18.07.2017 09:09, Philippe Mathieu-Daud=C3=A9 wrote:

> @@ -151,7 +151,7 @@ static int print_insn_objdump(bfd_vma pc, disassemb=
le_info *info,
>      info->read_memory_func(pc, buf, n, info);
> =20
>      for (i =3D 0; i < n; ++i) {
> -        if (i % 32 =3D=3D 0) {
> +        if (QEMU_IS_ALIGNED(i, 32)) {
>              info->fprintf_func(info->stream, "\n%s: ", prefix);
>          }
>          info->fprintf_func(info->stream, "%02x", buf[i]);

This does not seem to be related to _alignment_ per se, it is
just formatting, 32 entries per line, so that output looks
more-or less compact and stays readable.  To me it is a
strange move, not so much logical.

It doesn't matter much either way, but with IS_ALIGNED, to me
at least, it looks a bit less logical than now.

Thanks,

/mjt
