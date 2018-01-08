Received: from eggs.gnu.org ([2001:4830:134:3::10]:49879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYXxH-0005Gm-1W
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 08:59:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYXxG-0002p5-7F
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 08:59:11 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:37212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYXxG-0002od-1T
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 08:59:10 -0500
Received: by mail-ot0-x232.google.com with SMTP id p31so9272881ota.4
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 05:59:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180102193622.27215-5-andrew.smirnov@gmail.com>
References: <20180102193622.27215-1-andrew.smirnov@gmail.com>
	<20180102193622.27215-5-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 13:58:48 +0000
Message-ID: <CAFEAcA9aHoR84nhGZwLfHht+_7UKBC+AovOyLwzc-2CsiZSmLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/11] imx_fec: Move Tx frame buffer
 away from the stack
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
> Make Tx frame assembly buffer to be a paort of IMXFECState structure
> to avoid a concern about having large data buffer on the stack.
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
