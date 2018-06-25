Received: from eggs.gnu.org ([2001:4830:134:3::10]:55504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXPRD-0002VQ-5W
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:13:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXPR7-00069Z-Gp
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:13:39 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180625110721.22485-1-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0627e87c-6d3c-a64a-6d6d-2a632c73ebf7@amsat.org>
Date: Mon, 25 Jun 2018 08:13:27 -0300
MIME-Version: 1.0
In-Reply-To: <20180625110721.22485-1-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add ASPEED BMCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org

Hi Joel,

On 06/25/2018 08:07 AM, Joel Stanley wrote:
> This adds Cedric as the maintainer, with Andrew and I as reviewers, for
> the ASPEED boards and the peripherals we use.

Good idea, this should speed up ASPEED reviews.

> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2874ddce6097..14bcf2ed3e3d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -644,6 +644,17 @@ M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>  S: Maintained
>  F: hw/arm/msf2-som.c
>  
> +ASPEED BMCs
> +M: Cédric Le Goater <clg@kaod.org>
> +R: Andrew Jeffery <andrew@aj.id.au>
> +R: Joel Stanley <joel@jms.id.au>
> +L: qemu-arm@nongnu.org
> +S: Maintained
> +F: hw/*/*aspeed*
> +F: include/*/*aspeed*

This line does not match, however include/hw/*/*aspeed* does.

With that fixed:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +F: hw/net/ftgmac100.c
> +F: include/hw/net/ftgmac100.h
> +
>  CRIS Machines
>  -------------
>  Axis Dev88
> 
