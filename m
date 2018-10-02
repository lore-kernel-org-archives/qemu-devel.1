Received: from eggs.gnu.org ([2001:4830:134:3::10]:46333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1g7MxT-0005na-Vf
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1g7MxQ-0007mo-2o
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:51:34 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:46745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1g7MxO-0007lP-33
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:51:31 -0400
Received: by mail-io1-xd43.google.com with SMTP id t7-v6so2441831ioj.13
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 08:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-11-f4bug@amsat.org>
	<CAFEAcA_BUP5=nYoGii85Vv3=-B=_uKO5XXk2UzH2PWkxvu=aLw@mail.gmail.com>
In-Reply-To: <CAFEAcA_BUP5=nYoGii85Vv3=-B=_uKO5XXk2UzH2PWkxvu=aLw@mail.gmail.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 2 Oct 2018 17:50:59 +0200
Message-ID: <CACXAS8DewRG36K9yNynsdeLdyQbP84NYtq4AOtmtF8FW503qDg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, clg@kaod.org, qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Tue, Oct 2, 2018 at 3:24 PM Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> On 1 October 2018 at 23:09, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> > The TYPE_EMPTY_SLOT and TYPE_UNIMPLEMENTED_DEVICE are identical devices=
,
> > however the later use more recent APIs and is more widely used.
> >
> > Replace 'empty_slot' by 'unimplemented_device' to simplify devices code
> > maintenance.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
>
> > @@ -161,7 +161,7 @@ static void niagara_init(MachineState *machine)
> >          serial_mm_init(sysmem, NIAGARA_UART_BASE, 0, NULL, 115200,
> >                         serial_hd(0), DEVICE_BIG_ENDIAN);
> >      }
> > -    empty_slot_init(NIAGARA_IOBBASE, NIAGARA_IOBSIZE);
> > +    create_unimplemented_device("sun4v-iob", NIAGARA_IOBBASE, NIAGARA_=
IOBSIZE);
> >      sun4v_rtc_init(NIAGARA_RTC_BASE);
> >  }
>
> Is this actually an unimplemented (missing) device, or are we
> implementing hardware-defined "no bus errors when this range is
> touched" behaviour ?

In this case it's really an unimplemented device. But in sun4m (patch
11/15) it's
"no bus errors when this range is touched" behaviour.

Artyom

--
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu
