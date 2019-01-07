Received: from eggs.gnu.org ([209.51.188.92]:50562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggSy1-0005oc-FW
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:21:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggSy0-0008Pe-U5
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:21:13 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ggSy0-0008PA-OH
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:21:12 -0500
Received: by mail-wm1-x344.google.com with SMTP id t200so551721wmt.0
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 03:21:12 -0800 (PST)
References: <1546621859-28227-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1546621859-28227-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1546621859-28227-2-git-send-email-aleksandar.markovic@rt-rk.com>
Date: Mon, 07 Jan 2019 11:21:10 +0000
Message-ID: <87pnt8vhll.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/2] tests: tcg: mips: Move source files
 to new location
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
> New directory organization is as follows:
>
> tests
>   tcg
>     mips
>       user
>         isa
>           r5900
>         ase
>           dsp
>       system
>         ase
>           dsp
>
> New file names are unique within tests/tcg/mips directory, to
> avoid potential name colision problems.
>
> There will be new subdirectories in near future, for example:
>
> tests/tcg/mips/user/isa/nanomips
> tests/tcg/mips/user/ase/msa
> tests/tcg/mips/user/ase/mxu
>
> etc.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
