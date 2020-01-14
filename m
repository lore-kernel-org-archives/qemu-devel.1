Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22841C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E82E32072B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82E32072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irNVS-0005Vm-VL
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 09:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irNUm-00053y-3v
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:48:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irNUi-0004Nw-Dc
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:48:39 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:44385)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irNUi-0004Ni-4R
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:48:36 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MHX3R-1ivWLK19bV-00DXGr; Tue, 14 Jan 2020 15:48:19 +0100
Subject: Re: [PATCH v5 18/20] configure: Detect kcov support and introduce
 CONFIG_KCOV
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1578947683-21011-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1578947683-21011-19-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <aafe279b-769b-aaaa-7ec5-a8035b743acd@vivier.eu>
Date: Tue, 14 Jan 2020 15:48:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578947683-21011-19-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2GkKkqoCzyI74ILno45mnI8vuS6iz6VVKTBqRVu55lrjEKz+YSe
 4poOzBTftsOBpyHyaZAvtjYEKvtY27DSeGAGQIIGV+DrGknDCQw2qlLkK85O2tnXK1FecUm
 oWG5Hdx/89EVPZUF2RVBWT676U3yrNiLw3Qg8+EqfQsp/plnHEbY1W6S3HrqAkt1gGKzLfa
 SJLkYgLc7huNAB3FyQsOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9GiAqqQHFbs=:nfiRxDpRtRvKhlT9MjgVNE
 f9Xe0sGoAFrOSGWeLvA5pyjqk7Vw1gNP6VDENIyCXKdXG+P5LK1BptkpIF8w+59kBQEd8lavC
 e71+m4Kx0BuDNu+jCqktZwCiS2CiOSTYaOd9jcHs0NQPR8FNPwKbRYE5yK/Dv8mCJJgjPCiOZ
 M0ljKcZ4EJn0UCOblcMz8He9M+U8Kbn94jszk4co8iOdPRBj2C0vBd3OHlPWopwz8InK0pYtg
 /CVWpT1wQKnHPMCDonE7tYpuscoEXo2w/VfD2Ohyg5WhQvTYcwLg39xs/sTw0nmQ/5T3hd6Sv
 RsguMBz53gsy55GSzL8x5yxzHIkCF/Z2DgyhaDwNSnm1DQ5+zH3Lmb6hV3rr6Cw1gR+dzVxbZ
 cHgYVXvRyO4V2HZXfkwzM71lmdAE/3+3FpQ1gyDONAtyQcQrmf1UBTl7xmzzwRh/XySQjKGrM
 ZiPuHwdwHX8D+RRBun7HqZC4+15rfO/JN/mJSjG2WMH9gbrD1Cd0weL8+LPIfAlo3AMD5JsDE
 onYWovcGjpGSffmo01qZLpP2sT3DAL6eX6n7ugq1TRuddPl2O7eZ/LuwyFCTI8DHq95Ve8Xs8
 ljU33Csitst7/CBZLxdgHL/fxrjCkTR5AFwsd8Bl6Pmwk+H6Jx1eMcyYLnEHt/gkyEGHQ4FBw
 8G5Zy0jof+Enu4iTomtRJTT1n4u6OKIaAViRHqHc92sba9BhlNG+O36Inz/8ol1/f2MeESHSM
 2Qxqq4Gdb7GxuNFNALcR5IyiV9nqkMGnQW6WMd60MmDSQXMJ+YN5bp99FFo3J7fJ6x41kHxKn
 PaA/xUopmm63C3YtiSzAwdz2veq3p3aO4Kh2RpIIHZ+mW/kVopubEhA5IAWywwSiwuCLQJosE
 iNdWKC1V7dZOK39HMSVg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.187
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/01/2020 à 21:34, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> kcov is kernel code coverage tracing tool. It requires kernel 4.4+
> compiled with certain kernel options. Its interface consists of
> three ioctls.
> 
> This patch checks if kcov support is present on build machine, and
> stores the result in variable CONFIG_KCOV, meant to be used in
> linux-user code related to the support for above mentioned ioctls.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  configure | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/configure b/configure
> index 940bf9e..dbdba8f 100755
> --- a/configure
> +++ b/configure
> @@ -4752,6 +4752,24 @@ if compile_prog "" "" ; then
>    syncfs=yes
>  fi
>  
> +# check for kcov support (kernel must be 4.4+, compiled with certain options)
> +kcov=no
> +cat > $TMPC << EOF
> +#include <sys/kcov.h>
> +
> +int main(void)
> +{
> +    ioctl(-1, KCOV_ENABLE, NULL);
> +    ioctl(-1, KCOV_DISABLE, NULL);
> +    ioctl(-1, KCOV_INIT_TRACE, NULL);
> +
> +    return 0;
> +}
> +EOF
> +if compile_prog "" "" ; then
> +  kcov=yes
> +fi

Perhaps a 'check_include sys/kcov.h' is enough?

All these defines are present since the first release of the file.

Thanks,
Laurent

