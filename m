Received: from eggs.gnu.org ([2001:4830:134:3::10]:52989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7KfR-0007nh-LV
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7KfQ-0007Qz-Ui
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:24:49 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7KfQ-0007Qt-NS
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:24:48 -0400
Received: by mail-oi1-x243.google.com with SMTP id y81-v6so1467144oia.6
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 06:24:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181001220942.2382-11-f4bug@amsat.org>
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-11-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 14:24:27 +0100
Message-ID: <CAFEAcA_BUP5=nYoGii85Vv3=-B=_uKO5XXk2UzH2PWkxvu=aLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/15] hw/sparc64/niagara: Replace
 'empty_slot' by 'unimplemented_device'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 1 October 2018 at 23:09, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> The TYPE_EMPTY_SLOT and TYPE_UNIMPLEMENTED_DEVICE are identical devices,
> however the later use more recent APIs and is more widely used.
>
> Replace 'empty_slot' by 'unimplemented_device' to simplify devices code
> maintenance.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

> @@ -161,7 +161,7 @@ static void niagara_init(MachineState *machine)
>          serial_mm_init(sysmem, NIAGARA_UART_BASE, 0, NULL, 115200,
>                         serial_hd(0), DEVICE_BIG_ENDIAN);
>      }
> -    empty_slot_init(NIAGARA_IOBBASE, NIAGARA_IOBSIZE);
> +    create_unimplemented_device("sun4v-iob", NIAGARA_IOBBASE, NIAGARA_IO=
BSIZE);
>      sun4v_rtc_init(NIAGARA_RTC_BASE);
>  }

Is this actually an unimplemented (missing) device, or are we
implementing hardware-defined "no bus errors when this range is
touched" behaviour ?

thanks
-- PMM
