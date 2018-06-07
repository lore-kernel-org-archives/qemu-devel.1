Received: from eggs.gnu.org ([2001:4830:134:3::10]:48128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQsf5-0000h4-R7
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQsf0-0002rd-BK
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:00:59 -0400
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:40055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQsf0-0002r3-63
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:00:54 -0400
Received: by mail-ot0-x22c.google.com with SMTP id w9-v6so5494519otj.7
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 04:00:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180603000827.30872-2-f4bug@amsat.org>
References: <20180603000827.30872-1-f4bug@amsat.org>
	<20180603000827.30872-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Jun 2018 12:00:32 +0100
Message-ID: <CAFEAcA_EDXyOHpdamg05=p35jazqgZsLKP2O+G1tg6BoR4b28g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/8] sdcard: Update the Configuration
 Register (SCR) to Spec Version 1.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 3 June 2018 at 01:08, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> This register now matches the description of the header:
>
>  * SD Memory Card emulation as defined in the "SD Memory Card Physical
>  * layer specification, Version 1.10."

Can you provide a brief justification in the commit message
of why it makes more sense for us to advertise as 1.10, please?

(eg a summary of the 1.01 to 1.10 differences and a note
that we already implement them)

thanks
-- PMM
