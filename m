Received: from eggs.gnu.org ([2001:4830:134:3::10]:37772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1f17vp-0007iX-SY
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 06:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1f17vl-0002m2-SH
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 06:03:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47194 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1f17vl-0002lb-OK
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 06:03:45 -0400
References: <1516308132-10272-1-git-send-email-mst@redhat.com>
	<1516308132-10272-3-git-send-email-mst@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <d7c049af-8da0-a8a1-a4b1-5484c682fd10@redhat.com>
Date: Wed, 28 Mar 2018 12:03:36 +0200
MIME-Version: 1.0
In-Reply-To: <1516308132-10272-3-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v4 02/29] vhost-user: add new vhost user
 messages to support virtio config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Changpeng Liu <changpeng.liu@intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

Hi,

On 01/18/2018 09:44 PM, Michael S. Tsirkin wrote:
> From: Changpeng Liu <changpeng.liu@intel.com>
>=20
> Add VHOST_USER_GET_CONFIG/VHOST_USER_SET_CONFIG messages which can be
> used for live migration of vhost user devices, also vhost user devices
> can benefit from the messages to get/set virtio config space from/to th=
e
> I/O target. For the purpose to support virtio config space change,
> VHOST_USER_SLAVE_CONFIG_CHANGE_MSG message is added as the event notifi=
er
> in case virtio config space change in the slave I/O target.
>=20
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   docs/interop/vhost-user.txt       |  55 ++++++++++++++++++
>   include/hw/virtio/vhost-backend.h |  12 ++++
>   include/hw/virtio/vhost.h         |  15 +++++
>   hw/virtio/vhost-user.c            | 118 +++++++++++++++++++++++++++++=
+++++++++
>   hw/virtio/vhost.c                 |  32 +++++++++++
>   5 files changed, 232 insertions(+)
>=20

As discussed with Changpeng on DPDK ML, we need a vhost-user protocol
feature bit to back these new requests, else QEMU cannot whether the
user backend implement these.

With current and older DPDK version, if an unknown request is received,
the socket connection is closed.

Do we still have time before QEMU v2.12 is out?

Thanks,
Maxime
