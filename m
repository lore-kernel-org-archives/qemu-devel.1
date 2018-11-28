Received: from eggs.gnu.org ([2001:4830:134:3::10]:44962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gRnoM-0006VA-HD
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 19:34:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gRnoJ-0001PT-9T
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 19:34:38 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:38224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gRnoJ-0001Nk-1z
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 19:34:35 -0500
Received: by mail-pl1-x633.google.com with SMTP id e5so16448633plb.5
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 16:34:33 -0800 (PST)
Date: Tue, 27 Nov 2018 16:34:32 -0800 (PST)
In-Reply-To: <d17b7767-a72f-a84a-a65d-d848db42d030@mail.uni-paderborn.de>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-22cf4e89-cf9f-4a1d-b254-72b66e51dd82@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] riscv/cpu: use
 device_class_set_parent_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: maozhongyi@cmss.chinamobile.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, philmd@redhat.com

On Mon, 26 Nov 2018 01:06:33 PST (-0800), Bastian Koppelmann wrote:
> On 11/26/18 4:20 AM, Mao Zhongyi wrote:
>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>> ---
>>   target/riscv/cpu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>
> Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Shouldn't we also use device_class_set_parent_reset right below this?  Either
way, I'll queue this one for 3.2.

Thanks!
