Received: from eggs.gnu.org ([2001:4830:134:3::10]:37773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emWHN-00020G-0I
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 22:01:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emWHJ-00071g-0M
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 22:01:41 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:38845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emWHI-00071E-PN
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 22:01:36 -0500
Received: by mail-qt0-x242.google.com with SMTP id k13so2281034qtg.5
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 19:01:36 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215173539.11033-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2d925ff9-7e18-2d14-11a1-69a8871b9848@amsat.org>
Date: Fri, 16 Feb 2018 00:01:28 -0300
MIME-Version: 1.0
In-Reply-To: <20180215173539.11033-1-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="oxrSs47fQINSzDpfaWTAoyhUDVVedAzDC"
Subject: Re: [Qemu-devel] [RFC PATCH] capstone: fix building using system
 package
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oxrSs47fQINSzDpfaWTAoyhUDVVedAzDC
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Message-ID: <2d925ff9-7e18-2d14-11a1-69a8871b9848@amsat.org>
Subject: Re: [RFC PATCH] capstone: fix building using system package
References: <20180215173539.11033-1-f4bug@amsat.org>
In-Reply-To: <20180215173539.11033-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

What is interesting with this patch, is that, forcing use of system
capstone, Travis builds ran much faster; longest build took 40min:
https://travis-ci.org/philmd/qemu/builds/341979248

This revealed (without profiling yet) that compiling the capstone C++
takes some time...

mingw32@i7-4600U# time make subdir-capstone
  CC      cs.o
  CC      utils.o
  CC      SStream.o
  CC      MCInstrDesc.o
  CC      MCRegisterInfo.o
  CC      arch/ARM/ARMDisassembler.o
  CC      arch/ARM/ARMInstPrinter.o
  CC      arch/ARM/ARMMapping.o
  CC      arch/ARM/ARMModule.o
  CC      arch/AArch64/AArch64BaseInfo.o
  CC      arch/AArch64/AArch64Disassembler.o
  CC      arch/AArch64/AArch64InstPrinter.o
  CC      arch/AArch64/AArch64Mapping.o
  CC      arch/AArch64/AArch64Module.o
  CC      arch/Mips/MipsDisassembler.o
  CC      arch/Mips/MipsInstPrinter.o
  CC      arch/Mips/MipsMapping.o
  CC      arch/Mips/MipsModule.o
  CC      arch/PowerPC/PPCDisassembler.o
  CC      arch/PowerPC/PPCInstPrinter.o
  CC      arch/PowerPC/PPCMapping.o
  CC      arch/PowerPC/PPCModule.o
  CC      arch/Sparc/SparcDisassembler.o
  CC      arch/Sparc/SparcInstPrinter.o
  CC      arch/Sparc/SparcMapping.o
  CC      arch/Sparc/SparcModule.o
  CC      arch/SystemZ/SystemZDisassembler.o
  CC      arch/SystemZ/SystemZInstPrinter.o
  CC      arch/SystemZ/SystemZMapping.o
  CC      arch/SystemZ/SystemZModule.o
  CC      arch/SystemZ/SystemZMCTargetDesc.o
  CC      arch/X86/X86DisassemblerDecoder.o
  CC      arch/X86/X86Disassembler.o
  CC      arch/X86/X86IntelInstPrinter.o
  CC      arch/X86/X86ATTInstPrinter.o
  CC      arch/X86/X86Mapping.o
  CC      arch/X86/X86Module.o
  CC      arch/XCore/XCoreDisassembler.o
  CC      arch/XCore/XCoreInstPrinter.o
  CC      arch/XCore/XCoreMapping.o
  CC      arch/XCore/XCoreModule.o
  CC      MCInst.o
  AR      capstone.lib
i686-w64-mingw32.shared-ar: creating capstone/capstone.lib
make: 'subdir-capstone' is up to date.

real	0m35.391s
user	0m32.857s
sys	0m2.414s

Not that bad after all.

So I still dunno why this patch improved build time...

On 02/15/2018 02:35 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> The use of <capstone/capstone.h> is recommended by the upstream project=
:
>   http://www.capstone-engine.org/lang_c.html
> However when building the in-tree cloned submodule, the header is acces=
sible
> via <capstone.h>.
>=20
> This fixes building on Gentoo (and Haiku OS - not supported since 898be=
3e0415):
>     CC      disas.o
>   /sources/qemu-2.11.0/include/disas/capstone.h:6:22: fatal error: caps=
tone.h: No such file or directory
>   #include <capstone.h>
>            ^~~~~~~~~~~~
>=20
> On Haiku `pkg-config --cflags capstone` reports "-I/usr/develop/headers=
".
>=20
> Bug: https://bugs.gentoo.org/647570
> Reported-by: Zolt=C3=A1n Mizsei <miqlas@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> RFC because this might be a Gentoo portage issue.
>=20
>  configure                | 1 +
>  include/disas/capstone.h | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 913e14839d..3657a61a35 100755
> --- a/configure
> +++ b/configure
> @@ -7017,6 +7017,7 @@ if [ "$dtc_internal" =3D "yes" ]; then
>    echo "config-host.h: subdir-dtc" >> $config_host_mak
>  fi
>  if [ "$capstone" =3D "git" -o "$capstone" =3D "internal" ]; then
> +  echo "CONFIG_LIBCAPSTONE_INTERNAL=3Dy" >> $config_host_mak
>    echo "config-host.h: subdir-capstone" >> $config_host_mak
>  fi
>  if test -n "$LIBCAPSTONE"; then
> diff --git a/include/disas/capstone.h b/include/disas/capstone.h
> index 84e214956d..aea9601f41 100644
> --- a/include/disas/capstone.h
> +++ b/include/disas/capstone.h
> @@ -3,9 +3,13 @@
> =20
>  #ifdef CONFIG_CAPSTONE
> =20
> +#ifdef CONFIG_LIBCAPSTONE_INTERNAL
>  #include <capstone.h>
> -
>  #else
> +#include <capstone/capstone.h>
> +#endif /* CONFIG_LIBCAPSTONE_INTERNAL */
> +
> +#else /* CONFIG_CAPSTONE */
> =20
>  /* Just enough to allow backends to init without ifdefs.  */
> =20
>=20


--oxrSs47fQINSzDpfaWTAoyhUDVVedAzDC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlqGSYsACgkQ4+MsLN6t
wN4LvA//XarmYSS2urB8f5rxeE7ojjBRjrg60DmtOL4++cY2nYju7uiH14uK3G9W
3haMk8o9n/0U3YAX9kmv71WB8daCfkmFwjaoXjiIb84UKk0npGJvsTXQDpx1xwCI
kAIkeFUOHjyCXh4Rvfvmwy1BL+OaE9D3KBquCwlAR5IxRVWeLCYWvRC9APbXDwb/
oU2sv32MN+VJHWzU51MkM2wrsxt/ZqZ0iI6cA2KGVXtmZ20zzJ42g7BSDwNvX5EX
RcZCyk3mTTgSxocr2FDDIzIsVevoQfz2Pgtr4CskJsGyaL1Wv77bzyNkKqgkaqCO
JN+AmmxcqWFi/jsZMN6fsJ1qCff7UWbQL/9BRd4cKYlTEyA5mm7benXn2vNZSQZO
xigGwNB3TOxT9HA7ZBImFLgoxLefVUdWaNB327AuljeKuWiGzLBtwyurkBvDczYW
wbtjUkM19AvpGDrGUzbe/hMZZJCHJE1ZoRoZNJVSVL7POgGgxEdQ096Wbg5BZZsu
8ygoVYCn54AAB1uLviB1KI6DLrltjuYkc2qPVjQevKVWGwi+LzuUN62jLYwzGx7g
ExRpgxCd13XmgzuIqSnYwrqRuSOcFTlbcssMr4w8YF/mh1E198qXiR2G2y00h1ZH
dHzMZSh8Y1TTSm17qtu6g01GI1Jasha+CaHFrE/H44Ozx8lLrdk=
=TRRs
-----END PGP SIGNATURE-----

--oxrSs47fQINSzDpfaWTAoyhUDVVedAzDC--
