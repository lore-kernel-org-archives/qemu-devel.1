Received: from eggs.gnu.org ([2001:4830:134:3::10]:60660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dvUHN-0003rq-Lj
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dvUHM-0004G6-Nf
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:10:29 -0400
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-22-f4bug@amsat.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <727bda28-88b9-5c14-3e62-cfbe0af265e4@reactos.org>
Date: Fri, 22 Sep 2017 22:10:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170922154014.29350-22-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 21/34] hw/display/vga: remove the old
 i386/pc dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Le 22/09/2017 à 17:40, Philippe Mathieu-Daudé a écrit :
> move public API to "hw/display/vga.h" and private registers
> to "hw/display/vga_int_regs.h"
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> ./scripts/get_maintainer.pl -f hw/display/vga*
> get_maintainer.pl: No maintainers found...
> 
>   hw/display/vga_int.h                 |  3 ++-
>   hw/display/{vga.h => vga_int_regs.h} |  0
>   include/hw/display/vga.h             | 25 +++++++++++++++++++++++++
>   include/hw/i386/pc.h                 | 12 ------------
>   hw/display/vga-isa-mm.c              |  4 +---
>   hw/display/vga-isa.c                 |  2 +-
>   hw/display/vga.c                     |  4 ++--
>   hw/mips/mips_jazz.c                  |  1 +
>   vl.c                                 |  2 +-
>   9 files changed, 33 insertions(+), 20 deletions(-)
>   rename hw/display/{vga.h => vga_int_regs.h} (100%)
>   create mode 100644 include/hw/display/vga.h
> 

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
