Received: from eggs.gnu.org ([209.51.188.92]:52272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDmeG-0002rl-7A
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDmeE-0000EU-TG
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:02:32 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:35709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDmeE-0000EK-Kt
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:02:30 -0400
Received: by mail-ot1-x330.google.com with SMTP id m10so14879791otp.2
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 02:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190408190233.10321-1-eblake@redhat.com>
In-Reply-To: <20190408190233.10321-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 10:02:18 +0100
Message-ID: <CAFEAcA8U2CqknBTMUuMgAP8qd0rUo-5d5FfW74UfS4m4q=qmQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] NBD patches for 4.0-rc3
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

On Mon, 8 Apr 2019 at 20:04, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 2c573106279495795449b0d0373464b597dfe316:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-04-08' into staging (2019-04-08 15:21:11 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-04-08
>
> for you to fetch changes up to e53f88df77e70350b0eda92a2e5e39f67792008f:
>
>   nbd/client: Fix error message for server with unusable sizing (2019-04-08 13:51:25 -0500)
>
> ----------------------------------------------------------------
> nbd patches for 2019-04-08
>
> - Fix minor issues in recent alignment patches
>
> ----------------------------------------------------------------
> Eric Blake (4):
>       nbd/server: Fix blockstatus trace
>       nbd/server: Trace client noncompliance on unaligned requests
>       nbd/server: Don't fail NBD_OPT_INFO for byte-aligned sources
>       nbd/client: Fix error message for server with unusable sizing
>
>  nbd/client.c     |  2 +-
>  nbd/server.c     | 39 +++++++++++++++++++++++++++------------
>  nbd/trace-events |  1 +
>  3 files changed, 29 insertions(+), 13 deletions(-)
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
