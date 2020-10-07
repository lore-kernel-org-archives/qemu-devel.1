Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D64C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108E82087D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108E82087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ9gM-0001ST-Ne
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 09:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kQ9fh-0000nu-3s
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 09:39:57 -0400
Received: from relay64.bu.edu ([128.197.228.104]:51652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kQ9ff-00063T-5D
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 09:39:56 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 097DdWQQ008551
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 7 Oct 2020 09:39:35 -0400
Date: Wed, 7 Oct 2020 09:39:32 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH v3 02/16] fuzz: Add general virtual-device fuzzer
Message-ID: <20201007133932.ua6tg7hnr3ixpgni@mozz.bu.edu>
References: <20200921022506.873303-1-alxndr@bu.edu>
 <20200921022506.873303-3-alxndr@bu.edu>
 <63ca7622-557b-4217-f15e-ee9b024fbd77@redhat.com>
 <20200921143405.3taiymgzwvscxsry@mozz.bu.edu>
 <m2h7re6k3b.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m2h7re6k3b.fsf@oracle.com>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 09:39:52
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.902, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 201001 1629, Darren Kenny wrote:
> Hi Alex,
> 
> On Monday, 2020-09-21 at 10:34:05 -04, Alexander Bulekov wrote:
> > On 200921 0743, Philippe Mathieu-Daudé wrote:
> >> Hi Alexander,
> >> 
> >> On 9/21/20 4:24 AM, Alexander Bulekov wrote:
> >> > This is a generic fuzzer designed to fuzz a virtual device's
> >> > MemoryRegions, as long as they exist within the Memory or Port IO (if it
> >> > exists) AddressSpaces. The fuzzer's input is interpreted into a sequence
> >> > of qtest commands (outb, readw, etc). The interpreted commands are
> >> > separated by a magic seaparator, which should be easy for the fuzzer to
> >> > guess. Without ASan, the separator can be specified as a "dictionary
> >> > value" using the -dict argument (see libFuzzer documentation).
> >> > 
> >> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> >> > ---
> >> >  tests/qtest/fuzz/general_fuzz.c | 498 ++++++++++++++++++++++++++++++++
> >> >  tests/qtest/fuzz/meson.build    |   1 +
> >> >  2 files changed, 499 insertions(+)
> >> >  create mode 100644 tests/qtest/fuzz/general_fuzz.c
> >> > 
> >> > diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
> >> > new file mode 100644
> >> > index 0000000000..bf75b215ca
> >> > --- /dev/null
> >> > +++ b/tests/qtest/fuzz/general_fuzz.c
> >> > @@ -0,0 +1,498 @@
> >> > +/*
> >> > + * General Virtual-Device Fuzzing Target
> >> > + *
> >> > + * Copyright Red Hat Inc., 2020
> >> > + *
> >> > + * Authors:
> >> > + *  Alexander Bulekov   <alxndr@bu.edu>
> >> > + *
> >> > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> >> > + * See the COPYING file in the top-level directory.
> >> > + */
> >> > +
> >> > +#include "qemu/osdep.h"
> >> > +
> >> > +#include <wordexp.h>
> >> > +
> >> > +#include "hw/core/cpu.h"
> >> > +#include "tests/qtest/libqos/libqtest.h"
> >> > +#include "fuzz.h"
> >> > +#include "fork_fuzz.h"
> >> > +#include "exec/address-spaces.h"
> >> > +#include "string.h"
> >> > +#include "exec/memory.h"
> >> > +#include "exec/ramblock.h"
> >> > +#include "exec/address-spaces.h"
> >> > +#include "hw/qdev-core.h"
> >> > +
> >> > +/*
> >> > + * SEPARATOR is used to separate "operations" in the fuzz input
> >> > + */
> >> > +#define SEPARATOR "FUZZ"
> >> 
> >> Why use a separator when all pkt sizes are known?
> > Good point. 
> > 1. When we add the DMA Pattern OP in patch 04/16, we now have
> > variable-width OPs.
> > 2. Even when everything has a known size, take for example the input:
> > Acb Bd Caaaa Effff
> > Where Operation A has size 3, B: size 2, C size 5 ...:
> > Simply by removing the first byte, we now have a completely different
> > sequence of operations:
> > Cbbdc Aaa Aef Ff...
> > Thus the separators "add some stability" to random mutations:
> > Cb FUZZ Bd FUZZ Caaaa FUZZ Effff ...
> > (Cb is now invalid/ignored, but the rest of the commands are still
> > intact)
> > There is some libfuzzer documentation about this technique:
> > https://github.com/google/fuzzing/blob/master/docs/split-inputs.md#magic-separator
> >
> > There is also a promising "FuzzDataProvider" header library that lets
> > you directly call functions, such as ConsumeBytes, or
> > ConsumeIntegralInRange, but unfortunately it is a C++ header.
> 
> It might make sense to put the definition of SEPARATOR and some variant
> of the above the comments in patch 9 where you're adding this related
> functionality?
> 
> It seems a little out of place here.
> 
> Thanks,
> 
> Darren.
> 

Hi Darren,
If I move the definition of SEPARATOR to Patch 9, I would need some
different way to parse commands here, to keep everything bisectable. I
don't think the separator is only important in the context of the
Crossover functionality (Patch 9) - it is useful in general as a
"stable" way to parse an input into multiple commands.
Is it OK if I keep SEPARATOR in this patch and add the comments you
mention to both this patch and patch 9?
Thanks
-Alex

> >> 
> >> Can you fuzz writing "FUZZ" in memory? Like:
> >> OP_WRITE(0x100000, "UsingLibFUZZerString")?
> >
> > No.. Hopefully that's not a huge problem.
> >
> >> > +
> >> > +enum cmds {
> >> > +    OP_IN,
> >> > +    OP_OUT,
> >> > +    OP_READ,
> >> > +    OP_WRITE,
> >> > +    OP_CLOCK_STEP,
> >> > +};
> >> > +
> >> > +#define DEFAULT_TIMEOUT_US 100000
> >> > +#define USEC_IN_SEC 100000000
> >> 
> >> Are you sure this definition is correct?
> >> 
> > Thanks for the catch...
> >
> >> > +
> >> > +typedef struct {
> >> > +    ram_addr_t addr;
> >> > +    ram_addr_t size; /* The number of bytes until the end of the I/O region */
> >> > +} address_range;
> >> > +
> >> > +static useconds_t timeout = 100000;
> >> [...]
> >> 

