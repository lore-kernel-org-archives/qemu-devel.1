Received: from eggs.gnu.org ([2001:4830:134:3::10]:52698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eIAVc-0001zi-L5
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eIAVY-00024m-Ew
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:42:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eIAVY-00023O-97
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:42:52 -0500
References: <20171124075542.16979-1-ppandit@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <48adc6ba-270e-ab22-111b-1897d551dc65@redhat.com>
Date: Fri, 24 Nov 2017 10:42:44 +0100
MIME-Version: 1.0
In-Reply-To: <20171124075542.16979-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/2] check VirtiQueue Vring objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, zhangboxian <zhangboxian@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 24/11/2017 08:55, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> Hello,
> 
> An user could attempt to use an uninitialised VirtQueue object
> or set Vring object with undue values, raising an unexpected
> exception in Qemu. This patch set fixes this issue and also adds
> a unit test to the suite.
> 
> Thank you.
> --
> Prasad J Pandit (2):
>   virtio: check VirtQueue Vring object is set
>   tests: add test to check VirtQueue object
> 
>  hw/virtio/virtio.c      | 11 ++++++++---
>  tests/virtio-blk-test.c | 21 +++++++++++++++++++++
>  2 files changed, 29 insertions(+), 3 deletions(-)
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
