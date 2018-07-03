Received: from eggs.gnu.org ([2001:4830:134:3::10]:46059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faElJ-0000s1-HX
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faElG-0005tm-DL
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:26:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1faElG-0005t5-5r
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:26:02 -0400
Date: Tue, 3 Jul 2018 08:25:59 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180703062559.dn2dpecvicb6oelf@sirius.home.kraxel.org>
References: <20180702163345.17892-1-kraxel@redhat.com>
	<20180702163345.17892-2-kraxel@redhat.com>
	<20180702164326.ry3qghgjkjrshouh@sirius.home.kraxel.org>
	<6fba740c-3006-e6fd-9008-4ff3ed221b9b@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <6fba740c-3006-e6fd-9008-4ff3ed221b9b@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] warn about two vga cards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org

On Mon, Jul 02, 2018 at 02:03:58PM -0300, Philippe Mathieu-Daud=E9 wrote:
> On 07/02/2018 01:43 PM, Gerd Hoffmann wrote:
> > On Mon, Jul 02, 2018 at 06:33:45PM +0200, Gerd Hoffmann wrote:
> >> Two vga cards will try to register for the same legacy (isa) ioports=
.
> >> Due to this conflict only one of the two cards will work correctly i=
n
> >> vga mode.
> >>
> >> Print a warning message in that case.  Also try registering the port=
s
> >> only once, so the first vga added to the system will work properly.
> >=20
> > Scratch that, not working as expected.
>=20
> Uh what's wrong?

Well, current behavior (with patch 1/2 applied, or with virtio-vga
which doesn't use global_vmstate) is "last vga card wins", and that card
actually works.  This patch breaks the vga display, even when tweaked
that both vga and vbe ports are handled (so they don't end up being
assigned to two different cards).  Didn't figure yet why.

Beside that I've noticed cirrus-vga doesn't use that function, so even
the warning message doesn't work as intended in case cirrus is involved.

cheers,
  Gerd
