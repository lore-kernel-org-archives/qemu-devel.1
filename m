Received: from eggs.gnu.org ([209.51.188.92]:53591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hCKld-0008LM-Fw
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hCKjt-0003BT-MZ
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:02:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hCKjt-0003AY-3d
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:02:21 -0400
Date: Fri, 5 Apr 2019 10:02:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190405090212.GF6105@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
	<068f4832-7e0b-8850-ffa0-fcf1ecd50295@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <068f4832-7e0b-8850-ffa0-fcf1ecd50295@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Automatically fall back to TCI
 on non-release architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>, Samuel Thibault <samuel.thibault@ens-lyon.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, Apr 05, 2019 at 10:47:54AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Helge,
>=20
> On 4/5/19 9:56 AM, Helge Deller wrote:
> > On 05.04.19 03:34, Peter Maydell wrote:
> >> On Fri, 5 Apr 2019 at 01:59, Helge Deller <deller@gmx.de> wrote:
> >>> If a non-release architecture is found, and it's known that there i=
s no
> >>> native TCG support for that CPU, automatically fall back to the TCI
> >>> implementation instead of requesting the user to run configure agai=
n
> >>> with the --enable-tcg-interpreter option.
> >>>
> >>> This change simplifies building qemu in automatic build environment=
s
> >>> (like in my case the debian buildds) because one does not need to
> >>> special case on the architectures.
> >>
> >> I don't think we should do this. TCI is unmaintained, has several
> >> known flaws,
> >=20
> > Just out of interest: Is there a list with those flaws somewhere?
>=20
> The last big discussion is in this thread:
> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06528.html

Do the various crashes that you illustrate in that cover letter
still exist today ? If so, 2 years of continued brokenness with no
fixes would reinforce the the view that it is time to remove TCI
from the codebase.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
