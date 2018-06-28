Received: from eggs.gnu.org ([2001:4830:134:3::10]:58702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYaUW-0002Wt-DE
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYaUV-0001Jn-Hi
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:13:56 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:35826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYaUV-0001IO-DD
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:13:55 -0400
Received: by mail-ot0-x242.google.com with SMTP id j8-v6so4200182otl.2
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 10:13:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180509034658.26455-2-f4bug@amsat.org>
References: <20180509034658.26455-1-f4bug@amsat.org>
	<20180509034658.26455-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 18:13:34 +0100
Message-ID: <CAFEAcA-7xnkKYKP0YeY5GFuaknVpaUSiCaFiyUGQJOuRSgm05A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/14] sdcard: Use the ldst API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair@alistair23.me>, Michael Walle <michael@walle.cc>, "open list:ARM PrimeCell and..." <qemu-arm@nongnu.org>

On 9 May 2018 at 04:46, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote=
:
> The load/store API will ease further code movement.
>
> Per the Physical Layer Simplified Spec. "3.6 Bus Protocol":
>
>   "In the CMD line the Most Significant Bit (MSB) is transmitted
>    first, the Least Significant Bit (LSB) is the last."
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

This is a nice cleanup so I'm just going to fish this patch
out of the series and apply it to target-arm.next.

thanks
-- PMM
