Received: from eggs.gnu.org ([2001:4830:134:3::10]:54300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gFzgE-0000VY-5F
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gFzg2-0007Q4-IA
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:49:22 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:45984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gFzg2-0007OU-AO
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:49:14 -0400
References: <mhng-9e056850-7b5b-4869-befa-d37d0f37346b@palmer-si-x1c4>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <0496ac53-1bcf-2aa6-44b8-5901901be889@mail.uni-paderborn.de>
Date: Fri, 26 Oct 2018 12:49:10 +0200
MIME-Version: 1.0
In-Reply-To: <mhng-9e056850-7b5b-4869-befa-d37d0f37346b@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Palmer Dabbelt <palmer@sifive.com>
Cc: sagark@eecs.berkeley.edu, richard.henderson@linaro.org, qemu-devel@nongnu.org, peer.adelt@hni.uni-paderborn.de, Alistair Francis <Alistair.Francis@wdc.com>, Michael Clark <mjc@sifive.com>


On 10/25/18 6:58 PM, Palmer Dabbelt wrote:
>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>
> How do you want to go about merging these?  It looks like it should be 
> possible to merge the patch set piecemeal, which I'd actually be happy 
> doing as it'll be easier to get these out for testing that way.  That 
> way we can avoid having one day where everyone changes over to a new 
> decoder.  If that's OK then I'll start slurping up this up into my 
> weekly pull requests as I can review them, with the idea being that I 
> won't re-order anything (in other words, I'll start at the first patch 
> and take patches until I find one that isn't ready to go).


I think you can pick up everything up to the RVC conversion which still 
needs the work suggested by Richard. Thanks, for picking it up :)

Cheers,

Bastian
