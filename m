Received: from eggs.gnu.org ([2001:4830:134:3::10]:41547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUWcQ-0006WX-FH
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:12:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUWcN-00062P-9Z
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:12:46 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:36617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUWcN-00061o-0R
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:12:43 -0400
Received: by mail-wr0-f182.google.com with SMTP id c11so133986078wrc.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 04:12:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1707071117420.2919@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1707071117420.2919@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jul 2017 12:11:21 +0100
Message-ID: <CAFEAcA8c5JXR3VjjzAOFnRu32+TctZL2AHCqHBacpOZfKkqj8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] please pull xen-20170707-tag
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

On 7 July 2017 at 19:29, Stefano Stabellini <sstabellini@kernel.org> wrote:
> The following changes since commit b11365867568ba954de667a0bfe0945b8f78d6bd:
>
>   Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20170706' into staging (2017-07-06 11:42:59 +0100)
>
> are available in the git repository at:
>
>
>   git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20170707-tag
>
> for you to fetch changes up to 4daf62594d13dfca2ce3a74dd3bddee5f54d7127:
>
>   xen/pt: Fixup addr validation in xen_pt_pci_config_access_check (2017-07-07 11:13:10 -0700)
>
> ----------------------------------------------------------------
> Xen 2017/07/07
>
> ----------------------------------------------------------------
> Anoob Soman (1):
>       xen/pt: Fixup addr validation in xen_pt_pci_config_access_check
>
> Ross Lagerwall (1):
>       xen-platform: Cleanup network infrastructure when emulated NICs are unplugged
>
> Stefano Stabellini (1):
>       xenfb: remove xen_init_display "temporary" hack
>
>  hw/display/xenfb.c           | 81 ++++++++++----------------------------------
>  hw/i386/xen/xen_platform.c   | 11 ++++++
>  hw/xen/xen_pt.c              |  2 +-
>  hw/xenpv/xen_machine_pv.c    |  3 --
>  include/hw/xen/xen_backend.h |  2 --
>  5 files changed, 30 insertions(+), 69 deletions(-)

Applied, thanks.

-- PMM
