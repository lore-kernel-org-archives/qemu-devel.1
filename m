Received: from eggs.gnu.org ([2001:4830:134:3::10]:39065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aaron@os.amperecomputing.com>) id 1gCrNR-0007Dw-Jc
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aaron@os.amperecomputing.com>) id 1gCrNQ-0006es-OY
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:21:05 -0400
From: Aaron Lindsay <Aaron@os.amperecomputing.com>
Date: Wed, 17 Oct 2018 19:20:53 +0000
Message-ID: <20181017192013.GA25905@quinoa.localdomain>
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-13-aclindsa@gmail.com>
	<0fdcad4a-c8b5-3309-d2ce-f9be901ec52a@linaro.org>
In-Reply-To: <0fdcad4a-c8b5-3309-d2ce-f9be901ec52a@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D7899A26DE492E4DB9800DF0DEE58AAE@prod.exchangelabs.com>
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

On Oct 16 17:09, Richard Henderson wrote:
> On 10/10/18 1:37 PM, Aaron Lindsay wrote:
> > This both advertises that we support four counters and enables them
> > because the pmu_num_counters() reads this value from PMCR.
> >=20
> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> > ---
> >  target/arm/helper.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> It looks like this should have been folded into patch 10,
> or patch 10 split to include the code changes that go with
> these comment changes.

By setting PMCR.N to 4, this commit is what causes all the previous
implementation of non-PMCCNTR counters to become usable by the guest -
both because the OS can now detect their presence in PMCR, and because
the system registers used to setup/access the counters are gated on
pmu_num_counters(), which uses PMCR.N to determine if a counter is
implemented.

That said, I'm not against merging the two patches if you feel that is
cleaner.

-Aaron
