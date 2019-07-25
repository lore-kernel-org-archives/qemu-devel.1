Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857E7C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60EAA22BED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EAA22BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqZ0H-0001AQ-NM
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 04:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41982)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqZ06-0000li-RS
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqZ05-0000sL-KT
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:21:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqZ05-0000sC-Ch
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:21:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so35184288wme.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 01:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2kgRJ5seoJyla17aFynOL4gFWXROT8uzogMVsv8r03w=;
 b=c61FPNqt1CJ+YooxUUmwCMdaN6u+RPgSIICUB9PbgJwq/w2BK3omO0TPIHYj6mZn8H
 OGCAJnwDhg9XMGC4IhvYCwb7lSetg/ETYCypt3Y74FnNEfoSc2jucVMrFQj8fe0wftW3
 kEpT7lxtY+usEERxOO74pLRZT0hWj6hmlDaGGt4l7Luphtams+B/Bnevm4VdA1IaMulX
 u1McNIHNud5+JavRYKMwCoLiaddQunsfeqEBMW+HPrspWjMAIicx9ufJuERbJUg8pCvU
 bLcbIyNXwcYXNaaYncN3Ykqw3umwSECdlmh3tXXaxQtDWpPx/uXDspOGhN7ZiVGamawP
 dUsg==
X-Gm-Message-State: APjAAAXWvHl9ON316bIeyL9bnAilC72zbnC0hJrKFwuaNXZpXnBMqnDI
 FmMAHVU6+5nu0VYTyp2vZmRlEQ==
X-Google-Smtp-Source: APXvYqwDV5PBUm367F2H3lmE0IJPqxds6HdWFyZFv/6sTclw9JM1aLDn2cJ0trqvwW7rp0Zme4DXjA==
X-Received: by 2002:a1c:d185:: with SMTP id i127mr80805633wmg.63.1564042880147; 
 Thu, 25 Jul 2019 01:21:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id e3sm42777752wrt.93.2019.07.25.01.21.19
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 01:21:19 -0700 (PDT)
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-9-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <76dc362b-ae7c-6c81-f068-c7faf00d5b05@redhat.com>
Date: Thu, 25 Jul 2019 10:21:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725032321.12721-9-alxndr@bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [RFC 08/19] fuzz: add shims to intercept libfuzzer
 init
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
Cc: "bsd@redhat.com" <bsd@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/07/19 05:23, Oleinik, Alexander wrote:
> Intercept coverage buffer registration calls and use this information to
> copy them to shared memory, if using fork() to avoid resetting device
> state.
> 
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  tests/fuzz/fuzzer_hooks.c | 106 ++++++++++++++++++++++++++++++++++++++
>  tests/fuzz/fuzzer_hooks.h |   9 ++++
>  2 files changed, 115 insertions(+)
>  create mode 100644 tests/fuzz/fuzzer_hooks.c
>  create mode 100644 tests/fuzz/fuzzer_hooks.h
> 
> diff --git a/tests/fuzz/fuzzer_hooks.c b/tests/fuzz/fuzzer_hooks.c
> new file mode 100644
> index 0000000000..5a0bbec413
> --- /dev/null
> +++ b/tests/fuzz/fuzzer_hooks.c
> @@ -0,0 +1,106 @@
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "fuzzer_hooks.h"
> +
> +#include <dlfcn.h>
> +#include <elf.h>
> +
> +
> +extern void* _ZN6fuzzer3TPCE;

Would it make sense to make this a C++ source, so that you can avoid
using the mangled names (in this case, "namespace fuzzer { extern void
*TPC; }" and then using fuzzer::TPC)?  Even if it's just a single symbol.

> +// The libfuzzer handlers
> +void __real___sanitizer_cov_8bit_counters_init(uint8_t*, uint8_t*);
> +void __real___sanitizer_cov_trace_pc_guard_init(uint8_t*, uint8_t*);
> +
> +void __wrap___sanitizer_cov_8bit_counters_init(uint8_t *Start, uint8_t *Stop);
> +void __wrap___sanitizer_cov_trace_pc_guard_init(uint8_t *Start, uint8_t *Stop);
> +
> +
> +void* counter_shm;
> +
> +typedef struct CoverageRegion {
> +    uint8_t* start;
> +    size_t length;
> +    bool store; /* Set this if it needs to be copied to the forked process */
> +} CoverageRegion;
> +
> +CoverageRegion regions[10];
> +int region_index = 0;
> +
> +void __wrap___sanitizer_cov_8bit_counters_init(uint8_t *Start, uint8_t *Stop)
> +{
> +    regions[region_index].start = Start;
> +    regions[region_index].length = Stop-Start;
> +    regions[region_index].store = true;
> +    region_index++;
> +    __real___sanitizer_cov_8bit_counters_init(Start, Stop);
> +}
> +
> +void __wrap___sanitizer_cov_trace_pc_guard_init(uint8_t *Start, uint8_t *Stop)
> +{
> +    regions[region_index].start = Start;
> +    regions[region_index++].length = Stop-Start;
> +    regions[region_index].store = true;
> +    region_index++;
> +    __real___sanitizer_cov_trace_pc_guard_init(Start, Stop);
> +}
> +
> +static void add_tpc_region(void)
> +{
> +    /* Got symbol and length from readelf. Horrible way to do this! */
> +    regions[region_index].start = (uint8_t*)(&_ZN6fuzzer3TPCE);
> +    regions[region_index].length = 0x443c00; 
> +    regions[region_index].store = true;
> +    region_index++;
> +}
> +
> +void counter_shm_init(void)
> +{
> +    /*
> +     * Add the  internal libfuzzer object that gets modified by cmp, etc
> +     * callbacks
> +     */
> +    add_tpc_region(); 
> +
> +    size_t length = 0;
> +    for(int i=0; i<region_index; i++){
> +        printf("%d %lx\n", i, length);
> +        length += regions[i].length;
> +    }
> +
> +    /* 
> +     * Map some shared memory. When we use a fork-server we can copy the
> +     * libfuzzer-related counters
> +     * */
> +    counter_shm = mmap(NULL, length, PROT_READ | PROT_WRITE, 
> +            MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +    if(counter_shm == MAP_FAILED) {
> +        printf("mmap() failed\n");
> +        do { perror("error:"); exit(EXIT_FAILURE); } while (0);
> +        exit(-1);
> +    }
> +}
> +
> +void counter_shm_store(void)
> +{
> +    size_t offset = 0;
> +    for(int i=0; i<region_index; i++) {
> +        if(regions[i].store) {
> +            memcpy(counter_shm + offset, regions[i].start, regions[i].length);
> +        }
> +        offset+=regions[i].length;
> +    }
> +}
> +
> +void counter_shm_load(void)
> +{
> +    size_t offset = 0;
> +    for(int i=0; i<region_index; i++) {
> +        if(regions[i].store) {
> +            memcpy(regions[i].start, counter_shm + offset, regions[i].length);
> +        }
> +        offset+=regions[i].length;
> +    }
> +}
> +
> diff --git a/tests/fuzz/fuzzer_hooks.h b/tests/fuzz/fuzzer_hooks.h
> new file mode 100644
> index 0000000000..90dca254d4
> --- /dev/null
> +++ b/tests/fuzz/fuzzer_hooks.h
> @@ -0,0 +1,9 @@
> +#ifndef FUZZER_HOOKS_H
> +#define FUZZER_HOOKS_H
> +
> +void counter_shm_init(void);
> +void counter_shm_store(void);
> +void counter_shm_load(void);
> +
> +#endif
> +
> 


