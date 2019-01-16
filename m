Received: from eggs.gnu.org ([209.51.188.92]:50998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gjonv-00034z-Vs
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:16:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gjonu-0007zE-FP
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:16:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gjonl-0007vs-EB
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:16:31 -0500
References: <1547576349-13337-1-git-send-email-pbonzini@redhat.com>
	<1547576349-13337-2-git-send-email-pbonzini@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <94e0b9b3-3767-b89a-8674-4dfcc5651fe2@redhat.com>
Date: Wed, 16 Jan 2019 18:16:19 +0100
MIME-Version: 1.0
In-Reply-To: <1547576349-13337-2-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] tests/libqos: introduce
 virtio_start_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

On 15/01/2019 19:19, Paolo Bonzini wrote:
> From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> 
> This function is intended to group all the qvirtio_* functions that
> start the qvirtio devices.
> Applied in all tests using this combination of functions.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/libqos/virtio.c    |  7 +++++++
>   tests/libqos/virtio.h    |  1 +
>   tests/vhost-user-test.c  |  4 +---
>   tests/virtio-9p-test.c   |  4 +---
>   tests/virtio-blk-test.c  | 10 +++-------
>   tests/virtio-net-test.c  |  4 +---
>   tests/virtio-scsi-test.c |  4 +---
>   7 files changed, 15 insertions(+), 19 deletions(-)
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
