Received: from eggs.gnu.org ([2001:4830:134:3::10]:42808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eRPFZ-0005kN-Ao
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 16:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eRPFY-00006B-FQ
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 16:16:33 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eRPFY-00005U-Ao
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 16:16:32 -0500
Received: by mail-ot0-x241.google.com with SMTP id n18so8641629otd.1
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 13:16:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218224030.26726-1-aurelien@aurel32.net>
References: <20171218224030.26726-1-aurelien@aurel32.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Dec 2017 21:16:11 +0000
Message-ID: <CAFEAcA_nvtqkS8WV56q2qE1Rh8B5sNf1fuYbR5-Ajoxh=UH5fQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/6] Queued target/sh4 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 December 2017 at 22:40, Aurelien Jarno <aurelien@aurel32.net> wrote:
> The following changes since commit eaefea537b476cb853e2edbdc68e969ec777e4=
bb:
>
>   Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' i=
nto staging (2017-12-18 14:17:42 +0000)
>
> are available in the Git repository at:
>
>   git://git.aurel32.net/qemu.git tags/pull-target-sh4-20171218
>
> for you to fetch changes up to 6f1c2af641d6e7aceb2e5671a45b3d6e5966dfb8:
>
>   target/sh4: Convert to DisasContextBase (2017-12-18 23:35:33 +0100)
>
> ----------------------------------------------------------------
> Queued target/sh4 patches
>
> ----------------------------------------------------------------
> Alex Benn=C3=A9e (1):
>       target/sh4: fix TCG leak during gusa sequence
>
> Philippe Mathieu-Daud=C3=A9 (1):
>       target/sh4: add missing tcg_temp_free() in _decode_opc()
>
> Richard Henderson (4):
>       target/sh4: Use cmpxchg for movco when parallel_cpus
>       target/sh4: Convert to DisasJumpType
>       target/sh4: Do not singlestep after exceptions
>       target/sh4: Convert to DisasContextBase
>
>  linux-user/main.c      |  19 +++-
>  target/sh4/cpu.h       |   4 +-
>  target/sh4/helper.c    |   1 +
>  target/sh4/translate.c | 273 ++++++++++++++++++++++++++++---------------=
------
>  4 files changed, 174 insertions(+), 123 deletions(-)

Applied, thanks.

-- PMM
