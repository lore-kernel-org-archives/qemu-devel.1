Received: from eggs.gnu.org ([209.51.188.92]:39344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gmhKO-0002Ew-Pr
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gmhKO-0002wj-1Z
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:54:04 -0500
From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Date: Thu, 24 Jan 2019 15:53:48 +0000
Message-ID: <20190124155350.GF5213@quinoa.localdomain>
References: <20190123213227.17077-1-aaron@os.amperecomputing.com>
	<20190123213227.17077-2-aaron@os.amperecomputing.com>
	<7794239c-7850-1bb6-cbcb-b648533d9036@linaro.org>
In-Reply-To: <7794239c-7850-1bb6-cbcb-b648533d9036@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <900E5ED9B8D90848AB0349A726E3AE57@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v11 1/2] target/arm: Send interrupts on PMU
 counter overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Jan 23 15:37, Richard Henderson wrote:
> On 1/23/19 1:32 PM, Aaron Lindsay OS wrote:
> > +        uint64_t overflow_mask =3D env->cp15.c9_pmcr & PMCRLC ? \
> > +                                 INT64_MIN : INT32_MIN;
>=20
> With type promotion, this is the same as writing
>=20
>     ? 0x8000000000000000ull : 0xffffffff80000000ull
>=20
> which is probably not what you were intending.
>
> Perhaps just ? 1ull << 63 : 1ull << 31 is better?

You are correct. I think we changed this to INT32_MIN in an earlier
respin in an attempt at simplification, but I didn't catch the type
promotion issue.

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks, I'll send out a v12 momentarily.

-Aaron
