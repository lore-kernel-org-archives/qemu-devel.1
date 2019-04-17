Received: from eggs.gnu.org ([209.51.188.92]:58095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hGieL-0007FR-GP
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hGieJ-0001gb-RQ
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:22:45 -0400
Date: Wed, 17 Apr 2019 21:22:36 +1000
From: Nicholas Piggin <npiggin@gmail.com>
References: <20190412093603.18232-1-npiggin@gmail.com>
	<20190415041359.GE32705@umbus.fritz.box>
	<1555302690.7m52mtdllv.astroid@bobo.none>
	<20190417004721.GG32705@umbus.fritz.box>
In-Reply-To: <20190417004721.GG32705@umbus.fritz.box>
MIME-Version: 1.0
Message-Id: <1555500026.z0ch7int8l.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] spapr: add splpar hcalls H_JOIN, H_PROD,
 H_CONFER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

David Gibson's on April 17, 2019 10:47 am:
> On Mon, Apr 15, 2019 at 03:06:43PM +1000, Nicholas Piggin wrote:
>> It needs to be cleared at all vCPU dispatch points to SPEC, not just
>> when calling H_CEDE as Ben's patch had. I think complexity would be
>> significant for questionable benefit. Like the dispatch sequence, it
>> seems like the test is trying to cover some race condition for the
>> client but does not really do it well (and for Linux not necessary).
>>=20
>> prod bit is cleared after vCPU returns from preemption, so it can=20
>> clear at any time and you can't rely on it, unless you look at=20
>> dispatch sequence numbers to decipher if it was reset or not.
>>=20
>> KVM does implement something like the prodded flag as Ben's patch did
>> but that's not to spec AFAIKS.
>=20
> Hm, ok.  Maybe include this rationale in the comment here.

Done (hopefully)

>> > I don't see any sign that H_JOIN is implemented in KVM, although
>> > H_CONFER and H_PROD certainly are.
>>=20
>> H_JOIN is not.
>=20
> Right, so we shouldn't be trying to enable it.  What will happen if we
> use a KVM H_CONFGER and H_PROD along with a userspace H_JOIN?

Yeah good question I'll have to test before sending the H_JOIN
part again.

May have to modify KVM to make that work properly.

Thanks,
Nick
=
