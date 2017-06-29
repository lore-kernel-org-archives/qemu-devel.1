Received: from eggs.gnu.org ([2001:4830:134:3::10]:54360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQYJx-0006LN-Bu
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQYJw-0003Np-6b
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:13:17 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:36681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQYJw-0003Ma-0E
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:13:16 -0400
Received: by mail-wm0-x22a.google.com with SMTP id 62so80517915wmw.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 05:13:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1706271456310.24648@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1706271456310.24648@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jun 2017 13:12:54 +0100
Message-ID: <CAFEAcA_qxYbzmwhxqd_MHQAqJ0VPiUEJ1n0C4-nO8vfrTdOe9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] please pull xen-20170627-tag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, QEMU Developers <qemu-devel@nongnu.org>

On 27 June 2017 at 23:04, Stefano Stabellini <sstabellini@kernel.org> wrote:
> The following changes since commit 577caa2672ccde7352fda3ef17e44993de862f0e:
>
>   Merge remote-tracking branch 'remotes/edgar/tags/edgar/mmio-exec-v2.for-upstream' into staging (2017-06-27 16:56:55 +0100)
>
> are available in the git repository at:
>
>
>   git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20170627-tag
>
> for you to fetch changes up to 3284fad7283596033cb810b4788fd1bb43312dbd:
>
>   xen-disk: add support for multi-page shared rings (2017-06-27 15:01:56 -0700)
>
> ----------------------------------------------------------------
> Xen 2017/06/27
>
> ----------------------------------------------------------------
> Paul Durrant (2):
>       xen-disk: only advertize feature-persistent if grant copy is not available
>       xen-disk: add support for multi-page shared rings
>
> Stefano Stabellini (1):
>       xen/disk: don't leak stack data via response ring
>
>  hw/block/xen_disk.c | 184 +++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 133 insertions(+), 51 deletions(-)


Applied, thanks.

-- PMM
