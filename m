Received: from eggs.gnu.org ([2001:4830:134:3::10]:46723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nanjekyejoannah@gmail.com>) id 1eAbBS-0007S9-7R
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nanjekyejoannah@gmail.com>) id 1eAbBR-0000S1-BR
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:34:50 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:46208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nanjekyejoannah@gmail.com>)
	id 1eAbBR-0000Rd-4s
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:34:49 -0400
Received: by mail-wm0-x242.google.com with SMTP id r68so1226494wmr.1
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 05:34:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171103112442.GN5078@stefanha-x1.localdomain>
References: <1509020054-25434-1-git-send-email-nanjekyejoannah@gmail.com>
	<e4b4b545-919f-f043-6a6e-70e563fa75ff@amsat.org>
	<20171103112442.GN5078@stefanha-x1.localdomain>
From: joannah nanjekye <nanjekyejoannah@gmail.com>
Date: Fri, 3 Nov 2017 15:34:46 +0300
Message-ID: <CANFMCgQf4gE4Tsm0uPfq4ADD2TrinjpazTzp4Yh3+4d2wwr3vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH WIP] replace numpy with struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

I will send an update tomorrow as am travelling rite now.

Thanks for the reminder.

On Nov 3, 2017 2:24 PM, "Stefan Hajnoczi" <stefanha@gmail.com> wrote:

> On Thu, Oct 26, 2017 at 10:50:26AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi Joannah,
> >
> > The common subject to use is [RFC PATCH] instead of [PATCH WIP]
> >
> > On 10/26/2017 09:14 AM, Joannah Nanjekye wrote:
> > > This patch replaces the use of numpy with the standard Library struct
> module where possible.
> >
> > This seems a good idea but why?
>
> I suggest adding this to the commit description:
>
> Users tend to hit an ImportError when running analyze-migration.py due
> to the numpy dependency.  numpy functionality isn't actually used, just
> binary serialization that the standard library 'struct' module already
> provides.  Removing the dependency allows the script to run
> out-of-the-box.
>
> > Do you have any performance improvements results to share?
> >
> > > Signed-off-by: Joannah Nanjekye <nanjekyejoannah@gmail.com>
> > > ---
> > >
> > >  scripts/analyze-migration.py | 19 ++++++++++++-------
> > >  1 file changed, 12 insertions(+), 7 deletions(-)
>
> I don't see a removal of "import numpy as np" so this script still
> depends on numpy.  Did you forget to sent further patches that you have
> to remove the numpy dependency?
>
