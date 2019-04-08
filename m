Received: from eggs.gnu.org ([209.51.188.92]:35458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDVnX-0001v7-UN
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDVnX-0002pb-2h
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:02:59 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190204231815.29661-1-philmd@redhat.com>
	<20190204231815.29661-6-philmd@redhat.com>
Date: Mon, 08 Apr 2019 17:02:44 +0200
In-Reply-To: <20190204231815.29661-6-philmd@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 5 Feb 2019 00:18:09
	+0100")
Message-ID: <877ec4o7zf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/11] hw/devices: Move CBus
 declarations into a new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Joel Stanley <joel@jms.id.au>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, Jan Kiszka <jan.kiszka@web.de>, Aurelien Jarno <aurelien@aurel32.net>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Not at all this patch's problem, but I can't withhold these gems from
your admiring eyes:

hw/arm/nseries.c:    cbus_attach(cbus, s->retu =3D retu_init(retu_irq, 1));
hw/arm/nseries.c:    cbus_attach(cbus, s->tahvo =3D tahvo_init(tahvo_irq, 1=
));
