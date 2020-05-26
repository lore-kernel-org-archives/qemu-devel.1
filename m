Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29A9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 12:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DC9204EF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 12:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DC9204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZAK-0003n4-Lc
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 08:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jdZ9d-0003Kd-Ii
 for qemu-devel@nongnu.org; Tue, 26 May 2020 08:58:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:43140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jdZ9b-0008Nx-Sl
 for qemu-devel@nongnu.org; Tue, 26 May 2020 08:58:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1BFACACB1;
 Tue, 26 May 2020 12:58:00 +0000 (UTC)
Subject: Re: [RFC v3 0/4] QEMU cpus.c refactoring
To: qemu-devel@nongnu.org
References: <159044748030.3999.4835684679891787464@45ef0f9c86ae>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <bf1987f6-c21f-d7dd-8be8-00eba1bc1bda@suse.de>
Date: Tue, 26 May 2020 14:57:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <159044748030.3999.4835684679891787464@45ef0f9c86ae>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 00:12:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 ehabkost@redhat.com, philmd@redhat.com, mtosatti@redhat.com,
 r.bolshakov@yadro.com, wenchao.wang@intel.com, haxm-team@intel.com,
 colin.xu@intel.com, pbonzini@redhat.com, sunilmut@microsoft.com,
 alex.bennee@linaro.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some comments on patchew output:

On 5/26/20 12:58 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200525145440.29728-1-cfontana@suse.de/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Message-id: 20200525145440.29728-1-cfontana@suse.de
> Subject: [RFC v3 0/4] QEMU cpus.c refactoring
> Type: series
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
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  - [tag update]      patchew/20200525111001.8147-1-f4bug@amsat.org -> patchew/20200525111001.8147-1-f4bug@amsat.org
> Switched to a new branch 'test'
> 0f5db0e cpus: extract out accel-specific code to each accel
> 1b135cf cpu-timers, icount: new modules
> cb5c834 cpu-throttle: new module, extracted from cpus.c
> 3d5a04d softmmu: move softmmu only files from root
> 
> === OUTPUT BEGIN ===
> 1/4 Checking commit 3d5a04d99492 (softmmu: move softmmu only files from root)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #112: 
> rename from arch_init.c
> 
> total: 0 errors, 1 warnings, 77 lines checked


I am not sure who the maintainer of arch_init would be.

get_maintainer.pl: No maintainers found, printing recent contributors.


> 
> Patch 1/4 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 2/4 Checking commit cb5c834770dd (cpu-throttle: new module, extracted from cpus.c)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #110: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 386 lines checked

I assumed this would be Paolo, since he maintains related components (and the cpus.c it came from)


> 
> Patch 2/4 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 3/4 Checking commit 1b135cfa40c8 (cpu-timers, icount: new modules)
> WARNING: line over 80 characters
> #94: FILE: accel/tcg/cpu-exec.c:107:
> +            qemu_printf("Warning: The guest is now late by %.1f to %.1f seconds\n",



Here I would ignore the warning for the benefit of readability of the printf string.


> 
> ERROR: line over 90 characters
> #265: FILE: hw/core/ptimer.c:137:
> +    if (s->enabled == 1 && (delta * period < 10000) && !icount_enabled() && !qtest_enabled()) {


this I should fix


> 
> ERROR: line over 90 characters
> #274: FILE: hw/core/ptimer.c:220:
> +            if (!oneshot && (s->delta * period < 10000) && !icount_enabled() && !qtest_enabled()) {
> 

this I should fix

> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #384: 
> new file mode 100644
> 
> total: 2 errors, 2 warnings, 2331 lines checked
> 
> Patch 3/4 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 4/4 Checking commit 0f5db0e76127 (cpus: extract out accel-specific code to each accel)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #86: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 2463 lines checked
> 
> Patch 4/4 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> === OUTPUT END ===


I am adding the new accelerator interfaces to the respective accelerator maintainers.


> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20200525145440.29728-1-cfontana@suse.de/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


