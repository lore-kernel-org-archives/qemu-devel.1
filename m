Received: from eggs.gnu.org ([209.51.188.92]:42320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBbP1-0000vA-Sr
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBbP0-0006EN-Sv
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:37:47 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:59371 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hBbP0-0006Bh-IG
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:37:46 -0400
References: <1554212605-16457-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554212605-16457-6-git-send-email-mateja.marjanovic@rt-rk.com>
	<BN6PR2201MB12517DB6F0F0B64C4A2CD62CC6560@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <4aa5f2b4-5288-ef42-1a56-f427a779ab60@rt-rk.com>
Date: Wed, 3 Apr 2019 10:37:43 +0200
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB12517DB6F0F0B64C4A2CD62CC6560@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 5/5] target/mips: Refactor and fix
 INSERT.<B|H|W|D> instructions
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


On 2.4.19. 22:50, Aleksandar Markovic wrote:
>> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> Subject: [PATCH v4 5/5] target/mips: Refactor and fix INSERT.<B|H|W|D> instructions
>>
>> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>>
>> The old version of the helper for the INSERT.<B|H|W|D> MSA instructions
>> has been replaced with four helpers that don't use switch, and change
>> the endianness of the given index, when executed on a big endian host.
>>
>> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> ---
> ...
>
>
>> +    n %= 16;
> Mateja, could you just clarify what is the purpose of this line (and
> similar three lines involving "%=")? It looks to me that n is already
> limited here to be between 0 and 15, isn't it? (that follows from the
> source code of gen_msa_elm().) What made you insert this line,
> as it stands?

It was

n %= DF_ELEMENTS(df);

but when I deleted the df argument, so it had to be done like
this. I think it's a matter of precaution (in case a number
greater than 15, or 8... is passed as an argument).

> Thanks,
> Aleksandar

Thanks,
Mateja
