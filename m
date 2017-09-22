Received: from eggs.gnu.org ([2001:4830:134:3::10]:32909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dvUIc-0004cc-07
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dvUIb-0004sD-45
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:11:45 -0400
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922160111.31885-2-f4bug@amsat.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <d32b3ef0-33c2-bbb2-fd1a-de2711adc204@reactos.org>
Date: Fri, 22 Sep 2017 22:11:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170922160111.31885-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 24/34] hw/timer/mc146818: rename rtc_init()
 -> mc146818_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

Le 22/09/2017 à 18:01, Philippe Mathieu-Daudé a écrit :
> and remove the old i386/pc dependency
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   include/hw/timer/mc146818rtc.h | 3 ++-
>   hw/alpha/dp264.c               | 2 +-
>   hw/i386/pc.c                   | 2 +-
>   hw/isa/i82378.c                | 3 ++-
>   hw/mips/mips_fulong2e.c        | 2 +-
>   hw/mips/mips_jazz.c            | 2 +-
>   hw/mips/mips_malta.c           | 2 +-
>   hw/mips/mips_r4k.c             | 2 +-
>   hw/ppc/pnv.c                   | 2 +-
>   hw/timer/mc146818rtc.c         | 2 +-
>   10 files changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
