Received: from eggs.gnu.org ([2001:4830:134:3::10]:60219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gTkpj-0002zS-8C
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:48:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gTkpg-0008Ea-4Y
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:48:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gTkpf-00088H-VO
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:48:04 -0500
References: <20181203093544.6184-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <12ade2c0-53d2-a151-f7d8-c38035c85597@redhat.com>
Date: Mon, 3 Dec 2018 17:47:47 +0800
MIME-Version: 1.0
In-Reply-To: <20181203093544.6184-1-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V3 for 3.1 0/4] Fix possible OOB during
 queuing packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: mst@redhat.com, ppandit@redhat.com, liq3ea@163.com, liq3ea@gmail.com, pbonzini@redhat.com, thuth@redhat.com, eblake@redhat.com


On 2018/12/3 =E4=B8=8B=E5=8D=885:35, Jason Wang wrote:
> Hi:
>
> This series tries to fix a possible OOB during queueing packets
> through qemu_net_queue_append_iov(). This could happen when it tries
> to queue a packet whose size is larger than INT_MAX which may lead
> integer overflow. We've fixed similar issue in the past during
> qemu_net_queue_deliver_iov() by ignoring large packets there. Let's
> just move the check earlier to qemu_sendv_packet_async() and reduce
> the limitation to NET_BUFSIZE. A simple qtest were also added this.
>
> Please review.
>
> Thanks


Wrong version, please ignore this.

Thanks
