Received: from eggs.gnu.org ([2001:4830:134:3::10]:52371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1diMdQ-0000LL-PB
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 11:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1diMdM-0003sV-7M
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 11:23:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1diMdL-0003sL-Ul
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 11:22:56 -0400
Date: Thu, 17 Aug 2017 17:22:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170817172249.31cf5e3d@nial.brq.redhat.com>
In-Reply-To: <20170817043102.6322-1-f4bug@amsat.org>
References: <20170817043102.6322-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/8] QOMify MIPS cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, James Hogan <james.hogan@imgtec.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Thu, 17 Aug 2017 01:30:54 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Hi,
>=20
> While working with the mips codebase I had to QOMify it.
>=20
> I then read Igor's series "complete cpu QOMification" [1] and after some =
IRC
> chat I suggested Igor to rebase his series on mine to avoid code moving
> forward then back.
>=20
> Since most of Igor's series is reviewed I'm posting this a week before 2.=
11.
>=20
> I'm not sure about the TypeInfo.abstract change so it is RFC.
>=20
> Also I couldn't test it with KVM.
Tested in TCG mode (boots debian mips/mips64 kernel with different cpu type=
s),
and new CPU leaf types show up on QOM tree as expected (QOMifycation is don=
e as expected)
and '-cpu help' also works as expected,
so with checkpatch issues fixed you may add to patches my

Tested-by: Igor Mammedov <imammedo@redhat.com>



>=20
> Regards,
>=20
> Phil.
>=20
> [1]: http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg04414.html
>=20
> Igor Mammedov (2):
>   mips: MIPSCPU model subclasses
>   mips: replace cpu_mips_init() with cpu_generic_init()
>=20
> Philippe Mathieu-Daud=C3=A9 (6):
>   mips: move hw/mips/cputimer.c to target/mips/
>   mips: introduce internal.h and cleanup cpu.h
>   mips: split cpu_mips_realize_env() out of cpu_mips_init()
>   mips: call cpu_mips_realize_env() from mips_cpu_realizefn()
>   mips: now than MIPSCPU is QOMified, mark it abstract
>   mips: update mips_cpu_list() to use object_class_get_list()
>=20
>  target/mips/cpu-qom.h                         |   1 +
>  target/mips/cpu.h                             | 357 +-------------------=
--
>  target/mips/internal.h                        | 422 ++++++++++++++++++++=
++++++
>  hw/mips/cps.c                                 |   2 +-
>  hw/mips/mips_fulong2e.c                       |   2 +-
>  hw/mips/mips_jazz.c                           |   2 +-
>  hw/mips/mips_malta.c                          |   2 +-
>  hw/mips/mips_mipssim.c                        |   2 +-
>  hw/mips/mips_r4k.c                            |   2 +-
>  hw/mips/cputimer.c =3D> target/mips/cp0_timer.c |   2 +-
>  target/mips/cpu.c                             |  57 +++-
>  target/mips/gdbstub.c                         |   1 +
>  target/mips/helper.c                          |  47 +++
>  target/mips/kvm.c                             |   1 +
>  target/mips/machine.c                         |   1 +
>  target/mips/msa_helper.c                      |   1 +
>  target/mips/op_helper.c                       |   1 +
>  target/mips/translate.c                       |  23 +-
>  target/mips/translate_init.c                  |  68 +----
>  hw/mips/Makefile.objs                         |   2 +-
>  target/mips/Makefile.objs                     |   2 +-
>  21 files changed, 549 insertions(+), 449 deletions(-)
>  create mode 100644 target/mips/internal.h
>  rename hw/mips/cputimer.c =3D> target/mips/cp0_timer.c (99%)
>=20
