Received: from eggs.gnu.org ([2001:4830:134:3::10]:37658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecCJr-00050R-0S
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:41:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecCJq-00024H-A4
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:41:35 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:40550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ecCJq-00023x-52
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:41:34 -0500
Received: by mail-ot0-x230.google.com with SMTP id x4so4783424otg.7
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 07:41:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1f5614b9-591c-a3f9-c6ce-15d615d13c03@amsat.org>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA-8dwLpfrbV8+--L4Z9Um9xVsyUOfKjcz9-T1aTPkgrEg@mail.gmail.com>
	<20180117201515.1a49fcbf@redhat.com>
	<CAFEAcA9gXOOkv+-rTXcNyzgY9P8CR66Rrx-0GM2G0m0x+HbAmA@mail.gmail.com>
	<20180118114330.53ad7ce7@redhat.com>
	<CAFEAcA-My_vDd=_7g907MpO2WmVHOHKxsw2-E-vQwn=_SZadRQ@mail.gmail.com>
	<20180118140605.028b7e33@redhat.com>
	<CAFEAcA-oP7hCgjwqiCh4TKKpq-Jfho0JOAsSvWfc09iUouiUWg@mail.gmail.com>
	<1f5614b9-591c-a3f9-c6ce-15d615d13c03@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2018 15:41:12 +0000
Message-ID: <CAFEAcA86cRiz4UgCnagEs8q=c_taa=enJ3ZxA4hN3hPYAMp=Kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/24] generalize parsing of cpu_model
 (part 4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Michael Tokarev <mjt@tls.msk.ru>, Riku Voipio <riku.voipio@iki.fi>, Agustin Henze <tin@debian.org>, QEMU Developers <qemu-devel@nongnu.org>, Debian QEMU Team <pkg-qemu-devel@lists.alioth.debian.org>

On 18 January 2018 at 15:31, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> I disagree on this, since userland binaries are compiled for a specific
> arch/ABI/FPU.
> Even without worrying about the FPU, it is unlikely the "any" cpu can
> run indifferently ARMv6 and ARMv7 binaries.

In practice this works fine. Generally for userspace the Arm
architecture retains backwards compatibility. (This is not the
case for kernel mode, obviously.)

thanks
-- PMM
