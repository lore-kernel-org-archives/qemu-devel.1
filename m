Received: from eggs.gnu.org ([2001:4830:134:3::10]:58130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebSQe-0005p9-RC
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebSQe-0008C4-6L
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:41:32 -0500
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:46745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebSQe-0008Bq-18
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:41:32 -0500
Received: by mail-oi0-x230.google.com with SMTP id d124so10731778oib.13
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:41:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b085a18b-84f4-6695-f664-c146ece47eee@amsat.org>
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<20180116013709.13830-12-andrew.smirnov@gmail.com>
	<b085a18b-84f4-6695-f664-c146ece47eee@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 14:41:10 +0000
Message-ID: <CAFEAcA8xN1d-oX2RDqg8go1S6396w6-W46+0TF2d_d3k+cOP7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 11/14] ARM: Add basic code to emulate
 A7MPCore DAP block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 16 January 2018 at 04:32, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> You can just use add this in fsl_imx7_realize():
>
>   create_unimplemented_device("a7mpcore-dap-container",
>                               FSL_IMX7_A7MPCORE_DAP_ADDR,
>                               0x100000);
>
> to register a background region for the DAP (see "hw/misc/unimp.h")
>
> as a bonus, running with "-d unimp" you can trace the DAP access.
>
> So this model and those files are not necessary.

Yes, I think this is the best approach.

thanks
-- PMM
