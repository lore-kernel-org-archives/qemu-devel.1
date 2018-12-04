Received: from eggs.gnu.org ([2001:4830:134:3::10]:53152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gU94V-0007tK-89
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 06:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gU94S-0006R4-SP
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 06:40:58 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gU94N-0006H2-JB
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 06:40:53 -0500
Received: by mail-oi1-x244.google.com with SMTP id v6so13959402oif.2
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 03:40:43 -0800 (PST)
MIME-Version: 1.0
References: <20181204035347.6148-1-jasowang@redhat.com>
In-Reply-To: <20181204035347.6148-1-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Dec 2018 11:40:30 +0000
Message-ID: <CAFEAcA_2atTo=PUb3H2j6o_Y-e-hH6bz16XZpVRHbAkkSCio5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V5 for 3.1 0/5] Fix possible OOB during
 queuing packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, P J P <ppandit@redhat.com>, Li Qiang <liq3ea@163.com>, Li Qiang <liq3ea@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue, 4 Dec 2018 at 03:54, Jason Wang <jasowang@redhat.com> wrote:
>
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
>
> Changes from V1:
> - slient compiling warnings
> Changes from V2:
> - annotate pci_test_start() with GCC_FMT_ATTR()
> - drop intermediate cmd string variable
> Changes from V4:
> - silent hub warning if qtest is enabled
> - make qemu_deliver_packet_iov() static
> - add one more test for packet size slightly greater than NET_BUFSIZE
> - tweak the commit log and add more justification
> - typo/whitespace fixes and other minor code style tweaks
>
> Jason Wang (5):
>   net: drop too large packet early
>   net: hub: suppress warnings of no host network for qtest
>   virtio-net-test: accept variable length argument in pci_test_start()
>   virtio-net-test: remove unused macro
>   virtio-net-test: add large tx buffer test

Applied, thanks.

-- PMM
