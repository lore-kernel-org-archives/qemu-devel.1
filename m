Received: from eggs.gnu.org ([2001:4830:134:3::10]:37625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fRA9s-0007PA-2O
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 01:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fRA9r-0005U4-6o
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 01:41:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56710 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fRA9r-0005T7-2G
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 01:41:55 -0400
Date: Fri, 8 Jun 2018 07:41:53 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180608054153.n75nr2kjgj6chnaw@sirius.home.kraxel.org>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
	<20180601162749.27406-10-marcandre.lureau@redhat.com>
	<20180604085830.awobv45jz4nyrcx2@sirius.home.kraxel.org>
	<CAJ+F1CLqwx4VU-Aa71L0VUj=dPvRJu7MEk+jnt6TYys1hwRdrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLqwx4VU-Aa71L0VUj=dPvRJu7MEk+jnt6TYys1hwRdrg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 09/12] Add vhost-input-pci
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

On Fri, Jun 08, 2018 at 12:22:38AM +0200, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Mon, Jun 4, 2018 at 10:58 AM, Gerd Hoffmann <kraxel@redhat.com> wrot=
e:
> >> +#define TYPE_VHOST_USER_INPUT_PCI "vhost-user-input-pci"
> >
> > Patch $subject mismatch.
> >
> >> +struct VHostUserInput {
> >> +    VirtIOInput                       parent_obj;
> >> +
> >> +    VhostUserBackend                  *vhost;
> >> +};
> >
> > Nothing input specific here ...
>=20
> Except VirtIOInput

Oops, missed that.  Scratch the idea then.

cheers,
  Gerd
