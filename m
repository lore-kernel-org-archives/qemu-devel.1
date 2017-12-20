Received: from eggs.gnu.org ([2001:4830:134:3::10]:41728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRfCq-00040w-Ow
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:18:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRfCn-0005nR-Ay
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:18:48 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:62771)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eRfCn-0005m5-0v
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:18:45 -0500
References: <20171219201613.7399-1-michael.weiser@gmx.de>
	<20171219201613.7399-6-michael.weiser@gmx.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <6f0ce872-849b-dc5a-25e7-3242a6e5c624@vivier.eu>
Date: Wed, 20 Dec 2017 15:18:34 +0100
MIME-Version: 1.0
In-Reply-To: <20171219201613.7399-6-michael.weiser@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 5/5] linux-user: Add aarch64_be magic
 numbers to qemu-binfmt-conf.sh
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

Le 19/12/2017 à 21:16, Michael Weiser a écrit :
> As we now have a linux-user aarch64_be target, we can add it to the list
> of supported targets in qemu-binfmt-conf.sh
> 
> Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
> ---
>  scripts/qemu-binfmt-conf.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index 8afc3eb5bb..d69953525c 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -4,7 +4,7 @@
>  
>  qemu_target_list="i386 i486 alpha arm sparc32plus ppc ppc64 ppc64le m68k \
>  mips mipsel mipsn32 mipsn32el mips64 mips64el \
> -sh4 sh4eb s390x aarch64 hppa"
> +sh4 sh4eb s390x aarch64 aarch64_be hppa"
>  
>  i386_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x03\x00'
>  i386_mask='\xff\xff\xff\xff\xff\xfe\xfe\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
> @@ -92,6 +92,10 @@ aarch64_magic='\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x
>  aarch64_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
>  aarch64_family=arm
>  
> +aarch64_be_magic='\x7fELF\x02\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xb7'
> +aarch64_be_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
> +aarch64_be_family=arm

You need a different family, something like "armbe", to let
qemu_set_binfmts() registers aarch64_be on aarch64 and vice-versa.

The principle is binaries of a given family can be executed natively on
the host of the same family, so we don't want to register a binfmt
handler. Is that the case between aarch64 and arch64_be?

Thanks,
Laurent
