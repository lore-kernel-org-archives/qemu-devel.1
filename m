Received: from eggs.gnu.org ([2001:4830:134:3::10]:44226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eoYwD-00055T-6H
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:16:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eoYw8-0003X0-R7
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:16:17 -0500
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:45404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eoYw8-0003VD-KG
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:16:12 -0500
Received: by mail-pg0-x231.google.com with SMTP id e11so949448pgq.12
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 10:16:12 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-4-alex.bennee@linaro.org>
	<CAFEAcA-=Oh=MgSGoheP70o9dy0hgo64PBtRH5u1u51bjqUAh7A@mail.gmail.com>
	<87lgfm9u7a.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <595a9f5d-80ca-7ff9-5dd7-f4177a348afc@linaro.org>
Date: Wed, 21 Feb 2018 10:16:07 -0800
MIME-Version: 1.0
In-Reply-To: <87lgfm9u7a.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 03/32] target/arm/cpu64: allow fp16 to
 be disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 02/21/2018 08:35 AM, Alex Bennée wrote:
>> Good news everybody -- this is an opportunity for a naming bikeshed
>> discussion!
...
>>  * use the hwcaps names that Linux defines and prints in /proc/cpuinfo
>>    (in this case that would be a combination of "fphp" and "asimdhp",
>>    since hwcaps reflects the ID register setup that allows a CPU
>>    to report support for one and not the other)
> 
> In naming I favour the Arm ARM over whatever Linux-ism /proc came up
> with.

Likewise.


r~
