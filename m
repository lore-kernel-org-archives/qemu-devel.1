Received: from eggs.gnu.org ([2001:4830:134:3::10]:37117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbTKI-0002pK-9Z
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbTKH-0004UD-Cn
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:11:18 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:45824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fbTKH-0004Sz-81
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:11:17 -0400
Received: by mail-oi0-x241.google.com with SMTP id m2-v6so24415355oim.12
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 09:11:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180706155127.7483-4-f4bug@amsat.org>
References: <20180706155127.7483-1-f4bug@amsat.org>
	<20180706155127.7483-4-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jul 2018 17:10:56 +0100
Message-ID: <CAFEAcA8zY-3kwUrehYhW0OkL07mvam7U=5OnE0K+EDTd1iR1=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.0 3/3] linux-user: Report error
 message on stderr, rather than stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, QEMU Trivial <qemu-trivial@nongnu.org>

On 6 July 2018 at 16:51, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> Code change produced with:
>
>   git ls-files linux-user | \
>   xargs sed -i -E 's/(\s+)printf\s*\(("Unhandled.*)\);/\1fprintf(stderr, =
\2);/g'
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  linux-user/alpha/cpu_loop.c      | 2 +-
>  linux-user/cris/cpu_loop.c       | 2 +-
>  linux-user/microblaze/cpu_loop.c | 6 +++---
>  linux-user/sh4/cpu_loop.c        | 2 +-
>  linux-user/sparc/cpu_loop.c      | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)

Makes sense, as we're about to print the cpu_dump_state output to
stderr too.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
