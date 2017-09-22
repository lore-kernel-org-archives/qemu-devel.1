Received: from eggs.gnu.org ([2001:4830:134:3::10]:60878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dvUHu-0004Bs-2d
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dvUHt-0004XK-5M
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:11:02 -0400
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-23-f4bug@amsat.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <7c36f87b-78eb-2db7-679e-3ee76725e4d4@reactos.org>
Date: Fri, 22 Sep 2017 22:10:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170922154014.29350-23-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 22/34] hw/input/i8042: extract API from
 hw/i386/pc.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

Le 22/09/2017 à 17:40, Philippe Mathieu-Daudé a écrit :
> - include vmmouse
> - add entries in MAINTAINERS (pckbd.c, i8042.h)
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   include/hw/i386/pc.h     | 11 -----------
>   include/hw/input/i8042.h | 30 ++++++++++++++++++++++++++++++
>   hw/alpha/dp264.c         |  3 ++-
>   hw/i386/pc.c             |  5 +++--
>   hw/input/pckbd.c         |  2 +-
>   hw/input/vmmouse.c       |  3 +--
>   hw/mips/mips_fulong2e.c  |  3 ++-
>   hw/mips/mips_jazz.c      |  1 +
>   hw/mips/mips_malta.c     |  3 ++-
>   hw/mips/mips_r4k.c       |  3 ++-
>   hw/misc/vmport.c         |  1 +
>   hw/ppc/prep.c            |  5 +++--
>   hw/sparc64/sun4u.c       |  3 ++-
>   hw/unicore32/puv3.c      |  1 +
>   MAINTAINERS              |  4 +++-
>   15 files changed, 54 insertions(+), 24 deletions(-)
>   create mode 100644 include/hw/input/i8042.h

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
