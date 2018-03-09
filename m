Received: from eggs.gnu.org ([2001:4830:134:3::10]:58502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1euGqQ-0001li-6R
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 07:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1euGqP-00032M-1R
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 07:09:54 -0500
Received: from mail-yw0-x236.google.com ([2607:f8b0:4002:c05::236]:33684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1euGqO-00032A-Rg
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 07:09:52 -0500
Received: by mail-yw0-x236.google.com with SMTP id l200so1022616ywb.0
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 04:09:52 -0800 (PST)
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <CAHNT7NvjnwyknSQMpenSPOXJdoLOT6+Rptu9wPoy2j9uUZn24A@mail.gmail.com>
References: <CAHNT7NtB16m=Sn7bWugeOOiqVyeCT4Z7VrXijMDVZBA+tUdgPw@mail.gmail.com>
	<CAFEAcA_rPkjEgNc=uyQ2C+at8Zs28YZVAkOLAZk17JaVyjxuNw@mail.gmail.com>
	<CAHNT7NvZER8r0Jk2K_vLeB53tDS=rcpZg7S3Yy-7OFy=Gt+4CA@mail.gmail.com>
	<4e34d8f0-7dd8-e69a-3a00-7b5e7d635325@amsat.org>
	<CAHNT7NvjnwyknSQMpenSPOXJdoLOT6+Rptu9wPoy2j9uUZn24A@mail.gmail.com>
MIME-Version: 1.0
Date: Fri, 9 Mar 2018 04:09:51 -0800
Message-ID: <CAG7hfcJNs7BcYdPZEkZr8Q2dk8+1KJKf1gNCjs=ToOCQkkgFSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Apparently fpu/softfloat.c:1374 is reachable (->
 binary images)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt <palmer@sifive.com>, Richard Henderson <richard.henderson@linaro.org>

On 9 March 2018 at 13:58:06, Michael Clark (mjc@sifive.com) wrote:

> ... Hopefully we=E2=80=99ll have binary images for the various artefacts
> on the=C2=A0Releases section on all of the riscv repos,
> ...
> It will be great when binaries are included with the GitHub Releases/tags
> assuming we use GitHub Releases to host the binaries.

This is exactly how I did it in GNU MCU Eclipse and it worked great:

-=C2=A0https://github.com/gnu-mcu-eclipse/riscv-none-gcc/releases
-=C2=A0https://github.com/gnu-mcu-eclipse/windows-build-tools/releases
-=C2=A0https://github.com/gnu-mcu-eclipse/openocd/releases
-=C2=A0https://github.com/gnu-mcu-eclipse/qemu/releases

The binaries for QEMU are a bit old, an update is planned in the near futur=
e.

And I'll extend the use of xpm with binary xPacks for qemu and
arm-none-eabi-gcc. This will greatly simplify running CI jobs (with
support for Travis and AppVeyor under way).


Regards,

Liviu
