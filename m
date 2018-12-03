Received: from eggs.gnu.org ([2001:4830:134:3::10]:48994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTuCf-0001eN-FT
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:48:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTuCd-0004TZ-DL
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:48:25 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:45006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gTuCc-0004SA-CA
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:48:23 -0500
Received: by mail-oi1-x230.google.com with SMTP id m6so12044364oig.11
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 11:48:22 -0800 (PST)
MIME-Version: 1.0
References: <20181203155936.114526-1-eblake@redhat.com>
In-Reply-To: <20181203155936.114526-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Dec 2018 19:48:09 +0000
Message-ID: <CAFEAcA9RNyr7hB1BaRr9Y1Zc_mTmujRm_c7hquFm1pPTPquXTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] NBD patches for 3.1-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 3 Dec 2018 at 16:46, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 4750e1a888ac3d320607f33b676f299005be98e6:
>
>   Update version for v3.1.0-rc3 release (2018-11-28 17:37:34 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-12-03
>
> for you to fetch changes up to c688e6ca7b41a105241054853d250df64addbf8f:
>
>   nbd/client: Send NBD_CMD_DISC if open fails after connect (2018-11-30 14:13:37 -0600)
>
> ----------------------------------------------------------------
> nbd patches for 2018-12-03
>
> Improve x-dirty-bitmap handling for experimenting with pull mode
> incremental backups.
>
> - Eric Blake: 0/3 NBD dirty bitmap cleanups
>
> ----------------------------------------------------------------
> Eric Blake (3):
>       nbd/server: Advertise all contexts in response to bare LIST
>       nbd/client: Make x-dirty-bitmap more reliable
>       nbd/client: Send NBD_CMD_DISC if open fails after connect
>
>  block/nbd-client.c | 21 ++++++++++++++++++++-
>  nbd/server.c       |  1 +
>  2 files changed, 21 insertions(+), 1 deletion(-)

Applied, thanks.

-- PMM
