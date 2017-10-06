Received: from eggs.gnu.org ([2001:4830:134:3::10]:40385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1e0RS9-00028S-0U
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:10:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1e0RS4-0004Yv-W9
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:10:04 -0400
Date: Fri, 6 Oct 2017 14:09:48 +0200
From: "Eduardo Otubo\"" <otubo@redhat.com>
Message-ID: <20171006120948.GA12173@vader>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922160111.31885-1-f4bug@amsat.org>
	<a6bedac0-0e58-8709-f549-a602914c9077@reactos.org>
	<400dde93-d110-ee49-b2a0-76ea633b4abe@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <400dde93-d110-ee49-b2a0-76ea633b4abe@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 23/34] hw/dma/i8257: rename
 DMA_init() to i8257_dma_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Fri, Sep 22, 2017 at 03:08:03PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 09/22/2017 02:43 PM, Herv=C3=A9 Poussineau wrote:
> > Le 22/09/2017 =C3=A0 18:01, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit =
:
> [...]
> > > +void i8257_dma_init(ISABus *bus, int high_page_enable);
> > > +
> >=20
> > As you're changing the DMA_init prototype, can you add an Error **err=
p
> > parameter, and pass &error_abort in each caller?
> >=20
> > See http://lists.gnu.org/archive/html/qemu-devel/2017-09/msg00262.htm=
l
> > for more details
>=20
> If Eduardo doesn't have a patch ready I can do it.

Please go ahead.
You can also use my patch set (v2) for that as a base if you want.
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg08007.html

--=20
Eduardo Otubo
Senior Software Engineer @ RedHat
