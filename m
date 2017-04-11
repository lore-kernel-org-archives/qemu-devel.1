Received: from eggs.gnu.org ([2001:4830:134:3::10]:50854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxvgS-0001NT-1h
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxvgI-00072X-N4
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:18:12 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxvgI-00072G-FM
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:18:02 -0400
Received: by mail-wm0-x232.google.com with SMTP id w64so63486128wma.0
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 06:18:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170411122632.14050-1-famz@redhat.com>
References: <20170411122632.14050-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Apr 2017 14:17:40 +0100
Message-ID: <CAFEAcA8zHfkxZUtH0h5ybTwSEBr1foGLvKzsO0rt0dgWL9MN2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/11] Block patches for 2.9-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 11 April 2017 at 13:26, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit 17fa24b79ceaa8258e415822cf2e2cb23cf3facb:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-fixes-20170411-1' into staging (2017-04-11 10:03:51 +0100)
>
> are available in the git repository at:
>
>   git://github.com/famz/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 76296dff97864ebb15fa65cc56a6f890ee0c5a28:
>
>   sheepdog: Use bdrv_coroutine_enter before BDRV_POLL_WHILE (2017-04-11 20:07:15 +0800)
>
> ----------------------------------------------------------------
>
> This fixes the known issue 'snapshot_blkdev is broken when using iothreads'.
>
> ----------------------------------------------------------------
>
> Fam Zheng (11):
>   block: Make bdrv_parent_drained_begin/end public
>   block: Quiesce old aio context during bdrv_set_aio_context
>   tests/block-job-txn: Don't start block job before adding to txn
>   coroutine: Extract qemu_aio_coroutine_enter
>   async: Introduce aio_co_enter
>   block: Introduce bdrv_coroutine_enter
>   blockjob: Use bdrv_coroutine_enter to start coroutine
>   qemu-io-cmds: Use bdrv_coroutine_enter
>   block: Use bdrv_coroutine_enter to start I/O coroutines
>   block: Fix bdrv_co_flush early return
>   sheepdog: Use bdrv_coroutine_enter before BDRV_POLL_WHILE

Applied, thanks.

-- PMM
