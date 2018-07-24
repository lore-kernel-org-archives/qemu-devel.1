Received: from eggs.gnu.org ([2001:4830:134:3::10]:40561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhwSN-0003II-4x
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:30:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhwSJ-0003q0-5c
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:30:23 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:44598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fhwSI-0003pj-IU
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:30:18 -0400
Received: by mail-oi0-x244.google.com with SMTP id s198-v6so7093888oih.11
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 05:30:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180724000126.21787-1-mdroth@linux.vnet.ibm.com>
References: <20180724000126.21787-1-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jul 2018 13:29:57 +0100
Message-ID: <CAFEAcA8bWcr0_Z4gTvhw1Ww+kbbMWq3gZ9tcARUuTq8MfiKFUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL for-3.0 0/2] qemu-ga patch queue for
 hard-freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 July 2018 at 01:01, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> The following changes since commit 4eecc2e212bae7308d8582d99f665dfc253c9d=
da:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180723' into =
staging (2018-07-23 19:24:05 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/mdroth/qemu.git tags/qga-pull-2018-07-23-tag
>
> for you to fetch changes up to ae7da1e5f658ea21d96e565514de20ff2cf24fa1:
>
>   qga: process_event() simplification and leak fix (2018-07-23 18:54:26 -=
0500)
>
> ----------------------------------------------------------------
> qemu-ga patch queue for hard-freeze
>
> * fix leak in qga main loop error path
> * better error reporting when Windows version doesn't support fstrim
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (1):
>       qga: process_event() simplification and leak fix
>
> Sameeh Jubran (1):
>       qga-win: Handle fstrim for OSes lower than Win8
>
>  qga/commands-win32.c | 13 +++++++++++++
>  qga/main.c           | 54 ++++++++++++++++++++++++++--------------------=
------
>  2 files changed, 40 insertions(+), 27 deletions(-)


Applied, thanks.

-- PMM
