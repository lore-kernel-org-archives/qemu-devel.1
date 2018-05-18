Received: from eggs.gnu.org ([2001:4830:134:3::10]:54167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJaUh-0000EL-MA
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJaUe-00088R-Gs
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:12:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38496 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fJaUe-00088C-CA
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:12:04 -0400
Date: Fri, 18 May 2018 10:12:02 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180518081202.abeosmx2qkvfjbci@sirius.home.kraxel.org>
References: <20180517092513.735-1-kraxel@redhat.com>
	<20180517092513.735-2-kraxel@redhat.com>
	<acfb9725-d66b-4442-4dd0-89bfe24dd342@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <acfb9725-d66b-4442-4dd0-89bfe24dd342@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] vga: move bochs vbe defines to header
 file
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

On Thu, May 17, 2018 at 12:20:58PM -0300, Philippe Mathieu-Daud=E9 wrote:
> On 05/17/2018 06:25 AM, Gerd Hoffmann wrote:
> > Create a new header file, move the bochs vbe dispi interface
> > defines to it, so they can be used outside vga code.
> >=20
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  hw/display/vga_int.h           | 35 ++---------------------
> >  include/hw/display/bochs-vbe.h | 64 ++++++++++++++++++++++++++++++++=
++++++++++
> >  hw/display/vga-pci.c           | 13 ---------
>=20
> Adding those file in your Graphics MAINTAINERS entry:

"Graphics" is for ui/.

There isn't one for hw/display/*vga* in the devices section though,
guess I should add one ...

cheers,
  Gerd
