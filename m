Received: from eggs.gnu.org ([209.51.188.92]:40333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLW4i-0006aR-Pc
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLW4g-0003Sv-RQ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:57:48 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:34961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLW4f-0003PM-2X
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:57:46 -0400
Received: by mail-oi1-x229.google.com with SMTP id w197so11851254oia.2
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190430154244.30083-1-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 17:57:28 +0100
Message-ID: <CAFEAcA-rW3OLKt2a8+1cdcMa-=Hp+ppqp_HdC1=ZNVxSXtKqeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/27] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 30 Apr 2019 at 17:01, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 22d96eac64877c4d96f9928babb6f2fcc68faacf:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2019-04-29 19:11:15 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 54277a2aab876aba7b55c7e88e2b372691849741:
>
>   block/qed: add missed coroutine_fn markers (2019-04-30 15:29:00 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - iotests: Fix output of qemu-io related tests
> - Don't ignore bdrv_set_aio_context() for nodes with bs->drv = NUL
> - vmdk: Set vmdk parent backing_format to vmdk
> - qcow2: Preallocation fixes (especially for external data files)
> - Add linear-buffer-based APIs (as wrappers around qiov-based ones)
> - Various code cleanups and small corner case fixes
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM
