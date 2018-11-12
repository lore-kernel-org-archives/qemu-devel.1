Received: from eggs.gnu.org ([2001:4830:134:3::10]:60792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gM8GU-0003xj-N0
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gM8GP-0005Sl-9o
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:12:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gM8GP-0005Mc-16
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:12:09 -0500
Date: Mon, 12 Nov 2018 10:12:05 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181112091205.brrcxxzzvfthyqhk@sirius.home.kraxel.org>
References: <20181109142032.1628-1-kraxel@redhat.com>
	<9b2c9e91-8904-1200-f491-4ee1d6ed42e3@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9b2c9e91-8904-1200-f491-4ee1d6ed42e3@amsat.org>
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Martin Schrodt <martin@schrodt.org>, Max Ehrlich <maxehr@umiacs.umd.edu>

On Sat, Nov 10, 2018 at 08:36:39PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hi Gerd,
>=20
> On 11/9/18 3:20 PM, Gerd Hoffmann wrote:
> > The rate of pulseaudio absorbing the audio stream is used to control =
the
> > the rate of the guests audio stream.  When the emulated hardware uses
> > small chunks (like intel-hda does) we need small chunks on the audio
> > backend side too, otherwise that feedback loop doesn't work very well=
.
>=20
> Shouldn't this be user-configurable?

Why?

cheers,
  Gerd
