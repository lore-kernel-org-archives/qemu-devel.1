Received: from eggs.gnu.org ([2001:4830:134:3::10]:35741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1du0pn-0002n7-NZ
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1du0pm-0008Pg-OF
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:31:55 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:37630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1du0pm-0008PQ-HZ
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:31:54 -0400
Received: by mail-wr0-x244.google.com with SMTP id u48so873549wrf.4
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 11:31:53 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAMo8BfJp=dLbgGsqu8rKAoKxTkMNRHeAUcT74pQSdCpKWqxLPg@mail.gmail.com>
References: <134bcf2e2c0bb9160aa822ddfbc46d9bd51c4305.1505512474.git.alistair.francis@xilinx.com>
	<CAMo8BfJp=dLbgGsqu8rKAoKxTkMNRHeAUcT74pQSdCpKWqxLPg@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 18 Sep 2017 11:31:21 -0700
Message-ID: <CAKmqyKP0Z7nPer_cZxVjwU4iaR9yxJz2sR09bfghF7ykZXoT2Q@mail.gmail.com>
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
To: Max Filippov <jcmvbkbc@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel <qemu-devel@nongnu.org>

On Fri, Sep 15, 2017 at 3:37 PM, Max Filippov <jcmvbkbc@gmail.com> wrote:
> On Fri, Sep 15, 2017 at 2:56 PM, Alistair Francis
> <alistair.francis@xilinx.com> wrote:
>> Instead of using the hardcoded (MemTxAttrs){0} for no memory attributes
>> let's use the already defined MEMTXATTRS_UNSPECIFIED macro instead.
>>
>> This is technically a change of behaviour as MEMTXATTRS_UNSPECIFIED sets
>> the unspecified field to 1, but it doesn't look like anything is
>> checking this field.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>> V2:
>>  - Update commit message to indicate the change in behaviour
>>
>>  target/xtensa/op_helper.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>

Thanks Max,

Are you going to take this Max? Otherwise can it go through Peter?

Thanks,
Alistair

>
> --
> Thanks.
> -- Max
