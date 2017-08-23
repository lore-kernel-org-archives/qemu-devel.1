Received: from eggs.gnu.org ([2001:4830:134:3::10]:46353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dkWy8-0006ei-7a
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dkWy7-0007l6-EX
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:49:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dkWy7-0007kj-8U
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:49:19 -0400
Message-ID: <1503499750.16071.29.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 23 Aug 2017 16:49:10 +0200
In-Reply-To: <CAJ+F1CLtURFmjV6JYDtN6AX4_1F9JLAc8WcR62safC4yJQbNfw@mail.gmail.com>
References: <20170823135113.25769-1-kraxel@redhat.com>
	<CAJ+F1CLtURFmjV6JYDtN6AX4_1F9JLAc8WcR62safC4yJQbNfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-input: send rel-wheel events for
 wheel buttons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

On Wed, 2017-08-23 at 14:38 +0000, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Aug 23, 2017 at 3:52 PM Gerd Hoffmann <kraxel@redhat.com>
> wrote:
> > qemu uses wheel-up/down button events for mouse wheel input,
> > however
> > linux applications typically want REL_WHEEL events.
> >=20
> > This fixes wheel with linux guests. Tested with X11/wayland, and
> > windows virtio-input driver.
> >=20
> > Based on a patch from Marc.
> > Added property to enable/disable wheel axis.
> > TODO: add compat properties for old machine types.
>=20
> I guess this patch isn't enough to handle migration? Why not modify
> hw/compat.h with this patch?

Because we are in freeze right now.  Just waiting until 2.11 opens and
the 2.11 machine type patch (seen on the list already) is merged, then
I'll do a v2 with the compat fluff.  Meanwhile this one should be good
enough for testing.

cheers,
  Gerd
