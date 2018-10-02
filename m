Received: from eggs.gnu.org ([2001:4830:134:3::10]:50130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7KRm-0000kf-Dm
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7KRk-0002PV-Mq
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:10:42 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:32784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7KRk-0002PI-GI
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:10:40 -0400
Received: by mail-oi1-x241.google.com with SMTP id a203-v6so1449143oib.0
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 06:10:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181001220942.2382-2-f4bug@amsat.org>
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 14:10:18 +0100
Message-ID: <CAFEAcA-+sNGuvMjvTiLKu=qPLmhPrSinEBaNEDKiNvHqeGSGKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/15] trace-events: Fix copy/paste typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On 1 October 2018 at 23:09, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> Missed while reviewing 5dd85b4b486.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/timer/trace-events | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index fa4213df5b..ca9ad6321a 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -56,7 +56,7 @@ systick_timer_tick(void) "systick reload"
>  systick_read(uint64_t addr, uint32_t value, unsigned size) "systick read=
 addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
>  systick_write(uint64_t addr, uint32_t value, unsigned size) "systick wri=
te addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
>
> -# hw/char/cmsdk_apb_timer.c
> +# hw/timer/cmsdk_apb_timer.c
>  cmsdk_apb_timer_read(uint64_t offset, uint64_t data, unsigned size) "CMS=
DK APB timer read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>  cmsdk_apb_timer_write(uint64_t offset, uint64_t data, unsigned size) "CM=
SDK APB timer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>  cmsdk_apb_timer_reset(void) "CMSDK APB timer: reset"
> --
> 2.19.0

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I think I saw this in the trace file before going on holiday
and then forgot to send out a fix; thanks for the patch.

thanks
-- PMM
