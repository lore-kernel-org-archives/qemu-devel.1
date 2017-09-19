Received: from eggs.gnu.org ([2001:4830:134:3::10]:35001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duM7D-00006X-Vd
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duM7A-0001Z0-Ax
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:15:19 -0400
Received: from mail-io0-x234.google.com ([2607:f8b0:4001:c06::234]:55009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duM7A-0001Yj-5h
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:15:16 -0400
Received: by mail-io0-x234.google.com with SMTP id h66so671029ioh.11
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 10:15:16 -0700 (PDT)
References: <20170919111721.7931-1-clg@kaod.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4e5b4255-8e4d-2240-fb60-942559c2586d@linaro.org>
Date: Tue, 19 Sep 2017 12:15:00 -0500
MIME-Version: 1.0
In-Reply-To: <20170919111721.7931-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] watchdog/aspeed: fix variable type to
 store reload value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, "Anton D . Kachalov" <mouse@yandex-team.ru>, qemu-devel@nongnu.org

On 09/19/2017 06:17 AM, Cédric Le Goater wrote:
> +    uint64_t reload;
>  
>      if (pclk) {
>          reload = muldiv64(s->regs[WDT_RELOAD_VALUE], NANOSECONDS_PER_SECOND,
>                            s->pclk_freq);
>      } else {
> -        reload = s->regs[WDT_RELOAD_VALUE] * 1000;
> +        reload = s->regs[WDT_RELOAD_VALUE] * 1000UL;

UL does not help ilp32 hosts.  Need ULL or an explicit cast.

r~
