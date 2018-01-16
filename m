Received: from eggs.gnu.org ([2001:4830:134:3::10]:57919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebSPz-0005EW-68
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebSPy-0007uR-Bm
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:40:51 -0500
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:46695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebSPy-0007tt-7e
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:40:50 -0500
Received: by mail-ot0-x234.google.com with SMTP id t35so7119259otd.13
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:40:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180116013709.13830-11-andrew.smirnov@gmail.com>
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<20180116013709.13830-11-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 14:40:29 +0000
Message-ID: <CAFEAcA_jtRZdDhOtGnL3aK6WGfBwTyq_QLKVWvGrXf9Wv5LuYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 10/14] usb: Add basic code to emulate
 Chipidea USB IP
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

On 16 January 2018 at 01:37, Andrey Smirnov <andrew.smirnov@gmail.com> wrot=
e:
> Add code to emulate Chipidea USB IP (used in i.MX SoCs). Tested to
> work against:
>
> -usb -drive if=3Dnone,id=3Dstick,file=3Dusb.img,format=3Draw -device \
>  usb-storage,bus=3Dusb-bus.0,drive=3Dstick
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---

This looked a little odd at first but I see it's how we're
implementing TYPE_FUSBH200_EHCI, so I guess it's ok.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
