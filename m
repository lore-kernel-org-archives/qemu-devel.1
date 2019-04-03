Received: from eggs.gnu.org ([209.51.188.92]:41577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBbKK-0007cV-6e
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBbKJ-0002dw-Bm
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:32:56 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55562 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hBbKI-0002ch-WB
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:32:55 -0400
References: <1554218121-26766-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554218121-26766-3-git-send-email-mateja.marjanovic@rt-rk.com>
	<BN6PR2201MB1251AB337EE1A659E78D8742C6560@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <f7c7fefc-0fb5-52b3-e502-3caf738367e0@rt-rk.com>
Date: Wed, 3 Apr 2019 10:32:53 +0200
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB1251AB337EE1A659E78D8742C6560@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v5 2/2] target/mips: Optimize
 ILVEV.<B|H|W|D> MSA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Aleksandar Rikalo <arikalo@wavecomp.com>


On 2.4.19. 20:51, Aleksandar Markovic wrote:
>> +/*
>> + * [MSA] ILVEV.D wd, ws, wt
>> + *
>> + *   Vector Interleave Even (Double data elements)
>> + *
>> + */
> Double -> Doubleword

I will change it in v6.
