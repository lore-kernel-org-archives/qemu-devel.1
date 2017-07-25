Received: from eggs.gnu.org ([2001:4830:134:3::10]:44017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1da9l8-0006OL-05
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 20:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1da9l2-0006wn-Sq
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 20:01:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1da9l2-0006vo-JZ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 20:00:56 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6Q00ph6123929
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:00:55 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bx8t23mg2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:00:52 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 25 Jul 2017 17:59:01 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170725011530.17958-1-f4bug@amsat.org>
References: <20170725011530.17958-1-f4bug@amsat.org>
Date: Tue, 25 Jul 2017 18:03:47 -0500
Message-Id: <150102382734.26979.483898024984598924@loki>
Subject: Re: [Qemu-devel] [PATCH] configure: fix qemu-ga missing '.exe'
 extension on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?utf-8?b?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, Daniel Rempel <daniel@daynix.com>, Sameeh Jubran <sjubran@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

Quoting Philippe Mathieu-Daud=C3=A9 (2017-07-24 20:15:30)
> Reported-by: Sameeh Jubran <sjubran@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> original report from Sameeh Jubran:
> http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg00906.html

AFAICT the issue discussed in the context of that patch is simply that
the qemu-ga.exe file isn't deleted as part of `make clean`, which does
seem to be an issue.

But qemu.ga.exe is created just fine as part of `make qemu-ga`, at least
as of:

  fafcaf1d build: qemu-ga: add 'qemu-ga' build target for w32

The 'qemu-ga' target is actually an intermediate target which, on w32,
creates the MSI package (if configured) as well as qemu-ga.exe.

> =

>  Makefile  | 2 +-
>  configure | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/Makefile b/Makefile
> index ef721480eb..5f18243d05 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -490,7 +490,7 @@ clean:
>         rm -f qemu-options.def
>         rm -f *.msi
>         find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name =
'*.[oda]' \) -type f -exec rm {} +
> -       rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS csco=
pe.* *.pod *~ */*~
> +       rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.p=
od *~ */*~
>         rm -f fsdev/*.pod
>         rm -f qemu-img-cmds.h
>         rm -f ui/shader/*-vert.h ui/shader/*-frag.h
> diff --git a/configure b/configure
> index 48d4d7a2a7..f8b1d014d7 100755
> --- a/configure
> +++ b/configure
> @@ -5073,7 +5073,7 @@ fi
> =

>  if [ "$guest_agent" !=3D "no" ]; then
>    if [ "$linux" =3D "yes" -o "$bsd" =3D "yes" -o "$solaris" =3D "yes" -o=
 "$mingw32" =3D "yes" ] ; then
> -      tools=3D"qemu-ga $tools"
> +      tools=3D"qemu-ga\$(EXESUF) $tools"
>        guest_agent=3Dyes
>    elif [ "$guest_agent" !=3D yes ]; then
>        guest_agent=3Dno
> -- =

> 2.13.3
> =

>=20
