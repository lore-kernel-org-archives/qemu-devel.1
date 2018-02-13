Received: from eggs.gnu.org ([2001:4830:134:3::10]:36017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elg0t-0005HV-IF
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:13:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elg0s-0006Ft-FT
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:13:11 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:37212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elg0s-0006FW-Ak
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:13:10 -0500
Received: by mail-ot0-x241.google.com with SMTP id e64so18232344ote.4
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 11:13:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180209085755.30414-1-f4bug@amsat.org>
References: <20180209085755.30414-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 19:12:49 +0000
Message-ID: <CAFEAcA-xztCCo3tPe8MtYhnC4r1ij1czUzvCyBAZwWHKnx1LNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/2] aspeed: simplify using the
 'unimplemented device'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 9 February 2018 at 08:57, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Since v1:
> - corrected buggy UART base address (noticed by Peter)
> - tested using openbmc-build provided by Andrew
> - added C=C3=A9dric R-b
>
> tested with:
>
>   $ qemu-system-arm -M romulus-bmc -m 512 \
>     -drive file=3Dimage-bmc,if=3Dmtd,format=3Draw -nographic
>
> using this image:
>
>   https://openpower.xyz/job/openbmc-build/1240/distro=3Dubuntu,target=3Dr=
omulus/artifact/deploy/images/romulus/image-bmc
>
> (which is a good candidate for an Avocado / pyexpect test).
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   hw/arm/aspeed: directly map the serial device to the system address
>     space
>   hw/arm/aspeed: simplify using the 'unimplemented device' for
>     aspeed_soc.io
>
>  include/hw/arm/aspeed_soc.h |  1 -
>  hw/arm/aspeed_soc.c         | 35 +++++------------------------------
>  2 files changed, 5 insertions(+), 31 deletions(-)

Applied, thanks.

-- PMM
