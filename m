Received: from eggs.gnu.org ([2001:4830:134:3::10]:59917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eDBwx-0003xn-UD
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:14:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eDBwu-0003by-G7
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:14:35 -0500
Received: from mail-ve1eur01hn0227.outbound.protection.outlook.com
	([104.47.1.227]:46248
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eDBwt-0003YA-PK
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:14:32 -0500
Date: Fri, 10 Nov 2017 19:14:16 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20171110161415.GA19491@rkaganb.sw.ru>
References: <20171110090354.29608-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171110090354.29608-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] fix scripts/update-linux-headers.sh here
 document
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Nov 10, 2017 at 10:03:54AM +0100, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  scripts/update-linux-headers.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index 8b847e279b..e2b159aa3d 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -108,7 +108,7 @@ for arch in $ARCHLIST; do
>      if [ $arch = x86 ]; then
>          cat <<-EOF >"$output/include/standard-headers/asm-x86/hyperv.h"
>          /* this is a temporary placeholder until kvm_para.h stops including it */
> -        EOF
> +EOF
>          cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-x86/"
>          cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
>          cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"

Ugh, indeed, the minus sign after << causes the shell to strip only
preceding tabs, not spaces.  Apparently I expanded the tabs after I
tested the script to work...

Fixes: 40bf8e9aede0f9105a9e1e4aaf17b20aaa55f9a0
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>

Thanks,
Roman.
