Received: from eggs.gnu.org ([2001:4830:134:3::10]:48195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnmE5-0004jN-Al
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnmE1-0000Im-7a
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:47:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52508 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fnmE1-0000If-0I
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:47:41 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-17-e.emanuelegiuseppe@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <cad93265-c6ee-3aed-30d2-c2bfe7f480a8@redhat.com>
Date: Thu, 9 Aug 2018 16:47:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180806143412.27722-17-e.emanuelegiuseppe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 16/34] test/qgraph: virtio-mmio driver
 and interface nodes
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
> Add virtio-mmio node in qgraph framework.
> virtio-mmio produces virtio, the interface consumed by all virtio-*-device
> nodes.
> 
> Being a memory-mapped device, it doesn't have to provide a constructor
> to qgraph, since it's always "contained" inside some other nodes.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> ---
>  tests/libqos/virtio-mmio.c | 70 ++++++++++++++++++++++++++++----------
>  tests/libqos/virtio-mmio.h |  4 +++
>  2 files changed, 56 insertions(+), 18 deletions(-)

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
