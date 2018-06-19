Received: from eggs.gnu.org ([2001:4830:134:3::10]:58023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVEgc-0006EL-Hw
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVEgX-0007uF-H1
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:20:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56118 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fVEgX-0007u2-BW
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:20:29 -0400
Date: Tue, 19 Jun 2018 13:20:27 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180619112027.a4m67f2hj3s54zvq@sirius.home.kraxel.org>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
	<20180618161729.334-11-marcandre.lureau@redhat.com>
	<20180619062323.t6hbpvmcsrcgwmmm@sirius.home.kraxel.org>
	<CAJ+F1CLTege16ZM_-Ar6V92uGHsouBxNeOGFx6JPR7Qwvcbp_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLTege16ZM_-Ar6V92uGHsouBxNeOGFx6JPR7Qwvcbp_g@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 10/26] vhost-user: split
 vhost_user_read()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Tue, Jun 19, 2018 at 11:01:00AM +0200, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Tue, Jun 19, 2018 at 8:23 AM, Gerd Hoffmann <kraxel@redhat.com> wrot=
e:
> >> @@ -237,7 +251,7 @@ static int vhost_user_read(struct vhost_dev *dev=
, VhostUserMsg *msg)
> >>          error_report("Failed to read msg header."
> >>                  " Size %d exceeds the maximum %zu.", msg->hdr.size,
> >>                  VHOST_USER_PAYLOAD_SIZE);
> >> -        goto fail;
> >> +        return -1;
> >
> > Hmm?  Looks like a pointless indirection ...
>=20
> Isn't it removed by the patch? :)

Ah, right.  Sorry about the noise.

cheers,
  Gerd
