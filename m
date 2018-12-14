Received: from eggs.gnu.org ([2001:4830:134:3::10]:57352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXjKE-0002Gd-Kr
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:00:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXjKB-0004Tf-Fw
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:00:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gXjKB-0004Sw-7D
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 03:59:59 -0500
References: <20181213210057.3676-1-quintela@redhat.com>
	<20181213210057.3676-7-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <690074fb-6f0d-0999-e743-53bba6f6976f@redhat.com>
Date: Fri, 14 Dec 2018 09:59:51 +0100
MIME-Version: 1.0
In-Reply-To: <20181213210057.3676-7-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 06/16] virtio: split virtio 9p bits from
 virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Gonglei <arei.gonglei@huawei.com>

On 2018-12-13 22:00, Juan Quintela wrote:
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> ---
> 
> Also disable virtio9p test (lvivier)
[...]
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index dd7c882cc5..90d33bb058 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -151,7 +151,7 @@ check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
>  check-qtest-virtio-$(CONFIG_VIRTIO_RNG) += tests/virtio-rng-test$(EXESUF)
>  check-qtest-virtio-y += tests/virtio-scsi-test$(EXESUF)
>  ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)

I guess you could remove the CONFIG_VIRTIO in above line now, since
CONFIG_VIRTIO_9P should always be disabled when CONFIG_VIRTIO is
disabled, too. ... anyway, does not hurt to keep it here either.

> -check-qtest-virtio-y += tests/virtio-9p-test$(EXESUF)
> +check-qtest-virtio-$(CONFIG_VIRTIO_9P) += tests/virtio-9p-test$(EXESUF)
>  endif
>  check-qtest-virtio-y += tests/virtio-serial-test$(EXESUF)
>  check-qtest-virtio-y += $(check-qtest-virtioserial-y)

Reviewed-by: Thomas Huth <thuth@redhat.com>
