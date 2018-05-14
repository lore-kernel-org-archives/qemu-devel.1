Received: from eggs.gnu.org ([2001:4830:134:3::10]:57244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIDK8-0003wU-6H
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIDK6-0001j3-Ld
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:15:31 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:38491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIDK6-0001id-Dg
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:15:30 -0400
Received: by mail-ot0-x243.google.com with SMTP id n3-v6so14188898ota.5
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 06:15:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512092824.13848-1-stefanha@redhat.com>
References: <20180512092824.13848-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 14:15:09 +0100
Message-ID: <CAFEAcA9ACMbP2vapm2h_1D6+zniumtPc9PZMnFJKX4yj55ku_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On 12 May 2018 at 10:28, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit e5cd695266c5709308aa95b1baae499e4b5d4544:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2018-05-08 17:05:58 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 31be8a2a97ecba7d31a82932286489cac318e9e9:
>
>   block/file-posix: add x-check-page-cache=on|off option (2018-05-11 16:43:05 +0100)
>
> ----------------------------------------------------------------
> Block pull request
>
>  * Support -drive cache.direct=off live migration for POSIX files
>
> ----------------------------------------------------------------

With this I get test failures for x86-64 Linux host (debug enabled):

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
gtester -k --verbose -m=quick tests/test-replication
TEST: tests/test-replication... (pid=15016)
  /replication/primary/read:                                           OK
  /replication/primary/write:                                          OK
  /replication/primary/start:                                          OK
  /replication/primary/stop:                                           OK
  /replication/primary/do_checkpoint:                                  OK
  /replication/primary/get_error_all:                                  OK
  /replication/secondary/read:                                         **
ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-replication.c:119:test_blk_write:
assertion failed: (async_ret == 0)
FAIL
GTester: last random seed: R02Sf99d81651223b2fcdd0d7d601245eba3
(pid=15131)
  /replication/secondary/write:                                        OK
  /replication/secondary/start:                                        **
ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-replication.c:119:test_blk_write:
assertion failed: (async_ret == 0)
FAIL
GTester: last random seed: R02S3e753c59c58d385aa2ea07c974c2e384
(pid=15309)
  /replication/secondary/stop:                                         **
ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-replication.c:119:test_blk_write:
assertion failed: (async_ret == 0)
FAIL
GTester: last random seed: R02Sb6a8459edfa78efa369da3920846afa7
(pid=15439)
  /replication/secondary/do_checkpoint:                                **
ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-replication.c:119:test_blk_write:
assertion failed: (async_ret == 0)
FAIL
GTester: last random seed: R02S4b2e6aa4e33bba4c5bdea0b9073ee966
(pid=15580)
  /replication/secondary/get_error_all:                                OK
FAIL: tests/test-replication
/home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:892:
recipe for target 'check-tests/test-replication' failed


thanks
-- PMM
