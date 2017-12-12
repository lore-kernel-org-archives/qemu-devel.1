Received: from eggs.gnu.org ([2001:4830:134:3::10]:56032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOoQg-0000JN-Vs
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:33:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOoQg-0003BA-6T
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:33:18 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:42439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eOoQg-0003Ap-10
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:33:18 -0500
Received: by mail-ot0-x22f.google.com with SMTP id i1so18459227oth.9
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 09:33:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171211213007.7353-12-andrew.smirnov@gmail.com>
References: <20171211213007.7353-1-andrew.smirnov@gmail.com>
	<20171211213007.7353-12-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2017 17:32:56 +0000
Message-ID: <CAFEAcA_+o0KsdBMBzEC86xqi6YpRgUC=DdLftThj0ZRP60JnFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/13] imx_fec: Reserve full
 FSL_IMX25_FEC_SIZE page for the register file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 11 December 2017 at 21:30, Andrey Smirnov <andrew.smirnov@gmail.com> wro=
te:
> Some i.MX SoCs (e.g. i.MX7) have FEC registers going as far as offset
> 0x614, so to avoid getting aborts when accessing those on QEMU, extend
> the register file to cover FSL_IMX25_FEC_SIZE(16K) of address space
> instead of just 1K.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
