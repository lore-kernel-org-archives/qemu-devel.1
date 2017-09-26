Received: from eggs.gnu.org ([2001:4830:134:3::10]:39107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwuGc-0003Ye-CG
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwuGb-0002KV-Da
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:07:34 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:48338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dwuGb-0002KE-6h
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:07:33 -0400
Received: by mail-wm0-x232.google.com with SMTP id m127so10566555wmm.3
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 11:07:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170925134130.13262-1-eblake@redhat.com>
References: <20170925134130.13262-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2017 19:07:11 +0100
Message-ID: <CAFEAcA-gP0KzyN08wGb8vYhyKLzocGin2LvR0MGQ5giow9QQGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] NBD patches for 2017-09-25
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

On 25 September 2017 at 14:41, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 460b6c8e581aa06b86f59eebd9e52edfe7adf417:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-09-23 12:55:40 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-09-25
>
> for you to fetch changes up to a693437037328a95d815ad5aec37ac2f8e130e58:
>
>   block/nbd-client: nbd_co_send_request: fix return code (2017-09-25 08:21:26 -0500)
>
> ----------------------------------------------------------------
> nbd patches for 2017-09-25
>
> - Eric Blake: nbd-client: Use correct macro parenthesization
> - Vladimir Sementsov-Ogievskiy: 0/3 nbd client refactoring and fixing
>
> ----------------------------------------------------------------
> Eric Blake (1):
>       nbd-client: Use correct macro parenthesization
>
> Vladimir Sementsov-Ogievskiy (3):
>       block/nbd-client: refactor nbd_co_receive_reply
>       block/nbd-client: simplify check in nbd_co_receive_reply
>       block/nbd-client: nbd_co_send_request: fix return code
>
>  block/nbd-client.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)

Applied, thanks.

-- PMM
