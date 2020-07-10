Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9982C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9CE2077D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9CE2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsIo-0006CP-OY
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 08:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jtsI2-0005OA-LM
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:38:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:36116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jtsHz-0005jP-GO
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:38:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 27F55AD04;
 Fri, 10 Jul 2020 12:38:02 +0000 (UTC)
Subject: Re: [PULL v2 00/52] Misc patches for QEMU 5.1 soft freeze
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200708172542.25012-1-pbonzini@redhat.com>
 <CAFEAcA8b6sn8fXOKwqOF6MvsKT5oKqS+4jjYDPAPvnXmVimLiQ@mail.gmail.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <9631042d-00e4-2a2e-292b-66ca1b590120@suse.de>
Date: Fri, 10 Jul 2020 14:38:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8b6sn8fXOKwqOF6MvsKT5oKqS+4jjYDPAPvnXmVimLiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:07:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 2:14 PM, Peter Maydell wrote:
> On Wed, 8 Jul 2020 at 22:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit eb2c66b10efd2b914b56b20ae90655914310c925:
>>
>>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-07-06' into staging (2020-07-07 19:47:26 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to 392f34e59755f99d69586a63e0f5d80a7ef67f94:
>>
>>   apic: Report current_count via 'info lapic' (2020-07-08 10:01:08 -0400)
> 
> Hi; this still has the OSX failure, I'm afraid:
> 
> /Users/pm215/src/qemu-for-merges/ui/cocoa.m:1478:9: error: implicit
> declaration of function 'cpu_throttle_set' is invalid in C99 [-
> Werror,-Wimplicit-function-declaration]
>         cpu_throttle_set(throttle_pct);
>         ^
> /Users/pm215/src/qemu-for-merges/ui/cocoa.m:1478:9: error: this
> function declaration is not a prototype [-Werror,-Wstrict-prototypes]
> 
> (other builds haven't reported back yet)
> 
> thanks
> -- PMM
> 

Hi Peter,

I got regular green test reports from cirrus-ci for Mac, seems different compilation options.

The prototypes for cpu_throttle_ functions are 

in sysemu/cpu-throttle.h

so the fix should be to just

#include "sysemu-cpu_throttle.h"

The fact that we get so wildly different results from CI is concerning to me.

Should I resend you the cpu throttle patch with this change?

Ciao

C



