Received: from eggs.gnu.org ([2001:4830:134:3::10]:39687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gDN6T-0000wz-50
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gDN6P-0006Yo-OD
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:13:41 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gDN6P-0006Wu-Cw
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:13:37 -0400
Received: by mail-yb1-f195.google.com with SMTP id e16-v6so12792653ybk.8
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 22:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181013151545.3731-1-f4bug@amsat.org>
In-Reply-To: <20181013151545.3731-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 19 Oct 2018 07:13:24 +0200
Message-ID: <CAAdtpL59XyPyTjYkt=vuieWzX8G4Vue=Gay0WH_-DtBGQrwa5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/6] Avocado: more multi-arch tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, Magnus Damm <magnus.damm@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>

Ping for review before I send v3?

v3:
- fix patch 4 "Add test_sh4_r2d in BootLinuxConsole"
- drop patch 5? "Add test_sh4_r2d in BootLinuxTracing"

On Sat, Oct 13, 2018 at 5:15 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Another neanderthal approach to add multi-arch acceptance tests using Avo=
cado.
>
> I couldn't figure how to use the R2D serial, the kernel boots using the s=
m501
> display correctly, but I'm too console-oriented to write UI tests...
>
> Magnus or Zoltan, any hint on this?

Fixed (see reply to patch #5)

>
> Thanks
>
> Phil.
>
> Since v2 (http://lists.gnu.org/archive/html/qemu-devel/2018-06/msg06370.h=
tml):
> - use Debian packaged kernels, add link to the sources and a comment
>   about how to rebuild these images (Alex)
> - use self.arch from Cleber's series
> - add mips64el kernel console test
> - add sh4 test using the tracing framework
>
> Since v1 (http://lists.gnu.org/archive/html/qemu-devel/2018-04/msg03076.h=
tml):
> - we can now run other archs (Cleber)
>
> Based-on: 20181009232607.15521-1-crosa@redhat.com
> "Acceptance Tests: basic architecture support" from Cleber Rosa
> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01821.html
>
> Philippe Mathieu-Daud=C3=A9 (6):
>   tests/acceptance: Rename the generic BootLinuxConsole test as
>     test_x86_64_pc
>   tests/acceptance: Add a kludge to not use the default console
>   tests/acceptance: Add test_mips_4kc_malta in BootLinuxConsole
>   tests/acceptance: Add test_mipsel_5kc_malta in BootLinuxConsole
>   tests/acceptance: Add test_sh4_r2d in BootLinuxConsole
>   tests/acceptance: Add test_sh4_r2d in BootLinuxTracing

Thanks,

Phil.
