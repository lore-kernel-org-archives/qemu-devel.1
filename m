Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F240FC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 18:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF1421534
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 18:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF1421534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVf1Q-0007vK-WC
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 14:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVf0q-0007S5-DH
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 14:08:32 -0400
Received: from relay68.bu.edu ([128.197.228.73]:38291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVf0o-0001Dw-2Q
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 14:08:31 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 09MI7td9032495
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 22 Oct 2020 14:07:59 -0400
Date: Thu, 22 Oct 2020 14:07:55 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: Ramping up Continuous Fuzzing of Virtual Devices in QEMU
Message-ID: <20201022180755.5ouxjmzwfdsp2q2t@mozz.bu.edu>
References: <20201022161938.7clfymu6a3zl46s2@mozz.bu.edu>
 <20201022162416.iccjosbeg753qbzc@mozz.bu.edu>
 <20201022163925.GE428835@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201022163925.GE428835@redhat.com>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 14:08:28
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, rjones@redhat.com,
 0ops@0ops.net, liq3ea@gmail.com, qemu-devel@nongnu.org, f4bug@amsat.org,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, andrey.shinkevich@virtuozzo.com, ppandit@redhat.com,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 201022 1739, Daniel P. Berrangé wrote:
> On Thu, Oct 22, 2020 at 12:24:16PM -0400, Alexander Bulekov wrote:
> > +CC Prasad
> > 
> > On 201022 1219, Alexander Bulekov wrote:
> > > Hello,
> > > QEMU was accepted into Google's oss-fuzz continuous-fuzzing platform [1]
> > > earlier this year. The fuzzers currently running on oss-fuzz are based on my
> > > 2019 Google Summer of Code Project, which leveraged libfuzzer, qtest and libqos
> > > to provide a framework for writing virtual-device fuzzers. At the moment, there
> > > are a handful of fuzzers upstream and running on oss-fuzz(located in
> > > tests/qtest/fuzz/). They fuzz only a few devices and serve mostly as
> > > examples.
> > > 
> > > If everything goes well, soon a generic fuzzer [2] will land upstream, which
> > > allows us to fuzz many configurations of QEMU, without any device-specific
> > > code. To date this fuzzer has led to ~50 bug reports on launchpad. Once the
> > > generic-fuzzer lands upstream, OSS-Fuzz will automatically start fuzzing a
> > > bunch [3] of fuzzer configurations, and it is likely to find bugs.  Others will
> > > also be able to send simple patches to add additional device configurations for
> > > fuzzing.
> > > 
> > > The oss-fuzz process looks roughly like this:
> > >     1. oss-fuzz fuzzes QEMU
> > >     2. When oss-fuzz finds a bug, it reports it to a few [4] people that have
> > >     access to reports and reproducers.
> > >     3. If a fix is merged upstream, oss-fuzz will figure this out and mark the
> > >     bug as fixed and make the report public 30 days later.
> > >     3. After 90 days the bug(fixed or not) becomes public, so anyone can view
> > >     it here https://bugs.chromium.org/p/oss-fuzz/issues/list
> > > 
> > > The oss-fuzz reports look like this:
> > > https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=23701&q=qemu&can=2
> > > 
> > > This means that when oss-fuzz find new bugs, the relevant developers do not
> > > know about them unless someone with access files a separate report to the
> > > list/launchpad. So far this hasn't been a problem, since oss-fuzz has only been
> > > running some small example fuzzers. Once [2] lands upstream, we should
> > > see a significant uptick in oss-fuzz reports, and I hope that we can develop a
> > > process to ensure these bugs are properly dealt with. One option we have is to
> > > make the reports public immediately and send notifications to
> > > qemu-devel. This is the approach taken by some other projects on
> > > oss-fuzz, such as LLVM. Though its not on oss-fuzz, bugs found by
> > > syzkaller in the kernel, are also automatically sent to a public list.
> > > The question is: 
> > > 
> > > What approach should we take for dealing with bugs found on oss-fuzz?
> 
> If we assume that a non-negligible number of fuzz bugs will be exploitable
> by a malicious guest OS to break out into the host, then I think it is
> likely undesirable to make them public immediately without at least a basic
> human triage step to catch possibly serious security issues.
> 
> Still a large % are likely to be low impact / not urgent to deal with so
> we want a low overhead way to handle the fuzz output, which doesn't create
> a bottleneck on a small number of people.
> 
> Overall my feeling is that we want to be able to farm out triage to the
> respective subsystem maintainers, who can then decide whether the bug
> needs notifying to the security team, or can be made public immediately.
> 
> I think ideally we would be doing triage in QEMU's own bug tracker, so
> we don't need to have maintainers create accounts on a 3rd party tracker
> to see reports.
> 
> Is is practical to identify a primary affected source file from the fuzz
> crash report with any level reliablility such that we could file a private
> launchpad bug, automatically CC'ing a subsystem maintainer (and the security
> team)  ?

Hi Daniel,
As far as I know, there is currently no API for accessing oss-fuzz
results. We could use email-based scripts to parse the automated reports
(e.g.  [1]) and follow the links to automatically download crash-traces
and reproducers. However, accessing those requires a login through
google.com which might be tough to script against in a reliable way.

Assuming we have found a way to automatically download the binary fuzzer
reproducer, we should be able to automatically convert it into a qtest
reproducer that we could send to the right people. 
There are a few approaches I can think of to automatically identify the
maintainers to CC:
 1. Walk the stack-trace until we find the line likely responsible for
 the bug. This can be tricky, since the buggy line is often not the
 first line. E.g. from [2]
    #3 __GI___assert_fail assert.c:101
    #4 iov_from_buf_full util/iov.c:40
    #5 iov_from_buf iov.h:49
    #6 net_tx_pkt_update_ip_checksums hw/net/net_tx_pkt.c:139
    #7 e1000e_setup_tx_offloads hw/net/e1000e_core.c:638

  Do we cc the iov maintainer, the net_tx_pkt maintainer, or the e1000e
  maintainer? Might be tough to figure out automatically.

 2. git bisect until we find the commit where the reproducer started to
 crash and CC everyone who signed-off or reviewed that commit and who is
 in MAINTAINERS. This is also not a silver bullet, since reproducers
 might stop working due to reasons unrelated to the bug: e.g.  the MMIO
 range for a device changed, so the qtest reproducer now interacts with
 the wrong addresses, or the bug was obscured by another bug.

 [1] https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=23701&q=qemu&can=2
 [2] https://bugs.launchpad.net/qemu/+bug/1878250

-Alex

> 
> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

