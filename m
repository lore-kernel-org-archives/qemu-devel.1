Received: from eggs.gnu.org ([2001:4830:134:3::10]:60747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fPu6P-0005cX-MQ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 14:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fPu6O-0007It-He
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 14:21:09 -0400
MIME-Version: 1.0
In-Reply-To: <20180603000827.30872-1-f4bug@amsat.org>
References: <20180603000827.30872-1-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 4 Jun 2018 11:20:36 -0700
Message-ID: <CAKmqyKMgmsuqPqM=h6y85e-psAxRpQxo2hvkcS0Xq+FftwUTfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/8] sdcard: cleanup the SD_SPEC version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paul Brook <paul@codesourcery.com>, Paolo Bonzini <pbonzini@redhat.com>

On Sat, Jun 2, 2018 at 5:08 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Hi,
>
> This series adds a 'spec_version' property to the SD Card device,
> to allow to limit some commands to specific spec version range
> (some firmwares use this feature to detect which spec version the
> card implements).
>
> This restore the SSI/SD support of the Stellaris LM3S6965EVB board,
> which allow to stress the SD Card code with a nice integration test
> (waiting for another series to get merged to add the Avocado test):
>
>     $ qemu-system-arm -M lm3s6965evb -serial stdio \
>       -kernel sd_card.bin -sd sdcard.img
>
>     SD Card Example Program
>     Type 'help' for help.
>
>     /> ls
>     Open
>     listing
>
>     ----A 2012/04/25 17:44        12  README.TXT
>
>        1 File(s),        12 bytes total
>        0 Dir(s),      61182K bytes free
>
>     /> cat README.TXT
>     Hello World
>
> See:
> http://lists.nongnu.org/archive/html/qemu-devel/2012-04/msg03790.html
> http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg00353.html

Do you have a branch with all of your SD work available?

Alistair

>
> Regards,
>
> Phil.
>
> Philippe Mathieu-Daud=C3=A9 (8):
>   sdcard: Update the Configuration Register (SCR) to Spec Version 1.10
>   sdcard: Allow commands valid in SPI mode
>   sdcard: Add a 'spec_version' property
>   sdcard: Set Spec v2.00 as default
>   hw/sd/ssi-sd: Force cards connected in SPI mode to use Spec v1.10
>   sdcard: Disable SEND_IF_COND (CMD8) for Spec v1
>   sdcard: Reflect when the Spec v3 is supported in the Config Register (S=
CR)
>   sdcard: Disable CMD19/CMD23 for Spec v2
>
>  include/hw/sd/sd.h |  6 ++++++
>  hw/sd/sd.c         | 47 +++++++++++++++++++++++++++++-----------------
>  hw/sd/ssi-sd.c     |  2 ++
>  3 files changed, 38 insertions(+), 17 deletions(-)
>
> --
> 2.17.1
>
>
