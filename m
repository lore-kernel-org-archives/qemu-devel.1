Received: from eggs.gnu.org ([2001:4830:134:3::10]:48832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d2d8p-0000yz-0Y
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d2d8o-00043A-7j
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:30:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d2d8o-00042y-0M
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:30:54 -0400
Message-ID: <1493037051.19018.32.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 24 Apr 2017 14:30:51 +0200
In-Reply-To: <CAFEAcA9P9EECgmqubfN+71cYxsB5bbTddooyBfpM7=C2-6iTXw@mail.gmail.com>
References: <20170421091632.30900-1-kraxel@redhat.com>
	<20170421091632.30900-10-kraxel@redhat.com>
	<alpine.BSF.2.20.1704211236100.58688@zero.eik.bme.hu>
	<CAFEAcA9P9EECgmqubfN+71cYxsB5bbTddooyBfpM7=C2-6iTXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 9/9] sm501: make display updates thread safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, QEMU Developers <qemu-devel@nongnu.org>

On Mo, 2017-04-24 at 13:09 +0100, Peter Maydell wrote:
> On 21 April 2017 at 11:42, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> > On Fri, 21 Apr 2017, Gerd Hoffmann wrote:
> >>
> >> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >> ---
> >> hw/display/sm501.c | 23 ++++++-----------------
> >> 1 file changed, 6 insertions(+), 17 deletions(-)
> >
> >
> > Hold on with this please too. I have a series pending that changes this=
.
>=20
> Gerd: I've now applied Zoltan's patchset to git master, so you'll
> want to rebase your changes on it.

Pull request for the first batch is just out of the door, without sm501
+ tcx + cg3 to avoid conflicts.  They will follow with the next batch,
which then should also able to revert the temporary workaround.

cheers,
  Gerd
