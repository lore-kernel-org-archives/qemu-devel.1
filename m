Received: from eggs.gnu.org ([2001:4830:134:3::10]:52471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKMVD-0002mJ-81
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:23:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKMVC-00022b-FA
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:23:19 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:36649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKMVC-000228-7k
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:23:18 -0400
Received: by mail-wr0-x233.google.com with SMTP id v111so91252293wrc.3
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 03:23:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496857819-12466-1-git-send-email-kwolf@redhat.com>
References: <1496857819-12466-1-git-send-email-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jun 2017 11:22:56 +0100
Message-ID: <CAFEAcA_zNQDuSU633434Po=hng1rfk7oQfpDq0fYt9idO1scZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] Block layer patches
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

On 7 June 2017 at 18:50, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit b55a69fe5f0a504dac6359bb7e99a72b130c3661:
>
>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170607' into staging (2017-06-07 15:06:42 +0100)
>
> are available in the git repository at:
>
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 2cb8f869e43406ce829ebe3b16fecc78d367dc7f:
>
>   block: fix external snapshot abort permission error (2017-06-07 18:51:51 +0200)
>
> ----------------------------------------------------------------
> Block layer patches
>
> ----------------------------------------------------------------
> Jeff Cody (1):
>       block: fix external snapshot abort permission error
>
> Kevin Wolf (6):
>       block: Fix anonymous BBs in blk_root_inactivate()
>       migration: Inactivate images after .save_live_complete_precopy()
>       migration/block: Clean up BBs in block_save_complete()
>       qemu-iotests: Block migration test
>       commit: Fix use after free in completion
>       qemu-iotests: Test automatic commit job cancel on hot unplug
>
> Peter Maydell (1):
>       block/qcow.c: Fix memory leak in qcow_create()

Applied, thanks.

-- PMM
