Received: from eggs.gnu.org ([2001:4830:134:3::10]:35811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gZzKj-000779-T8
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:29:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gZzIr-0002LX-BH
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:28:02 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gZzIr-0002Ko-6F
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:27:57 -0500
Received: by mail-ot1-f65.google.com with SMTP id a11so2047115otr.10
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 06:27:56 -0800 (PST)
MIME-Version: 1.0
References: <20181213210057.3676-1-quintela@redhat.com>
	<20181213210057.3676-6-quintela@redhat.com>
In-Reply-To: <20181213210057.3676-6-quintela@redhat.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 20 Dec 2018 15:27:44 +0100
Message-ID: <CAGxU2F7KA=sW21_vqp0WY0cJMVSGX7FsrQ8v_k2iP=pmV3gPsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 05/16] virtio: split virtio balloon bits
 from virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, Dec 13, 2018 at 10:07 PM Juan Quintela <quintela@redhat.com> wrote:
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/virtio/Makefile.objs        |  1 +
>  hw/virtio/virtio-balloon-pci.c | 94 ++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c         | 58 ---------------------
>  hw/virtio/virtio-pci.h         | 14 -----
>  tests/Makefile.include         |  2 +-
>  5 files changed, 96 insertions(+), 73 deletions(-)
>  create mode 100644 hw/virtio/virtio-balloon-pci.c

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
