Received: from eggs.gnu.org ([2001:4830:134:3::10]:52280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHD8I-0006fb-8F
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHD8H-0003Qp-EJ
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:18:54 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:38153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHD8H-0003QP-A9
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:18:53 -0500
Received: by mail-oi0-x241.google.com with SMTP id b189so9180474oia.5
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 10:18:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171106154813.19936-17-andrew.smirnov@gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
	<20171106154813.19936-17-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 18:18:32 +0000
Message-ID: <CAFEAcA8RExNSWHO1F87o6j1Z8k1MEcJ_VvrE3VOpgJRPcCa-vQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 16/30] i.MX: Add code to emulate GPCv2
 IP block
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

On 6 November 2017 at 15:47, Andrey Smirnov <andrew.smirnov@gmail.com> wrot=
e:
> Add minimal code needed to allow upstream Linux guest to boot.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  hw/intc/Makefile.objs       |   2 +-
>  hw/intc/imx_gpcv2.c         | 125 ++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/intc/imx_gpcv2.h |  22 ++++++++
>  3 files changed, 148 insertions(+), 1 deletion(-)
>  create mode 100644 hw/intc/imx_gpcv2.c
>  create mode 100644 include/hw/intc/imx_gpcv2.h

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
