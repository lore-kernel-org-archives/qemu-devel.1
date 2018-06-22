Received: from eggs.gnu.org ([2001:4830:134:3::10]:60199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fWIJ3-0002qe-FK
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fWIJ0-0003Vc-Bf
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:24:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47362 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fWIJ0-0003VN-6f
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:24:34 -0400
Date: Fri, 22 Jun 2018 11:24:31 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180622092431.mvo3ve46cw2rp45c@sirius.home.kraxel.org>
References: <cover.1529568501.git.balaton@eik.bme.hu>
	<20180622005134.GC612@umbus.fritz.box>
	<84aa3623-0b93-182e-d9bb-6acca7a7d7ea@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <84aa3623-0b93-182e-d9bb-6acca7a7d7ea@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] Misc sm501 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>, Peter Maydell <peter.maydell@linaro.org>, Sebastian Bauer <mail@sebastianbauer.info>, Magnus Damm <magnus.damm@gmail.com>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On Thu, Jun 21, 2018 at 10:37:10PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Cc'ing Gerd who maintains many hw/display/ files.
>=20
> On 06/21/2018 09:51 PM, David Gibson wrote:
> > On Thu, Jun 21, 2018 at 10:08:21AM +0200, BALATON Zoltan wrote:
> >> These are fixes to sm501 emulation that were found while testing wit=
h
> >> AmigaOS 4.1FE (AmigaOS 4 is known to work on real hardware but we ha=
ve
> >> no way to verify it against hardware). While this is mainly to impro=
ve
> >> sam460ex emulation this is now a separate series with the sm501
> >> specific patches because that's also used on SH emulation. I hope
> >> someone can review and merge this.
> [...]
> > hw/display/sm501.c                 | 166
> +++++++++++++++++++++++++++++++++++--
> >=20
> > I'm not really familiar with the sm501 hardware, so I can't speak to
> > these technically, beyond the fact that there's nothing obviously
> > bogus.
> >=20
> > I can say that BALATON Zoltan is the only person who's made
> > non-trivial changes to sm501 lately, and there don't seem to have bee=
n
> > any screams, so I'm pretty happy to assume he knows what he's doing.

Changes all look sane to me even without having sm501 specs at hand.

cheers,
  Gerd
