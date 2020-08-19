Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6389C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A43F20882
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A43F20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8QtR-0001ZS-KO
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 12:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8Qsm-0000l4-P3
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:24:12 -0400
Received: from relay68.bu.edu ([128.197.228.73]:60054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8Qsj-00004r-MY
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:24:12 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 07JGNHiq001908
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 19 Aug 2020 12:23:20 -0400
Date: Wed, 19 Aug 2020 12:23:17 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 00/15] Add a General Virtual Device Fuzzer
Message-ID: <20200819162313.5x5elxeypitklf2k@mozz.bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
 <159781875904.25250.2549056217558413980@66eaa9a8a123>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159781875904.25250.2549056217558413980@66eaa9a8a123>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 12:24:08
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: darren.kenny@oracle.com, bsd@redhat.com, f4bug@amsat.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Oops I forgot to do my checkpatch pass. I'll resend this, shortly.
-Alex

On 200818 2332, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200819061110.1320568-1-alxndr@bu.edu/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 20200819061110.1320568-1-alxndr@bu.edu
> Subject: [PATCH v2 00/15] Add a General Virtual Device Fuzzer
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> Switched to a new branch 'test'
> a8e119d scripts/oss-fuzz: Add crash trace minimization script
> ae04d9e scripts/oss-fuzz: Add script to reorder a general-fuzzer trace
> 565c5c5 scripts/oss-fuzz: build the general-fuzzer configs
> 559cd36 scripts/oss-fuzz: Add general-fuzzer configs for oss-fuzz
> 54db062 scripts/oss-fuzz: Add general-fuzzer build script
> 8973b6e scripts/oss-fuzz: Add wrapper program for generic fuzzer
> 3452c68 fuzz: add a crossover function to generic-fuzzer
> 5c579c9 fuzz: add a DISABLE_PCI op to general-fuzzer
> 4f50ecd fuzz: Add support for custom crossover functions
> 95bd76d fuzz: Add fuzzer callbacks to DMA-read functions
> 89e6484 fuzz: Declare DMA Read callback function
> a5441b1 fuzz: Add DMA support to the generic-fuzzer
> 9bd3375 fuzz: Add PCI features to the general fuzzer
> a2759f3 fuzz: Add general virtual-device fuzzer
> f9c6ddd fuzz: Change the way we write qtest log to stderr
> 
> === OUTPUT BEGIN ===
> 1/15 Checking commit f9c6ddda8115 (fuzz: Change the way we write qtest log to stderr)
> 2/15 Checking commit a2759f329ffa (fuzz: Add general virtual-device fuzzer)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #31: 
> new file mode 100644
> 
> ERROR: missing space after enum definition
> #68: FILE: tests/qtest/fuzz/general_fuzz.c:33:
> +enum cmds{
> 
> ERROR: line over 90 characters
> #108: FILE: tests/qtest/fuzz/general_fuzz.c:73:
> +    AddressSpace *as = (io_space == get_system_memory()) ? &address_space_memory : &address_space_io;
> 
> ERROR: line over 90 characters
> #124: FILE: tests/qtest/fuzz/general_fuzz.c:89:
> +                if(address_space_translate(as, abs_addr, &xlat, &len, true, MEMTXATTRS_UNSPECIFIED) == mr){
> 
> ERROR: space required before the open brace '{'
> #124: FILE: tests/qtest/fuzz/general_fuzz.c:89:
> +                if(address_space_translate(as, abs_addr, &xlat, &len, true, MEMTXATTRS_UNSPECIFIED) == mr){
> 
> ERROR: space required before the open parenthesis '('
> #124: FILE: tests/qtest/fuzz/general_fuzz.c:89:
> +                if(address_space_translate(as, abs_addr, &xlat, &len, true, MEMTXATTRS_UNSPECIFIED) == mr){
> 
> ERROR: space required before the open brace '{'
> #128: FILE: tests/qtest/fuzz/general_fuzz.c:93:
> +                    if(mr->size){
> 
> ERROR: space required before the open parenthesis '('
> #128: FILE: tests/qtest/fuzz/general_fuzz.c:93:
> +                    if(mr->size){
> 
> ERROR: spaces required around that '-' (ctx:VxV)
> #131: FILE: tests/qtest/fuzz/general_fuzz.c:96:
> +                    result->len = mr->size-(result->addr-abs_addr);
>                                            ^
> 
> ERROR: spaces required around that '-' (ctx:VxV)
> #131: FILE: tests/qtest/fuzz/general_fuzz.c:96:
> +                    result->len = mr->size-(result->addr-abs_addr);
>                                                          ^
> 
> ERROR: space prohibited between function name and open parenthesis '('
> #483: FILE: tests/qtest/fuzz/general_fuzz.c:448:
> +    char **result = g_strsplit (getenv("QEMU_FUZZ_OBJECTS"), " ", -1);
> 
> ERROR: space required before the open brace '{'
> #500: FILE: tests/qtest/fuzz/general_fuzz.c:465:
> +    if(!fuzzable_memoryregions->len){
> 
> ERROR: space required before the open parenthesis '('
> #500: FILE: tests/qtest/fuzz/general_fuzz.c:465:
> +    if(!fuzzable_memoryregions->len){
> 
> total: 12 errors, 1 warnings, 501 lines checked
> 
> Patch 2/15 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 3/15 Checking commit 9bd3375b88bc (fuzz: Add PCI features to the general fuzzer)
> 4/15 Checking commit a5441b1099c7 (fuzz: Add DMA support to the generic-fuzzer)
> ERROR: externs should be avoided in .c files
> #84: FILE: tests/qtest/fuzz/general_fuzz.c:97:
> +void fuzz_dma_read_cb(size_t addr, size_t len, MemoryRegion *mr, bool is_write);
> 
> WARNING: line over 80 characters
> #129: FILE: tests/qtest/fuzz/general_fuzz.c:142:
> +        || (mr != MACHINE(qdev_get_machine())->ram && !(mr->ops == &unassigned_mem_ops))
> 
> total: 1 errors, 1 warnings, 247 lines checked
> 
> Patch 4/15 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 5/15 Checking commit 89e64845b1dd (fuzz: Declare DMA Read callback function)
> 6/15 Checking commit 95bd76d180c1 (fuzz: Add fuzzer callbacks to DMA-read functions)
> 7/15 Checking commit 4f50ecd4705c (fuzz: Add support for custom crossover functions)
> ERROR: space required before the open parenthesis '('
> #30: FILE: tests/qtest/fuzz/fuzz.c:127:
> +    if(fuzz_target->crossover) {
> 
> WARNING: line over 80 characters
> #59: FILE: tests/qtest/fuzz/fuzz.h:91:
> +     * seed: the seed that should be used to make mutations deterministic, when needed
> 
> total: 1 errors, 1 warnings, 57 lines checked
> 
> Patch 7/15 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 8/15 Checking commit 5c579c959fec (fuzz: add a DISABLE_PCI op to general-fuzzer)
> ERROR: do not initialise statics to 0 or NULL
> #30: FILE: tests/qtest/fuzz/general_fuzz.c:97:
> +static bool pci_disabled = false;
> 
> total: 1 errors, 0 warnings, 55 lines checked
> 
> Patch 8/15 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 9/15 Checking commit 3452c68ac630 (fuzz: add a crossover function to generic-fuzzer)
> ERROR: do not use C99 // comments
> #49: FILE: tests/qtest/fuzz/general_fuzz.c:773:
> +    // Copy in the first input
> 
> ERROR: spaces required around that '+' (ctx:VxV)
> #51: FILE: tests/qtest/fuzz/general_fuzz.c:775:
> +    memcpy(out+size, data1, copy);
>                ^
> 
> ERROR: spaces required around that '+=' (ctx:VxW)
> #52: FILE: tests/qtest/fuzz/general_fuzz.c:776:
> +    size+= copy;
>          ^
> 
> ERROR: spaces required around that '-=' (ctx:VxW)
> #53: FILE: tests/qtest/fuzz/general_fuzz.c:777:
> +    max_out_size-= copy;
>                  ^
> 
> ERROR: do not use C99 // comments
> #55: FILE: tests/qtest/fuzz/general_fuzz.c:779:
> +    // Append a separator
> 
> ERROR: spaces required around that '+' (ctx:VxV)
> #57: FILE: tests/qtest/fuzz/general_fuzz.c:781:
> +    memcpy(out+size, SEPARATOR, copy);
>                ^
> 
> ERROR: spaces required around that '+=' (ctx:VxW)
> #58: FILE: tests/qtest/fuzz/general_fuzz.c:782:
> +    size+= copy;
>          ^
> 
> ERROR: spaces required around that '-=' (ctx:VxW)
> #59: FILE: tests/qtest/fuzz/general_fuzz.c:783:
> +    max_out_size-= copy;
>                  ^
> 
> ERROR: do not use C99 // comments
> #61: FILE: tests/qtest/fuzz/general_fuzz.c:785:
> +    // Clear out the
> 
> ERROR: spaces required around that '+=' (ctx:VxW)
> #66: FILE: tests/qtest/fuzz/general_fuzz.c:790:
> +    size+= copy;
>          ^
> 
> ERROR: spaces required around that '-=' (ctx:VxW)
> #67: FILE: tests/qtest/fuzz/general_fuzz.c:791:
> +    max_out_size-= copy;
>                  ^
> 
> ERROR: spaces required around that '+' (ctx:VxV)
> #70: FILE: tests/qtest/fuzz/general_fuzz.c:794:
> +    memcpy(out+size, SEPARATOR, copy);
>                ^
> 
> ERROR: spaces required around that '+=' (ctx:VxW)
> #71: FILE: tests/qtest/fuzz/general_fuzz.c:795:
> +    size+= copy;
>          ^
> 
> ERROR: spaces required around that '-=' (ctx:VxW)
> #72: FILE: tests/qtest/fuzz/general_fuzz.c:796:
> +    max_out_size-= copy;
>                  ^
> 
> ERROR: spaces required around that '+=' (ctx:VxW)
> #78: FILE: tests/qtest/fuzz/general_fuzz.c:802:
> +    size+= copy;
>          ^
> 
> ERROR: spaces required around that '-=' (ctx:VxW)
> #79: FILE: tests/qtest/fuzz/general_fuzz.c:803:
> +    max_out_size-= copy;
>                  ^
> 
> ERROR: spaces required around that '+' (ctx:VxV)
> #82: FILE: tests/qtest/fuzz/general_fuzz.c:806:
> +    memcpy(out+size, SEPARATOR, copy);
>                ^
> 
> ERROR: spaces required around that '+=' (ctx:VxW)
> #83: FILE: tests/qtest/fuzz/general_fuzz.c:807:
> +    size+= copy;
>          ^
> 
> ERROR: spaces required around that '-=' (ctx:VxW)
> #84: FILE: tests/qtest/fuzz/general_fuzz.c:808:
> +    max_out_size-= copy;
>                  ^
> 
> ERROR: spaces required around that '+' (ctx:VxV)
> #87: FILE: tests/qtest/fuzz/general_fuzz.c:811:
> +    memcpy(out+size, data2, copy);
>                ^
> 
> ERROR: spaces required around that '+=' (ctx:VxW)
> #88: FILE: tests/qtest/fuzz/general_fuzz.c:812:
> +    size+= copy;
>          ^
> 
> ERROR: spaces required around that '-=' (ctx:VxW)
> #89: FILE: tests/qtest/fuzz/general_fuzz.c:813:
> +    max_out_size-= copy;
>                  ^
> 
> total: 22 errors, 0 warnings, 93 lines checked
> 
> Patch 9/15 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 10/15 Checking commit 8973b6e31476 (scripts/oss-fuzz: Add wrapper program for generic fuzzer)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #19: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 40 lines checked
> 
> Patch 10/15 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 11/15 Checking commit 54db062fafe0 (scripts/oss-fuzz: Add general-fuzzer build script)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #17: 
> new file mode 100755
> 
> total: 0 errors, 1 warnings, 62 lines checked
> 
> Patch 11/15 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 12/15 Checking commit 559cd365394c (scripts/oss-fuzz: Add general-fuzzer configs for oss-fuzz)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #16: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 103 lines checked
> 
> Patch 12/15 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 13/15 Checking commit 565c5c5cec66 (scripts/oss-fuzz: build the general-fuzzer configs)
> 14/15 Checking commit ae04d9edfe56 (scripts/oss-fuzz: Add script to reorder a general-fuzzer trace)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #21: 
> new file mode 100755
> 
> total: 0 errors, 1 warnings, 94 lines checked
> 
> Patch 14/15 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 15/15 Checking commit a8e119d529aa (scripts/oss-fuzz: Add crash trace minimization script)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #16: 
> new file mode 100755
> 
> total: 0 errors, 1 warnings, 118 lines checked
> 
> Patch 15/15 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20200819061110.1320568-1-alxndr@bu.edu/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

