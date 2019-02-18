Received: from eggs.gnu.org ([209.51.188.92]:60892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gvaP5-000584-6d
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 23:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gvaP3-0004dQ-K9
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 23:19:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gvaOy-0004Zn-W7
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 23:19:34 -0500
References: <20190215174659.4007-1-v.maffione@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5159fece-5573-7d9e-b6fe-c5832138d63e@redhat.com>
Date: Mon, 18 Feb 2019 12:19:21 +0800
MIME-Version: 1.0
In-Reply-To: <20190215174659.4007-1-v.maffione@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 0/1] Allow TAP to unnegotiate virtio-net
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vincenzo Maffione <v.maffione@gmail.com>, qemu-devel@nongnu.org


On 2019/2/16 =E4=B8=8A=E5=8D=881:46, Vincenzo Maffione wrote:
> Hi,
>    I was doing experiments with a custom paravirtualized net device,
> and I ran into a limitation of the TAP backend. I see from the kernel
> code that it is not possible to set the TAP virtio-net header
> length to something different from 10 or 12, which means that it
> is not possible to set it to 0. That's fine.
> The QEMU implementation of the TAP backend already supports
> the case where virtio-net header is set to 10 or 12 in kernel,
> but the emulated/paravirtualized net device is not using that:
> the TAP backend will just strip/prepend a zeroed header in this case
> (e.g., see the if statement in tap_receive_iov()).
> However, the tap_using_vnet_hdr() has an assert() that prevents
> this situation to happen, and I don't understand why. Maybe it
> is a leftover? I tried to remove the assert and by doing that
> my paravirtualized device was able to stop using the virtio-net
> header.


Hi:

If=C2=A0 I understand this correctly, your PV device is API compatible wi=
th=20
TAP? Then you may just adding code to call TUNSETIFF without IFF_VNET_HDR=
?

Thanks


>
> Vincenzo Maffione (1):
>    net: tap: allow net frontends to un-negotiate virtio-net header
>
>   net/tap.c | 1 -
>   1 file changed, 1 deletion(-)
>
