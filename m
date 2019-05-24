Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57EEC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:32:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA5C217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA5C217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52783 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU8Qi-0002Ex-KB
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 07:32:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hU8Kj-0005PV-Pl
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hU8Ki-00015S-H9
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:25:57 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50617)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hU8Ki-000140-7r
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:25:56 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MI5YH-1hNpCJ46sh-00FFho; Fri, 24 May 2019 13:25:29 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 13:25:15 +0200
Message-Id: <20190524112520.17684-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524112520.17684-1-laurent@vivier.eu>
References: <20190524112520.17684-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PwQEIESTGe/x7EyIbQZJ7+3Sc2Kts5aj0+2tZveJH7SlRx9tfuF
	USBHd0UhkUV/MBnLwsC66K5MTlSmF23dm36pQ5fPFOuSiCjbOluuQxh0YRai1rhbUgX2Wpw
	r39oT5NIo8i5CzxiHUtz7w7egjwbFHJE1VTp0wVMFc1bl0wVddcO5ynBJShnGucjp9Dl2XI
	GHvVUBGqPATV6pfyDz82Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PDYS0joFyE0=:xEqisyWnjc6Lcs5bB/+YjO
	GArUdMKtk5nbmrKb9I0BWHl0sHvil51i8Dx2XoBoWwwRT9/ivo3MQ0CXr4wFiEMT1I1Q/MMDE
	yVzNyCOyiVPLGsUc6IUFz8YatOskNYUWrY8LOxuyJNkYm4QTtZuaPrsGoQ6m9IESQo5Vrf7uW
	i+dGQNDbCPbFcXU5aKRLymw06hHmz61qmbhaoHdU/PVItfSQeEf3T9nEFqtG7xEg6v5IdQeDv
	tjN9aU8GaK0ahdXiSP/8UjfKbz9dMsLFQEPeyF8xIslpfFfxt/MxQgpK+y3ZW94MVagVaOVVj
	XVzAsG5aWSqiUfMLLzlVrnoxNVbzKZAaXpo9lqbGpX/uE6Pcrwpf7Y21Xdi4k/QYvU5WElcIS
	R5GoWtlabs4wP98OJuneNvukLx35/SAwMsjtCJhtHbMABTeD0h2vG6BCYskZziWjfY8WyzLk1
	TnpTybe0AuA1Jfd0reDTehZM8GAglH7x42Q3p7benH4hHh39AuKrhBCpIFBXtKZstqwoJg2Dd
	kwbbSf+rE4qNVnFGuQ51pSUA263zU4PobMzQROrhKA8opNrhqQH92tqmQYSBM7TJAEGt+AgSj
	3vclL9XcrrFn8MlpzCjWZM9qQsC0ZycTkKb1faiEoOeypmkcG9xYSVSfJk6AxDqL1YmvPTRH3
	J5KG4fDf6J/+LZCcVq6g9Bc5nAVIjTg7Lri+2UPcowINomC1K4TpN6IbtaXVM/9eCVyVU5R1o
	Pd5TbDhFRiKYqhHbun58+2WkPAX0aH7NT+kNKw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PULL v2 4/9] linux-user: Add support for SIOCSPGRP
 ioctl for all targets
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
	Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add support for setting the process (or process group) to receive SIGIO
or SIGURG signals when I/O becomes possible or urgent data is available,
using SIOCSPGRP ioctl.

The ioctl numeric values for SIOCSPGRP are platform-dependent and are
determined by following files in Linux kernel source tree:

arch/ia64/include/uapi/asm/sockios.h:#define SIOCSPGRP    0x8902
arch/mips/include/uapi/asm/sockios.h:#define SIOCSPGRP    _IOW('s', 8, pid_t)
arch/parisc/include/uapi/asm/sockios.h:#define SIOCSPGRP  0x8902
arch/sh/include/uapi/asm/sockios.h:#define SIOCSPGRP      _IOW('s', 8, pid_t)
arch/xtensa/include/uapi/asm/sockios.h:#define SIOCSPGRP  _IOW('s', 8, pid_t)
arch/alpha/include/uapi/asm/sockios.h:#define SIOCSPGRP   _IOW('s', 8, pid_t)
arch/sparc/include/uapi/asm/sockios.h:#define SIOCSPGRP   0x8902
include/uapi/asm-generic/sockios.h:#define SIOCSPGRP      0x8902

Hence the different definition for alpha, mips, sh4, and xtensa.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1558282527-22183-3-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       | 1 +
 linux-user/syscall_defs.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 37501f575cdd..99ed9d982568 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -218,6 +218,7 @@
   IOCTL(SIOCSRARP, IOC_W, MK_PTR(MK_STRUCT(STRUCT_arpreq)))
   IOCTL(SIOCGRARP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_arpreq)))
   IOCTL(SIOCGIWNAME, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_char_ifreq)))
+  IOCTL(SIOCSPGRP, IOC_W, MK_PTR(TYPE_INT)) /* pid_t */
   IOCTL(SIOCGPGRP, IOC_R, MK_PTR(TYPE_INT)) /* pid_t */
   IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
   IOCTL(SIOCGSTAMPNS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 5b530e04b8fd..9470a5ce965b 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -740,11 +740,14 @@ struct target_pollfd {
 #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
        defined(TARGET_XTENSA)
 #define TARGET_SIOCATMARK      TARGET_IOR('s', 7, int)
+#define TARGET_SIOCSPGRP       TARGET_IOW('s', 8, pid_t)
 #define TARGET_SIOCGPGRP       TARGET_IOR('s', 9, pid_t)
 #else
 #define TARGET_SIOCATMARK      0x8905
+#define TARGET_SIOCSPGRP       0x8902
 #define TARGET_SIOCGPGRP       0x8904
 #endif
+
 #define TARGET_SIOCGSTAMP      0x8906          /* Get stamp (timeval) */
 #define TARGET_SIOCGSTAMPNS    0x8907          /* Get stamp (timespec) */
 
-- 
2.20.1


