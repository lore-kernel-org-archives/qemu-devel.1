Received: from eggs.gnu.org ([2001:4830:134:3::10]:40404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIVbk-00074F-R0
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:47:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIVbk-0001ds-4C
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:46:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38492 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fIVbj-0001db-Vg
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:46:56 -0400
Date: Tue, 15 May 2018 10:46:54 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180515084654.4ldzo2gzqh5bycaz@sirius.home.kraxel.org>
References: <20180510230739.28459-1-peter@lekensteyn.nl>
	<20180510230739.28459-2-peter@lekensteyn.nl>
	<20180515083009.eo6bh6x2flzhmogv@sirius.home.kraxel.org>
	<20180515083912.GE24129@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180515083912.GE24129@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] gtk: disable the F10 menubar key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Wu <peter@lekensteyn.nl>, qemu-devel@nongnu.org

On Tue, May 15, 2018 at 09:39:12AM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, May 15, 2018 at 10:30:09AM +0200, Gerd Hoffmann wrote:
> > On Fri, May 11, 2018 at 01:07:39AM +0200, Peter Wu wrote:
> > > The F10 key is used in various applications, disable it uncondition=
ally
> > > (do not limit it to grab mode). Note that this property is deprecat=
ed
> > > and might be removed in the future (GTK+ commit b082fb598d).
> >=20
> > Any replacement provided by gtk?
>=20
> It doesn't look like it
>=20
> > I don't feel like adding new code depending on already deprecated
> > features ...
> >=20
> > Also note that there is the "grab-on-hover" option in the view menu,
> > which will make qemu grab the keyboard if the mouse pointer is inside
> > the qemu window.  Which is pretty convinient for hotkeys, they go to =
the
> > guest if you work in the qemu window and to the host otherwise.
>=20
> IMHO the right thing todo long term is to kill the menu bar from the
> GTK UI entirely, and replace with the GTK HeaderBar. This allows the
> menu items to be provided via popups directly from the title bar of
> the windows, which is more vertically space efficient. This would
> probably have to wait for us to ditch GTK2, so I think this fix is
> reasonable until that time.

Fair enough.  Patch queued.

cheers,
  Gerd
