Received: from eggs.gnu.org ([2001:4830:134:3::10]:36315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ecXjk-0000i8-MH
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:33:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ecXjf-0002Z4-NA
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:33:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ecXjf-0002Xn-Go
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:33:39 -0500
Date: Fri, 19 Jan 2018 15:33:32 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180119153332.77b3d4d0@igors-macbook-pro.local>
In-Reply-To: <41ae7321-c370-84ec-97ec-bd065cef2a61@vivier.eu>
References: <20180116222212.1266-1-laurent@vivier.eu>
	<20180117164950.3c818541@redhat.com>
	<41ae7321-c370-84ec-97ec-bd065cef2a61@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/4] linux-user: select CPU type
 according ELF header values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, YunQiang Su <syq@debian.org>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, Philippe =?UTF-8?Q?Mathieu-Daud?= =?UTF-8?Q?=C3=A9?= <f4bug@amsat.org>, Aaron Sierra <asierra@xes-inc.com>

On Fri, 19 Jan 2018 14:56:53 +0100
Laurent Vivier <laurent@vivier.eu> wrote:

> Le 17/01/2018 =C3=A0 16:49, Igor Mammedov a =C3=A9crit=C2=A0:
> > On Tue, 16 Jan 2018 23:22:08 +0100
> > Laurent Vivier <laurent@vivier.eu> wrote:
> >=20
> >> This idea has been suggested to me before by Philippe
> >> Mathieu-Daud=C3=A9, and recently YunQiang Su has proposed a
> >> patch to manage the MIPS r6 case.
> >>
> >> Based on this, this series tries to clean-up the original
> >> patch, and introduces the use for m68k architecture and
> >> port the patch from YunQiang Su.
> >>
> >> v3: fix code indent problem reported by patchew
> >>     remove useless "!=3D 0"
> >>     check for EF_M68K_M68000
> >>     add EF_M68K_* flags in elf.h
> >>     set 680x0 default CPU to m68040
> >>     change "#if ... #endif" structure for ppc
> >> v2: move cpu_model selection to linux-user/*/target_elf.h
> >>     provide eflags to cpu_get_model() instead of fd
> >>     (and modify other patches accordingly)
> > Sorry for not noticing it earlier, but could you please
> > fix series to use cpu type names instead of cpu_model?
>=20
> As your series is not ready for inclusion, perhaps we can take my series
> first?
>=20
> I'll happily help you to adapt your series on top of this one if you need.
It wasn't about whose series goes first (I don't really care as I can rebas=
e),

suggestion was about using cpu types instead of cpu models
which you are adding/moving into linux-user/*/target_elf.h

Otherwise we would need immediately to have a patch on top that
replaces them in linux-user/*/target_elf.h with cpu types.

So I'd rather amend this series so that it would use cpu types
from the start instead of doing refactoring on top which just
doubles amount of touched lines.



> Thanks,
> Laurent
>=20
