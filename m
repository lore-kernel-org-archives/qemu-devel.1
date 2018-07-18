Received: from eggs.gnu.org ([2001:4830:134:3::10]:43891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffo7c-0004ql-DA
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffo7Z-0004J5-93
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:12:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36040 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ffo7Z-0004Hj-2G
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:12:05 -0400
References: <09124b32-2571-2b6f-f10f-4c542683b1e7@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <285670de-6281-4de2-54a4-78610d3d7835@redhat.com>
Date: Wed, 18 Jul 2018 17:12:00 +0200
MIME-Version: 1.0
In-Reply-To: <09124b32-2571-2b6f-f10f-4c542683b1e7@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] spice/qlx: atomic-alignment error with clang-7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>

On 18/07/2018 16:56, Philippe Mathieu-Daud=C3=A9 wrote:
> Using clang-7 (Debian) on x86_64 to build v3.0.0-rc1.
>=20
> Not a regression, it was probably always there:
>=20
> $ ./configure --cc=3Dclang-7 && make hw/display/qxl.o
> hw/display/qxl.c:1884:19: error: misaligned or large atomic operation
> may incur significant performance penalty [-Werror,-Watomic-alignment]
>     old_pending =3D atomic_fetch_or(&d->ram->int_pending, le_events);
>                   ^
> include/qemu/atomic.h:206:34: note: expanded from macro 'atomic_fetch_o=
r'
> #define atomic_fetch_or(ptr, n)  __atomic_fetch_or(ptr, n, __ATOMIC_SEQ=
_CST)
>                                  ^
> 1 error generated.

Hi, this is fixed in the latest SPICE git.  The upstream commit is

https://gitlab.freedesktop.org/spice/spice-protocol/commit/beda5ec7a6848b=
e20c0cac2a9a8ef2a41e8069c1

Thanks,

Paolo
