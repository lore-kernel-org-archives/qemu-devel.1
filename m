Received: from eggs.gnu.org ([2001:4830:134:3::10]:46650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3fbw-0002TN-Lt
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3fbs-0001kZ-O7
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:25:48 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:40734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f3fbs-0001j3-Hv
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:25:44 -0400
Received: by mail-wm0-x242.google.com with SMTP id x4so40970031wmh.5
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 03:25:44 -0700 (PDT)
References: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1519324303-5674-7-git-send-email-aleksandar.markovic@rt-rk.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1519324303-5674-7-git-send-email-aleksandar.markovic@rt-rk.com>
Date: Wed, 04 Apr 2018 11:25:42 +0100
Message-ID: <87po3fclp5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/6] target/mips: introduce
 MTTCG-enabled builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Goran Ferenc <goran.ferenc@mips.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Petar Jovanovic <petar.jovanovic@mips.com>, Raghu Gandham <raghu.gandham@mips.com>


Aleksandar Markovic <aleksandar.markovic@rt-rk.com> writes:

> From: Aleksandar Markovic <aleksandar.markovic@mips.com>
>
> Introduce MTTCG-enabled QEMU builds for mips32, mipsn32, and mips64.
>
> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  configure         | 3 +++
>  target/mips/cpu.h | 2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/configure b/configure
> index ed45a3c..9b338dd 100755
> --- a/configure
> +++ b/configure
> @@ -6735,16 +6735,19 @@ case "$target_name" in
>      bflt=3D"yes"
>    ;;
>    mips|mipsel)
> +    mttcg=3D"yes"
>      TARGET_ARCH=3Dmips
>      echo "TARGET_ABI_MIPSO32=3Dy" >> $config_target_mak
>    ;;
>    mipsn32|mipsn32el)
> +    mttcg=3D"yes"
>      TARGET_ARCH=3Dmips64
>      TARGET_BASE_ARCH=3Dmips
>      echo "TARGET_ABI_MIPSN32=3Dy" >> $config_target_mak
>      echo "TARGET_ABI32=3Dy" >> $config_target_mak
>    ;;
>    mips64|mips64el)
> +    mttcg=3D"yes"
>      TARGET_ARCH=3Dmips64
>      TARGET_BASE_ARCH=3Dmips
>      echo "TARGET_ABI_MIPSN64=3Dy" >> $config_target_mak
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 3fa85b0..8f41952 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -11,6 +11,8 @@
>  #include "exec/cpu-defs.h"
>  #include "fpu/softfloat.h"
>
> +#define TCG_GUEST_DEFAULT_MO (0)
> +
>  struct CPUMIPSState;
>
>  typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;


--
Alex Benn=C3=A9e
