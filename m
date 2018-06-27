Received: from eggs.gnu.org ([2001:4830:134:3::10]:32905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY3S7-0002fS-3j
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 01:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY3S4-0000Ek-2n
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 01:57:15 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:32889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY3S3-0000E1-J1
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 01:57:12 -0400
Received: by mail-pf0-x241.google.com with SMTP id b17-v6so485970pfi.0
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 22:57:11 -0700 (PDT)
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-6-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5f396d83-59c4-01e0-3f90-ba68e8217c1e@linaro.org>
Date: Tue, 26 Jun 2018 22:57:07 -0700
MIME-Version: 1.0
In-Reply-To: <20180625124238.25339-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 05/46] hw: Use IEC binary prefix
 definitions from "qemu/units.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Paul Burton <paul.burton@mips.com>, "open list:ARM" <qemu-arm@nongnu.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On 06/25/2018 05:41 AM, Philippe Mathieu-Daudé wrote:
> Code change produced with:
> 
>   $ git ls-files | egrep '\.[ch]$' | \
>     xargs sed -i -e 's/\(\W[KMGTPE]\)_BYTE/\1iB/g'
> 
> Suggested-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Acked-by: David Gibson <david@gibson.dropbear.id.au> (ppc parts)
> ---
>  include/qemu/cutils.h  |  8 +-------
>  hw/arm/msf2-soc.c      |  4 ++--
>  hw/arm/msf2-som.c      |  6 +++---
>  hw/core/loader-fit.c   |  3 ++-
>  hw/core/machine.c      |  2 +-
>  hw/display/sm501.c     | 14 +++++++-------
>  hw/hppa/machine.c      |  2 +-
>  hw/mips/boston.c       | 28 ++++++++++++++--------------
>  hw/ppc/pnv.c           |  4 ++--
>  hw/ppc/ppc440_uc.c     | 26 +++++++++++++-------------
>  hw/ppc/prep.c          |  2 +-
>  hw/ppc/sam460ex.c      |  2 +-
>  hw/ppc/spapr.c         | 10 +++++-----
>  hw/ppc/spapr_rtas.c    |  2 +-
>  hw/sd/sd.c             |  4 ++--
>  hw/sd/sdhci.c          |  2 +-
>  tests/test-cutils.c    | 18 +++++++++---------
>  tests/test-keyval.c    |  6 +++---
>  tests/test-qemu-opts.c |  7 +++----
>  19 files changed, 72 insertions(+), 78 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
