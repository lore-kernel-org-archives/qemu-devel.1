Received: from eggs.gnu.org ([2001:4830:134:3::10]:37488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gXiet-0002zE-3B
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 03:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gXiep-00066u-Vg
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 03:17:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gXieo-00065j-0e
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 03:17:15 -0500
References: <20181206165907.23465-1-v.maffione@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1404a5f8-42bc-94b8-20ca-a8b565402463@redhat.com>
Date: Fri, 14 Dec 2018 16:17:08 +0800
MIME-Version: 1.0
In-Reply-To: <20181206165907.23465-1-v.maffione@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 0/3] Improvements to the netmap backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vincenzo Maffione <v.maffione@gmail.com>, qemu-devel@nongnu.org
Cc: g.lettieri@iet.unipi.it


On 2018/12/7 =E4=B8=8A=E5=8D=8812:59, Vincenzo Maffione wrote:
> Improvements to the netmap backend, mostly to fix the handling of
> incomplete multi-slot packets.
> This has been tested with and without jumbo frames, using pkt-gen
> to send 60, 1500, 5000 or 9000 bytes packets between two VMs connected
> through a VALE switch.
>
> Vincenzo Maffione (3):
>    net: netmap: small improvements netmap_send()
>    net: netmap: simplify netmap_receive()
>    net: netmap: improve netmap_receive_iov()
>
>   net/netmap.c | 110 ++++++++++++++++++++++----------------------------=
-
>   1 file changed, 47 insertions(+), 63 deletions(-)
>

Applied.

Thanks
