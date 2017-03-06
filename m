Received: from eggs.gnu.org ([2001:4830:134:3::10]:44194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1ckwMe-0001i6-M5
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:24:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1ckwMd-0004zR-RO
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:24:04 -0500
Date: Mon, 6 Mar 2017 19:23:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <20170306172346.2f7guqfhzzlzmnfq@kozik-lap>
References: <20170305214857.9510-1-krzk@kernel.org>
	<20170305214857.9510-3-krzk@kernel.org>
	<2130c1b2-0f81-13f6-a1f8-c0a2e294e3f0@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2130c1b2-0f81-13f6-a1f8-c0a2e294e3f0@amsat.org>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 3/3] hw/misc/exynos4210_pmu:
 Reorder local variables for readability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On Mon, Mar 06, 2017 at 01:06:29AM -0300, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Krzysztof,
>=20
> On 03/05/2017 06:48 PM, Krzysztof Kozlowski wrote:
> > Short declaration of 'i' was in the middle of declarations with
> > assignments.  Make it a little bit more readable.  No functional change.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  hw/misc/exynos4210_pmu.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/misc/exynos4210_pmu.c b/hw/misc/exynos4210_pmu.c
> > index cbdfa0614600..60d1545c0baa 100644
> > --- a/hw/misc/exynos4210_pmu.c
> > +++ b/hw/misc/exynos4210_pmu.c
> > @@ -401,8 +401,8 @@ static uint64_t exynos4210_pmu_read(void *opaque, h=
waddr offset,
> >                                      unsigned size)
> >  {
> >      const Exynos4210PmuState *s =3D (Exynos4210PmuState *)opaque;
> > -    unsigned i;
> >      const Exynos4210PmuReg *reg_p =3D exynos4210_pmu_regs;
> > +    unsigned i;
>=20
> your change seems OK but while you are here, 'unsigned' is considered
> harmful since more than a decade. why not use 'size_t i' since
> PMU_NUM_OF_REGISTERS is indeed an ARRAY_SIZE()?

It is a loop counter. I think "unsigned int" for loop counters is the
most common pattern - easy to understand the true meaning of variable.
I can expand it to "unsigned int" but that wouldn't change much...

Let's look at current style:
$ git grep "unsigned int i[,;$]" | wc -l
188

$ git grep "unsigned i[,;$]" | wc -l
92

$ git grep "size_t i[,;$]" | wc -l
114

=2E.. where do we go now?



Best regards,
Krzysztof
