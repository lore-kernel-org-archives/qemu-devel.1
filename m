Received: from eggs.gnu.org ([2001:4830:134:3::10]:39979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnlk8-0000rQ-Ce
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnlk5-0001w3-28
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:16:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60724 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fnlk4-0001vV-RM
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:16:44 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-30-e.emanuelegiuseppe@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <f1bdb55c-9787-f9cb-6da8-c74d192d3c3e@redhat.com>
Date: Thu, 9 Aug 2018 16:16:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180806143412.27722-30-e.emanuelegiuseppe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 29/34] test/qgraph: virtio-blk test node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

On 06/08/2018 16:34, Emanuele Giuseppe Esposito wrote:
> -static void mmio_basic(void)
> +static void basic_resize(void *obj, void *data, QGuestAllocator *t_alloc)
>  {
> -    QVirtioMMIODevice *dev;
> -    QVirtQueue *vq;
> -    QGuestAllocator *alloc;
> +    QVirtioBlk *blk_if = obj;
> +    QVirtioDevice *dev = blk_if->vdev;
>      int n_size = TEST_IMAGE_SIZE / 2;
>      uint64_t capacity;
> +    QVirtQueue *vq;
>  
> -    arm_test_start();
> -
> -    dev = qvirtio_mmio_device_new(MMIO_DEV_BASE_ADDR, MMIO_PAGE_SIZE);

This is the only user of qvirtio_mmio_device_new(), so if you remove the
call here, you could also remove the function definition.

Thanks,
Laurent
