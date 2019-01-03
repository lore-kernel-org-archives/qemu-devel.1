Received: from eggs.gnu.org ([208.118.235.92]:49457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gf2yS-00012C-FW
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:23:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gf2yR-0000pY-GH
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:23:48 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gf2yR-0000pD-C7
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:23:47 -0500
Received: by mail-oi1-x243.google.com with SMTP id i6so27619537oia.6
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 05:23:47 -0800 (PST)
MIME-Version: 1.0
References: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jan 2019 13:23:35 +0000
Message-ID: <CAFEAcA8Xb1DeTTus7vwfQXDGC8ETR5a9Egg4nVN=+cLy0xm2dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/44] MIPS pull request for December
 2018 - v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Mon, 31 Dec 2018 at 14:56, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 9b2e891ec5ccdb4a7d583b77988848282606fd=
ea:
>
>   Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' in=
to staging (2018-12-22 11:25:31 +0000)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-dec-2018-v2
>
> for you to fetch changes up to 96446398f47b70cf0998412314730709570e08c5:
>
>   tests/tcg: mips: Test R5900 three-operand MADDU1 (2018-12-31 15:47:28 +=
0100)
>
> ----------------------------------------------------------------
>
> MIPS queue for December 2018 - v2
>
>
>   - this queue contains various amendments to MIPS code
>   - there are three checkpatch warnings that should be ingnored
>     in given circumstances
>   - most of the patches are not yet visible/noticeable to the end
>     user, just a single note related to Paul's patch will be added
>     to ChangeLog
>
> v1->v2:
>
>   - added three patches that were meanwhile tested better
>

Hi; I'm afraid this doesn't build on all my test hosts:

target/mips/translate.c: In function =E2=80=98gen_mxu_Q8MAX_Q8MIN=E2=80=99:
target/mips/translate.c:25092:9: error: =E2=80=98for=E2=80=99 loop initial
declarations are only allowed in C99 mode
         for (int i =3D 2; i >=3D 0; i--) {
         ^
target/mips/translate.c:25092:9: note: use option -std=3Dc99 or
-std=3Dgnu99 to compile your code
target/mips/translate.c:25129:9: error: =E2=80=98for=E2=80=99 loop initial
declarations are only allowed in C99 mode
         for (int i =3D 2; i >=3D 0; i--) {
         ^

(This probably only shows up on builds with older versions
of gcc which don't default to c99.)

We don't use variable-declaration-in-for-loop.

thanks
-- PMM
