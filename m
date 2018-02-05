Received: from eggs.gnu.org ([2001:4830:134:3::10]:49720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eid7x-0007Rs-2F
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 04:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eid7r-0000zc-DY
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 04:31:53 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:38496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eid7r-0000z3-74
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 04:31:47 -0500
Received: by mail-ot0-x241.google.com with SMTP id v5so26309995oth.5
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 01:31:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202071751.16316-1-kraxel@redhat.com>
References: <20180202071751.16316-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Feb 2018 09:31:25 +0000
Message-ID: <CAFEAcA9L0+GMxo7ZZxvH_KvvOYQH2VeoBEJvmq3WH-Zw4Yu9-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] Ui 20180202 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 February 2018 at 07:17, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 11ed801d3df3c6e46b2f1f97dcfbf4ca3a2a2f=
4f:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-reques=
t' into staging (2018-01-30 09:47:51 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20180202-pull-request
>
> for you to fetch changes up to 627ebec208a8809818589e17f4fce55a59420ad2:
>
>   ui: correctly advance output buffer when writing SASL data (2018-02-02 =
07:48:18 +0100)
>
> ----------------------------------------------------------------
> ui: use QIONetListener in vnc, bugfixes for sdl1 and vnc.
>
> ----------------------------------------------------------------
>
> Daniel P. Berrange (1):
>   ui: convert VNC server to QIONetListener
>
> Daniel P. Berrang=C3=A9 (2):
>   ui: fix mixup between qnum and qcode in SDL1 key handling
>   ui: correctly advance output buffer when writing SASL data
>
>  ui/vnc.h           |   9 +--
>  ui/sdl.c           |   9 ++-
>  ui/vnc-auth-sasl.c |   2 +-
>  ui/vnc.c           | 195 +++++++++++++++--------------------------------=
------
>  4 files changed, 67 insertions(+), 148 deletions(-)
>

Applied, thanks.

-- PMM
