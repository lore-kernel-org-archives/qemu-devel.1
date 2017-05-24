Received: from eggs.gnu.org ([2001:4830:134:3::10]:41701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dDRsV-0002cJ-Ig
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dDRsQ-00017U-Sh
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:42:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dDRsQ-00016K-Mi
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:42:42 -0400
References: <20170524083446.32261-1-maxime.coquelin@redhat.com>
	<CAJ+F1C+t_RqLfHCuEm0c32VapbZ33FrV_-FQhxtuamj5i6up6w@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <52021862-138d-970a-135e-821e9a083445@redhat.com>
Date: Wed, 24 May 2017 10:42:30 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+t_RqLfHCuEm0c32VapbZ33FrV_-FQhxtuamj5i6up6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost-user: pass message as a pointer to
 process_message_reply()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, zhiyong.yang@intel.com, mst@redhat.com, qemu-devel@nongnu.org, jfreiman@redhat.com



On 05/24/2017 10:40 AM, Marc-Andr=C3=A9 Lureau wrote:
>=20
>=20
> On Wed, May 24, 2017 at 11:35 AM Maxime Coquelin=20
> <maxime.coquelin@redhat.com <mailto:maxime.coquelin@redhat.com>> wrote:
>=20
>     process_message_reply() was recently updated to get full message
>     content instead of only its request field.
>=20
>     There is no need to copy all the struct content into the stack,
>     so just pass its pointer.
>=20
>     Cc: Zhiyong Yang <zhiyong.yang@intel.com
>     <mailto:zhiyong.yang@intel.com>>
>     Fixes: 60cd11024f41 ("hw/virtio: fix vhost user fails to startup
>     when MQ")
>     Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com
>     <mailto:maxime.coquelin@redhat.com>>
>     ---
>       hw/virtio/vhost-user.c | 12 ++++++------
>       1 file changed, 6 insertions(+), 6 deletions(-)
>=20
>     diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>     index b87a176..baf2487 100644
>     --- a/hw/virtio/vhost-user.c
>     +++ b/hw/virtio/vhost-user.c
>     @@ -162,11 +162,11 @@ fail:
>       }
>=20
>       static int process_message_reply(struct vhost_dev *dev,
>     -                                 VhostUserMsg msg)
>     +                                 VhostUserMsg *msg)
>=20
>=20
> Can you make it const?
Sure!

Thanks,
Maxime
