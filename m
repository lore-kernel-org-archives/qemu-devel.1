Received: from eggs.gnu.org ([2001:4830:134:3::10]:44544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1dG6Pk-0004pu-O5
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1dG6Pj-0006fK-UJ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:24:04 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1dG6Pj-0006ek-Pg
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:24:03 -0400
Received: by mail-oi0-x243.google.com with SMTP id w138so2657918oiw.3
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 09:24:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c5d963e7-ef71-0ed5-aaae-01d492e4fd8b@redhat.com>
References: <1496212144-14947-1-git-send-email-yang.zhong@intel.com>
	<c5d963e7-ef71-0ed5-aaae-01d492e4fd8b@redhat.com>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Wed, 31 May 2017 18:24:01 +0200
Message-ID: <CABoDooMMWkkPJ+5DxBYd0BwQ_q9rJXuUyf0PL50zdG6T89JD-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/6] tcg: move the tcg files into tcg/
 subdirectory.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, Eric Blake <eblake@redhat.com>, anthony.xu@intel.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hello,

On Wed, May 31, 2017 at 2:54 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 31/05/2017 08:28, Yang Zhong wrote:
>> Move the tcg related files into tcg/ subdirectory, which will make
>> the code more clean in qemu. Next step, we will base on those changes
>> to disable tcg.
>
> You should also move cpu-exec.c, cpu-exec-common.c and cputlb.c.

The LICENSE file in tcg directory contains this:

---------------------------------------------------------------------
All the files in this directory and subdirectories are released under
a BSD like license (see header in each file). No other license is
accepted.
---------------------------------------------------------------------

All source files have an explicit BSD license except tcg-runtime.h
which has none and aarch64 files which are licensed under GPL.  So we
are already not following the rule expressed in LICENSE.

tcg-runtime.c is BSD
tci.c is GPL
translate-all.[ch] are GPL
translate-common.c is GPL
cpu-exec.c cpu-exec-common.c cputlb.c are GPL

I guess the LICENSE file has become obsolete and so should be removed
(and Fabrice Bellard should perhaps be let know about that just in
case).

Thanks,

Laurent

> Also, feel free to squash everything in a single patch.
> Thanks,
>
> Paolo
>
>> Yang Zhong (6):
>>   tcg: move tcg-runtime.c to tcg/ subdirectory
>>   tcg: move translate-all.c to tcg/ subdirectory
>>   tcg: move tcg header file
>>   tcg: move translate-common.c to tcg/ subdirectory
>>   tcg: move tci.c to tcg/ subdirectory
>>   tcg: change tcg related file's compile definition
>>
>>  Makefile.objs                                | 1 +
>>  Makefile.target                              | 8 ++------
>>  tcg/Makefile.objs                            | 2 ++
>>  tcg-runtime.c => tcg/tcg-runtime.c           | 0
>>  tci.c => tcg/tci.c                           | 0
>>  tcg/trace-events                             | 6 ++++++
>>  translate-all.c => tcg/translate-all.c       | 2 +-
>>  translate-all.h => tcg/translate-all.h       | 0
>>  translate-common.c => tcg/translate-common.c | 0
>>  trace-events                                 | 3 ---
>>  10 files changed, 12 insertions(+), 10 deletions(-)
>>  create mode 100644 tcg/Makefile.objs
>>  rename tcg-runtime.c => tcg/tcg-runtime.c (100%)
>>  rename tci.c => tcg/tci.c (100%)
>>  create mode 100644 tcg/trace-events
>>  rename translate-all.c => tcg/translate-all.c (99%)
>>  rename translate-all.h => tcg/translate-all.h (100%)
>>  rename translate-common.c => tcg/translate-common.c (100%)
>>
>
