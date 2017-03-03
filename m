Received: from eggs.gnu.org ([2001:4830:134:3::10]:40785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjnom-0006Xi-KE
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:04:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjnol-0003HO-IP
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:04:24 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjnol-0003H8-Ac
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:04:23 -0500
Received: by mail-wm0-x232.google.com with SMTP id t193so16121280wmt.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 06:04:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170302161033.4787-1-berrange@redhat.com>
References: <20170302161033.4787-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 14:04:01 +0000
Message-ID: <CAFEAcA-XcVye-fwujx+WxZ_-D4V1n3Bf7S9VFKeFg2n1wRyURA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 0/3] Merge qio 2017/02/27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 March 2017 at 16:10, Daniel P. Berrange <berrange@redhat.com> wrote:
> The following changes since commit 8f2d7c341184a95d05476ea3c45dbae2b9ddbe=
51:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-0=
2-27-1' into staging (2017-02-27 15:33:21 +0000)
>
> are available in the git repository at:
>
>   git://github.com/berrange/qemu tags/pull-qio-2017-02-27-2
>
> for you to fetch changes up to 07e95cd529af345fdeea230913f68eff5b925bb6:
>
>   io: fully parse & validate HTTP headers for websocket protocol handshak=
e (2017-02-28 11:51:16 +0000)
>
> ----------------------------------------------------------------
> Merge qio 2017/02/27 v2
>
> ----------------------------------------------------------------
>
> Daniel P. Berrange (2):
>   io: fix decoding when multiple websockets frames arrive at once
>   io: fully parse & validate HTTP headers for websocket protocol
>     handshake
>
> Marc-Andr=C3=A9 Lureau (1):
>   tests: fix leaks in test-io-channel-command
>
>  io/channel-websock.c            | 264 +++++++++++++++++++++++++++++++---=
------
>  tests/test-io-channel-command.c |   6 +-
>  2 files changed, 210 insertions(+), 60 deletions(-)

Applied, thanks.

-- PMM
