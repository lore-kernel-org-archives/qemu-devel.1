Received: from eggs.gnu.org ([2001:4830:134:3::10]:58727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTAeb-0002Fp-4b
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:01:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTAeV-0000Yi-9z
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:01:09 -0500
Received: from mail-vk0-x22e.google.com ([2607:f8b0:400c:c05::22e]:33356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTAeV-0000YX-4y
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:01:03 -0500
Received: by mail-vk0-x22e.google.com with SMTP id k127so31178345vke.0
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 09:01:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1483979087-32663-1-git-send-email-clg@kaod.org>
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jan 2017 17:00:42 +0000
Message-ID: <CAFEAcA_4+potq55ep0ZQhpX2-31W_K6-0aoNAEWWKcm+ZqAPtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/11] Aspeed SMC controller fixes and
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Marcin Krzeminski <marcin.krzeminski@nokia.com>

On 9 January 2017 at 16:24, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Hello,
>
> I have reduced the patchset size to focus on some improvements of the
> SMC (Flash) controller model only and will address the watchdog and
> network models in other patchset.
>
> The main benefit of this series is to enable booting directly from a
> flash image containing U-Boot. It adds :
>
>  - some minor fixes and code rearrangements
>  - Command mode support. Flash contents is accessed directly on the
>    AHB bus
>  - auto strapping of configuration for boot flash
>  - use CE0 as a boot ROM. Today, qemu can not boot from a MMIO region.
>    As this is complex to do (TCG layer modification), we use a ROM
>    region in which we copy the flash contents. Hopefully, I got it
>    right this time.
>  - dummy bytes support for Command mode only
>
> Still in the pipe for the SMC controller are :
>
>  - DMA support
>  - dummy bytes support in user mode (hacky)
>
> which I will send later.

Applied 1-10 to target-arm.next, but not 11 since there
seemed to be some discussion on whether it was correct.

thanks
-- PMM
