Received: from eggs.gnu.org ([2001:4830:134:3::10]:51289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcoWk-0005wK-Do
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcoWj-00053L-HI
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:01:42 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:43192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcoWj-00053B-C7
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:01:41 -0400
Received: by mail-oi0-x243.google.com with SMTP id b15-v6so41162377oib.10
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 02:01:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180709185828.4248-1-mreitz@redhat.com>
References: <20180709185828.4248-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jul 2018 10:01:19 +0100
Message-ID: <CAFEAcA8NqcoB+NMASH8YD0U0SuSAN8vtQ5ROqt4zNGmHS-KANA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Block patches for 3.0-rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>

On 9 July 2018 at 19:58, Max Reitz <mreitz@redhat.com> wrote:
> The following changes since commit ec7eb2ae77cc207064e17ace048f7ec0c4b85d6f:
>
>   translate-all: honour CF_NOCACHE in tb_gen_code (2018-07-09 16:14:36 +0100)
>
> are available in the Git repository at:
>
>   https://git.xanclic.moe/XanClic/qemu.git tags/pull-block-2018-07-09
>
> for you to fetch changes up to 0e4e4318eaa56c831001bdf617094807ec6d451c:
>
>   qcow2: add overlap check for bitmap directory (2018-07-09 19:43:24 +0200)
>
> ----------------------------------------------------------------
> Block patches for 3.0-rc0:
> - qcow2 metadata overlap protection for the persistent bitmap directory
> - Various bug fixes
>
> ----------------------------------------------------------------
> Fam Zheng (4):
>   qcow2: Drop unused cluster_data
>   file-posix: Fix fd_open check in raw_co_copy_range_to
>   qcow2: Drop unreachable break
>   raw: Drop superfluous semicolon
>
> Max Reitz (2):
>   vmdk: Fix possible segfault with non-VMDK backing
>   iotests: Add VMDK backing file correlation test
>
> Vladimir Sementsov-Ogievskiy (1):
>   qcow2: add overlap check for bitmap directory

Applied, thanks.

-- PMM
