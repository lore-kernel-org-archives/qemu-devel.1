Received: from eggs.gnu.org ([2001:4830:134:3::10]:42207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gMAOk-0001gw-J0
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:28:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gMAOg-0006m0-Dk
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:28:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gMAOa-0006g6-SM
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:28:46 -0500
Date: Mon, 12 Nov 2018 12:28:33 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181112112833.hcbgtwjkb3p2qpgx@sirius.home.kraxel.org>
References: <20181109142032.1628-1-kraxel@redhat.com>
	<9b2c9e91-8904-1200-f491-4ee1d6ed42e3@amsat.org>
	<20181112091205.brrcxxzzvfthyqhk@sirius.home.kraxel.org>
	<c21b1cba-3dee-d7d8-24b3-8d04fb0a9265@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c21b1cba-3dee-d7d8-24b3-8d04fb0a9265@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] pulseaudio: process audio data in
 smaller chunks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Martin Schrodt <martin@schrodt.org>, Max Ehrlich <maxehr@umiacs.umd.edu>, qemu-devel@nongnu.org

On Mon, Nov 12, 2018 at 10:51:36AM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 12/11/18 10:12, Gerd Hoffmann wrote:
> > On Sat, Nov 10, 2018 at 08:36:39PM +0100, Philippe Mathieu-Daud=E9 wr=
ote:
> > > Hi Gerd,
> > >=20
> > > On 11/9/18 3:20 PM, Gerd Hoffmann wrote:
> > > > The rate of pulseaudio absorbing the audio stream is used to cont=
rol the
> > > > the rate of the guests audio stream.  When the emulated hardware =
uses
> > > > small chunks (like intel-hda does) we need small chunks on the au=
dio
> > > > backend side too, otherwise that feedback loop doesn't work very =
well.
> > >=20
> > > Shouldn't this be user-configurable?
> >=20
> > Why?
>=20
> When emulated hardware is not intel-hda?

Ok, maybe it is not required then, but it also doesn't hurt.

Also, when making chunk size configurable we should not leave that
to the confused user but pick a working value automatically, probably
depending on the emulated device.  I can't see what the benefit would
be though, especially given that intel-hda is probably used in most
configurations these days.

cheers,
  Gerd
