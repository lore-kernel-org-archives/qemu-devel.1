Received: from eggs.gnu.org ([209.51.188.92]:49235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyMTz-0006yY-My
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyMTx-00015u-LE
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:04:11 -0500
References: <20190225200318.16102-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <76f82a00-ca72-3881-d83b-a7902ec6a209@redhat.com>
Date: Mon, 25 Feb 2019 21:04:05 +0100
MIME-Version: 1.0
In-Reply-To: <20190225200318.16102-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] s390x/tcg: Cleanups and
 refactorings for vector instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>

On 25.02.19 21:03, David Hildenbrand wrote:
> Before we start with the real magic, some more cleanups and refactorings.
> This series does not depend on other patches not yet in master.
> 
> Also add a variant of "LOAD LENGTHENED" that is used along with
> vector instructions in linux (HFP instructions that can be used without
> HFP  ). Implement "LOAD COUNT TO BLOCK BOUNDARY", introduced with
> vector facility but not operating on vectors.
> 
> v1 -> v2:
> - "s390x/tcg: Simplify disassembler operands initialization"
> -- s/simply/simplify/ in description
> - "s390x/tcg: Implement LOAD COUNT TO BLOCK BOUNDARY"
> -- Use bit magic without a helper to calculate the count

Oh, and dropped the "inline" from "s390x/tcg: Factor out
gen_addi_and_wrap_i64() from get_address()"

> 
> David Hildenbrand (7):
>   s390x/tcg: RXE has an optional M3 field
>   s390x/tcg: Simplify disassembler operands initialization
>   s390x/tcg: Clarify terminology in vec_reg_offset()
>   s390x/tcg: Factor out vec_full_reg_offset()
>   s390x/tcg: Factor out gen_addi_and_wrap_i64() from get_address()
>   s390x/tcg: Implement LOAD LENGTHENED short HFP to long HFP
>   s390x/tcg: Implement LOAD COUNT TO BLOCK BOUNDARY
> 
>  target/s390x/cc_helper.c     |  8 +++
>  target/s390x/helper.c        |  1 +
>  target/s390x/insn-data.def   |  4 ++
>  target/s390x/insn-format.def |  2 +-
>  target/s390x/internal.h      |  1 +
>  target/s390x/translate.c     | 94 +++++++++++++++++++++++++-----------
>  6 files changed, 80 insertions(+), 30 deletions(-)
> 


-- 

Thanks,

David / dhildenb
