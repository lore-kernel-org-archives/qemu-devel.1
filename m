Received: from eggs.gnu.org ([2001:4830:134:3::10]:50886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drsIX-000844-Ht
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drsIU-0005hL-83
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:00:45 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drsIU-0005hA-14
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:00:42 -0400
Received: by mail-qt0-x244.google.com with SMTP id t46so2305184qtj.3
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 14:00:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170911204936.5020-1-f4bug@amsat.org>
	<e4be431e-0c31-baf7-7e0b-8419fa507478@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0fa28753-c353-8f64-81f4-ccd992455641@amsat.org>
Date: Tue, 12 Sep 2017 18:00:38 -0300
MIME-Version: 1.0
In-Reply-To: <e4be431e-0c31-baf7-7e0b-8419fa507478@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg/ppc: disable atomic write check on
 ppc32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

On 09/12/2017 02:01 PM, Richard Henderson wrote:
> On 09/11/2017 01:49 PM, Philippe Mathieu-Daudé wrote:
>> -        atomic_set((uint64_t *)jmp_addr, pair);
>> +        atomic_set__nocheck((uint64_t *)jmp_addr, pair);
>>           flush_icache_range(jmp_addr, jmp_addr + 8);
>>       } else {
>>           intptr_t diff = addr - jmp_addr;
>>
> 
> Queued, thanks.

Thanks Richard for adding the comment requested by Peter!
