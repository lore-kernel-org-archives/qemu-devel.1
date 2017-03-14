Received: from eggs.gnu.org ([2001:4830:134:3::10]:52507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cniEF-0007W1-UQ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cniEC-0004mG-UZ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:54:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cniEC-0004m2-OM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:54:48 -0400
References: <1489416892-2719-1-git-send-email-yongbok.kim@imgtec.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <15665355-4ee1-6f2c-f645-a9a2b2d836e1@redhat.com>
Date: Tue, 14 Mar 2017 09:54:42 +0100
MIME-Version: 1.0
In-Reply-To: <1489416892-2719-1-git-send-email-yongbok.kim@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: update for MIPS devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Paul Burton <paul.burton@imgtec.com>

On 13.03.2017 15:54, Yongbok Kim wrote:
> Add myself to MIPSSIM and new entry for Fulong 2E.
> Add an entry for Boston machine (Paul Burton).
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
> cc: Paul Burton <Paul.Burton@imgtec.com>
> ---
>  MAINTAINERS | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e3edd04..d196f19 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -600,15 +600,26 @@ S: Maintained
>  F: hw/mips/mips_malta.c
>  
>  Mipssim
> -L: qemu-devel@nongnu.org
> -S: Orphan
> +M: Yongbok Kim <yongbok.kim@imgtec.com>
> +S: Odd Fixes
>  F: hw/mips/mips_mipssim.c
> +F: hw/net/mipsnet.c
>  
>  R4000
>  M: Aurelien Jarno <aurelien@aurel32.net>
>  S: Maintained
>  F: hw/mips/mips_r4k.c
>  
> +Fulong 2E
> +M: Yongbok Kim <yongbok.kim@imgtec.com>
> +S: Odd Fixes
> +F: hw/mips/mips_fulong2e.c
> +
> +Boston
> +M: Paul Burton <Paul.Burton@imgtec.com>
> +S: Maintained
> +F: hw/mips/boston.c
> +
>  OpenRISC Machines
>  -----------------
>  or1k-sim
> 

Thanks for the update!

Reviewed-by: Thomas Huth <thuth@redhat.com>
