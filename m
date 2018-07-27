Received: from eggs.gnu.org ([2001:4830:134:3::10]:40147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1fixy1-0006qs-C7
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 04:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1fixxy-0003JX-6z
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 04:19:17 -0400
Message-ID: <e444331077031e04ff2037732e50007016af5bc6.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 27 Jul 2018 18:18:51 +1000
In-Reply-To: <25b9402d-d3e3-ca43-7f57-698650f0681f@kaod.org>
References: <20180628083633.12413-1-clg@kaod.org>
	<20180628083633.12413-2-clg@kaod.org>
	<adea078d-3e69-9ba3-aea7-1e4f8affb1c4@kaod.org>
	<1c0ea35e33f56f5127e5c934ca107775fd4933f1.camel@kernel.crashing.org>
	<25b9402d-d3e3-ca43-7f57-698650f0681f@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, 2018-07-27 at 09:16 +0200, C=C3=A9dric Le Goater wrote:
> > I'd have to remember how PQ works on P8 ... my gut feeling is that we
> > should resend if P=3D1 but I'm no 100% certain.
>=20
> This is not exactly what the code does. To force a resend, it ignores=20
> P but if Q=3D1, it bails out without doing anything, like a normal trig=
ger=20
> would do. So I think that in the resend case we should ignore Q as well.

Not too sure. We might need to swallow the resend if PQ became 01.

I don't know for sure what the HW does. Does it unconditionally resend
or does it re-evaluate the priority etc... it's unclear to me.

But yes, we should still resend if PQ=3D11

Cheers,
Ben.
