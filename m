Received: from eggs.gnu.org ([2001:4830:134:3::10]:44812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG2dQ-0006rU-7K
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG2dN-0000It-29
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:58:44 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG2dM-0000Dn-Ix
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:58:40 -0400
Received: by mail-wm1-x343.google.com with SMTP id b14-v6so1548661wmj.3
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 06:58:27 -0700 (PDT)
References: <mhng-9e056850-7b5b-4869-befa-d37d0f37346b@palmer-si-x1c4>
	<0496ac53-1bcf-2aa6-44b8-5901901be889@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4de7646a-6898-0ef1-9198-8e66501e0b41@linaro.org>
Date: Fri, 26 Oct 2018 14:58:23 +0100
MIME-Version: 1.0
In-Reply-To: <0496ac53-1bcf-2aa6-44b8-5901901be889@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>
Cc: sagark@eecs.berkeley.edu, qemu-devel@nongnu.org, peer.adelt@hni.uni-paderborn.de, Alistair Francis <Alistair.Francis@wdc.com>, Michael Clark <mjc@sifive.com>

On 10/26/18 11:49 AM, Bastian Koppelmann wrote:
> I think you can pick up everything up to the RVC conversion which still needs
> the work suggested by Richard. Thanks, for picking it up :)

Even then I thought we were talking about splitting the RV64 insns
into a separate file, reducing the ifdefs, and renaming the arg-sets
to match the instruction formats described in the riscv spec.


r~
