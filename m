Received: from eggs.gnu.org ([2001:4830:134:3::10]:38610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnlhG-0007NJ-BS
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnlhD-0000KO-1O
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:13:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39514 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fnlhC-0000KE-Qj
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:13:46 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-16-e.emanuelegiuseppe@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <e93ee2eb-c912-1eb6-fca5-eec7b7bd5e78@redhat.com>
Date: Thu, 9 Aug 2018 16:13:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180806143412.27722-16-e.emanuelegiuseppe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 15/34] tests/qgraph: rename
 qvirtio_mmio_init_device functions
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

On 06/08/2018 16:33, Emanuele Giuseppe Esposito wrote:
> Rename qvirtio_mmio_init_device in qvirtio_mmio_device_new, since the function
> actually allocates a new QVirtioMMIODevice and initialize it.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> ---
>  tests/libqos/virtio-mmio.c | 2 +-
>  tests/libqos/virtio-mmio.h | 2 +-
>  tests/virtio-blk-test.c    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

I think you can merge this patch with the following one because the only
reason you do that is to be able to define a new qvirtio_mmio_init() of
your own.

Thanks,
Laurent
