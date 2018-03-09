Received: from eggs.gnu.org ([2001:4830:134:3::10]:46611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euLVp-0001R0-B0
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euLVo-0003yt-EY
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:08:57 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:42740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euLVo-0003yU-9M
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:08:56 -0500
Received: by mail-ot0-x22a.google.com with SMTP id l5so9277106otf.9
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 09:08:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180309153654.13518-1-f4bug@amsat.org>
References: <20180309153654.13518-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 17:08:35 +0000
Message-ID: <CAFEAcA-RQT8a6tJ9Radqt3_n=cP6FhyNcjNfJa6VyN=jtS_GZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/8] SDCard: improve tracing, support UHS-I
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair@alistair23.me>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>

On 9 March 2018 at 15:36, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> This series contains the leftover patches from these 2 series:
> - SDCard: housekeeping, add tracing (part 4)
> - SDCard: bugfixes, support UHS-I (part 5)
> with Peter Maydell comments addressed.
>
> I misunderstood the 2.12 train deadline, but better to have the series
> standing in the list rather than forgot it.
>
> Philippe Mathieu-Daud=C3=A9 (8):
>   sdcard: Do not trace CMD55, except when we already expect an ACMD
>   sdcard: Display command name when tracing CMD/ACMD
>   sdcard: Display which protocol is used when tracing (SD or SPI)
>   sdcard: Add the Tuning Command (CMD19)
>   sdcard: Implement the UHS-I SWITCH_FUNCTION entries (Spec v3)
>   sdcard: Add a 'uhs' property, update the OCR register ACCEPT_SWITCH_1V8=
 bit
>   sdhci: Fix a typo in comment
>   MAINTAINERS: Add entries for SD (SDHCI, SDBus, SDCard)

Thanks. I've applied patches 1-4, 7 and 8 to target-arm.next, so
they will make 2.12. Patches 5 and 6 I had review comments on.

(We may be able to call 5/6 bugfix patches and get them into 2.12;
depends on timing.)

thanks
-- PMM
