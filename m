Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6CAC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E611C21925
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E611C21925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUYkv-0003Dr-2d
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 11:11:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iUYi3-0007XU-Hp
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:08:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iUYi2-00015R-E0
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:08:03 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:44701)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iUYi2-00014D-54
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:08:02 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M6URd-1iX0bw3P3J-006vPJ; Tue, 12 Nov 2019 17:07:45 +0100
Subject: Re: [PATCH] linux-user: remove host stime() syscall
To: qemu-devel@nongnu.org
References: <20191112142556.6335-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b696978a-fb10-0e7d-ae4f-f63408b1fa44@vivier.eu>
Date: Tue, 12 Nov 2019 17:07:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191112142556.6335-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JC9DoKQFAwpfHRL89qKFbCvA3T2S1AFBhZYIiuXK23B8Vs7iAWJ
 acv0L/QJbB5+brSZoD5gmZLwBdDgcEupRtH6LSSuP3XAYzfRRT8VvTvuKkjuvvY/feC0ZmK
 73xbvq3u/gborA/UL6zRJlpHo2BigoRlQyD5CuKalAn+JYmdeVyRVTGHUljfqgmxk8n9/TE
 PAWRccKbrRkbpTekNTO5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WcvLFGuu5aM=:WBQYcLuxYsztcrGByhXgEl
 +xMpPN2fxhDV3Os5A3RKLaAmj3YGdFuws6PuF5BSy1TUy0ONIYKc1x0P2/yCdOi4fJEzVMIzW
 3Cocs9G92ikFnA8Hw7KpanMiwkgY2AOhgWHqK0GkqhgUEedF9tA+ZLuap+62xUR5O31lN98um
 HYcyEoAuunqN2/AYSce6dBXksgluZi5I0RU8kthwMFhD3sc2ROvvmIqJmwiYIiqrVjbR/8HvH
 I2b6dBcJoqjH/FJ0fA4z/4ml/+zAKNGNokwPHYw2bSrehwl4B2RcxWmI4m4mKqS7/974n+QwU
 yAtdr9vxvXKU1AstQpX6bVP6RkORN/so2k+cYDSfzk/5GSpgSkGnIBLx52RsekTmoHM1O2E6R
 69xCPap49i3GG44HkaWrJKcbMILbpNAMyAA7kWanbZRLAwrPSGKOM0CK2/mACs/06GSPUesxT
 W6z5Zx2WrFDHexofi5GoxOh02qS3oNfKc1uIwMbJCff3y3hSY+WxK8JzFdEMu2os8miOZc4gX
 ApeBc/xaiqQNZFH9PP+strlGfNSOSsHHJlFihJyHrRgzm3PdoeLbifnWlRgx1dSsCWhvLGsFF
 ytmu6uUVIHY8jTt/5r0gtUCE6XHgvbfkcvnR3vXdyEBLWrvKhqQfqREve8+4sr44cT3wy0927
 EMRF+wuLoFfDx42gDmzpsSzYljyz4NR8VdbzwQT/dqs2pJVbWeTK6kMpdljNmy+OATkUgsTeR
 FCoyzCyBAQo89OA3BAsy0XW4yy9ccSrT397juSZZPv8aLMkM76JWBg7/WmkvMPBDTZa1wYN+H
 10bNqM39xk3SXAnQB+/0yIXnhU7HqZgbYHSWHDeTdLwaP9/6ch2bO3lMCLjH24cwiizmcVA7g
 dpiDP4lBP1P49kgIqPAeKRvd1iF/Zee6P/SuO116g=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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
Cc: "Daniel P . Berrange" <dan@berrange.com>,
 Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 Cole Robinson <crobinso@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 12/11/2019 à 15:25, Laurent Vivier a écrit :
> stime() has been withdrawn from glibc
> (12cbde1dae6f "Use clock_settime to implement stime; withdraw stime.")
> 
> Implement the target stime() syscall using host
> clock_settime(CLOCK_REALTIME, ...) as it is done internally in glibc.
> 
> Tested qemu-ppc/x86_64 with:
> 
> 	#include <time.h>
> 	#include <stdio.h>
> 
> 	int main(void)
> 	{
> 		time_t t;
> 		int ret;
> 
> 		/* date -u -d"2019-11-12T15:11:00" "+%s" */
> 		t = 1573571460;
> 		ret = stime(&t);
> 		printf("ret %d\n", ret);
> 		return 0;
> 	}
> 
>         # date; ./stime; date
>         Tue Nov 12 14:18:32 UTC 2019
>         ret 0
>         Tue Nov 12 15:11:00 UTC 2019
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1852115
> Reported-by: Cole Robinson <crobinso@redhat.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index ab9d933e53af..c4dcdc94b10c 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7763,10 +7763,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #ifdef TARGET_NR_stime /* not on alpha */
>      case TARGET_NR_stime:
>          {
> -            time_t host_time;
> -            if (get_user_sal(host_time, arg1))
> +            struct timespec ts;
> +            ts.tv_nsec = 0;
> +            if (get_user_sal(ts.tv_sec, arg1)) {
>                  return -TARGET_EFAULT;
> -            return get_errno(stime(&host_time));
> +            }
> +            return get_errno(clock_settime(CLOCK_REALTIME, &ts));
>          }
>  #endif
>  #ifdef TARGET_NR_alarm /* not on alpha */
> 

Applied to my linux-user branch.

Thanks,
Laurent

