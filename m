Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEC4C18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:17:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 618EC20675
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618EC20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39004 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTNNd-0005Am-Hp
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 05:17:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTNJt-0002ks-Oh
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTNJs-0006PJ-OX
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:13:57 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:46555)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTNJs-0006O3-FJ
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:13:56 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MBV2f-1hLzr62O7j-00D3Jx; Wed, 22 May 2019 11:12:55 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1558282527-22183-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1558282527-22183-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <cf487418-2f81-45b3-3c29-94f8b5edb47e@vivier.eu>
Date: Wed, 22 May 2019 11:12:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1558282527-22183-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nzNwOBj87EbADDeESs5OLwpVvT52rbZP/3vSdTae119NPZTEHHu
	hTFLgFV4TL+gNqvEKx8890h5p22foPN7lDD5hzIncoYsWfwBuvpYFJmbhBtaBB843ZSuH3R
	+v2GYevAR4cRS4tBRDsue12b+kS3mhwpNUiPKBGSd899sdKaF11qKgfcd1caIX5/me9aYxu
	YDOt9/831M8i28rJExsYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EdODHUzSxjM=:D0IJrh4u84UQZrAh4H2cfC
	AjlyAolLRunIEQlQtADXBlIj6s93ZlPRNh/V6QleMsMWg5/TAcZ/PPWpL1GvTCwhKt06jRql7
	LVHBUx8XISqw7KpB8Tx2UWxxfhF6jyAKxuWa7Mr2SSc5LC83fuzWeI6bIdrOG/O0hYl5/XGby
	J3BagkGZwFnjLLK5LK/R9Dor7mapZXghkPXMD8LLUK4P3WBK7NovAE0s5ALXpcs0WLhp7R5w9
	/keJ3LwzucTnbO9mlc4Wq5WcO/MG47tUifBbpUUA72zC7remhqvZNoYxnl9yapXMTSnjC5Fhh
	QWjuwBqTI4/nvSbvlF9bksETToxwaaJjdxaABzBqo5A7V79kN0zSZ4/O6/rgrtna/v0VVVfIY
	JXE+Kbm0bgLQYS/jVUgtV+kpJDRsYl6Um9D9w6P1whYsWQ6GA3yulOWF0Zwu7PCjNkYGSafpZ
	AJMI37lnFtrVd5z/U6ZlGxeeoE1l/yOp8iriTLYsqGV+ppQVWy+MSY9oV5JofpaXPNuBi2/Du
	LgUI7EOydxk3x44hU/jEXz5VmE7lKikgqpdONAAJxu2WeCvXUlEf4DMCG/8w/7pN7qpI+RLAh
	NGv8K41nYBPAH54AfJC15Xi/2Zi7fVVAXb+1clCoKEGs4S2hCRAdVn/Irep9h3MvC2c11bl/G
	hOVAHs+bEi56sIUSRGd394U7qMqFdxg4+msUokm0Zkh8fXjuIaeYielS84eD2AIIx1peicpBq
	VUGS/Rcss1047ryEUAF2QGBL98vNd3zMZDohHne2/DW310cPbynFnNL+QI8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: Re: [Qemu-devel] [PATCH v6 2/6] linux-user: Add support for
 SIOCSPGRP ioctl for all targets
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
Cc: lvivier@redhat.com, thuth@redhat.com, daniel.santos@pobox.com,
	arikalo@wavecomp.com, jcmvbkbc@gmail.com, amarkovic@wavecomp.com,
	nchen@wavecomp.com, philmd@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/05/2019 18:15, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Add support for setting the process (or process group) to receive SIGIO
> or SIGURG signals when I/O becomes possible or urgent data is available,
> using SIOCSPGRP ioctl.
> 
> The ioctl numeric values for SIOCSPGRP are platform-dependent and are
> determined by following files in Linux kernel source tree:
> 
> arch/ia64/include/uapi/asm/sockios.h:#define SIOCSPGRP    0x8902
> arch/mips/include/uapi/asm/sockios.h:#define SIOCSPGRP    _IOW('s', 8, pid_t)
> arch/parisc/include/uapi/asm/sockios.h:#define SIOCSPGRP  0x8902
> arch/sh/include/uapi/asm/sockios.h:#define SIOCSPGRP      _IOW('s', 8, pid_t)
> arch/xtensa/include/uapi/asm/sockios.h:#define SIOCSPGRP  _IOW('s', 8, pid_t)
> arch/alpha/include/uapi/asm/sockios.h:#define SIOCSPGRP   _IOW('s', 8, pid_t)
> arch/sparc/include/uapi/asm/sockios.h:#define SIOCSPGRP   0x8902
> include/uapi/asm-generic/sockios.h:#define SIOCSPGRP      0x8902
> 
> Hence the different definition for alpha, mips, sh4, and xtensa.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   linux-user/ioctls.h       | 1 +
>   linux-user/syscall_defs.h | 3 +++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index ae89516..c37adc5 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -218,6 +218,7 @@
>     IOCTL(SIOCSRARP, IOC_W, MK_PTR(MK_STRUCT(STRUCT_arpreq)))
>     IOCTL(SIOCGRARP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_arpreq)))
>     IOCTL(SIOCGIWNAME, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_char_ifreq)))
> +  IOCTL(SIOCSPGRP, IOC_W, MK_PTR(TYPE_INT)) /* pid_t */
>     IOCTL(SIOCGPGRP, IOC_R, MK_PTR(TYPE_INT)) /* pid_t */
>     IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
>     IOCTL(SIOCGSTAMPNS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 1e86fb9..2941231 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -739,11 +739,14 @@ struct target_pollfd {
>   #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
>          defined(TARGET_XTENSA)
>   #define TARGET_SIOCATMARK      TARGET_IOR('s', 7, int)
> +#define TARGET_SIOCSPGRP       TARGET_IOW('s', 8, pid_t)
>   #define TARGET_SIOCGPGRP       TARGET_IOR('s', 9, pid_t)
>   #else
>   #define TARGET_SIOCATMARK      0x8905
> +#define TARGET_SIOCSPGRP       0x8902
>   #define TARGET_SIOCGPGRP       0x8904
>   #endif
> +
>   #define TARGET_SIOCGSTAMP      0x8906          /* Get stamp (timeval) */
>   #define TARGET_SIOCGSTAMPNS    0x8907          /* Get stamp (timespec) */
>   
> 

Applied to my linux-user branch.

Thanks,
Laurent

