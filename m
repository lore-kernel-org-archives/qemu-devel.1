Received: from eggs.gnu.org ([2001:4830:134:3::10]:42589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1dszEb-0000Rr-Nb
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 18:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1dszEb-0006zW-0N
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 18:37:17 -0400
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:37587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1dszEa-0006z3-RG
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 18:37:16 -0400
Received: by mail-yw0-x244.google.com with SMTP id v137so2444830ywg.4
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 15:37:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <134bcf2e2c0bb9160aa822ddfbc46d9bd51c4305.1505512474.git.alistair.francis@xilinx.com>
References: <134bcf2e2c0bb9160aa822ddfbc46d9bd51c4305.1505512474.git.alistair.francis@xilinx.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 15 Sep 2017 15:37:14 -0700
Message-ID: <CAMo8BfJp=dLbgGsqu8rKAoKxTkMNRHeAUcT74pQSdCpKWqxLPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] target/xtensa: Use the pre-defined
 MEMTXATTRS_UNSPECIFIED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, alistair23@gmail.com

On Fri, Sep 15, 2017 at 2:56 PM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> Instead of using the hardcoded (MemTxAttrs){0} for no memory attributes
> let's use the already defined MEMTXATTRS_UNSPECIFIED macro instead.
>
> This is technically a change of behaviour as MEMTXATTRS_UNSPECIFIED sets
> the unspecified field to 1, but it doesn't look like anything is
> checking this field.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> V2:
>  - Update commit message to indicate the change in behaviour
>
>  target/xtensa/op_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
