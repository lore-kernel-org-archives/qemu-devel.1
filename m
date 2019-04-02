Received: from eggs.gnu.org ([209.51.188.92]:57137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBH3l-0000OM-0y
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBH3j-0001Z8-R7
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:54:28 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34282 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hBH3j-0001Xl-B5
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:54:27 -0400
References: <1553845000-6537-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1553845000-6537-4-git-send-email-mateja.marjanovic@rt-rk.com>
	<CY4PR2201MB125474BCF00E6B16576EE851C6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <4989b987-2a0f-1942-5838-3b5c4e9ba249@rt-rk.com>
Date: Tue, 2 Apr 2019 12:54:25 +0200
MIME-Version: 1.0
In-Reply-To: <CY4PR2201MB125474BCF00E6B16576EE851C6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 3/5] target/mips: Different approach
 toward COPY_S MSA instr. and big endian fix
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


On 1.4.19. 20:01, Aleksandar Markovic wrote:
>> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> Subject: [PATCH v3 3/5] target/mips: Different approach toward COPY_S MSA instr. and big endian fix
>>
> "Different approach toward..." -> "Refactor and fix COPY_S.<B|H|W|D> instructions"
I will change that in v4.
>
>> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>>
>> The old version of the helper for the COPY_S.<B|H|W|D> MSA instructions
>> has been replaced with a four helpers that don't use switch, and change
>> the endianness of the given index, when executed on a big endian host.
>>
>> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> ---
Thanks,
Mateja
