Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E1DC388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D472463D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D472463D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVdPJ-0001H5-QS
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 12:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVdOV-0000mp-8R
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:24:51 -0400
Received: from relay64.bu.edu ([128.197.228.104]:36498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVdOT-0004Uf-5k
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:24:50 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 09MGOGL0017215
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 22 Oct 2020 12:24:24 -0400
Date: Thu, 22 Oct 2020 12:24:16 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: Re: Ramping up Continuous Fuzzing of Virtual Devices in QEMU
Message-ID: <20201022162416.iccjosbeg753qbzc@mozz.bu.edu>
References: <20201022161938.7clfymu6a3zl46s2@mozz.bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022161938.7clfymu6a3zl46s2@mozz.bu.edu>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 12:14:26
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.502, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, berrange@redhat.com,
 0ops@0ops.net, liq3ea@gmail.com, f4bug@amsat.org, rjones@redhat.com,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 andrey.shinkevich@virtuozzo.com, pbonzini@redhat.com, ppandit@redhat.com,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+CC Prasad

On 201022 1219, Alexander Bulekov wrote:
> Hello,
> QEMU was accepted into Google's oss-fuzz continuous-fuzzing platform [1]
> earlier this year. The fuzzers currently running on oss-fuzz are based on my
> 2019 Google Summer of Code Project, which leveraged libfuzzer, qtest and libqos
> to provide a framework for writing virtual-device fuzzers. At the moment, there
> are a handful of fuzzers upstream and running on oss-fuzz(located in
> tests/qtest/fuzz/). They fuzz only a few devices and serve mostly as
> examples.
> 
> If everything goes well, soon a generic fuzzer [2] will land upstream, which
> allows us to fuzz many configurations of QEMU, without any device-specific
> code. To date this fuzzer has led to ~50 bug reports on launchpad. Once the
> generic-fuzzer lands upstream, OSS-Fuzz will automatically start fuzzing a
> bunch [3] of fuzzer configurations, and it is likely to find bugs.  Others will
> also be able to send simple patches to add additional device configurations for
> fuzzing.
> 
> The oss-fuzz process looks roughly like this:
>     1. oss-fuzz fuzzes QEMU
>     2. When oss-fuzz finds a bug, it reports it to a few [4] people that have
>     access to reports and reproducers.
>     3. If a fix is merged upstream, oss-fuzz will figure this out and mark the
>     bug as fixed and make the report public 30 days later.
>     3. After 90 days the bug(fixed or not) becomes public, so anyone can view
>     it here https://bugs.chromium.org/p/oss-fuzz/issues/list
> 
> The oss-fuzz reports look like this:
> https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=23701&q=qemu&can=2
> 
> This means that when oss-fuzz find new bugs, the relevant developers do not
> know about them unless someone with access files a separate report to the
> list/launchpad. So far this hasn't been a problem, since oss-fuzz has only been
> running some small example fuzzers. Once [2] lands upstream, we should
> see a significant uptick in oss-fuzz reports, and I hope that we can develop a
> process to ensure these bugs are properly dealt with. One option we have is to
> make the reports public immediately and send notifications to
> qemu-devel. This is the approach taken by some other projects on
> oss-fuzz, such as LLVM. Though its not on oss-fuzz, bugs found by
> syzkaller in the kernel, are also automatically sent to a public list.
> The question is: 
> 
> What approach should we take for dealing with bugs found on oss-fuzz?
> 
> [1] https://github.com/google/oss-fuzz
> [2] https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg06331.html
> [3] https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg06345.html
> [4] https://github.com/google/oss-fuzz/blob/fbf916ce14952ba192e58fe8550096b868fcf62d/projects/qemu/project.yaml#L4
> 
> For further reference, the vast majority of these bugs, were found with the
> generic-fuzzer:
> https://bugs.launchpad.net/~a1xndr/+bugs
> 
> There are more that I haven't yet had time to write reports for.
> Thank you
> -Alex

