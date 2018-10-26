Received: from eggs.gnu.org ([2001:4830:134:3::10]:34474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gG3Ui-0003Nv-1X
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gG3Ue-0002lj-Sy
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:53:47 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:33522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gG3Ue-0002eL-BI
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:53:44 -0400
References: <mhng-9e056850-7b5b-4869-befa-d37d0f37346b@palmer-si-x1c4>
	<0496ac53-1bcf-2aa6-44b8-5901901be889@mail.uni-paderborn.de>
	<4de7646a-6898-0ef1-9198-8e66501e0b41@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <35fa718e-1ee0-9ed1-9af3-045852275c7d@mail.uni-paderborn.de>
Date: Fri, 26 Oct 2018 16:53:17 +0200
MIME-Version: 1.0
In-Reply-To: <4de7646a-6898-0ef1-9198-8e66501e0b41@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
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
To: Richard Henderson <richard.henderson@linaro.org>, Palmer Dabbelt <palmer@sifive.com>
Cc: sagark@eecs.berkeley.edu, qemu-devel@nongnu.org, peer.adelt@hni.uni-paderborn.de, Alistair Francis <Alistair.Francis@wdc.com>, Michael Clark <mjc@sifive.com>


On 10/26/18 3:58 PM, Richard Henderson wrote:
> On 10/26/18 11:49 AM, Bastian Koppelmann wrote:
>> I think you can pick up everything up to the RVC conversion which still needs
>> the work suggested by Richard. Thanks, for picking it up :)
> Even then I thought we were talking about splitting the RV64 insns
> into a separate file, reducing the ifdefs, and renaming the arg-sets
> to match the instruction formats described in the riscv spec.


Yes, you are right I forgot that.

Cheers,

Bastian
