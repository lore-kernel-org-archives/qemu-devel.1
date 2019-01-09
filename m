Received: from eggs.gnu.org ([209.51.188.92]:55992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mmogilvi+qemu@zoho.com>) id 1ghEAd-0001ef-An
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:45:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mmogilvi+qemu@zoho.com>) id 1ghEAc-0005FA-D1
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:45:23 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mmogilvi+qemu@zoho.com>)
	id 1ghEAb-00056X-UH
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:45:22 -0500
Date: Tue, 8 Jan 2019 22:58:57 -0700
From: Matthew Ogilvie <mmogilvi+qemu@zoho.com>
Message-ID: <20190109055856.GA30631@comcast.net>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
	<20190107163117.16269-25-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190107163117.16269-25-peter.maydell@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 24/37] qtest: Add set_irq_in command to set
 IRQ/GPIO level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

On Mon, Jan 07, 2019 at 04:31:04PM +0000, Peter Maydell wrote:
> From: Steffen G=F6rtz <contrib@steffen-goertz.de>
>=20
> Adds a new qtest command "set_irq_in" which allows
> to set qemu gpio lines to a given level.
>=20
> Based on https://lists.gnu.org/archive/html/qemu-devel/2012-12/msg02363=
.html
> which never got merged.
>=20
> Signed-off-by: Steffen G=F6rtz <contrib@steffen-goertz.de>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-id: 20190103091119.9367-2-stefanha@redhat.com
> Originally-by: Matthew Ogilvie <mmogilvi_qemu@miniinfo.net>

It is kind of interesting to see a part of my old thread(s)
resurrected, even if it isn't the part I was actually interested
in.

Note that my miniinfo email account no longer exists, but I
can still be reached at mmogilvi+qemu@zoho.com if desired.

Regarding the patch, I haven't kept up with changes to qemu
well enough to really have a useful opinion, although superficially
it looks good.  Perhaps it would make sense to include both
my old and new email addresses in the sign-off section, to both
tie it to the old threads and make it easier to reach me
if someone wants to contact me?  (But I'm not sure of a "clean"
way to do so, and it is probably low priority.  Perhaps this
current email is good enough?)

                - Matthew Ogilvie

P.S.: Explanation and keywords to find this message (and me) with
search tools:

With regards to qemu, my primary interest (from that thread and
related 2012 threads) is/was being able to run
"Microport UNIX System V/386 v2.1" (ca. 1987) under qemu, which
especially required:
   - Fixing various inaccuracies in qemu's model of the i8259
     interrupt controller.
   - Implementing very old graphics card model(s) that Microport UNIX
     actually knows how to control properly.  Perhaps original
     IBM monochrome display adaptor (MDA), CGA, and/or hercules
     graphics card.  Or else my nasty qemu hackish patches I wrote
     that allowed VGA to work in text mode despite Microport driving
     it like CGA in a way that didn't work with real VGA hardware.
