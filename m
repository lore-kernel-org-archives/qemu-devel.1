Received: from eggs.gnu.org ([2001:4830:134:3::10]:36072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebPnZ-00073S-JE
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:53:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebPnY-0001bM-Nq
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:53:01 -0500
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:46921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebPnY-0001aa-JP
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:53:00 -0500
Received: by mail-ot0-x231.google.com with SMTP id t35so6694128otd.13
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 03:53:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180115182436.2066-1-f4bug@amsat.org>
References: <20180115182436.2066-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 11:52:39 +0000
Message-ID: <CAFEAcA-RofZJyFx5Mbxf7zEJ7dCWdJ0svoOKaEn7uCM1VvfnEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 00/14] SDHCI: housekeeping (part 1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

On 15 January 2018 at 18:24, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Since v7:
> - addressed Peter & Paolo reviews
>   - do not use qdev_property_add_static() but move common properties into
>     a new DEFINE_SDHCI_COMMON_PROPERTIES()
>   - use &address_space_memory rather than create AS with address_space_in=
it()

Thanks; applied this version to target-arm.next.

-- PMM
