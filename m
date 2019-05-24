Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093A1C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5A6217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5A6217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52710 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU8M3-0006W8-2O
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 07:27:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hU8KH-00051N-6B
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hU8KG-0000tA-AJ
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:25:29 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:36377)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hU8KG-0000hs-0b
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:25:28 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MBmI6-1hMTnz3Yui-00CEa4; Fri, 24 May 2019 13:19:32 +0200
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190523144336.13960-1-laurent@vivier.eu>
	<CAFEAcA8x2bNdqkBiu4sTh9T8P=U2JYwdCZYK1dHDK7Q8MbyQ0A@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <abbb2f98-add7-6065-7619-ae616206bd56@vivier.eu>
Date: Fri, 24 May 2019 13:19:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8x2bNdqkBiu4sTh9T8P=U2JYwdCZYK1dHDK7Q8MbyQ0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lQp4VIGuv9x8vdMpZMdFQ4CuM3KEBMLXIkK/W3uM0GyjnDX/5yv
	ElsYMM/Z/NeWyHhEwj47B0yqGZdfg/m0UwXCYPHPu2tFYF5Jiq2DCfCZDfrwiSxDRj4Svkw
	RpVofs8dBu0bZbG9qsUmGMdreY6POc+5FddtNORBWUidQp1IWRIiAvpV1B+b+FjoCCCL/X+
	fMB9EeE7R7MtCO/Daeo3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AtafB0Mqkm8=:YRFSxBl+gwV0HWifrYZs5o
	cg1Euy2tlZsmpMtK2OLFf7PWRQyTZUHlGeu0kY04TaWC/jO63SsB5NU59cDWjiBFJp5kIvxD4
	1/gHB3QhP49vVShnpfU0JFDh/n+PT9/uDZF5EjnxHpnrYZpwcgC3MF55SFiIti1O1dOv4zFMD
	s4R6D2TFIuh3uUSF3qqWe0eRM4bv6QHPw09R96yewuxB7ENKTFRSx3SQSopv/iAc5YqOrrVqO
	MAXeGM0/b3DgWwDIIWaKY9kzhX21usJV10eUK27zJ0WouqlIANpUy1JS+Tp/+eNFfgQ7p3Nb1
	8nR0WhQwRpdyikLlJ/dA86eA1WIxZYMtfNAt4sRqB3vBeo6dUmrr0LXmnaw4rkmaCLYZyvSCU
	oU8kAJATz5LpcEBxCAeENew6e/fUGB/sOa53cSJEeWXbsrKoU5v7qZ/E0m+9ECMr0owzI54BK
	6FcDP0jAYlpwRBFnpLSNxpBjdBxtaDtq9wKJgiRfiDH7WCdu0nAvPVA0hFI5D4Bkwvg0k1Zo9
	Nwytl6Y0HqWFLGrE2irFilv/sLxzXnMDmqdJz797bF0eACsmMdAENVH84+aWhVVq03OXvZ4tL
	iFF+Rdws6ZdnlPV7i+b8v0QOE4ggieJGSChx3A0T+7M1hRXObPmNPBcSRnwAUxDv5UhX/teoZ
	KlQuXG0h39yswajcm/SN/zHurfq5Uf+nJTpwpVr/ktBwOiSSq/mViPn5XunZjgZeeyVPqTh5D
	oa/kNIug0XDbmyP+o2W9MAQwBcU6pa7Qj+9ozJ1qPuKcCHNeqGVgO1tuIKg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [PULL 00/10] Linux user for 4.1 patches
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/05/2019 13:07, Peter Maydell wrote:
> On Thu, 23 May 2019 at 15:47, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> The following changes since commit a4f667b6714916683408b983cfe0a615a725775f:
>>
>>    Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3' into staging (2019-05-21 16:30:13 +0100)
>>
>> are available in the Git repository at:
>>
>>    git://github.com/vivier/qemu.git tags/linux-user-for-4.1-pull-request
>>
>> for you to fetch changes up to 069a1504ee1e2943964d0357d798e11b66afd351:
>>
>>    linux-user: Pass through nanosecond timestamp components for stat syscalls (2019-05-22 20:50:55 +0200)
>>
>> ----------------------------------------------------------------
>> Add /proc/hardware and /proc/cpuinfo,
>> update SIOCXXX ioctls,
>> update IPV6 options,
>> fix shmat emulation,
>> add nanoseconds in stat,
>> init field fp_abi on mips
>>
>> ----------------------------------------------------------------
> 
> Hi; I'm afraid this fails to build on a couple of the hosts
> I test on:
> 
> /home/pm215/qemu/linux-user/syscall.c: In function ‘do_setsockopt’:
> /home/pm215/qemu/linux-user/syscall.c:1929:5: error:
> "__UAPI_DEF_IPV6_MREQ" is not defined [-Werror=undef]
>   #if __UAPI_DEF_IPV6_MREQ
>       ^
> 
> (these were the ppc64 and aarch64 machines in the gcc compile farm, but
> I suspect this is just "older kernel headers" rather than arch-specific.)
> 

Thank you,

I'm going to remove the patch from the PR and we will rework it later.

Thanks,
Laurent


