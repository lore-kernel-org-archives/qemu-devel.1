Received: from eggs.gnu.org ([2001:4830:134:3::10]:54261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gS1Cl-0003nn-LW
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:52:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gS0xV-0003wH-2X
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:37:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gS0xU-0003vZ-SM
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:36:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so20902754wrr.0
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 06:36:56 -0800 (PST)
References: <1543412590-29716-1-git-send-email-stefan.markovic@rt-rk.com>
	<1543412590-29716-3-git-send-email-stefan.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bea9f668-e0ee-1dde-4dfd-c6f45f6e17e1@redhat.com>
Date: Wed, 28 Nov 2018 15:36:50 +0100
MIME-Version: 1.0
In-Reply-To: <1543412590-29716-3-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] docs/qemu-cpu-models: Add
 MIPS/nanoMIPS QEMU supported CPU models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pburton@wavecomp.com, smarkovic@wavecomp.com, jhogan@kernel.org, huth@tuxfamily.org, hpoussin@reactos.org, amarkovic@wavecomp.com, pjovanovic@wavecomp.com

On 28/11/18 14:43, Stefan Markovic wrote:
> From: Stefan Markovic <smarkovic@wavecomp.com>
> 
> Add list of supported and preferred CPU models for MIPS32, MIPS64
> and nanoMIPS hosts.
> 
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  docs/qemu-cpu-models.texi | 163 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 161 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/qemu-cpu-models.texi b/docs/qemu-cpu-models.texi
> index 1935f98..475d434 100644
> --- a/docs/qemu-cpu-models.texi
> +++ b/docs/qemu-cpu-models.texi
> @@ -5,8 +5,9 @@ QEMU / KVM CPU model configuration
>  @c man begin DESCRIPTION
>  
>  @menu
> -* recommendations_cpu_models_x86:: Recommendations for KVM CPU model configuration on x86 hosts
> -* cpu_model_syntax_apps::          Syntax for configuring CPU models
> +* recommendations_cpu_models_x86::  Recommendations for KVM CPU model configuration on x86 hosts
> +* recommendations_cpu_models_MIPS:: Supported CPU model configurations on MIPS hosts
> +* cpu_model_syntax_apps::           Syntax for configuring CPU models
>  @end menu
>  
>  QEMU / KVM virtualization supports two ways to configure CPU models
> @@ -368,6 +369,164 @@ hardware assisted virtualization, that should thus not be required for
>  running virtual machines.
>  @end table
>  
> +@node recommendations_cpu_models_MIPS
> +@subsection Supported CPU model configurations on MIPS hosts
> +
> +QEMU supports variety of MIPS CPU models:
> +
> +@menu
> +* cpu_models_MIPS32::               Supported CPU models for MIPS32 hosts
> +* cpu_models_MIPS64::               Supported CPU models for MIPS64 hosts
> +* cpu_models_nanoMIPS::             Supported CPU models for nanoMIPS hosts
> +* preferred_cpu_models_MIPS::       Preferred CPU models for MIPS hosts
> +@end menu
> +
> +@node cpu_models_MIPS32
> +@subsubsection Supported CPU models for MIPS32 hosts
> +
> +The following CPU models are supported for use on MIPS32 hosts. Administrators /
> +applications are recommended to use the CPU model that matches the generation
> +of the host CPUs in use. In a deployment with a mixture of host CPU models
> +between machines, if live migration compatibility is required, use the newest
> +CPU model that is compatible across all desired hosts.
> +
> +@table @option
> +@item @code{mips32r6-generic}
> +
> +MIPS32 Processor (Release 6, 2015)
> +
> +
> +@item @code{P5600}
> +
> +MIPS32 Processor (P5600, 2014)
> +
> +
> +@item @code{M14K}
> +@item @code{M14Kc}
> +
> +MIPS32 Processor (M14K, 2009)
> +
> +
> +@item @code{74Kf}
> +
> +MIPS32 Processor (74K, 2007)
> +
> +
> +@item @code{34Kf}
> +
> +MIPS32 Processor (34K, 2006)
> +
> +
> +@item @code{24Kc}
> +@item @code{24KEc}
> +@item @code{24Kf}
> +
> +MIPS32 Processor (24K, 2003)
> +
> +
> +@item @code{4Kc}
> +@item @code{4Km}
> +@item @code{4KEcR1}
> +@item @code{4KEmR1}
> +@item @code{4KEc}
> +@item @code{4KEm}
> +
> +MIPS32 Processor (4K, 1999)
> +@end table
> +
> +@node cpu_models_MIPS64
> +@subsubsection Supported CPU models for MIPS64 hosts
> +
> +The following CPU models are supported for use on MIPS64 hosts. Administrators /
> +applications are recommended to use the CPU model that matches the generation
> +of the host CPUs in use. In a deployment with a mixture of host CPU models
> +between machines, if live migration compatibility is required, use the newest
> +CPU model that is compatible across all desired hosts.
> +
> +@table @option
> +@item @code{I6400}
> +
> +MIPS64 Processor (Release 6, 2014)
> +
> +
> +@item @code{Loongson-2F}
> +
> +MIPS64 Processor (Longsoon 2, 2008)
> +
> +
> +@item @code{Loongson-2E}
> +
> +MIPS64 Processor (Loongson 2, 2006)
> +
> +
> +@item @code{mips64dspr2}
> +
> +MIPS64 Processor (Release 2, 2006)
> +
> +
> +@item @code{MIPS64R2-generic}
> +@item @code{5KEc}
> +@item @code{5KEf}
> +
> +MIPS64 Processor (Release 2, 2002)
> +
> +
> +@item @code{20Kc}
> +
> +MIPS64 Processor (20K, 2000)
> +
> +
> +@item @code{5Kc}
> +@item @code{5Kf}
> +
> +MIPS64 Processor (5K, 1999)
> +
> +
> +@item @code{VR5432}
> +
> +MIPS64 Processor (VR, 1998)
> +
> +
> +@item @code{R4000}
> +
> +MIPS64 Processor (MIPS III, 1991)
> +@end table
> +
> +@node cpu_models_nanoMIPS
> +@subsubsection Supported CPU models for nanoMIPS hosts
> +
> +The following CPU models are supported for use on nanoMIPS hosts. Administrators /
> +applications are recommended to use the CPU model that matches the generation
> +of the host CPUs in use. In a deployment with a mixture of host CPU models
> +between machines, if live migration compatibility is required, use the newest
> +CPU model that is compatible across all desired hosts.
> +
> +@table @option
> +@item @code{I7200}
> +
> +MIPS I7200 (nanoMIPS, 2018)
> +
> +@end table
> +
> +@node preferred_cpu_models_MIPS
> +@subsubsection Preferred CPU models for MIPS hosts
> +
> +The following CPU models are preferred for use on different MIPS hosts:
> +
> +@table @option
> +@item @code{MIPS III}
> +R4000
> +
> +@item @code{MIPS32R2}
> +34Kf
> +
> +@item @code{MIPS64R6}
> +I6400
> +
> +@item @code{nanoMIPS}
> +I7200
> +@end table
> +
>  @node cpu_model_syntax_apps
>  @subsection Syntax for configuring CPU models
>  
> 
