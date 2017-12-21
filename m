Received: from eggs.gnu.org ([2001:4830:134:3::10]:54640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRxcK-0000gx-Lx
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 04:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRxcF-0004Gq-OZ
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 04:58:20 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:57512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eRxcF-0004GD-Ek
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 04:58:15 -0500
References: <20171220212308.12614-1-michael.weiser@gmx.de>
	<20171220212308.12614-8-michael.weiser@gmx.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <268e428e-cc7e-741f-4e98-86a6abdb8e1d@vivier.eu>
Date: Thu, 21 Dec 2017 10:58:04 +0100
MIME-Version: 1.0
In-Reply-To: <20171220212308.12614-8-michael.weiser@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 7/7] linux-user: Activate armeb handler
 registration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Weiser <michael.weiser@gmx.de>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Le 20/12/2017 à 22:23, Michael Weiser a écrit :
> armeb is missing from the target list in qemu-binfmt-conf.sh. Add it so
> the handler for those binaries gets registered by the script.
> 
> Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
> ---
>  scripts/qemu-binfmt-conf.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index 597efdbe50..ea5a748745 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -2,7 +2,7 @@
>  # enable automatic i386/ARM/M68K/MIPS/SPARC/PPC/s390/HPPA
>  # program execution by the kernel
>  
> -qemu_target_list="i386 i486 alpha arm sparc32plus ppc ppc64 ppc64le m68k \
> +qemu_target_list="i386 i486 alpha arm armeb sparc32plus ppc ppc64 ppc64le m68k \
>  mips mipsel mipsn32 mipsn32el mips64 mips64el \
>  sh4 sh4eb s390x aarch64 aarch64_be hppa"
>  
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
