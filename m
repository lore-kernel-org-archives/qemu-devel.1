Received: from eggs.gnu.org ([2001:4830:134:3::10]:49835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gG4IG-0003lx-9u
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gG4GD-0000ui-4W
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:42:56 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gG4GC-0000uN-LN
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:42:53 -0400
Received: by mail-pl1-x643.google.com with SMTP id b5-v6so76100pla.6
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:42:52 -0700 (PDT)
Date: Fri, 26 Oct 2018 08:42:49 -0700 (PDT)
In-Reply-To: <35fa718e-1ee0-9ed1-9af3-045852275c7d@mail.uni-paderborn.de>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-65acecc6-386e-4cfc-9be3-c2c522880ce1@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 02/29] targer/riscv: Activate decodetree
 and implemnt LUI & AUIPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: richard.henderson@linaro.org, sagark@eecs.berkeley.edu, qemu-devel@nongnu.org, peer.adelt@hni.uni-paderborn.de, Alistair Francis <Alistair.Francis@wdc.com>, Michael Clark <mjc@sifive.com>

On Fri, 26 Oct 2018 07:53:17 PDT (-0700), Bastian Koppelmann wrote:
>
> On 10/26/18 3:58 PM, Richard Henderson wrote:
>> On 10/26/18 11:49 AM, Bastian Koppelmann wrote:
>>> I think you can pick up everything up to the RVC conversion which still needs
>>> the work suggested by Richard. Thanks, for picking it up :)
>> Even then I thought we were talking about splitting the RV64 insns
>> into a separate file, reducing the ifdefs, and renaming the arg-sets
>> to match the instruction formats described in the riscv spec.
>
>
> Yes, you are right I forgot that.

OK, so I think I'll hold off for a v3, then.
