Received: from eggs.gnu.org ([209.51.188.92]:39450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1goRk5-0001zD-FA
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1goRk4-0001iT-7s
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:49 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:46587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1goRk2-0001fE-6q
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:46 -0500
Received: by mail-oi1-f180.google.com with SMTP id x202so15815545oif.13
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 03:39:44 -0800 (PST)
MIME-Version: 1.0
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 29 Jan 2019 12:39:32 +0100
Message-ID: <CAGxU2F6_Raw8gAW-ug1EKGKhpCnhgdbv6VQKo7E_L4zMRSEs0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] VSOCK performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jiangyiwen@huawei.com
Cc: Michael Tsirkin <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org, qemu devel list <qemu-devel@nongnu.org>

Hi Yiwen,
I'm currently interested on how to improve the VSOCK performance and I
read your discussions with Jason, Michael, and Stefan on both
linux-netdev and qemu-devel mailing lists.

Are you still working on it?

Reading the discussions I understood that batching can help us a lot
to increase the VSOCK performance (especially for guest->host
direction).

As a first step, I added VSOCK support to iperf3 [1] in order to
measure the current performance of VSOCK (without any modification):

              Single socket
Guest->Host        ~950MB/s
Host->Guest       ~2700MB/s

They are slightly different from your results but I think that depends
on the hardware.
My current setup is the following:
HW: Lenovo T480s (i7-8650U, DDR4 2133 Mhz)
OS (guest/host): Fedora 29 (Linux 4.20.4-200.fc29.x86_64)
Guest app: iperf3 --vsock -s
Host app:  iperf3 --vsock -c $GUEST_CID -l 64K


Just to double check these values, can you share with me the tool that you used?


Thanks,
Stefano

#1 https://github.com/esnet/iperf/pull/840

-- 
Stefano Garzarella
Software Engineer @ Red Hat
