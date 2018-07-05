Received: from eggs.gnu.org ([2001:4830:134:3::10]:40434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fb7TH-00038e-NF
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fb7TD-0000j1-2R
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:51:07 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <128b92a6-7b0e-5e27-2bad-63da14bb3a6a@linaro.org>
Date: Thu, 5 Jul 2018 12:51:00 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <1106207A-1C28-4146-9F94-F9747BF8B345@gmail.com>
References: <20180703151732.29843-1-richard.henderson@linaro.org>
	<20180703151732.29843-8-richard.henderson@linaro.org>
	<B9095EFA-A3D5-4EEE-A5DA-E4284FD8881E@gmail.com>
	<128b92a6-7b0e-5e27-2bad-63da14bb3a6a@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 7/7] target/ppc: Use non-arithmetic
 conversions for fp load/store
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org


> On Jul 5, 2018, at 12:48 PM, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 07/05/2018 09:31 AM, Programmingkid wrote:
>>> On Jul 3, 2018, at 11:17 AM, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>>>=20
>>> Memory operations have no side effects on fp state.
>>> The use of a "real" conversions between float64 and float32
>>> would raise exceptions for SNaN and out-of-range inputs.
>>=20
>> Would you have any documentation that tells us about converting
>> between 64 bit and 32 bit floating points?
>=20
> Spelled out right at the beginning of sections 4.6 (load) and 4.7 =
(store) of
> Book 1 of the Power ISA manual (version 3.0B) [0].
>=20
> I've double-checked vs RISU[1] testing of LFS and STFS, with master =
traces
> generated on Power 8 ppc64le, so I don't see anything immediately =
wrong with
> the patch.  But I haven't had time to look further than that.
>=20
>=20
> r~
>=20
>=20
> [0] =
https://openpowerfoundation.org/?resource_lib=3Dpower-isa-version-3-0
> [1] https://git.linaro.org/people/peter.maydell/risu.git

Thank you for the documentation. My guess is there are differences =
between the PowerPC and Power 8 implementations. PowerPC is big endian. =
Would you be able to do your testing again with your Power 8 CPU in big =
endian mode?
