Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC43C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 19:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD712177E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 19:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD712177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60186 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOpCi-0005kR-77
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 15:59:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOpAw-0004TW-G6
	for qemu-devel@nongnu.org; Thu, 09 May 2019 15:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOopx-0008SW-FU
	for qemu-devel@nongnu.org; Thu, 09 May 2019 15:36:57 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:37899)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hOopx-0008QC-3j
	for qemu-devel@nongnu.org; Thu, 09 May 2019 15:36:13 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MTRIi-1hHEfu1VfA-00Tnys; Thu, 09 May 2019 21:35:38 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1556905846-14074-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1556905846-14074-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1590f274-5aef-0c0f-9039-7cc11e863719@vivier.eu>
Date: Thu, 9 May 2019 21:35:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1556905846-14074-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NcK3ejsfFjhEg6l4eYK1Fs37yKx/V+lbomjNaFFlaKZI7IddYl4
	FShf954cda0b2C8eS5GK9J5TvYa8SyyCQPaJjXnjLks5yBlO5dk14zRpQe5ao44YjMfJZ3K
	JMZycv4mJgygQZ6gxoVc1R3P2rGF3QKLKE9SwrE3jq8ZJ6dFECc+LBTIezmraWleWjMaz8/
	a0D8XF2Um66P1PwRrcmxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tJJqzhodc5I=:0RMATG7OT5N67baWXkRNrU
	sqKApI7tF5ZqI3yVc5V7HSRR0j40pQX660FPuefC9GKYzS0byAN3JQdcajxB4NnYopEpNCsjI
	Hs/1hO2hw0E6PnnCgqyW4H//T3HKPfpw8U+FghJiDqMxKJ+RJqGpwb+gGF0DOHNelRzRzRSBW
	CObKGm7A2OdiE/c9EDDNNrei/QQ3X78SNHV7zifLis2W9uCYcXbHnXcIaK3QUHqa0vjMA4B7G
	fBgq2+E1TlxZu32km3Ry/LsByxBBY34vrfLlkJNop1nkF4XfwtAPyODX7Q5tO4ndlb/D+JPG3
	70TR7sEM8o7S70MsaaKLR9RY0644msAC5qQWYX98D1zetBXQFKBtQCyLnDL12t7WR8Q7shK+8
	9FoeHDaImV9BHTzcYu0HFi+bTBHP8bS6TwOMG7sc9ko+a9nS/4xZ9DUefPHY1ZJD0o70yhZod
	YDKJg3Hwwab+Go9dJRyzjzlL3r5xfqEAjYx5eCXXzZFKPcKxD6g3nCWXARrZ7hGSMqQos7jsu
	hXEu2ZTbTmfSodIiW//xt11RnyOTkudp+N1bxembYtwa75U4YHT1UuAnzaOEujfF8KU+Qlzuf
	2y/PHH2dSJUVlh4Ud7ydvnJDpjLoIfFFbePfxV9amK3u9e8CDEkPnhhwJvb9iWn+6KLqeUDio
	yNjTmJHDa+79uec4gkxh50UrQcnQ0FYTaL/VdQlh3M8VgmmJfAJKqjkNyXCAAhFA2+7ucPe5O
	v6A799T851vRZW37E51+t9pW8yXQUs2N+XQApnVSN0EAr8llHNujLH12A5M=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: Re: [Qemu-devel] [PATCH v4 2/5] linux-user: Add support for the
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

On 03/05/2019 19:50, Aleksandar Markovic wrote:
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
> Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
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

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


