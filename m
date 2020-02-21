Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAB4C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC20207FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWInEruD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC20207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j56Gx-00082t-Qs
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 06:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j56GO-0007be-As
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:14:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j56GL-0003yi-U0
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:14:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21762
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j56GL-0003xo-Ok
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582283668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ECHrBDrgffJL9SDlmfIGpM3cwBRji4pyRv2dVyqmDd0=;
 b=DWInEruD7GC+Yw5HnaGYoIFCU1F+HWv5B7b2O2J94TI0kI0yx0Uzg6QT174YN+5VoOY8UY
 enScDpJCOcWg/VqL9wIOpk3TJdg+bkvn7OHfwN/tsuSTcg1GhwL5F9d0rh+8EnU4UTKScJ
 348G/k1Cpvw9/VqnGINAizLJEBtTKTg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-wOgE__K5OLuvA7U--8seKg-1; Fri, 21 Feb 2020 06:14:22 -0500
X-MC-Unique: wOgE__K5OLuvA7U--8seKg-1
Received: by mail-wr1-f71.google.com with SMTP id u8so875744wrp.10
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 03:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/U1Z1edV7HX8PTwGJhVD4S41faa+cVOWVbOj9ojg11E=;
 b=fqHRC4cVfJ5V7dHRz94nr4MUks/dBKfNrH0yoFGQNGYM2TDK6Z20bGx9hv1Rj4/Z5g
 zGIIZuX/bGfCnz82DU75hHDHC5F+U3PxLh45qVQBSDln0SnsmfBBSjiclTNm/cw0IMkz
 ojtarNXdz5ENK5lmMthylGPZLny1nL06y9YhjPpnVOep8rLgmdN7u3X3C+nqiRcYbrd4
 09qTrN9khbvLQ2Ah3bMg43s5n2S4fXld9L7QNapAL8JGd3XRW02Wx0LTqLVqwuqsqXj9
 ZtvKTAY1IsgeAK+JgYbegl5mT/CqSR+uBzyzi0sCCzjTX8y07DcdsZ9dd2geAVsbL3IE
 cPyA==
X-Gm-Message-State: APjAAAXIOnPJc4KlTnoTsQkMkTBTxA+Xe8Uej3d1Cfj8fUriwJhKLhmU
 hQqlGO+b8Jn0A4OfYGRIlM3JPNoaa/DuPb2mJ87ufi+oa4Z259bweB7zGCNMK89sALBKmTvdLWT
 Xrj3lVMrsIhvnLYc=
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr3324950wmk.65.1582283660736; 
 Fri, 21 Feb 2020 03:14:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqyaO312KxB/e4xt4DhK3bwAOZiDJChq8esLk2X+iaIOWeTFmwihKp8jnrosaXocl3TxUiBWtg==
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr3324905wmk.65.1582283660373; 
 Fri, 21 Feb 2020 03:14:20 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id s8sm3726277wrt.57.2020.02.21.03.14.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 03:14:19 -0800 (PST)
Subject: Re: [GSoC/Outreachy] Arduino complete setup visualization and
 emulation
To: Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>
References: <CAAdtpL524K2QFSU9ZK2zbW_EJyiDPJ=efhwRWVzCpsJUP6HioA@mail.gmail.com>
 <20200211105119.GA422372@stefanha-x1.localdomain>
 <20200221105620.GD1484511@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <675f0951-7f47-ada3-e30d-4f8b2416253c@redhat.com>
Date: Fri, 21 Feb 2020 12:14:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221105620.GD1484511@stefanha-x1.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/21/20 11:56 AM, Stefan Hajnoczi wrote:
> On Tue, Feb 11, 2020 at 10:51:19AM +0000, Stefan Hajnoczi wrote:
>> On Mon, Feb 10, 2020 at 08:58:28PM +0100, Philippe Mathieu-Daud=E9 wrote=
:
>=20
> Ping?
>=20
> QEMU has been accepted as a mentoring organization.  Please post a final
> version of this project idea on the wiki:
>=20
>    https://wiki.qemu.org/Google_Summer_of_Code_2020

I apologize, quickly after we chat on IRC about this last week I did the=20
modifications but forgot to reply to this thread.

There is the project description with 1 FIXME and 2 TODO (add the=20
references), we will update the wiki tomorrow:

---

[*] Goal

Be able to use a visual virtual Arduino board, and program it with
the Arduino IDE. The result should be easily usable by newcomers to
the Arduino world.

[*] Summary

The project will add a visual representation of an Arduino board.

By running the code on the emulated AVR processor, the virtual board is
updated and displays the changes. Interracting with the code via external
events (sensors) triggers changes on the UI.

[*] Materials provided

- a specific circuit configuration represented as a netlist.
- preset Arduino tests compliant with QEMU limitations
- QMP commands documentation

[*] Essential skills required

- Fluent in C
- Comfortable programming in Python
- Knowledge of Javascript might be useful (Java will *not* be used).
- Working knowledge with User Interfaces

* Electrical engineering background is not essential


[*] Deliverables

- IDE Integration
   Configure QEMU with the Arduino IDE (using chardev UART0).
   Compile program and upload via serial.
   The IDE doesn't need modifications.

- UI (Python)
   Connect UART1 (via QMP or chardev), display as textbox
   (input is not important at this point).

- QEMU: GPIO
   Produce a script to extract the GPIO devices from the netlist.
   Configure QEMU devices to use the previous names/values.
   Publish GPIO events (name as a string and tension as float) via
   a QMP socket (JSON form?).
   Write a test which runs FreeRTOS to generate a stable output.

- UI (Python)
   Connect to the QMP socket and display the GPIO events.
   Now GPIOs are connected to LEDs. Present graphical LEDs as ON/OFF.
   Add an oscilloscope representation (matplotlib widget). Each GPIO
   can be plugged into the oscilloscope channels.
   Add Switches and PushButtons to the UI, generating QMP events which
   trigger GPIO input.
   Add a push button to reset the Arduino (already on board) signaling to
   the core, and[to] switch for[to] general power (for QEMU shutdown and=20
start).
   ### FIXME check with Joaquin ###

- QEMU: PWM
   Modify script to extract PWM devices used from the netlist.
   Configure QEMU devices to use the previous names/values.
   Use QEMU sound API to generate a stream of PWM values (as a wav).
   Add a QMP command to lookup the PWM wav stream.
   Write a FreeRTOS test producing a sinusoidal via PWM, verify the
   wav form.

- UI (Python)
   Lookup the wav stream via the QMP socket, connect to it, display
   it on the oscilloscope view.
   Add a graphical representation of the LED intensity.

- QEMU: ADC
   Modify the script to extract the ADC devices from the netlist.
   Similarly to PWM, use the sound wav stream to read ADC samples.

- UI: Python
   Add a textbox to set the ambient temperature (a thermometer is
   connected to some ADC pins).
   Use a slider to set the tension sampled by the ADC (like if it
   was a potentiometer).

[*] Test with the preset arduino examples (### TODO add references ###)

- Basic: "Blink: Turn a LED on and off."
- Analog: "Fading: Use an analog output (PWM pin) to dim a LED."
- Analog: "Analog Input: Use a potentiometer to control the flashing
   of a LED."

Additional tasks are available for applicants who completes the project.

[References]


[*] Prerequisites:

- AVR port and Arduino machines merged upstream
- AVR flash device working (for firmware upload via IDE)


Co-mentor: Philippe Mathieu-Daud=E9 <address@hidden>
Co-mentor: Joaqu=EDn De Andres <address@hidden>


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
|    +----v-----------------------------+---+            ---\
|    |        LED LED LED LED DIPSW         |               |
|    | +---+                          +---+ |               |
|    | |osc|    +-----------------+   |osc| |               |
|    | +---+    |                 |   +---+ |               |
|    | +---+    |                 |   +---+ |               |
|    | |osc|    |  Arduino board  |   |osc| |               |
|    | +---+    |                 |   +---+ |               | Virtual Board
|    | +---+    |                 |   +---+ |               |    (UI)
|    | |osc|    +-----------------+   |osc| |               |
+----> +---+                          +---+ |               |
      |       POT POT 7LED PWM PWM PWM       |               |
      +--------------------------------------+               |
      |                                      |               |
      |          Serial console              |               |
      +--------------------------------------+            ---/


[*] Additional tasks (saved on list)

- QEMU: Other communication protocols
   Modify the script to extract the RTC pin names (via I2C) and the SD card
   pin names (via SPI) from the netlist. ### TODO upload the netlist ###

- QEMU: Match physical electrical characteristics

   Model the VOL/VOH/VIL/VIH ranges, and consider to mark an input
   as dead if the provided value is out of range (smoke on the UI!)

- QEMU: Connect 2 virtual Arduinos and ensure they are communicating
   successfully with each other.

- UI (Python)

   Add graphical displays (Seven-Segment, SSD1306 128=D732, Nokia 5110
   Graphic LCD).

- Propose additional tests (Use of RTC, SD card, LCD, ...).

---


