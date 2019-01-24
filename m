Received: from eggs.gnu.org ([209.51.188.92]:35671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmh9v-0002rx-7Z
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:43:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmh11-0001jN-PG
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:34:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmh11-0001iZ-JQ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:34:03 -0500
Date: Thu, 24 Jan 2019 16:33:55 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190124153355.n5wey3savg7kyrjs@sirius.home.kraxel.org>
References: <20190124011554.25418-1-philmd@redhat.com>
	<20190124011554.25418-4-philmd@redhat.com>
	<20190124112336.oviomaisnaglg22e@sirius.home.kraxel.org>
	<c047d5bf-2cfb-233d-07ca-dbd2effa850e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c047d5bf-2cfb-233d-07ca-dbd2effa850e@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/4] configure: Let SDL support be
 optional on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>

On Thu, Jan 24, 2019 at 02:51:08PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 1/24/19 12:23 PM, Gerd Hoffmann wrote:
> >>      sdl)
> >>      if test "$sdl" =3D "no"; then
> >> -        error_exit "sdl not found or disabled, can not use sdl audi=
o driver"
> >> +        echo "WARN: sdl not found or disabled, can not use sdl audi=
o driver"
> >> +        audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/sdl *=
//g')
> >=20
> > Busy tackling that in a separate patch series (audio: rework driver
> > probing)
>=20
> But we need the Milkymist TMU fixes to build without SDL,
> I still get this error when building the series you mentioned using
> --disable-sdl on OpenBSD:

Yep.  Try https://git.kraxel.org/cgit/qemu/log/?h=3Dsirius/drop-sdl1

That is the audio series and the first two patches of this series plus
Daniel's sdl1 removal patch rebased.  Looks good so far, need to run
some more build tests though.

cheers,
  Gerd
