Received: from eggs.gnu.org ([2001:4830:134:3::10]:39238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPxXt-0006nl-8C
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 17:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPxXp-0004t9-4a
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 17:34:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPxXo-0004sx-UR
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 17:33:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so10590047wrt.7
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 14:33:56 -0800 (PST)
References: <20181122180143.14237-1-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1259e457-6cb8-3b1e-853f-53f1e47cac63@redhat.com>
Date: Thu, 22 Nov 2018 23:33:54 +0100
MIME-Version: 1.0
In-Reply-To: <20181122180143.14237-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] MAINTAINERS: Add an ARM SMMU
 section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com

Hi Eric,

On 22/11/18 19:01, Eric Auger wrote:
> Add a new ARM SMMU section and set Eric Auger as the maintainer
> for ARM SMMU emulation sources.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1032406c56..3cac9f0a0c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -151,6 +151,13 @@ F: disas/arm.c
>  F: disas/arm-a64.cc
>  F: disas/libvixl/
>  
> +ARM SMMU
> +M: Eric Auger <eric.auger@redhat.com>
> +L: qemu-arm@nongnu.org
> +S: Maintained

Shouldn't you use 'Supported': "Someone is actually paid to look after
this."?

> +F: hw/arm/smmu*
> +F: include/hw/arm/smmu*
> +
>  CRIS
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  S: Maintained
> 
