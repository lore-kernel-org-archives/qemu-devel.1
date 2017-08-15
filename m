Received: from eggs.gnu.org ([2001:4830:134:3::10]:37606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhajc-0007Uf-Kb
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 08:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhajb-0006bt-Lo
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 08:14:12 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dhajb-0006bf-FY
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 08:14:11 -0400
Received: by mail-wm0-x229.google.com with SMTP id f15so8402632wmg.1
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 05:14:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170815105721.31893-1-famz@redhat.com>
References: <20170815105721.31893-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Aug 2017 13:13:49 +0100
Message-ID: <CAFEAcA8FyAfaZ_nJ7UCBU3X2ytrkWYySADKcCHuK2Jt61vX=MQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/5] Build and test patches
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

On 15 August 2017 at 11:57, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit 83c3a1f61673ef554facf4d6d29ed56c5a219f=
9d:
>
>   xlnx-qspi: add a property for mmio-execution (2017-08-14 14:17:18 +0100=
)
>
> are available in the git repository at:
>
>   git://github.com/famz/qemu.git tags/build-and-test-pull-request
>
> for you to fetch changes up to a8132a2f288c260fb43243eb3c092b5186d84968:
>
>   docker: add centos7 image (2017-08-15 15:16:45 +0800)
>
> ----------------------------------------------------------------
>
> One fix and a few docker test enhancements. Not 2.10 blocker, but it's
> good to have them.
>
> ----------------------------------------------------------------
>
> Fam Zheng (1):
>   Makefile: Let "make check-help" work without running ./configure
>
> Philippe Mathieu-Daud=C3=A9 (4):
>   docker: use one package per line in CentOS config
>   docker: add Xen libs to centos6 image
>   docker: install more packages on CentOS to extend code coverage
>   docker: add centos7 image
>
>  Makefile                                |  2 --
>  tests/Makefile.include                  | 46 ++++++++++++++++++---------=
------
>  tests/docker/dockerfiles/centos6.docker | 31 ++++++++++++++++++----
>  tests/docker/dockerfiles/centos7.docker | 31 ++++++++++++++++++++++
>  4 files changed, 82 insertions(+), 28 deletions(-)
>  create mode 100644 tests/docker/dockerfiles/centos7.docker
Applied, thanks.

-- PMM
