Received: from eggs.gnu.org ([209.51.188.92]:51630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggSze-0006iS-LI
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggSze-0001fl-01
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:22:54 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ggSzd-0001eU-QB
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:22:53 -0500
Received: by mail-wm1-x342.google.com with SMTP id y185so5890826wmd.1
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 03:22:53 -0800 (PST)
References: <1546621859-28227-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1546621859-28227-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1546621859-28227-3-git-send-email-aleksandar.markovic@rt-rk.com>
Date: Mon, 07 Jan 2019 11:22:51 +0000
Message-ID: <87o98svhis.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/2] tests: tcg: mips: Remove old
 directories after moving source files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: qemu-devel@nongnu.org, amarkovic@wavecomp.com, arikalo@wavecomp.com, smarkovic@wavecomp.com, noring@nocrew.org, aurelien@aurel32.net


Aleksandar Markovic <aleksandar.markovic@rt-rk.com> writes:

> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Remove old directories after reorganization of MIPS TCG tests.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  tests/tcg/mips/mips32-dsp/Makefile        | 136 -------------
>  tests/tcg/mips/mips32-dspr2/Makefile      |  71 -------
>  tests/tcg/mips/mips64-dsp/Makefile        | 306 ------------------------=
------
>  tests/tcg/mips/mips64-dsp/head.S          |  16 --
>  tests/tcg/mips/mips64-dsp/io.h            |  22 ---
>  tests/tcg/mips/mips64-dsp/mips_boot.lds   |  31 ---
>  tests/tcg/mips/mips64-dspr2/.directory    |   2 -
>  tests/tcg/mips/mips64-dspr2/Makefile      | 116 -----------
>  tests/tcg/mips/mips64-dspr2/head.S        |  16 --
>  tests/tcg/mips/mips64-dspr2/io.h          |  22 ---
>  tests/tcg/mips/mips64-dspr2/mips_boot.lds |  31 ---
>  tests/tcg/mips/mipsr5900/Makefile         |  32 ----

Erm do we really want this? Ideally the Makefiles should be moved into
their new locations and tested with whatever the out of tree build
approach was before. Then my series can apply on top and translate them
into new style check-tcg tests builds.

--
Alex Benn=C3=A9e
