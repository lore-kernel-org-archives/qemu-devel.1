Received: from eggs.gnu.org ([2001:4830:134:3::10]:36836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duyCu-0006W4-Li
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:55:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duyCt-00057N-Iq
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:55:44 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:44554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1duyCs-000548-Qq
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:55:43 -0400
Received: by mail-wm0-x22d.google.com with SMTP id m127so116012wmm.1
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 02:55:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1709201906040.2968@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1709201906040.2968@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 10:55:20 +0100
Message-ID: <CAFEAcA_+QCQ-uWO24O6BdOuiN6roO7LLH5NDK1mW9Ktq=bNOFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] xen-20170920-tag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, QEMU Developers <qemu-devel@nongnu.org>

On 21 September 2017 at 03:21, Stefano Stabellini
<sstabellini@kernel.org> wrote:
> The following changes since commit b62b7ed0fc9c58e373b8946c9bd2e193be98dae6:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2017-09-20 20:33:48 +0100)
>
> are available in the git repository at:
>
>
>   git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20170920-tag
>
> for you to fetch changes up to a8036336609d2e184fc3543a4c439c0ba7d7f3a2:
>
>   xen/pt: allow QEMU to request MSI unmasking at bind time (2017-09-20 19:05:27 -0700)
>
> ----------------------------------------------------------------
> Xen 2017/09/20
>
> ----------------------------------------------------------------
> Olaf Hering (1):
>       xen-disk: use g_new0 to fix build
>
> Roger Pau Monne (1):
>       xen/pt: allow QEMU to request MSI unmasking at bind time
>
>  hw/block/xen_disk.c         |  2 +-
>  hw/xen/xen_pt.h             |  1 +
>  hw/xen/xen_pt_config_init.c | 20 ++++++++++++++++++--
>  hw/xen/xen_pt_msi.c         | 13 ++++++++++---
>  4 files changed, 30 insertions(+), 6 deletions(-)

Applied, thanks.

-- PMM
