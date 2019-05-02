Received: from eggs.gnu.org ([209.51.188.92]:44054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hM5AB-0003Kj-TT
	for qemu-devel@nongnu.org; Thu, 02 May 2019 02:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hM5AA-0007We-75
	for qemu-devel@nongnu.org; Thu, 02 May 2019 02:25:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hM5A9-0007RA-Rk
	for qemu-devel@nongnu.org; Thu, 02 May 2019 02:25:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id y2so746504wmi.5
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 23:25:40 -0700 (PDT)
References: <20190501223819.8584-1-richard.henderson@linaro.org>
	<20190501223819.8584-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <776e0e87-494a-1bd3-8074-09c6390d498c@redhat.com>
Date: Thu, 2 May 2019 08:25:38 +0200
MIME-Version: 1.0
In-Reply-To: <20190501223819.8584-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] configure: Use quotes around uses of
 $CPU_CFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, mark.cave-ayland@ilande.co.uk, alex.bennee@linaro.org, david@gibson.dropbear.id.au

On 5/2/19 12:38 AM, Richard Henderson wrote:
> About half of the values to which CPU_CFLAGS is set
> have multiple space separated arguments.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  configure | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/configure b/configure
> index 234cb929ca..16bd4375d1 100755
> --- a/configure
> +++ b/configure
> @@ -1543,37 +1543,37 @@ case "$cpu" in
>             CPU_CFLAGS="-m64"
>             LDFLAGS="-m64 $LDFLAGS"
>             cross_cc_ppc64=$cc
> -           cross_cc_cflags_ppc64=$CPU_CFLAGS
> +           cross_cc_cflags_ppc64="$CPU_CFLAGS"
>             ;;
>      sparc)
>             CPU_CFLAGS="-m32 -mv8plus -mcpu=ultrasparc"
>             LDFLAGS="-m32 -mv8plus $LDFLAGS"
>             cross_cc_sparc=$cc
> -           cross_cc_cflags_sparc=$CPU_CFLAGS
> +           cross_cc_cflags_sparc="$CPU_CFLAGS"
>             ;;
>      sparc64)
>             CPU_CFLAGS="-m64 -mcpu=ultrasparc"
>             LDFLAGS="-m64 $LDFLAGS"
>             cross_cc_sparc64=$cc
> -           cross_cc_cflags_sparc64=$CPU_CFLAGS
> +           cross_cc_cflags_sparc64="$CPU_CFLAGS"
>             ;;
>      s390)
>             CPU_CFLAGS="-m31"
>             LDFLAGS="-m31 $LDFLAGS"
>             cross_cc_s390=$cc
> -           cross_cc_cflags_s390=$CPU_CFLAGS
> +           cross_cc_cflags_s390="$CPU_CFLAGS"
>             ;;
>      s390x)
>             CPU_CFLAGS="-m64"
>             LDFLAGS="-m64 $LDFLAGS"
>             cross_cc_s390x=$cc
> -           cross_cc_cflags_s390x=$CPU_CFLAGS
> +           cross_cc_cflags_s390x="$CPU_CFLAGS"
>             ;;
>      i386)
>             CPU_CFLAGS="-m32"
>             LDFLAGS="-m32 $LDFLAGS"
>             cross_cc_i386=$cc
> -           cross_cc_cflags_i386=$CPU_CFLAGS
> +           cross_cc_cflags_i386="$CPU_CFLAGS"
>             ;;
>      x86_64)
>             # ??? Only extremely old AMD cpus do not have cmpxchg16b.
> @@ -1582,13 +1582,13 @@ case "$cpu" in
>             CPU_CFLAGS="-m64 -mcx16"
>             LDFLAGS="-m64 $LDFLAGS"
>             cross_cc_x86_64=$cc
> -           cross_cc_cflags_x86_64=$CPU_CFLAGS
> +           cross_cc_cflags_x86_64="$CPU_CFLAGS"
>             ;;
>      x32)
>             CPU_CFLAGS="-mx32"
>             LDFLAGS="-mx32 $LDFLAGS"
>             cross_cc_i386=$cc
> -           cross_cc_cflags_i386=$CPU_CFLAGS
> +           cross_cc_cflags_i386="$CPU_CFLAGS"
>             ;;
>      # No special flags required for other host CPUs
>  esac
> 
