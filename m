Received: from eggs.gnu.org ([2001:4830:134:3::10]:45795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIYdB-00036Z-8P
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIYdA-0000RF-BO
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:56:05 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:35784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIYdA-0000R2-3o
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:56:04 -0400
Received: by mail-wm0-x230.google.com with SMTP id x70so55156339wme.0
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 03:56:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496806444-27910-1-git-send-email-jasowang@redhat.com>
References: <1496806444-27910-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Jun 2017 11:55:42 +0100
Message-ID: <CAFEAcA9jwBwtD0Gd+5Hz=4LzOKnDwkfzpz3KRyhjECAk1iGpRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 June 2017 at 04:34, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit 199e19ee538eb61fd08b1c1ee5aa838ebdcc968e:
>
>   Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2017-06-05 15:28:12 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 6701e5514beab7b781a10424a94e9850c707287c:
>
>   Revert "Change net/socket.c to use socket_*() functions" again (2017-06-07 10:58:31 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
> Daniel P. Berrange (1):
>       Revert "Change net/socket.c to use socket_*() functions" again
>
> Mao Zhongyi (1):
>       net/rocker: Cleanup the useless return value check
>
>  hw/net/rocker/rocker.c      |   9 ++--
>  hw/net/rocker/rocker_desc.c |   4 +-
>  net/socket.c                | 127 +++++++++++++++++++-------------------------
>  3 files changed, 60 insertions(+), 80 deletions(-)
>
Applied, thanks.

-- PMM
