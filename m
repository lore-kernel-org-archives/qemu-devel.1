Received: from eggs.gnu.org ([2001:4830:134:3::10]:50549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYXym-0006H7-3C
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:00:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYXyl-00049E-5l
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:00:44 -0500
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:42390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYXyl-00048m-10
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:00:43 -0500
Received: by mail-oi0-x232.google.com with SMTP id o64so7381508oia.9
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 06:00:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180102193622.27215-6-andrew.smirnov@gmail.com>
References: <20180102193622.27215-1-andrew.smirnov@gmail.com>
	<20180102193622.27215-6-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 14:00:21 +0000
Message-ID: <CAFEAcA-4=wy==HyXxivLQJE1rRsZxOW0=r7p3raTKfJEtsVPBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 05/11] imx_fec: Use ENET_FTRL to
 determine truncation length
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

On 2 January 2018 at 19:36, Andrey Smirnov <andrew.smirnov@gmail.com> wrote=
:
> Frame truncation length, TRUNC_FL, is determined by the contents of
> ENET_FTRL register, so convert the code to use it instead of a
> hardcoded constant.
>
> To avoid the case where TRUNC_FL is greater that ENET_MAX_FRAME_SIZE,
> increase the value of the latter to its theoretical maximum of 16K.
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
