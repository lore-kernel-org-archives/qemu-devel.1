Received: from eggs.gnu.org ([2001:4830:134:3::10]:57783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCueX-0005Vp-76
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 16:46:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCueW-0002ON-7p
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 16:46:25 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1510228971-6005-1-git-send-email-sundeep.lkml@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4beb4e47-0ff9-8251-6502-23824779edbd@amsat.org>
Date: Thu, 9 Nov 2017 18:46:15 -0300
MIME-Version: 1.0
In-Reply-To: <1510228971-6005-1-git-send-email-sundeep.lkml@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu devel PATCH] MAINTAINERS: Add entries for
 Smartfusion2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, alistair23@gmail.com

Hi Subbaraya,

On 11/09/2017 09:02 AM, Subbaraya Sundeep wrote:
> add voluntarily myself as maintainer for Smartfusion2

You need to share your GnuPG key signed, I couldn't find it using
http://pgp.mit.edu/pks/lookup?search=Subbaraya+Sundeep

from https://wiki.qemu.org/Contribute/SubmitAPullRequest :
All pull requests must be signed. If your key is not already signed by
members of the QEMU community, you should make arrangements to attend a
KeySigningParty (for example at KVM Forum) or make alternative
arrangements to have your key signed by an attendee. Key signing
requires meeting another community member *in person* so please make
appropriate arrangements.

IMHO it would be great you find some time to review some patches
(qemu-arm@nongnu.org is not that verbose):
https://wiki.qemu.org/Contribute/SubmitAPatch#Return_the_favor

> 
> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> ---
>  MAINTAINERS | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0cd4d02..dae08bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -564,6 +564,23 @@ M: Alistair Francis <alistair@alistair23.me>
>  S: Maintained
>  F: hw/arm/netduino2.c
>  
> +MSF2 SoC

SmartFusion2

> +M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> +S: Maintained
> +F: hw/arm/msf2-soc.c
> +F: hw/misc/msf2-sysreg.c
> +F: hw/timer/mss-timer.c
> +F: hw/ssi/mss-spi.c
> +F: include/hw/arm/msf2-soc.h
> +F: include/hw/misc/msf2-sysreg.h
> +F: include/hw/timer/mss-timer.h
> +F: include/hw/ssi/mss-spi.h
> +

Emcraft M2S-FG484

> +MSF2 SOM board
> +M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> +S: Maintained
> +F: hw/arm/msf2-som.c
> +
>  CRIS Machines
>  -------------
>  Axis Dev88

Regards,

Phil.
