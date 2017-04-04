Received: from eggs.gnu.org ([2001:4830:134:3::10]:49332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvSKr-0004ZG-BY
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvSKq-0003o8-9N
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:33:41 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cvSKq-0003nr-3N
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:33:40 -0400
Received: by mail-wr0-x235.google.com with SMTP id k6so216221027wre.2
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 10:33:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1491322410-24532-1-git-send-email-groug@kaod.org>
References: <1491322410-24532-1-git-send-email-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Apr 2017 18:33:18 +0100
Message-ID: <CAFEAcA-oRfJb9=zSpYKUBEM4ryY_4_1K4odNxpdMR5rjYTzfew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] 9pfs fixes for 2.9 2017-04-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 4 April 2017 at 17:13, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit 87cc4c61020addea6a001b94b662596b1896d1b3:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-04-04 11:40:55 +0100)
>
> are available in the git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to 6d54af0ea9eeee70b4c0eb48bd2ae1d22b207dd4:
>
>   9pfs: clear migration blocker at session reset (2017-04-04 18:06:01 +0200)
>
> ----------------------------------------------------------------
> Some 9pfs bugs fixes: potential hang at reset, migration blocker leak.
>
> ----------------------------------------------------------------
> Greg Kurz (2):
>       9pfs: fix multiple flush for same request
>       9pfs: clear migration blocker at session reset
>
>  hw/9pfs/9p.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

Applied, thanks.

-- PMM
