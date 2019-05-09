Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF8EC46460
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9EDE21783
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EDE21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58863 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOnIA-0006Z6-Sm
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:57:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOnGi-00053V-Va
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOnGh-00088u-Us
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:55:44 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:59479)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hOnGh-00088R-MP
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:55:43 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1N0Zfg-1gSaUs0fDA-00wXBy; Thu, 09 May 2019 19:55:10 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1556905846-14074-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1556905846-14074-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f23a5f3f-6536-ab15-13cc-656f641b84a4@vivier.eu>
Date: Thu, 9 May 2019 19:55:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1556905846-14074-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:hh/RhXH0OY3U7OHBwSBwmw8211QjDoNmhwGLs2aksUopDRO3G2n
	WD0N00w+s5n3v+jOSWsvql97HpW6nf1Rt9nbhsJ/AeaMX17Efdk/faCLMOp5nR9uBoW7civ
	vNzxes689bBzry+9x8HWaIzRW4rJ4MT3nwwG/9yIHJrW7qkiVtr82lsnc+nxn1qjcRQNxcl
	uLMWrnOmPtSxcpoKWDvDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XybKPSXskKY=:4Wv1KOPyNhZ5Rp/juDt/Yx
	S0SsD2mEn2YVeRcLgq5NkUt1aGpdDX2sVzix+Ck70+VRkt+P84WfvguP1S+kWMUM29fS194oS
	IlodyM59LsFgurTclg1PlU5qzzPYC5gcSEoYh2B+IBJqHX4/P97VURVHJYCPEBXOFgfrZLm/g
	Ne3ChVzBthOzTs12dkTcwNAEhKYLm52NoWV6MRDID3ipmJXseOYU/kh8iOHGIi6DzR2humUO1
	JrKpEGudTcarnUO8chFTdr3uXRQI6/woByTcmAhBFnnEGQi6VTPlnFjbiqyOdmerVCozgLc3R
	QNMcy6VuF+sag9/W1r6RzQQQcv8oHL5deJu6PCG1hVCmvNVpyWZ9hn7QXoXq+wjnlMU4t/aMq
	CiIExtg+gH5JInuo8OgcRB1wxBGg++Hr1BZh/YMj6uu6WBHkRWL5ofRi8egn1Z7O2qAOdk4t+
	VtYq7o4y3/o0TCDdiJnpwl6X2trdGjYTwiwsfKSnI4RyAldVRAnsCwmI5S1HrjjIMzn9kyCvC
	p5WYpdXQ7tPLfWzcCzIrg52wooKUjQCjuseLRJv1ZHIJlgg6SOlnBDjeGSQZgfKpch6hoqcaq
	kFfx4Siy/DB7xUCvONXMrLt37FYwt919vMmd4HS6eQsaYRDTkh8vA+oIF5RnL3xgAYIl3yjUP
	Dt9OYroI1HMfol3JVv2p7eBL+pqrQbrMTM6jyowdfEO7bdvedPepcGW5/zlTMOPPptAn0VtV8
	S+82unOjZnE7ysvGDq8XHlfS7fApxHIDQ3yEw+nwkbv40surPQvwx+8HnVw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: Re: [Qemu-devel] [PATCH v4 1/5] linux-user: Fix support for the
 SIOCATMARK and SIOCGPGRP ioctls for xtensa
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
> Fix support for the SIOCATMARK and SIOCGPGRP ioctls for xtensa by
> correcting corresponding macro definition.
> 
> Values for TARGET_SIOCATMARK and TARGET_SIOCGPGRP are determined by
> Linux kernel. Following relevant lines (obtained by grep) are from
> the kernel source tree:
> 
> arch/ia64/include/uapi/asm/sockios.h:#define SIOCATMARK    0x8905
> arch/mips/include/uapi/asm/sockios.h:#define SIOCATMARK    _IOR('s', 7, int)
> arch/parisc/include/uapi/asm/sockios.h:#define SIOCATMARK  0x8905
> arch/sh/include/uapi/asm/sockios.h:#define SIOCATMARK      _IOR('s', 7, int)
> arch/xtensa/include/uapi/asm/sockios.h:#define SIOCATMARK  _IOR('s', 7, int)
> arch/alpha/include/uapi/asm/sockios.h:#define SIOCATMARK   _IOR('s', 7, int)
> arch/sparc/include/uapi/asm/sockios.h:#define SIOCATMARK   0x8905
> include/uapi/asm-generic/sockios.h:#define SIOCATMARK	   0x8905
> 
> arch/ia64/include/uapi/asm/sockios.h:#define SIOCGPGRP     0x8904
> arch/mips/include/uapi/asm/sockios.h:#define SIOCGPGRP     _IOR('s', 9, pid_t)
> arch/parisc/include/uapi/asm/sockios.h:#define SIOCGPGRP   0x8904
> arch/sh/include/uapi/asm/sockios.h:#define SIOCGPGRP       _IOR('s', 9, pid_t)
> arch/xtensa/include/uapi/asm/sockios.h:#define SIOCGPGRP   _IOR('s', 9, pid_t)
> arch/alpha/include/uapi/asm/sockios.h:#define SIOCGPGRP    _IOR('s', 9, pid_t)
> arch/sparc/include/uapi/asm/sockios.h:#define SIOCGPGRP    0x8904
> include/uapi/asm-generic/sockios.h:#define SIOCGPGRP       0x8904
> 
> It is visible from above that xtensa should have the same definitions
> as alpha, mips and sh4 already do. This patch brings QEMU to the accurate
> state wrt these two ioctls.
> 
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   linux-user/syscall_defs.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 12c8407..1e86fb9 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -736,7 +736,8 @@ struct target_pollfd {
>   #define TARGET_KDSETLED        0x4B32	/* set led state [lights, not flags] */
>   #define TARGET_KDSIGACCEPT     0x4B4E
>   
> -#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4)
> +#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
> +       defined(TARGET_XTENSA)
>   #define TARGET_SIOCATMARK      TARGET_IOR('s', 7, int)
>   #define TARGET_SIOCGPGRP       TARGET_IOR('s', 9, pid_t)
>   #else
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


