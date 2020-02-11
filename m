Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B7CC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 10:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0089F20842
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 10:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbHWceKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0089F20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1TBF-0005oG-7g
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 05:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j1T8f-0002xW-9G
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:51:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j1T8c-0001df-7E
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:51:32 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33319
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j1T8b-0001cn-Ch
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581418288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jlw1aLTcQNPnBOMBKQVdm7QJJraLofd8766nbPbzgRU=;
 b=KbHWceKv41r5eVjRK4hIafLUCe4fup2KTcnYXLd9wQvuzeuQrh7khecuCzUq0mm4ZAsZE0
 9MZbFVmBp+ZUwnqVP4sdk5f+Ad0Ag8zfOP1OPGwEfgtvecn/Z2tBK3gi5HjcksO1OHz9+v
 kadJmLdlrJRU6/d4fjfTuQtGjqGytz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-MRnuaxaNPKSI1Q7iG2YFWw-1; Tue, 11 Feb 2020 05:51:25 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9724107ACCA;
 Tue, 11 Feb 2020 10:51:23 +0000 (UTC)
Received: from localhost (unknown [10.36.118.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 434F28EA1A;
 Tue, 11 Feb 2020 10:51:20 +0000 (UTC)
Date: Tue, 11 Feb 2020 10:51:19 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [GSoC/Outreachy] Arduino complete setup visualization and
 emulation
Message-ID: <20200211105119.GA422372@stefanha-x1.localdomain>
References: <CAAdtpL524K2QFSU9ZK2zbW_EJyiDPJ=efhwRWVzCpsJUP6HioA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAdtpL524K2QFSU9ZK2zbW_EJyiDPJ=efhwRWVzCpsJUP6HioA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: MRnuaxaNPKSI1Q7iG2YFWw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 10, 2020 at 08:58:28PM +0100, Philippe Mathieu-Daud=E9 wrote:

Cool, thanks for proposing this idea!

> [*] Goal:
>=20
> Be able to use a visual virtual arduino board, and program it with
> the Arduino IDE. The result should be easily usable by newcomers to
> the Arduino world.

Out of curiosity, how does this compare to existing Arduino simulators?

> [*] Prerequisite:
>=20
> - AVR port and Arduino machines merged upstream
> - AVR flash device working (for firmware upload via IDE)

How likely is it that these dependencies will be merged by May 18th
(start of the coding period)?  If they are not merged then the intern
will not be able to get their own patches into qemu.git.

> This works applies to a specific circuit configuration represented as
> a netlist.
>=20
> [*] Deliverables
>=20
> - IDE Integration
>   Configure QEMU with the Arduino IDE (using chardev UART0).

This (https://www.arduino.cc/en/Main/Software) Java program?  Please add
links to relevant code bases, hardware specs, file formats, etc so that
someone considering the project idea can research it.

I also see Python mentioned in this project idea.  Does the intern need
to be fluent in C, Python, and Java?  Please include skill/language
requirements in the text.

>   Compile program and upload via serial.
>=20
> - UI: Python:
>   Connect UART1 (via QMP or chardev), display as textbox
>   (input is not important at this point).
>=20
> - QEMU: GPIO
>   Produce script to extract GPIO devices used from the netlist.
>   Configure QEMU devices to use the previous names/values.
>   Publish GPIO events (name, tension as float) via a QMP socket
>   (JSON form?).
>   Write test which runs FreeRTOS test to generates a stable output.
>=20
> - UI interface (Python)
>   Connect to the QMP socket and display the GPIO events.
>   Now GPIOs are connected to LEDs. Represent graphical LEDS as ON/OFF.
>   Add an oscilloscope representation (matplotlib widget). Each GPIO
>   can be plugged into the oscilloscope channels.
>   Add Switch and PushButton to the UI, generating QMP events which
>   trigger GPIO input.
>   Add push button for arduino reset (already on board) signaling the
>   core, and switch for general power (for QEMU shutdown and start).
>=20
> - Test with the arduino examples
>   Basic: "Blink: Turn an LED on and off."
>=20
> - QEMU: PWM
>   Modify script to extract PWM devices used from the netlist.
>   Configure QEMU devices to use the previous names/values.
>   Use QEMU sound API to generate a stream of PWM values (as a wav).
>   Add a QMP command to lookup the PWM wav stream.
>   Write a FreeRTOS test producing a sinusoidal via PWM, verify the
>   wav form.
>=20
> - UI interface (Python)
>   Lookup wav stream via QMP socket, connect to it, display to
>   oscilloscope view.
>   Add graphical representation of the LED intensity to the LED.
>=20
> - Test with the arduino examples
>   Analog: "Fading: Use an analog output (PWM pin) to fade an LED."

The tasks above could already take 12 weeks.  Especially the new QMP
commands and the UI code could be non-trivial.

I think newcomers will have a hard time designing QMP commands.  It
would help to provide the QMP command documentation so the intern
doesn't need to make design decisions in a space they are unfamiliar
with.

When Steffen G=F6rtz experimented with similar things using the micro:bit
emulation I remember emulation timing issues were a little tricky.
Emitting LED/PWM output and displaying it without timing glitches is
non-trivial since QEMU is not very precise and guest software might be
bit banging.

> - QEMU: ADC
>   Modify script to extract ADC devices used from the netlist.
>   Similarly to the PWM, use sound wav stream to read ADC samples.
>=20
> - UI: Python
>   Add a textbox to set the ambient temperature (A thermometer is
>   connected to some ADC pin).
>   Use slider to set the tension sampled by the ADC (as a potentiometer)
>=20
> - Test with the arduino examples
>   Analog: "Analog Input: Use a potentiometer to control the blinking
>   of an LED."
>=20
> - QEMU: Other communication protocols
>   Modify script to extract RTC (via I2C) and SD card (via SPI) from
>   the netlist.
>=20
> - Propose examples to Arduino IDE for these use cases.
>=20
> - QEMU: Match physical electrical characteristics (extra)
>   Use imprecise VOL/VOH output
>   Check input within VIL/VIH range
>   Mark input dead when out of range
>=20
> - Extra (fun):
>   Connect 2 QEMU Arduino interacting with each other
>=20
> - UI: Python (extra++):
>   Add Seven-Segment Display
>   Add SSD1306 128=D732 display controller or Nokia 5110 Graphic LCD
>   Propose examples to Arduino IDE for these use cases.

The scope of the project seems large for 12 weeks.  It could scare off
applicants or be unrealistic for an intern without lots of experience.
You could remove some tasks from the project idea and if the intern is
really quick then you can always give them additional tasks later.

> Co-mentor: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Co-mentor: Joaqu=EDn De Andres <me@xcancerberox.com.ar>
>=20
>=20
> Reference Schema:
>=20
>            +-----+---------------------+
>            |     |                     |
>            |     |                     |
>            |     |                     |
>            |     |    Arduino IDE      |
>            |     |                     |
>            |     |                     |
>            |     +---------------------+
>            |     |                     |
>            |     |                     |
>            +-----+------------------+--+
>                                     |
>                                     |console
>               +------------------+  |chardev
>               |                  |  |
>               |                  <--+
>               |       QEMU       |
>   PWM stream  |                  |
> +-------------+     AVR core     |
> |             |                  |
> |         +---+                  <------+
> |         |   |                  |      |JSON
> |    JSON |   +------------------+      |event
> |    event|                             | I/O
> |     I/O |                             |
> |         |                             |
> |    +----v-----------------------------+---+
> |    |        LED LED LED LED DIPSW         |
> |    | +---+                          +---+ |
> |    | |osc|    +-----------------+   |osc| |
> |    | +---+    |                 |   +---+ |
> |    | +---+    |                 |   +---+ |
> |    | |osc|    |   Arduino board |   |osc| |
> |    | +---+    |                 |   +---+ |
> |    | +---+    |                 |   +---+ |
> |    | |osc|    +-----------------+   |osc| |
> +----> +---+                          +---+ |
>      |       POT POT 7LED PWM PWM PWM       |
>      +--------------------------------------+
>      |                                      |
>      |          Serial console              |
>      +--------------------------------------+

"Arduino IDE" and "QEMU" are clear.  Is the "Arduino board" component
the Python UI application?


