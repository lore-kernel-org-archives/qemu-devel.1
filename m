Received: from eggs.gnu.org ([2001:4830:134:3::10]:33648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dvUKC-000636-IF
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dvUKB-0005zW-Lc
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:13:24 -0400
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922160111.31885-4-f4bug@amsat.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <97087b0e-6960-9429-fff5-97cfd75436bc@reactos.org>
Date: Fri, 22 Sep 2017 22:13:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170922160111.31885-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 26/34] hw/net/ne2000: extract ne2k-isa code
 from i386/pc to ne2000-isa.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

Le 22/09/2017 à 18:01, Philippe Mathieu-Daudé a écrit :
> - add "hw/net/ne2000-isa.h" (and new entry in MAINTAINERS)
> - remove the old i386 dependency
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   hw/net/ne2000.h             |  3 +++
>   include/hw/i386/pc.h        | 20 --------------------
>   include/hw/net/ne2000-isa.h | 33 +++++++++++++++++++++++++++++++++
>   hw/i386/pc.c                |  1 +
>   hw/mips/mips_r4k.c          |  1 +
>   hw/net/ne2000-isa.c         |  6 ++----
>   hw/net/ne2000.c             |  2 --
>   hw/ppc/prep.c               |  1 +
>   MAINTAINERS                 |  1 +
>   9 files changed, 42 insertions(+), 26 deletions(-)
>   create mode 100644 include/hw/net/ne2000-isa.h

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
