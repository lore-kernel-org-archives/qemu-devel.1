Received: from eggs.gnu.org ([2001:4830:134:3::10]:35872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonynpavlov@gmail.com>) id 1eXZih-0006Hs-0C
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonynpavlov@gmail.com>) id 1eXZid-0000yw-PH
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:40:06 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <antonynpavlov@gmail.com>)
	id 1eXZid-0000yT-EG
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:40:03 -0500
Received: by mail-lf0-x242.google.com with SMTP id h5so6505676lfj.2
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 13:40:03 -0800 (PST)
Date: Sat, 6 Jan 2018 00:54:02 +0300
From: Antony Pavlov <antonynpavlov@gmail.com>
Message-Id: <20180106005402.caea79a9e9676296e6eb805b@gmail.com>
In-Reply-To: <1514940265-18093-20-git-send-email-mjc@sifive.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-20-git-send-email-mjc@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 19/21] SiFive Freedom E300 RISC-V Machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Wed,  3 Jan 2018 13:44:23 +1300
Michael Clark <mjc@sifive.com> wrote:

> This provides a RISC-V Board compatible with the the SiFive E300 SDK.
> The following machine is implemented:
>=20
> - 'sifive_e300'; CLINT, PLIC, UART, AON, GPIO, QSPI, PWM
>=20

...

> diff --git a/include/hw/riscv/sifive_e300.h b/include/hw/riscv/sifive_e30=
0.h
> new file mode 100644
> index 0000000..453c43b
> --- /dev/null
> +++ b/include/hw/riscv/sifive_e300.h
> @@ -0,0 +1,79 @@
> +/*
> + * SiFive E300 series machine interface
> + *
> + * Copyright (c) 2017 SiFive, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef HW_SIFIVE_E300_H
> +#define HW_SIFIVE_E300_H
> +
> +#define TYPE_SIFIVE_E300 "riscv.sifive.e300"
> +
> +#define SIFIVE_E300(obj) \
> +    OBJECT_CHECK(SiFiveE300State, (obj), TYPE_SIFIVE_E300)
> +
> +typedef struct SiFiveE300State {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    RISCVHartArrayState soc;

I suppose that name 'soc' is misleading because it contain only CPU core-re=
lated information
but it does not contain any SoC-related information.

> +    DeviceState *plic;
> +} SiFiveE300State;
> +



--=20
Best regards,
=A0 Antony Pavlov
