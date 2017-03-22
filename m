Received: from eggs.gnu.org ([2001:4830:134:3::10]:39762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cqejI-0004eR-Hn
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cqejE-000885-FW
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:47:04 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1cqejE-00087K-8K
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:47:00 -0400
Received: by mail-wr0-f194.google.com with SMTP id l37so26298920wrc.3
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 04:46:59 -0700 (PDT)
References: <mvminn3t1fq.fsf@suse.de>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <a7886994-b4fe-3c6c-40ee-213b36e1e4b4@tuxfamily.org>
Date: Wed, 22 Mar 2017 12:46:56 +0100
MIME-Version: 1.0
In-Reply-To: <mvminn3t1fq.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qemu-binfmt-conf.sh: Fix m68k_mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

On 21.03.2017 10:38, Andreas Schwab wrote:
> The m68k mask should not remove the low bit of the ELF version field and
> should ignore the OS/ABI field.

Did you encounter a problem with a real binary here? ... then it might
be worth to mention it in the patch description and the patch should
likely be included into QEMU 2.9. Or is this just cosmetics? ... then it
should rather be included in 2.10 later, I think.

 Thomas

> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  scripts/qemu-binfmt-conf.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index 0f1aa63872..484bcf166e 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -47,7 +47,7 @@ ppc64le_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\x
>  ppc64le_family=ppcle
>  
>  m68k_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x04'
> -m68k_mask='\xff\xff\xff\xff\xff\xff\xfe\xfe\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
> +m68k_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
>  m68k_family=m68k
>  
>  # FIXME: We could use the other endianness on a MIPS host.
> 
