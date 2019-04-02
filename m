Received: from eggs.gnu.org ([209.51.188.92]:44263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBGIs-0003s7-59
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBGAZ-0002V3-U5
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:57:28 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:42027 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hBGAZ-0002TQ-Hk
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:57:27 -0400
References: <1554129501-27175-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<CY4PR2201MB1254B9E68F5103DE4ECBD140C6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <93aa5570-10f0-8a29-3bcd-c64e6f0992bf@rt-rk.com>
Date: Tue, 2 Apr 2019 11:57:25 +0200
MIME-Version: 1.0
In-Reply-To: <CY4PR2201MB1254B9E68F5103DE4ECBD140C6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/2] target/mips: Integer division by zero
 in MSA insturctions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>


On 1.4.19. 19:43, Aleksandar Markovic wrote:
>> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> Subject: [PATCH 0/2] target/mips: Integer division by zero in MSA insturctions
>>
> The title look incomplete and uninformative: it mentions "the division by zero"
> - but what is done in this case? Is this an implementation of that case? Or fix?
> Or something else?
>
> The title should clearly and in a condensed form explain what is done in the
> series.
Yes, you are right, it looks unclear, I will change it in v2.
>
>> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>>
>> Integer division by zero in MSA insturctions results in unpredictable
>> behaviour, but according to the hardware, it depends on the sign of
>> the dividend, or always returns the same value.
>>
> This is a very unclear sentence.
>
> A sentence that says that the series makes the behavior of QEMU
> and the reference hardware the same in cases of division and modulus
> operations with zero divisor is missing.
I will change it and make it more clear and understandable in v2.
>
>> Mateja Marjanovic (2):
>>   target/mips: DIV_<U|S>.<B|H|W|D> MSA insturctions fixed
>>   target/mips: MOD_<U|S>.<B|H|W|D> MSA insturctions fixed
>>
>> target/mips/msa_helper.c | 11 +++++++----
>> 1 file changed, 7 insertions(+), 4 deletions(-)
> Check spelling.
I will try to find some tool for that.
>
> Thanks,
> Aleksandar
Thanks,
Mateja
