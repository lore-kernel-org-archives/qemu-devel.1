Received: from eggs.gnu.org ([209.51.188.92]:49934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glZqz-0001Gk-Cn
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:43:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glZk3-0002wf-Fo
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:36:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1glZjz-0002tl-U6
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:35:53 -0500
References: <20190121131602.55003-1-ysato@users.sourceforge.jp>
	<20190121131602.55003-2-ysato@users.sourceforge.jp>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <937dc78e-beea-aa9c-ee35-e92023f74ad7@redhat.com>
Date: Mon, 21 Jan 2019 14:35:43 +0100
MIME-Version: 1.0
In-Reply-To: <20190121131602.55003-2-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 01/11] TCG translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 2019-01-21 14:15, Yoshinori Sato wrote:
> This part only supported RXv1 instructions.
> Instruction manual.
> https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01us00=
32ej0120_rxsm.pdf
>=20
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
[...]
> diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
> new file mode 100644
> index 0000000000..c9c87dc308
> --- /dev/null
> +++ b/target/rx/op_helper.c
> @@ -0,0 +1,548 @@
> +/*
> + *  RX helper functions
> + *
> + *  Copyright (c) 2018 Yoshinori Sato
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.

 Hi,

just a short meta comment for all the new files in your patch series:
It's either

 GNU *Library* General Public License, version 2

or

 GNU Lesser General Public License, version *2.1*

I'd suggest to go with "Lesser" and "2.1".

Apart from that, it might be a good idea to CC: some people who are
familiar with TCG if you want to make sure to get some review (see the
MAINTAINERS file for example).

 Thanks,
  Thomas


PS: Seems like we've got this "Lesser" vs. "Library" wrong in a couple
of other source files in QEMU ... I'll try to come up with a patch to
fix this in the files that we've already got in the repo.
