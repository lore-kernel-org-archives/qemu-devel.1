Received: from eggs.gnu.org ([2001:4830:134:3::10]:36526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aaron@os.amperecomputing.com>) id 1gDEOw-0004qb-FV
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 15:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aaron@os.amperecomputing.com>) id 1gDEOq-0008In-La
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 15:56:08 -0400
From: Aaron Lindsay <Aaron@os.amperecomputing.com>
Date: Thu, 18 Oct 2018 19:55:04 +0000
Message-ID: <20181018195456.GF12691@quinoa.localdomain>
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-13-aclindsa@gmail.com>
	<0fdcad4a-c8b5-3309-d2ce-f9be901ec52a@linaro.org>
	<20181017192013.GA25905@quinoa.localdomain>
	<31f327f4-42ee-55fc-596d-97d935803867@linaro.org>
	<20181017202505.GC25905@quinoa.localdomain>
	<ddceb720-97d2-22fa-e58a-7283fb416c29@linaro.org>
In-Reply-To: <ddceb720-97d2-22fa-e58a-7283fb416c29@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DCF50956F035B347998E5F63B6B81EB6@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 12/14] target/arm: PMU: Set PMCR.N to 4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Aaron Lindsay <aclindsa@gmail.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Michael Spradling <mspradli@codeaurora.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Digant Desai <digantd@codeaurora.org>

On Oct 17 14:14, Richard Henderson wrote:
> On 10/17/18 1:25 PM, Aaron Lindsay wrote:
> > I suppose pmcrn (the local variable) should've been set to 0 before thi=
s
> > patch and updated here to be 4.
>=20
> That's plausible.
>=20
> > Anyway, by splitting these patches apart, my intention was to separate
> > the plumbing work from turning on the water. If you believe it is bette=
r
> > to do both in the same patch, I'll make that change for v7.
>=20
> Fair.  I'll let Peter weigh in for final decision.

At a minimum, I've updated my local tree so that pmcrn is initially set
to 0 in 'target/arm: Finish implementation of PM[X]EVCNTR and
PM[X]EVTYPER' and updated to 4 in this patch. And I'll squash them
instead if that ends up being the decision.=20

-Aaron
