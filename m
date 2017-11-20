Received: from eggs.gnu.org ([2001:4830:134:3::10]:44844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGnS8-0000Sg-AQ
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGnS7-0006ST-He
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:53:40 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:46198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eGnS7-0006S7-BO
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:53:39 -0500
Received: by mail-wr0-x230.google.com with SMTP id r2so1866632wra.13
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 06:53:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171117181653.20651-1-kwolf@redhat.com>
References: <20171117181653.20651-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2017 14:53:17 +0000
Message-ID: <CAFEAcA8Y9OpRpSkQwAHPaN8gAPen7M3kJmLi4FDLB7DWBKV1WA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/25] Block layer patches for 2.11.0-rc2
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

On 17 November 2017 at 18:16, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit fec035a53fa15c4c8c4e62bfef56a35df4161e38:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20171117-pull-request' into staging (2017-11-17 10:18:41 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to d5a49c6e7d9e42059450674ec845b7bc0d62cb7e:
>
>   Merge remote-tracking branch 'mreitz/tags/pull-block-2017-11-17' into queue-block (2017-11-17 18:24:30 +0100)
>
> ----------------------------------------------------------------
> Block layer patches for 2.11.0-rc2
>
> ----------------------------------------------------------------

Hi. I'm afraid this fails 'make check' (Linux x86-64, gcc, debug build):

  GTESTER tests/test-replication
**
ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-replication.c:117:test_blk_write:
assertion failed: (async_ret == 0)
GTester: last random seed: R02S7bcadec8b2ecdf71fa8abd7f833c90f5
/home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:863:
recipe for target 'check-tests/test-replication' failed

thanks
-- PMM
