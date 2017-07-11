Received: from eggs.gnu.org ([2001:4830:134:3::10]:37178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUuf9-0004vR-4F
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUuf6-0000o1-0y
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:53:11 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:34626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUuf5-0000nr-Qq
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:53:07 -0400
Received: by mail-wr0-f177.google.com with SMTP id 77so182180932wrb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 05:53:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <149977720815.27.5500531494767534688@5d477a5b5989>
References: <1499771839-32518-1-git-send-email-peter.maydell@linaro.org>
	<149977720815.27.5500531494767534688@5d477a5b5989>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 13:51:46 +0100
Message-ID: <CAFEAcA8MC3goto_HyKQ1wHbg6H-Ly+rscuw-qOvPM3t4qde=Lg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/7] ARM: implement MPS2 board (with 2 FPGA
 flavours)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Fam Zheng <famz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 11 July 2017 at 13:46,  <no-reply@patchew.org> wrote:
> /var/tmp/patchew-tester-tmp-e38by36j/src/hw/char/cmsdk-apb-uart.c: In fun=
ction =E2=80=98uart_read=E2=80=99:
> /var/tmp/patchew-tester-tmp-e38by36j/src/hw/char/cmsdk-apb-uart.c:164:20:=
 error: array subscript is above array bounds [-Werror=3Darray-bounds]
>          r =3D uart_id[offset / 4 - A_PID4];
>              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> /var/tmp/patchew-tester-tmp-e38by36j/src/rules.mak:66: recipe for target =
'hw/char/cmsdk-apb-uart.o' failed
> make: *** [hw/char/cmsdk-apb-uart.o] Error 1
> make: *** Waiting for unfinished jobs....

The compiler is correct here -- should be (offset - A_PID4) / 4,
since the A_* values are the register offsets and all multiples of 4.

thanks
-- PMM
