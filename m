Received: from eggs.gnu.org ([2001:4830:134:3::10]:49402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHDwg-0004YX-GD
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHDwd-00010C-BX
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:06:26 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:32827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHDwd-000102-7T
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:06:23 -0500
Received: by mail-vk0-f47.google.com with SMTP id 137so40185325vkl.0
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 10:06:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161202054617.6749-3-alastair@au1.ibm.com>
References: <20161202054617.6749-1-alastair@au1.ibm.com>
	<20161202054617.6749-3-alastair@au1.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Dec 2016 18:05:02 +0000
Message-ID: <CAFEAcA-X-V6gX89xOvTW_=hOC51-=fZXieaGSPEPEYT6JS0Swg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 2/7] hw/arm: remove trailing whitespace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alastair D'Silva <alastair@au1.ibm.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, Alastair D'Silva <alastair@d-silva.org>

On 2 December 2016 at 05:46, Alastair D'Silva <alastair@au1.ibm.com> wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
>
> Remove trailing whitespace in hw/arm/pxa2xx.c
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  hw/arm/pxa2xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
> index 21ea1d6..8aa0f8a 100644
> --- a/hw/arm/pxa2xx.c
> +++ b/hw/arm/pxa2xx.c
> @@ -2070,7 +2070,7 @@ PXA2xxState *pxa270_init(MemoryRegion *address_space,
>      }
>      if (!revision)
>          revision = "pxa270";
> -
> +
>      s->cpu = cpu_arm_init(revision);
>      if (s->cpu == NULL) {
>          fprintf(stderr, "Unable to find CPU definition\n");
> --

Applied this patch to target-arm.next for 2.9.

thanks
-- PMM
