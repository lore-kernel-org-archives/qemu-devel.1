Received: from eggs.gnu.org ([2001:4830:134:3::10]:58863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fai36-0003aO-4f
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 09:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fai32-0004TA-4L
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 09:42:24 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20180704033134.GE14043@umbus.fritz.box>
Date: Wed, 4 Jul 2018 09:42:16 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <5DE66F68-07F2-4494-9CC7-51632A386542@gmail.com>
References: <20180703151732.29843-1-richard.henderson@linaro.org>
	<20180704033134.GE14043@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH for-3.1 0/7] target/ppc fp cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


> On Jul 3, 2018, at 11:31 PM, David Gibson =
<david@gibson.dropbear.id.au> wrote:
>=20
> On Tue, Jul 03, 2018 at 08:17:25AM -0700, Richard Henderson wrote:
>> Beginning with John Arbuckle's fdiv test case, clean up some
>> of the fp helpers.  As with fdiv, fre and fresqrt are missing
>> divide-by-zero exceptions.
>>=20
>> I've also noticed that load/store were using arithmetic conversions
>> to/from float32.  These should be using the non-arithmetic algorithms
>> listed in the manual.
>>=20
>> Aside from cleaning up all of the rest of the helpers, I believe that
>> the implementation of the single-precision operations are incorrect.
>> They are currently implemented with the double-precision operation
>> followed by a round-to-single.  This causes incorrect results via
>> double rounding.  I believe better results could be had by using
>> these non-arithmetic converters to produce float32 operands, use the
>> proper float32 softfloat operations, and then convert back.
>>=20
>> Anyway, all of this has been broken long enough that it'll need to
>> wait til next devel cycle before anything further gets done.
>=20
> Applied to ppc-for-3.1 (newly created)

Could I have the address for your ppc-for-3.1 repo please? Would you =
like future floating point patches to be based on this repo?
