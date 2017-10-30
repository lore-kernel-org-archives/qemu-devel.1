Received: from eggs.gnu.org ([2001:4830:134:3::10]:35649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e96qX-0006nM-QI
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e96qX-0003L6-6U
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:59:05 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:45330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e96qX-0003K9-00
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:59:05 -0400
Received: by mail-wm0-x230.google.com with SMTP id y80so7777155wmd.0
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 02:59:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508898544-10307-1-git-send-email-sundeep.lkml@gmail.com>
References: <1508898544-10307-1-git-send-email-sundeep.lkml@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Oct 2017 09:58:43 +0000
Message-ID: <CAFEAcA8yX6QKngPT8sbssDo+UOsH9cyCshrXigMkwTk2uoNWmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu devel V4 PATCH] msf2: Remove dead code
 reported by Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair23@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, darren.kenny@oracle.com

On 25 October 2017 at 03:29, Subbaraya Sundeep <sundeep.lkml@gmail.com> wrote:
> Fixed incorrect frame size mask, validated maximum frame
> size in spi_write and removed dead code.
>
> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> ---
> v4:
>         changed %d to %u while logging frame size error.
> v3:
>         Added comment that [31:6] bits are reserved in R_SPI_DFSIZE
>         register and logged incorrect value too in guest error(suggested
>         by Darren).
> v2:
>         else if -> else in set_fifodepth
>         log guest error when frame size is more than 32
>
>  hw/ssi/mss-spi.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>



Applied to target-arm.next, thanks.

-- PMM
