Received: from eggs.gnu.org ([209.51.188.92]:59530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LGI-0004ql-D1
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LGH-0004UI-Nz
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:22 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:46782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1LGH-0004SG-HM
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:21 -0500
Received: by mail-pg1-x52f.google.com with SMTP id 196so6940445pgf.13
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 17:22:21 -0800 (PST)
References: <20190305162829.20079-1-philmd@redhat.com>
	<20190305162829.20079-5-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <99f44997-9abb-9e14-04c1-2a78fc76e765@linaro.org>
Date: Tue, 5 Mar 2019 15:53:17 -0800
MIME-Version: 1.0
In-Reply-To: <20190305162829.20079-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/5] hw/mips/malta: Only accept 'monitor'
 pflash of 4MiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On 3/5/19 8:28 AM, Philippe Mathieu-Daudé wrote:
> +
> +        if (blk_getlength(pflash_blk) != FLASH_SIZE) {
> +                error_report("Malta CoreLV card expects a bios of 4MB");
> +                exit(1);
> +        }

Indentation is off, somehow.  Tabs or extra spaces?


r~
