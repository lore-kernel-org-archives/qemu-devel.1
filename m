Received: from eggs.gnu.org ([2001:4830:134:3::10]:57266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb5BH-0003rB-Qa
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb5BH-0005T5-1H
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:52:07 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:41832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb5BG-0005Sc-SM
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:52:06 -0500
Received: by mail-ot0-x22c.google.com with SMTP id 44so9791276otk.8
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 05:52:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180113050717.22969-1-f4bug@amsat.org>
References: <20180113050717.22969-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 13:51:45 +0000
Message-ID: <CAFEAcA9YNOfZW6tY_OWZ+cyF1Gvc9-9Sq81WgdL_JRDUxcfAqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 00/14] SDHCI: housekeeping (part 1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Kevin O'Connor <kevin@koconnor.net>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

On 13 January 2018 at 05:07, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Since v6:
> - addressed Peter reviews
>   - do not use an unique Property[] for both sysbus/pci
>     Peter didn't recommend me to use the qdev_property_add_static() API s=
ince
>     it is only used by the ARM cpus and may be due for removal, however I=
 found
>     it cleaner.

Your cover letter says this but patches 3 and 14 in the v7 you sent
to the list use qdev_property_add_static(). Did you send the wrong
version of the code?

thanks
-- PMM
