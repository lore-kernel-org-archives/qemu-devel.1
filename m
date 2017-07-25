Received: from eggs.gnu.org ([2001:4830:134:3::10]:35604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1da2Rs-0001tp-Rn
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1da2Rr-0002ik-TW
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:12:40 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:36319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1da2Rr-0002iD-My
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:12:39 -0400
Received: by mail-wm0-x230.google.com with SMTP id t201so50320060wmt.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 09:12:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170725151233.26077-1-mreitz@redhat.com>
References: <20170725151233.26077-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jul 2017 17:12:18 +0100
Message-ID: <CAFEAcA_KqmMQ+crz6KVCqD9Pj+NHPhZ18UOyT+QqGAzeb_5Nmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Block patches for 2.10-rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 25 July 2017 at 16:12, Max Reitz <mreitz@redhat.com> wrote:
> The following changes since commit 4c4414a4388f902b7ae2814f9a64898dd0e426a5:
>
>   hw/display/sm501: Don't use vmstate_register_ram_global() (2017-07-25 13:04:28 +0100)
>
> are available in the git repository at:
>
>   git://github.com/XanClic/qemu.git tags/pull-block-2017-07-25
>
> for you to fetch changes up to bd998d7cc8ced211def90e4225042d63dddecc54:
>
>   qemu-iotests: Fix reference output for 186 (2017-07-25 16:33:58 +0200)
>
> ----------------------------------------------------------------
> Block patches for 2.10-rc0
>
> ----------------------------------------------------------------
> Daniel P. Berrange (1):
>   qcow: fix memory leaks related to encryption
>
> Kevin Wolf (1):
>   qemu-iotests: Fix reference output for 186
>
> Vladimir Sementsov-Ogievskiy (1):
>   qcow2-bitmap: fix bitmap_free
>
>  block/qcow.c               | 5 +++--
>  block/qcow2-bitmap.c       | 4 ++++
>  block/qcow2.c              | 7 ++++---
>  tests/qemu-iotests/186.out | 6 +++---
>  4 files changed, 14 insertions(+), 8 deletions(-)

Applied, thanks.

-- PMM
