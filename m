Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910CBC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 20:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7EF20838
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 20:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7EF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1FEE-0005lc-BY
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 15:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j1FCd-0004QL-UH
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j1FCb-0006Nj-R5
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:58:43 -0500
Received: from mail-yb1-f179.google.com ([209.85.219.179]:35502)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j1FCb-0006KN-Kw
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:58:41 -0500
Received: by mail-yb1-f179.google.com with SMTP id p123so3358065ybp.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 11:58:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=v/x9fWvJ4HdP2BeBpoPZhRMJW6D9oAtPYIccvkIKRMo=;
 b=Mk8noi0aTn8m6d9qIeI7TJD8xn7xlfFZ+4HWoeMkKWLdJOztYEjeD0RbP3Mm0k+Eij
 B1ztHp3OU4xliNUbQq6qYCSsWYcoFomvCgJ3rJz8yw4Aizo8/o8vK14JxFn+9iak0K6F
 E4CjkAlrRl6lZWF30Rrow8yKDy7omRVjFMCxN9t5s+5OGY3xixqCs6WScsGURJ/YToU6
 f1b4LJdHRjwWfPx8NdcbWrYIO9JZD/SllHWbfGC0xGEj4zg2KrAiDazDri4kmADMDitA
 g5SzrswDbfUcheWN1TKWiFiVPQ23uczBn0zHWbZhwaT85fxKIOXI3f+k2DqnX9FmFnBG
 QxYA==
X-Gm-Message-State: APjAAAVKAL/2ge71WUD+S1EzrlaamlChmaynOSYm1ri6TJlJp+bQgh+I
 q60BALprO3QIJ2q1RKC9TMkATUw6NEnqiQl3HTU6xQmtP7g=
X-Google-Smtp-Source: APXvYqwwkN/QC805fkQfi8L+wAcWMFW8CabXj1F/pGZDamjDaDqLD+nb2p88vko8q3INfic1qAKCPBPAV5ZM4/hVP70=
X-Received: by 2002:a25:7605:: with SMTP id r5mr2656329ybc.323.1581364719534; 
 Mon, 10 Feb 2020 11:58:39 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 10 Feb 2020 20:58:28 +0100
Message-ID: <CAAdtpL524K2QFSU9ZK2zbW_EJyiDPJ=efhwRWVzCpsJUP6HioA@mail.gmail.com>
Subject: [GSoC/Outreachy] Arduino complete setup visualization and emulation
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.219.179
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[*] Goal:

Be able to use a visual virtual arduino board, and program it with
the Arduino IDE. The result should be easily usable by newcomers to
the Arduino world.

[*] Prerequisite:

- AVR port and Arduino machines merged upstream
- AVR flash device working (for firmware upload via IDE)

This works applies to a specific circuit configuration represented as
a netlist.

[*] Deliverables

- IDE Integration
  Configure QEMU with the Arduino IDE (using chardev UART0).
  Compile program and upload via serial.

- UI: Python:
  Connect UART1 (via QMP or chardev), display as textbox
  (input is not important at this point).

- QEMU: GPIO
  Produce script to extract GPIO devices used from the netlist.
  Configure QEMU devices to use the previous names/values.
  Publish GPIO events (name, tension as float) via a QMP socket
  (JSON form?).
  Write test which runs FreeRTOS test to generates a stable output.

- UI interface (Python)
  Connect to the QMP socket and display the GPIO events.
  Now GPIOs are connected to LEDs. Represent graphical LEDS as ON/OFF.
  Add an oscilloscope representation (matplotlib widget). Each GPIO
  can be plugged into the oscilloscope channels.
  Add Switch and PushButton to the UI, generating QMP events which
  trigger GPIO input.
  Add push button for arduino reset (already on board) signaling the
  core, and switch for general power (for QEMU shutdown and start).

- Test with the arduino examples
  Basic: "Blink: Turn an LED on and off."

- QEMU: PWM
  Modify script to extract PWM devices used from the netlist.
  Configure QEMU devices to use the previous names/values.
  Use QEMU sound API to generate a stream of PWM values (as a wav).
  Add a QMP command to lookup the PWM wav stream.
  Write a FreeRTOS test producing a sinusoidal via PWM, verify the
  wav form.

- UI interface (Python)
  Lookup wav stream via QMP socket, connect to it, display to
  oscilloscope view.
  Add graphical representation of the LED intensity to the LED.

- Test with the arduino examples
  Analog: "Fading: Use an analog output (PWM pin) to fade an LED."

- QEMU: ADC
  Modify script to extract ADC devices used from the netlist.
  Similarly to the PWM, use sound wav stream to read ADC samples.

- UI: Python
  Add a textbox to set the ambient temperature (A thermometer is
  connected to some ADC pin).
  Use slider to set the tension sampled by the ADC (as a potentiometer)

- Test with the arduino examples
  Analog: "Analog Input: Use a potentiometer to control the blinking
  of an LED."

- QEMU: Other communication protocols
  Modify script to extract RTC (via I2C) and SD card (via SPI) from
  the netlist.

- Propose examples to Arduino IDE for these use cases.

- QEMU: Match physical electrical characteristics (extra)
  Use imprecise VOL/VOH output
  Check input within VIL/VIH range
  Mark input dead when out of range

- Extra (fun):
  Connect 2 QEMU Arduino interacting with each other

- UI: Python (extra++):
  Add Seven-Segment Display
  Add SSD1306 128=C3=9732 display controller or Nokia 5110 Graphic LCD
  Propose examples to Arduino IDE for these use cases.


Co-mentor: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Co-mentor: Joaqu=C3=ADn De Andres <me@xcancerberox.com.ar>


Reference Schema:

           +-----+---------------------+
           |     |                     |
           |     |                     |
           |     |                     |
           |     |    Arduino IDE      |
           |     |                     |
           |     |                     |
           |     +---------------------+
           |     |                     |
           |     |                     |
           +-----+------------------+--+
                                    |
                                    |console
              +------------------+  |chardev
              |                  |  |
              |                  <--+
              |       QEMU       |
  PWM stream  |                  |
+-------------+     AVR core     |
|             |                  |
|         +---+                  <------+
|         |   |                  |      |JSON
|    JSON |   +------------------+      |event
|    event|                             | I/O
|     I/O |                             |
|         |                             |
|    +----v-----------------------------+---+
|    |        LED LED LED LED DIPSW         |
|    | +---+                          +---+ |
|    | |osc|    +-----------------+   |osc| |
|    | +---+    |                 |   +---+ |
|    | +---+    |                 |   +---+ |
|    | |osc|    |   Arduino board |   |osc| |
|    | +---+    |                 |   +---+ |
|    | +---+    |                 |   +---+ |
|    | |osc|    +-----------------+   |osc| |
+----> +---+                          +---+ |
     |       POT POT 7LED PWM PWM PWM       |
     +--------------------------------------+
     |                                      |
     |          Serial console              |
     +--------------------------------------+


D-Bus can be considered too:

      +-----+---------------------+
      |     |                     |
      |     |                     |
      |     |                     |
      |     |    Arduino IDE      |
      |     |                     |
      |     |                     |
      |     +---------------------+
      |     |                     |
      |     |                     |
      +-----+-------------+-------+
                          |
                          |
+-----------------+       |
|                 <-------+
|                 |
|      QEMU       +---------------+
|                 |               |
|    AVR core     |         +-----v------+
|                 +--------->            |
|                 |         |            |
|                 <---------+    DBUS    |
+-----------------+         |            |
                            |            |
                            +--+----^----+
                               |    |
+----v-------------------------v----+--+
|        LED LED LED LED DIPSW         |
| +---+                          +---+ |
| |osc|    +-----------------+   |osc| |
| +---+    |                 |   +---+ |
| +---+    |                 |   +---+ |
| |osc|    |   Arduino board |   |osc| |
| +---+    |                 |   +---+ |
| +---+    |                 |   +---+ |
| |osc|    +-----------------+   |osc| |
> +---+                          +---+ |
|       POT POT 7LED PWM PWM PWM       |
+--------------------------------------+
|                                      |
|          Serial console              |
+--------------------------------------+

