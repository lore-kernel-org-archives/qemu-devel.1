Received: from eggs.gnu.org ([2001:4830:134:3::10]:49493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDoPX-0006Pq-5K
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDoPS-0001WJ-Ck
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:50:55 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:37006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1fDoPS-0001Vl-0s
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:50:50 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
References: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
	<20180501142222.19154-3-kbastian@mail.uni-paderborn.de>
	<04b2ae36-e7ec-3b78-5443-09fe25d2ebb3@amsat.org>
	<d620b0e6-36d4-722d-d049-46957f02c797@mail.uni-paderborn.de>
Message-ID: <dfe02f14-c8a7-a328-0bd9-ae623fffeacc@mail.uni-paderborn.de>
Date: Wed, 2 May 2018 11:50:32 +0200
MIME-Version: 1.0
In-Reply-To: <d620b0e6-36d4-722d-d049-46957f02c797@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 02/12] tests/tcg/tricore: Add build
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Florian Artmeier <florian.artmeier@efs-auto.de>, David Brenken <david.brenken@efs-auto.de>, qemu-devel@nongnu.org, Georg Hofstetter <georg.hofstetter@efs-auto.de>

On 05/02/2018 11:26 AM, Bastian Koppelmann wrote:
> Hi Phil,
> 
[...]
>> I then get:
>>
>> tricore-softmmu/qemu-system-tricore -M tricore_testboard -nographic
>> -kests/tcg/tricore/test_muls.tst -d in_asm
>> QEMU 2.12.50 monitor - type 'help' for more information
>> (qemu) QEMU 2.12.50 monitor - type 'help' for more information
>> (qemu) IN:
>> 0x80000000:  qemu-system-tricore: function cpu_get_phys_page_attrs_debug
>> not implemented, aborting
> 
> This is odd. I'll try to reproduce it.

It looks like this is due to -d in_asm. I'll sent fix this in a different patchset.

Cheers,
Bastian
