Received: from eggs.gnu.org ([2001:4830:134:3::10]:34979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPcrx-0000nN-Ih
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 19:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPcrs-0000fg-GP
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 19:29:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPcro-0000bQ-Hn
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 19:29:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so7413614wmf.5
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 16:29:11 -0800 (PST)
References: <20181121234651.24596-1-palmer@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <201f1cf4-30af-03c5-393b-0eab6ac7eb87@redhat.com>
Date: Thu, 22 Nov 2018 01:29:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181121234651.24596-1-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 1/2] MAINTAINERS: Any file with
 "riscv" in the name is a RISC-V file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org

On 22/11/18 0:46, Palmer Dabbelt wrote:
> There was a recent thread about unmaintained files in QEMU where it was
> noted that a few RISC-V related files had slipped through the patterns
> in our MAINTAINERS file entry.  This patch adds some more aggressive
> pattern matching in an attempt to rectify this situation.
> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1032406c5607..e89adc81d5d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -255,6 +255,8 @@ F: target/riscv/
>   F: hw/riscv/
>   F: include/hw/riscv/
>   F: disas/riscv.c
> +K: riscv
> +N: riscv

QEMU doesn't support the 'N' tag.
I see from the Linux kernel:

   N: Files and directories with regex patterns.
      N:   [^a-z]tegra     all files whose path contains the word tegra
      One pattern per line.  Multiple N: lines acceptable.
      scripts/get_maintainer.pl has different behavior for files that
      match F: pattern and matches of N: patterns.  By default,
      get_maintainer will not look at git log history when an F: pattern
      match occurs.  When an N: match occurs, git log history is used
      to also notify the people that have git commit signatures.

Should we add this feature to checkscript?

>   
>   S390
>   M: Richard Henderson <rth@twiddle.net>
> 
