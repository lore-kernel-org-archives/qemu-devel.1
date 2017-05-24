Received: from eggs.gnu.org ([2001:4830:134:3::10]:43301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreiman@redhat.com>) id 1dDS0e-0004xE-V3
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreiman@redhat.com>) id 1dDS0Z-0003tR-Ab
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:51:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreiman@redhat.com>) id 1dDS0Z-0003t1-40
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:51:07 -0400
Date: Wed, 24 May 2017 10:50:59 +0200
From: Jens Freimann <jfreiman@redhat.com>
Message-ID: <20170524085059.uzkkpvbndsin5kce@dhcp-192-218.str.redhat.com>
References: <20170524083446.32261-1-maxime.coquelin@redhat.com>
	<CAJ+F1C+t_RqLfHCuEm0c32VapbZ33FrV_-FQhxtuamj5i6up6w@mail.gmail.com>
	<52021862-138d-970a-135e-821e9a083445@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <52021862-138d-970a-135e-821e9a083445@redhat.com>
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
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, zhiyong.yang@intel.com, mst@redhat.com, qemu-devel@nongnu.org

On Wed, May 24, 2017 at 10:42:30AM +0200, Maxime Coquelin wrote:
>=20
>=20
> On 05/24/2017 10:40 AM, Marc-Andr=E9 Lureau wrote:
> >=20
> >=20
> > On Wed, May 24, 2017 at 11:35 AM Maxime Coquelin
> > <maxime.coquelin@redhat.com <mailto:maxime.coquelin@redhat.com>> wrot=
e:
> >=20
> >     process_message_reply() was recently updated to get full message
> >     content instead of only its request field.
> >=20
> >     There is no need to copy all the struct content into the stack,
> >     so just pass its pointer.
> >=20
> >     Cc: Zhiyong Yang <zhiyong.yang@intel.com
> >     <mailto:zhiyong.yang@intel.com>>
> >     Fixes: 60cd11024f41 ("hw/virtio: fix vhost user fails to startup
> >     when MQ")
> >     Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com
> >     <mailto:maxime.coquelin@redhat.com>>
> >     ---
> >       hw/virtio/vhost-user.c | 12 ++++++------
> >       1 file changed, 6 insertions(+), 6 deletions(-)
> >=20
> >     diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >     index b87a176..baf2487 100644
> >     --- a/hw/virtio/vhost-user.c
> >     +++ b/hw/virtio/vhost-user.c
> >     @@ -162,11 +162,11 @@ fail:
> >       }
> >=20
> >       static int process_message_reply(struct vhost_dev *dev,
> >     -                                 VhostUserMsg msg)
> >     +                                 VhostUserMsg *msg)
> >=20
> >=20
> > Can you make it const?
> Sure!

with that:

Reviewed-by: Jens Freimann <jfreimann@redhat.com>
