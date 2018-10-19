Received: from eggs.gnu.org ([2001:4830:134:3::10]:51849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDTJo-0007aI-AY
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDTJj-0004KV-7u
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:51:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDTJj-0004Hx-0X
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:51:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id o17-v6so2676608wmh.0
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 04:51:46 -0700 (PDT)
References: <20181019104326.28052-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <97ec9ea1-839d-ab27-a691-5d3c02d76563@redhat.com>
Date: Fri, 19 Oct 2018 13:51:44 +0200
MIME-Version: 1.0
In-Reply-To: <20181019104326.28052-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: set cross_cc_FOO from cc,
 not host_cc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org

On 19/10/2018 12:43, Alex Bennée wrote:
> The purpose of the code is to use the designated compiler for building
> the targets test cases. This is not actually host_cc which will still
> be cc even when we are cross compiling. As the tests for $cpu all use
> $cc we should do the same.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reported-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  configure | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/configure b/configure
> index 9138af37f8..d6605bd633 100755
> --- a/configure
> +++ b/configure
> @@ -717,37 +717,37 @@ case "$cpu" in
>    ppc|ppc64|s390|s390x|sparc64|x32)
>      cpu="$cpu"
>      supported_cpu="yes"
> -    eval "cross_cc_${cpu}=\$host_cc"
> +    eval "cross_cc_${cpu}=\$cc"
>    ;;
>    i386|i486|i586|i686|i86pc|BePC)
>      cpu="i386"
>      supported_cpu="yes"
> -    cross_cc_i386=$host_cc
> +    cross_cc_i386=$cc
>    ;;
>    x86_64|amd64)
>      cpu="x86_64"
>      supported_cpu="yes"
> -    cross_cc_x86_64=$host_cc
> +    cross_cc_x86_64=$cc
>    ;;
>    armv*b|armv*l|arm)
>      cpu="arm"
>      supported_cpu="yes"
> -    cross_cc_arm=$host_cc
> +    cross_cc_arm=$cc
>    ;;
>    aarch64)
>      cpu="aarch64"
>      supported_cpu="yes"
> -    cross_cc_aarch64=$host_cc
> +    cross_cc_aarch64=$cc
>    ;;
>    mips*)
>      cpu="mips"
>      supported_cpu="yes"
> -    cross_cc_mips=$host_cc
> +    cross_cc_mips=$cc
>    ;;
>    sparc|sun4[cdmuv])
>      cpu="sparc"
>      supported_cpu="yes"
> -    cross_cc_sparc=$host_cc
> +    cross_cc_sparc=$cc
>    ;;
>    *)
>      # This will result in either an error or falling back to TCI later
> 
