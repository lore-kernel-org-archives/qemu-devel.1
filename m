Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA6FC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A5224650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=xcancerberox.com.ar header.i=@xcancerberox.com.ar header.b="wWMVqiEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A5224650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xcancerberox.com.ar
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5CuE-0000Rp-JN
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 13:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <me@xcancerberox.com.ar>) id 1j5Ct8-0008P9-Pe
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <me@xcancerberox.com.ar>) id 1j5Ct7-00020N-Jy
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:18:58 -0500
Received: from [51.158.76.159] (port=43480 helo=mail.xcancerberox.com.ar)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <me@xcancerberox.com.ar>) id 1j5Ct7-0001zp-BS
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:18:57 -0500
Subject: Re: [GSoC/Outreachy] Arduino complete setup visualization and
 emulation
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xcancerberox.com.ar;
 s=mail; t=1582309132;
 bh=E9jh43Pct6GuiVsok+BzajKB4Unwrkw6hWjhYkTVz9Q=;
 h=Subject:To:Cc:References:From:In-Reply-To;
 b=wWMVqiEa7pEsLLHDh4t00XFg+c/fE3w9GvbilzsskqQXG2Y9zjHQrnbac3G3Q8VQK
 Vb0CDVdeYHYS/bHU6w8jlPagzt7SGWVRIL31tkGuHmw4IA4Nrz8QV1k4S9BQ47w7r1
 OADENrbWnTRZb9vu4ZuJPDoD0yd13VLnEzZ8cifUvFdtPGmjr2/lfWuohz2UbzsPXo
 yy/ZgmI+GwiLRFTAJtvhZswiymIJV1IbVdiT9nXLdCVlOup8K2zR1A4WdC7oraMfpz
 9P+QusF4CuUFDlCHijoLl/vyE1EvmUi5wDOhqpInZcMsqUSY1uc/13fcFYTKOaqrjZ
 EfyrJaI9dHjsA==
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <CAAdtpL524K2QFSU9ZK2zbW_EJyiDPJ=efhwRWVzCpsJUP6HioA@mail.gmail.com>
 <20200211105119.GA422372@stefanha-x1.localdomain>
 <20200221105620.GD1484511@stefanha-x1.localdomain>
 <675f0951-7f47-ada3-e30d-4f8b2416253c@redhat.com>
From: Joaquin de Andres <me@xcancerberox.com.ar>
Autocrypt: addr=me@xcancerberox.com.ar; keydata=
 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
 OZRo+ULKJ1xXuVGe8hnP9Q==
Message-ID: <d258dbd0-4c2c-8c62-c8d6-335e43638f6a@xcancerberox.com.ar>
Date: Fri, 21 Feb 2020 19:18:51 +0100
Mime-Version: 1.0
In-Reply-To: <675f0951-7f47-ada3-e30d-4f8b2416253c@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 51.158.76.159
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
 Markus Armbruster <armbru@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/21/20 12:14 PM, Philippe Mathieu-Daud=E9 wrote:
> On 2/21/20 11:56 AM, Stefan Hajnoczi wrote:
>> On Tue, Feb 11, 2020 at 10:51:19AM +0000, Stefan Hajnoczi wrote:
>>> On Mon, Feb 10, 2020 at 08:58:28PM +0100, Philippe Mathieu-Daud=E9 wr=
ote:
...
> [*] Test with the preset arduino examples (### TODO add references ###)
>=20
> - Basic: "Blink: Turn a LED on and off."
> - Analog: "Fading: Use an analog output (PWM pin) to dim a LED."
> - Analog: "Analog Input: Use a potentiometer to control the flashing
> =A0 of a LED."
>=20

[*] Test with the preset Arduino examples [0]

- Basic: "Blink: Turn a LED on and off." [1]
- Analog: "Fading: Use an analog output (PWM pin) to dim a LED." [2]
- Analog: "Analog Input: Use a potentiometer to control the blinking
  of a LED." [3]

[0] https://www.arduino.cc/en/Tutorial/BuiltInExamples
[1] https://www.arduino.cc/en/Tutorial/Blink
[2] https://www.arduino.cc/en/Tutorial/Fading
[3] https://www.arduino.cc/en/Tutorial/AnalogInput

--Joa

