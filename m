Received: from eggs.gnu.org ([2001:4830:134:3::10]:50999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ceYr4-0007ZG-W1
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 22:05:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ceYr1-00057g-Sp
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 22:05:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ceYr1-00056m-MN
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 22:05:03 -0500
References: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <11a4ab90-650e-7f88-504c-d5ae3e6c5c94@redhat.com>
Date: Fri, 17 Feb 2017 11:04:57 +0800
MIME-Version: 1.0
In-Reply-To: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] A few VLAN-related bugfixes for RX
 packet abstraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dmitry Fleytman <dmitry@daynix.com>, qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>, P J P <ppandit@redhat.com>



On 2017=E5=B9=B402=E6=9C=8816=E6=97=A5 20:29, Dmitry Fleytman wrote:
> This series fix a few issues related
> to processing of RX packets with VLAN headers.
>
> See commit messages of specific patches
> for information regarding affected devices.
>
> Dmitry Fleytman (5):
>    eth: Extend vlan stripping functions
>    NetRxPkt: Fix memory corruption on VLAN header stripping
>    NetRxPkt: Do not try to pull more data than present
>    NetRxPkt: Account buffer with ETH header in IOV length
>    NetRxPkt: Remove code duplication in net_rx_pkt_pull_data()
>
>   hw/net/net_rx_pkt.c | 40 +++++++++++++++++++++-------------------
>   include/net/eth.h   |  4 ++--
>   net/eth.c           | 25 ++++++++++++++-----------
>   3 files changed, 37 insertions(+), 32 deletions(-)
>

Applied. Thanks
