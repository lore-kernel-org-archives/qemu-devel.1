Received: from eggs.gnu.org ([2001:4830:134:3::10]:53784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEzar-0002yZ-4C
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:27:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEzac-0007Xn-94
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:27:13 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:50483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eEzab-0007Vo-RD
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:26:58 -0500
Received: by mail-wr0-f194.google.com with SMTP id p96so20751058wrb.7
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 07:26:57 -0800 (PST)
References: <20171110090354.29608-1-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b1e322ad-7156-3bb9-8878-2d7eea6adc1d@redhat.com>
Date: Wed, 15 Nov 2017 16:26:53 +0100
MIME-Version: 1.0
In-Reply-To: <20171110090354.29608-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 10/11/2017 10:03, Gerd Hoffmann wrote:
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
> 

Queued, thanks.

Paolo
