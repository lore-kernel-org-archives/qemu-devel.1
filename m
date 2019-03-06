Received: from eggs.gnu.org ([209.51.188.92]:34670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1RUq-0003CD-5e
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:01:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1RUk-0006P3-Er
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:01:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1RUk-0006HP-8E
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:01:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id d17so12234142wre.10
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 00:01:34 -0800 (PST)
References: <20190305162829.20079-1-philmd@redhat.com>
	<20190305162829.20079-5-philmd@redhat.com>
	<99f44997-9abb-9e14-04c1-2a78fc76e765@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <47bf07eb-529d-eef0-3ab5-c1107e2582cf@redhat.com>
Date: Wed, 6 Mar 2019 09:01:30 +0100
MIME-Version: 1.0
In-Reply-To: <99f44997-9abb-9e14-04c1-2a78fc76e765@linaro.org>
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
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On 3/6/19 12:53 AM, Richard Henderson wrote:
> On 3/5/19 8:28 AM, Philippe Mathieu-Daudé wrote:
>> +
>> +        if (blk_getlength(pflash_blk) != FLASH_SIZE) {
>> +                error_report("Malta CoreLV card expects a bios of 4MB");
>> +                exit(1);
>> +        }
> 
> Indentation is off, somehow.  Tabs or extra spaces?

Oops... Probably extra spaces, since checkpatch didn't complain.

I'll let Markus fix this if it takes this series ;)

Thanks!

Phil.
