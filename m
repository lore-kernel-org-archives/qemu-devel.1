Received: from eggs.gnu.org ([2001:4830:134:3::10]:46173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyI6J-0002ni-Ae
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyI6I-0004UM-AH
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:18:55 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:40557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyI6I-0004UC-4V
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:18:54 -0400
Received: by mail-oi0-x242.google.com with SMTP id c12-v6so1444277oic.7
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 07:18:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 14:18:33 +0000
Message-ID: <CAFEAcA_EbFC2qJvMGKj1gzTBnSgytLaJJfhDcn0FjEsjnvz1Sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/50] virtio, vhost, pci, pc: features,
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 March 2018 at 03:16, Michael S. Tsirkin <mst@redhat.com> wrote:
> Changes from v1:
> - dropped include change for one generated file - proposed a tree-wide refactoring
> - dropped vhost used slot refactoring due to alignment issues found by clang
> - added vhost-user post-copy support
>
> The following changes since commit 026aaf47c02b79036feb830206cfebb2a726510d:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2018-03-13 16:26:44 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to a466e2cdb09d7b1262e24bae8cc47a51550d3af3:
>
>   postcopy shared docs (2018-03-20 05:03:30 +0200)
>
> ----------------------------------------------------------------
> virtio,vhost,pci,pc: features, cleanups
>
> SRAT tables for DIMM devices
> new virtio net flags for speed/duplex
> post-copy migration support in vhost
> cleanups in pci
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Link failure on aarch64 host:
  LINK    arm-softmmu/qemu-system-arm
hw/virtio/vhost-user.o: In function `vhost_user_postcopy_fault_handler':
/home/pm215/qemu/hw/virtio/vhost-user.c:1000: undefined reference to
`postcopy_request_shared_page'

I think this host is taking the "don't have userfaultfd" #ifdef
path in postcopy-ram.c, which doesn't define a stub
for the postcopy_request_shared_page function, but there's
no equivalent guard in vhost-user.c

thanks
-- PMM
