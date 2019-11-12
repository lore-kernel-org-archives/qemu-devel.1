Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E6FC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 19:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C0AE21783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 19:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0AE21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUbTi-0000ST-Ep
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 14:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iUbT1-0008OU-TN
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 14:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iUbT0-0007i4-7d
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 14:04:43 -0500
Received: from relay64.bu.edu ([128.197.228.104]:57324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iUbT0-0007hl-3l
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 14:04:42 -0500
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: 144.121.20.162.lightower.net [144.121.20.162] (may be forged)
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id xACJ4CmN025844
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
 Tue, 12 Nov 2019 14:04:12 -0500
Subject: Re: [PATCH v4 15/20] fuzz: add fuzzer skeleton
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-16-alxndr@bu.edu>
 <20191107125540.GA365089@stefanha-x1.localdomain>
From: Alexander Bulekov <alxndr@bu.edu>
Message-ID: <488e43a4-91f9-69a0-93a0-97553d57cbb7@bu.edu>
Date: Tue, 12 Nov 2019 14:04:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191107125540.GA365089@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6.x [fuzzy]
X-Received-From: 128.197.228.104
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/7/19 7:55 AM, Stefan Hajnoczi wrote:
> On Wed, Oct 30, 2019 at 02:50:00PM +0000, Oleinik, Alexander wrote:
>> diff --git a/tests/fuzz/fuzz.c b/tests/fuzz/fuzz.c
>> new file mode 100644
>> index 0000000000..0e38f81c48
>> --- /dev/null
>> +++ b/tests/fuzz/fuzz.c
>> @@ -0,0 +1,177 @@
>> +/*
>> + * fuzzing driver
>> + *
>> + * Copyright Red Hat Inc., 2019
>> + *
>> + * Authors:
>> + *  Alexander Bulekov   <alxndr@bu.edu>
> 
> Bulekov instead of Oleinik?
Yes I changed my last name and the approval from the court finally came 
through last week :)
I'll make sure its consistent across v5.

>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
> 
> stdio.h and stdlib.h are already included by qemu/osdep.h.
> 
>> +/* Executed for each fuzzing-input */
>> +int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size)
>> +{
>> +    if (fuzz_target->fuzz) {
> 
> Will this ever be NULL?
I'll remove the check

>> +        fuzz_target->fuzz(fuzz_qts, Data, Size);
>> +    }
>> +    return 0;
>> +}
>> +
>> +/* Executed once, prior to fuzzing */
>> +int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>> +{
>> +
>> +    char *target_name;
>> +
>> +    /* Initialize qgraph and modules */
>> +    qos_graph_init();
>> +    module_call_init(MODULE_INIT_FUZZ_TARGET);
>> +    module_call_init(MODULE_INIT_QOM);
>> +    module_call_init(MODULE_INIT_LIBQOS);
>> +
>> +    if (*argc <= 1) {
>> +        usage(**argv);
>> +    }
>> +
>> +    /* Identify the fuzz target */
>> +    target_name = (*argv)[1];
>> +    if (!strstr(target_name, "--fuzz-target=")) {
>> +        usage(**argv);
>> +    }
>> +
>> +    target_name += strlen("--fuzz-target=");
>> +
>> +    fuzz_target = fuzz_get_target(target_name);
>> +    if (!fuzz_target) {
>> +        usage(**argv);
>> +    }
>> +
>> +    fuzz_qts = qtest_setup();
>> +
>> +    if (!fuzz_target) {
> 
> This is dead code since fuzz_target was already checked above.  Please
> remove this if statement.
> 
>> +        fprintf(stderr, "Error: Fuzz fuzz_target name %s not found\n",
>> +                target_name);
>> +        usage(**argv);
>> +    }
>> +
>> +    if (fuzz_target->pre_vm_init) {
>> +        fuzz_target->pre_vm_init();
>> +    }
>> +
>> +    /* Run QEMU's softmmu main with the fuzz-target dependent arguments */
>> +    char *init_cmdline = fuzz_target->get_init_cmdline(fuzz_target);
> 
> Where is init_cmdline freed or should this be const char *?
> 
>> +    wordexp_t result;
>> +    wordexp(init_cmdline, &result, 0);
> 
> What is the purpose of word expansion here?
The fuzz target devs can specify arguments in a single string and not 
worry about calculating the argc and **argv - we take care of it for them.

>> +
>> +    qemu_init(result.we_wordc, result.we_wordv, NULL);
>> +
>> +    if (fuzz_target->pre_fuzz) {
>> +        fuzz_target->pre_fuzz(fuzz_qts);
>> +    }
>> +
>> +    return 0;
>> +}
>> diff --git a/tests/fuzz/fuzz.h b/tests/fuzz/fuzz.h
>> new file mode 100644
>> index 0000000000..b569b622d7
>> --- /dev/null
>> +++ b/tests/fuzz/fuzz.h
>> @@ -0,0 +1,66 @@
>> +/*
>> + * fuzzing driver
>> + *
>> + * Copyright Red Hat Inc., 2019
>> + *
>> + * Authors:
>> + *  Alexander Bulekov   <alxndr@bu.edu>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#ifndef FUZZER_H_
>> +#define FUZZER_H_
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/units.h"
>> +#include "qapi/error.h"
>> +#include "exec/memory.h"
>> +#include "tests/libqtest.h"
>> +
>> +
> 
> Some documentation would be nice:
> 
...
> Does the caller need to call g_free() on the returned string?  Please
> document this.
...
> s/to to/to/
...
> Please also mention that QEMU has been initialized at this point.
> 
...
> "makes a copy of *target" -> does this mean the argument type can be
> const FuzzTarget *target?
> 

Thanks - I made changes to address these.
-Alex

-- 
===
I recently changed my last name from Oleinik to Bulekov
===

