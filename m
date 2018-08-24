Received: from eggs.gnu.org ([2001:4830:134:3::10]:41956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ftGXh-0005j8-Ja
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 14:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ftGXf-0001u6-Fd
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 14:10:41 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:34506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ftGXf-0001tW-9Q
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 14:10:39 -0400
Received: by mail-yw1-xc44.google.com with SMTP id y134-v6so3412457ywg.1
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 11:10:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8JPnTaa_uXEMbTbBXwM+ATxBSMs5ed3PJm_R9srag_cQ@mail.gmail.com>
References: <20180820023110.6583-1-jcmvbkbc@gmail.com>
	<CAFEAcA8JPnTaa_uXEMbTbBXwM+ATxBSMs5ed3PJm_R9srag_cQ@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 24 Aug 2018 11:10:37 -0700
Message-ID: <CAMo8BfJg=JhJX-rP+U8rd+feUzuRsTPzJdTyA7+rmA0HyoHD2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: convert to
 do_transaction_failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

On Fri, Aug 24, 2018 at 10:56 AM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 20 August 2018 at 03:31, Max Filippov <jcmvbkbc@gmail.com> wrote:
>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>> ---
>>  target/xtensa/cpu.c       |  2 +-
>>  target/xtensa/cpu.h       |  7 ++++---
>>  target/xtensa/op_helper.c | 12 +++++++-----
>>  3 files changed, 12 insertions(+), 9 deletions(-)
>
> Hi -- thanks for doing this conversion. This change means that
> you'll no longer get guest exceptions for bus errors that happen
> during get_pte()'s page table entry fetch. Don't you need at
> least a TODO comment there indicating that there's missing
> behaviour?

Thanks for taking a look and letting me know, I've missed that entirely.

> (Obviously the ideal would be to switch to address_space_ldl_*
> and handle the case when they don't return MEMTX_OK.)

Yeah, let me do something about it.

-- 
Thanks.
-- Max
