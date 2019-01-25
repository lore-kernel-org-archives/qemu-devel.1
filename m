Received: from eggs.gnu.org ([209.51.188.92]:46538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gn1aU-0002th-Dm
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gn1aT-0002f1-6U
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:32:02 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:36555 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gn1aS-0002Wq-Rs
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:32:01 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 25 Jan 2019 14:31:38 +0100
Message-Id: <1548423098-31864-15-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548423098-31864-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1548423098-31864-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 14/14] docs/qemu-cpu-models: Add MIPS/nanoMIPS
 QEMU supported CPU models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Add list of supported and preferred CPU models for MIPS32, MIPS64
and nanoMIPS hosts.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 docs/qemu-cpu-models.texi | 163 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 161 insertions(+), 2 deletions(-)

diff --git a/docs/qemu-cpu-models.texi b/docs/qemu-cpu-models.texi
index 1935f98..475d434 100644
--- a/docs/qemu-cpu-models.texi
+++ b/docs/qemu-cpu-models.texi
@@ -5,8 +5,9 @@ QEMU / KVM CPU model configuration
 @c man begin DESCRIPTION
 
 @menu
-* recommendations_cpu_models_x86:: Recommendations for KVM CPU model configuration on x86 hosts
-* cpu_model_syntax_apps::          Syntax for configuring CPU models
+* recommendations_cpu_models_x86::  Recommendations for KVM CPU model configuration on x86 hosts
+* recommendations_cpu_models_MIPS:: Supported CPU model configurations on MIPS hosts
+* cpu_model_syntax_apps::           Syntax for configuring CPU models
 @end menu
 
 QEMU / KVM virtualization supports two ways to configure CPU models
@@ -368,6 +369,164 @@ hardware assisted virtualization, that should thus not be required for
 running virtual machines.
 @end table
 
+@node recommendations_cpu_models_MIPS
+@subsection Supported CPU model configurations on MIPS hosts
+
+QEMU supports variety of MIPS CPU models:
+
+@menu
+* cpu_models_MIPS32::               Supported CPU models for MIPS32 hosts
+* cpu_models_MIPS64::               Supported CPU models for MIPS64 hosts
+* cpu_models_nanoMIPS::             Supported CPU models for nanoMIPS hosts
+* preferred_cpu_models_MIPS::       Preferred CPU models for MIPS hosts
+@end menu
+
+@node cpu_models_MIPS32
+@subsubsection Supported CPU models for MIPS32 hosts
+
+The following CPU models are supported for use on MIPS32 hosts. Administrators /
+applications are recommended to use the CPU model that matches the generation
+of the host CPUs in use. In a deployment with a mixture of host CPU models
+between machines, if live migration compatibility is required, use the newest
+CPU model that is compatible across all desired hosts.
+
+@table @option
+@item @code{mips32r6-generic}
+
+MIPS32 Processor (Release 6, 2015)
+
+
+@item @code{P5600}
+
+MIPS32 Processor (P5600, 2014)
+
+
+@item @code{M14K}
+@item @code{M14Kc}
+
+MIPS32 Processor (M14K, 2009)
+
+
+@item @code{74Kf}
+
+MIPS32 Processor (74K, 2007)
+
+
+@item @code{34Kf}
+
+MIPS32 Processor (34K, 2006)
+
+
+@item @code{24Kc}
+@item @code{24KEc}
+@item @code{24Kf}
+
+MIPS32 Processor (24K, 2003)
+
+
+@item @code{4Kc}
+@item @code{4Km}
+@item @code{4KEcR1}
+@item @code{4KEmR1}
+@item @code{4KEc}
+@item @code{4KEm}
+
+MIPS32 Processor (4K, 1999)
+@end table
+
+@node cpu_models_MIPS64
+@subsubsection Supported CPU models for MIPS64 hosts
+
+The following CPU models are supported for use on MIPS64 hosts. Administrators /
+applications are recommended to use the CPU model that matches the generation
+of the host CPUs in use. In a deployment with a mixture of host CPU models
+between machines, if live migration compatibility is required, use the newest
+CPU model that is compatible across all desired hosts.
+
+@table @option
+@item @code{I6400}
+
+MIPS64 Processor (Release 6, 2014)
+
+
+@item @code{Loongson-2F}
+
+MIPS64 Processor (Longsoon 2, 2008)
+
+
+@item @code{Loongson-2E}
+
+MIPS64 Processor (Loongson 2, 2006)
+
+
+@item @code{mips64dspr2}
+
+MIPS64 Processor (Release 2, 2006)
+
+
+@item @code{MIPS64R2-generic}
+@item @code{5KEc}
+@item @code{5KEf}
+
+MIPS64 Processor (Release 2, 2002)
+
+
+@item @code{20Kc}
+
+MIPS64 Processor (20K, 2000)
+
+
+@item @code{5Kc}
+@item @code{5Kf}
+
+MIPS64 Processor (5K, 1999)
+
+
+@item @code{VR5432}
+
+MIPS64 Processor (VR, 1998)
+
+
+@item @code{R4000}
+
+MIPS64 Processor (MIPS III, 1991)
+@end table
+
+@node cpu_models_nanoMIPS
+@subsubsection Supported CPU models for nanoMIPS hosts
+
+The following CPU models are supported for use on nanoMIPS hosts. Administrators /
+applications are recommended to use the CPU model that matches the generation
+of the host CPUs in use. In a deployment with a mixture of host CPU models
+between machines, if live migration compatibility is required, use the newest
+CPU model that is compatible across all desired hosts.
+
+@table @option
+@item @code{I7200}
+
+MIPS I7200 (nanoMIPS, 2018)
+
+@end table
+
+@node preferred_cpu_models_MIPS
+@subsubsection Preferred CPU models for MIPS hosts
+
+The following CPU models are preferred for use on different MIPS hosts:
+
+@table @option
+@item @code{MIPS III}
+R4000
+
+@item @code{MIPS32R2}
+34Kf
+
+@item @code{MIPS64R6}
+I6400
+
+@item @code{nanoMIPS}
+I7200
+@end table
+
 @node cpu_model_syntax_apps
 @subsection Syntax for configuring CPU models
 
-- 
2.7.4
