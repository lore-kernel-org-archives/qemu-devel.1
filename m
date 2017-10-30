Received: from eggs.gnu.org ([2001:4830:134:3::10]:36216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e96st-00083L-3r
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 06:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e96sn-0004zM-Jf
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 06:01:31 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:46539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e96sn-0004z0-Ct
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 06:01:25 -0400
Received: by mail-wm0-x242.google.com with SMTP id m72so14648201wmc.1
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 03:01:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1509253165-7434-1-git-send-email-sundeep.lkml@gmail.com>
References: <1509253165-7434-1-git-send-email-sundeep.lkml@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Oct 2017 10:01:03 +0000
Message-ID: <CAFEAcA8h4g6Jif-03yBeNikPaVLFYraLaiSGgcoB7GTmsLeKVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu devel PATCH] msf2: Wire up SYSRESETREQ in
 SoC for system reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair23@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 29 October 2017 at 04:59, Subbaraya Sundeep <sundeep.lkml@gmail.com> wrote:
> Implemented system reset by creating SYSRESETREQ gpio
> out from nvic.
>
> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> ---
>  hw/arm/msf2-soc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>



Applied to target-arm.next, thanks.

-- PMM
