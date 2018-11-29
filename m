Received: from eggs.gnu.org ([2001:4830:134:3::10]:39103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSMki-0005Gz-JS
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:53:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSMkh-0000dj-Rh
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:53:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gSMkh-0000dC-IX
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:53:11 -0500
References: <20181129121449.4322-1-jasowang@redhat.com>
	<20181129121449.4322-5-jasowang@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <026ee7b1-80d7-c762-599d-aa3275212458@redhat.com>
Date: Thu, 29 Nov 2018 14:53:06 +0100
MIME-Version: 1.0
In-Reply-To: <20181129121449.4322-5-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 for 3.1 4/4] virtio-net-test: add large
 tx buffer test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: mst@redhat.com, liq3ea@163.com, liq3ea@gmail.com, ppandit@redhat.com, pbonzini@redhat.com

On 2018-11-29 13:14, Jason Wang wrote:
> This test tries to build a packet whose size is greater than INT_MAX
> which tries to trigger integer overflow in qemu_net_queue_append_iov()
> which may result OOB.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  tests/virtio-net-test.c | 45 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>
