Received: from eggs.gnu.org ([2001:4830:134:3::10]:34204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY3Ys-0004e2-3R
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:04:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY3Yo-00084U-Vk
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:04:14 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:36628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY3Yo-00082g-Gi
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:04:10 -0400
Received: by mail-pl0-x242.google.com with SMTP id a7-v6so533935plp.3
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 23:04:10 -0700 (PDT)
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-7-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4b975f8b-681e-eb6d-9c7b-baa565ee4a52@linaro.org>
Date: Tue, 26 Jun 2018 23:04:06 -0700
MIME-Version: 1.0
In-Reply-To: <20180625124238.25339-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 06/46] hw: Directly use "qemu/units.h"
 instead of "qemu/cutils.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, Alexander Graf <agraf@suse.de>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Paul Burton <paul.burton@mips.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>

On 06/25/2018 05:41 AM, Philippe Mathieu-Daudé wrote:
> These files don't use anything exposed by "qemu/cutils.h",
> simplify preprocessing including directly "qemu/units.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Acked-by: David Gibson <david@gibson.dropbear.id.au> (ppc parts)
> ---
>  hw/arm/msf2-soc.c  | 2 +-
>  hw/arm/msf2-som.c  | 2 +-
>  hw/core/machine.c  | 2 +-
>  hw/display/sm501.c | 2 +-
>  hw/mips/boston.c   | 2 +-
>  hw/ppc/pnv.c       | 2 +-
>  hw/ppc/ppc440_uc.c | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
