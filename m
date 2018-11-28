Received: from eggs.gnu.org ([2001:4830:134:3::10]:44529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gS4vm-0005Vt-S6
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 13:51:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gS4vj-0003Cc-P3
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 13:51:26 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:41280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gS4vj-0003BS-EE
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 13:51:23 -0500
Received: by mail-pg1-x531.google.com with SMTP id 70so9883089pgh.8
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 10:51:23 -0800 (PST)
Date: Wed, 28 Nov 2018 10:51:20 -0800 (PST)
In-Reply-To: <57736c8b-767b-aa02-762c-c2d6aed060df@cmss.chinamobile.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-6b342876-a719-4f12-9928-04ffbc498752@palmer-si-x1c4>
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
To: maozhongyi@cmss.chinamobile.com
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, philmd@redhat.com

On Tue, 27 Nov 2018 17:46:04 PST (-0800), maozhongyi@cmss.chinamobile.com wrote:
> Hi, Palmer
>
> On 11/28/18 8:34 AM, Palmer Dabbelt wrote:
>> On Mon, 26 Nov 2018 01:06:33 PST (-0800), Bastian Koppelmann wrote:
>>> On 11/26/18 4:20 AM, Mao Zhongyi wrote:
>>>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>>>> ---
>>>>   target/riscv/cpu.c | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>
>>> Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>>
>> Shouldn't we also use device_class_set_parent_reset right below this?
>
> device_class_set_parent_reset only used for DeviceClass *dc->reset, here
> is CPUClass *cc->reset.

Ah, OK, I didn't look closely enough.

> Thanks,
> Mao
>
>> Either
>> way, I'll queue this one for 3.2.
>>
>> Thanks!
>>
