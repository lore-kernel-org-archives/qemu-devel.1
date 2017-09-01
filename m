Received: from eggs.gnu.org ([2001:4830:134:3::10]:45822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnin-0006Jd-4G
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnii-0001PA-7F
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:19:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnih-0001NZ-Uj
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:18:56 -0400
Date: Fri, 1 Sep 2017 12:18:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170901151850.GD17184@localhost.localdomain>
References: <20170830225225.27925-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170830225225.27925-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/7] QOMify MIPS cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

On Wed, Aug 30, 2017 at 07:52:18PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi,
>=20
> This series is based on Igor's "complete cpu QOMification" [1] but only=
 modify
> the MIPS part. Igor posted an updated series [2], both series should ap=
ply
> separately.
>=20
> Igor suggested on IRC this series could enter via the Machine core tree=
, so
> I added Eduardo and Marcel.

I would do that only if the MIPS maintainers (CCed) aren't
willing to merge the series themselves.


>=20
> Regards,
>=20
> Phil.
>=20
> [1]: http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg04414.h=
tml
> [2]: http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg03364.h=
tml
>=20
> v2:=20
> - added Igor and James Tested-by
> - squashed "!fixup mips: now than MIPSCPU is QOMified, mark it abstract=
"
>=20
> PS: code movement somehow triggers a "binary vs unary operators" confus=
ion
>     in checkpatch: "ERROR: space prohibited after that '&' (ctx:WxW)"
>=20
> Igor Mammedov (2):
>   mips: MIPSCPU model subclasses
>   mips: replace cpu_mips_init() with cpu_generic_init()
>=20
> Philippe Mathieu-Daud=E9 (5):
>   mips: move hw/mips/cputimer.c to target/mips/
>   mips: introduce internal.h and cleanup cpu.h
>   mips: split cpu_mips_realize_env() out of cpu_mips_init()
>   mips: call cpu_mips_realize_env() from mips_cpu_realizefn()
>   mips: update mips_cpu_list() to use object_class_get_list()
>=20
>  target/mips/cpu-qom.h                         |   1 +
>  target/mips/cpu.h                             | 357 +-----------------=
----
>  target/mips/internal.h                        | 422 ++++++++++++++++++=
++++++++
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
> --=20
> 2.14.1
>=20
>=20

--=20
Eduardo
