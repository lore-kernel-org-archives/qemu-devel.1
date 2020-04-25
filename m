Return-Path: <SRS0=p7gi=6J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159C2C55185
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 08:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E055E2071C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 08:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E055E2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSFyN-0001tA-1p
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 04:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jSFxb-00019Y-Rc
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 04:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jSFxb-0006We-9t
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 04:14:51 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:57429)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jSFxa-0006Nj-Iw
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 04:14:50 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mt7st-1jCNrs1DNB-00tXaR; Sat, 25 Apr 2020 10:14:41 +0200
Subject: Re: [PATCH] linux-user: Add support for /proc/cpuinfo on hppa platform
To: Helge Deller <deller@gmx.de>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org
References: <20200424210648.GA26715@ls3530.fritz.box>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8c63cd8b-f5f7-a1ab-f586-6c75bcfd5f3f@vivier.eu>
Date: Sat, 25 Apr 2020 10:14:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200424210648.GA26715@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:A2bsq1Zf7mXIcRvYqIz9YMgUFrUQ3MoYGsut9xE6/rByolncahk
 DbM7vAtT1+s2vL2vwcuWYrx74//gA8RLS6pqeLkS2kbcVQTof/O5q2vBDcK4I/c2RkiLOlM
 DsqGwgBusBPx6HitND3r7fwoti1x/Vt5y+eQeIWofr8kTp/YlROLpfPukStn1l58m0TlD3G
 I/E3shuPdIdP2d5N5W/gw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o5Du8jNP3oU=:vTIKIp9ot6B5Fp13s9nIZI
 aPqO3XGxFnNOhbxNWUCBIQeCDxpXOXRUsQbtkVy/H+vpFh9qzKvehmnZO0pXuzmFKNghUD5le
 h3arW/6KPFrKMPUuTFhHF7tqPwnvEyTVh3JlI1Hrb6ZMgXz6ZImkYlfrGGdkeVCoKMsAOH6+H
 dni8SXWhU+h2lLYUjjZOaBn+qJ5p4GpozSt98w52TsiHHEL/DIpUehtk4ii5ZbhK0e4nlSCdy
 VashjeHI9LXgUKye5Y1rdeM9+1e6KF8y7aGSMXmTCtP8BmQh6teEf47Bf7Egqobm60CTPl7Mk
 qgr3gIAcjC066b+qg/T83kHq9Ye5fxCxns/R1aaDo5tAZrqRW1AZreh+JqULSRYU2NJiendGL
 sWqMOhkdFuJr/pXROOvmcigsmZg848+9cVUE4umMlEaYoLOwORGLyhfdPkUZpjZoB78qBMFCz
 cKjtzArfVp7IMwbk5WE9opwf7qxeC6aAoiZ12RXPU7i8g2mG97ctlAr4hggo6mXe6Mg73TVit
 MpOrejeMymQWAVsMqYJ3RgGv/J+qxLYZ8L/E0aTkMWZLMQunoJq5Mm5HJwzXGdIcEo7Rgiz4W
 A7+3mnj9aVMKnqq3cElyqKxrQ4enZmqz5vIfgbKVOp2Skn6UdaPMHP4pjVMzD86BIOF4YJS92
 KPDaJTnwD4P9jjgWAGrOaSBVdcH5bQ0lSOUNKHJfDsea/A6MXII7BUUZCx86QzTBwCkMCruDE
 oVG5ufuc3AOnBQ1Hm/vod7qk9arhZVrgHAxZVlXInFArwGz9xGbLZyRk7OSUk8SQLDLJJo7wU
 aFjTKAdJ8/Bl4TD/fnE4r2JyBzivqMEpEhf0ArMcQ8YptVoHiIyK5dKYj0lAoKl6TV9bnD8
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/25 04:14:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 217.72.192.74
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 24/04/2020 à 23:06, Helge Deller a écrit :
> Provide an own /proc/cpuinfo file for the hppa (parisc) platform.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 05f03919ff..ebf0d38321 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7438,6 +7435,18 @@ static int open_cpuinfo(void *cpu_env, int fd)
>  }
>  #endif
> 
> +#if defined(TARGET_HPPA)
> +static int open_cpuinfo(void *cpu_env, int fd)
> +{
> +    dprintf(fd, "cpu family\t: PA-RISC 1.1e\n");
> +    dprintf(fd, "cpu\t\t: PA7300LC (PCX-L2)\n");
> +    dprintf(fd, "capabilities\t: os32\n");
> +    dprintf(fd, "model\t\t: 9000/778/B160L\n");
> +    dprintf(fd, "model name\t: Merlin L2 160 QEMU (9000/778/B160L)\n");
> +    return 0;
> +}
> +#endif
> +
>  #if defined(TARGET_M68K)
>  static int open_hardware(void *cpu_env, int fd)
>  {
> @@ -7462,7 +7471,7 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags,
>  #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
>          { "/proc/net/route", open_net_route, is_proc },
>  #endif
> -#if defined(TARGET_SPARC)
> +#if defined(TARGET_SPARC) || defined(TARGET_HPPA)
>          { "/proc/cpuinfo", open_cpuinfo, is_proc },
>  #endif
>  #if defined(TARGET_M68K)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

