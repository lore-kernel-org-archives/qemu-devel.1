Received: from eggs.gnu.org ([2001:4830:134:3::10]:40590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1evn5Q-0001rD-8T
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1evn5P-000134-FS
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:47:40 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Tue, 13 Mar 2018 16:47:30 +0000
Message-ID: <MWHPR21MB018956AFEA7FC79D5ADF870F9ED20@MWHPR21MB0189.namprd21.prod.outlook.com>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
	<20180313153458.26822-7-peter.maydell@linaro.org>
In-Reply-To: <20180313153458.26822-7-peter.maydell@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 6/9] hw/arm/bcm2836: Create proper bcm2837
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>, Pekka Enberg <penberg@iki.fi>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>

> From: Peter Maydell <peter.maydell@linaro.org>
> Sent: Tuesday, 13 March 2018 08:35
>=20
> The bcm2837 is pretty similar to the bcm2836, but it does have
> some differences. Notably, the MPIDR affinity aff1 values it
> sets for the CPUs are 0x0, rather than the 0xf that the bcm2836
> uses, and if this is wrong Linux will not boot.
>=20
> Rather than trying to have one device with properties that
> configure it differently for the two cases, create two
> separate QOM devices for the two SoCs. We use the same approach
> as hw/arm/aspeed_soc.c and share code and have a data table
> that might differ per-SoC. For the moment the two types don't
> actually have different behaviour.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/bcm2836.h | 19 +++++++++++++++++++
>  hw/arm/bcm2836.c         | 37 ++++++++++++++++++++++++++++++++-----
>  hw/arm/raspi.c           |  3 ++-
>  3 files changed, 53 insertions(+), 6 deletions(-)

I haven't tried to understand enough of QOM to review this one... (It looks=
 sane to me though.)

Andrew
