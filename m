Received: from eggs.gnu.org ([2001:4830:134:3::10]:32832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX33d-00010k-HJ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX33c-0000FC-Gy
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:15:17 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dX33c-0000DV-9a
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:15:16 -0400
Received: by mail-wm0-x22b.google.com with SMTP id f67so78553907wmh.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 03:15:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170715123057.8529-1-samuel.thibault@ens-lyon.org>
References: <20170715123057.8529-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 11:14:54 +0100
Message-ID: <CAFEAcA_2DESu-EaXkgyC1zpe6aPkHUQ=m+6RnQ8f+jh5BinTSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/4] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

On 15 July 2017 at 13:30, Samuel Thibault <samuel.thibault@ens-lyon.org> wr=
ote:
> warning: redirection vers https://people.debian.org/~sthibault/qemu.git/
> The following changes since commit 4871b51b9241b10f4fd8e04bbb21577886795e=
25:
>
>   vmgenid-test: use boot-sector infrastructure (2017-07-14 17:03:03 +0100=
)
>
> are available in the git repository at:
>
>   http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 75cb298d905030fca897ea1d80e409c7f7e3e5ea:
>
>   slirp: Handle error returns from sosendoob() (2017-07-15 14:28:25 +0200=
)
>
> ----------------------------------------------------------------
> slirp updates
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (1):
>       slirp: use DIV_ROUND_UP
>
> Peter Maydell (3):
>       slirp: fork_exec(): Don't close() a negative number in fork_exec()
>       slirp: Handle error returns from slirp_send() in sosendoob()
>       slirp: Handle error returns from sosendoob()
>
>  slirp/ip6.h    |  6 +++---
>  slirp/misc.c   |  4 +++-
>  slirp/sbuf.c   |  2 +-
>  slirp/socket.c | 52 +++++++++++++++++++++++++++++++++++-----------------
>  4 files changed, 42 insertions(+), 22 deletions(-)

Applied, thanks.

-- PMM
