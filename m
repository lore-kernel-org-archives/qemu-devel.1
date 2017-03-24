Received: from eggs.gnu.org ([2001:4830:134:3::10]:34212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crQY1-0001lO-38
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crQXw-0000p6-KD
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:50:37 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:33241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1crQXw-0000os-D3
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:50:32 -0400
Received: by mail-wm0-x233.google.com with SMTP id v203so7971113wmg.0
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 07:50:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170324140854.28134-1-stefanha@redhat.com>
References: <20170324140854.28134-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Mar 2017 14:50:10 +0000
Message-ID: <CAFEAcA9D1r+X9UALs8ctCj7QUWKifnOzY4CAdXW7YWLk2gO9FA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9 0/3] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 March 2017 at 14:08, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 08329701199449bde497570dcfdb9c86062baf20:
>
>   qom: Fix regression with 'qom-type' (2017-03-23 17:59:40 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to 0d3ef78829332f2fdc323d1b625b60fe9c89119c:
>
>   trace: Avoid abuse of amdvi_mmio_read (2017-03-24 09:21:42 +0000)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Eric Blake (3):
>   trace: Fix backwards mirror_yield parameters
>   trace: Fix incorrect megasas trace parameters
>   trace: Avoid abuse of amdvi_mmio_read
>
>  block/mirror.c       | 5 +++--
>  hw/i386/amd_iommu.c  | 3 +--
>  hw/scsi/megasas.c    | 6 +++---
>  hw/i386/trace-events | 1 +
>  4 files changed, 8 insertions(+), 7 deletions(-)
>

Applied, thanks.

-- PMM
