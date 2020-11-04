Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606C5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF917206FA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF917206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaM3i-0005kq-2A
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kaM2x-00053B-0Z
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:54:07 -0500
Received: from relay64.bu.edu ([128.197.228.104]:41021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kaM2u-0003pH-Tf
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:54:06 -0500
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 0A4GqsEi019783
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 4 Nov 2020 11:52:58 -0500
Date: Wed, 4 Nov 2020 11:52:54 -0500
From: Alexander Bulekov <alxndr@bu.edu>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Ramping up Continuous Fuzzing of Virtual Devices in QEMU
Message-ID: <20201104165254.2qibav3njmpmchnc@mozz.bu.edu>
References: <20201022161938.7clfymu6a3zl46s2@mozz.bu.edu>
 <20201022162416.iccjosbeg753qbzc@mozz.bu.edu>
 <20201022163925.GE428835@redhat.com>
 <p2qq7p64-r88p-s228-133q-n770po2ssonp@erqung.pbz>
 <20201104152506.abplvggv2ll36m6v@mozz.bu.edu>
 <CAFEAcA84Awk26JgRB90R5M9=R66XXR5eWs47pwZ6Oq0V7A34TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA84Awk26JgRB90R5M9=R66XXR5eWs47pwZ6Oq0V7A34TA@mail.gmail.com>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 10:26:04
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.379, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>, 0ops@0ops.net,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 P J P <ppandit@redhat.com>, Darren Kenny <darren.kenny@oracle.com>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Dima Stepanov <dimastep@yandex-team.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 201104 1546, Peter Maydell wrote:
> On Wed, 4 Nov 2020 at 15:26, Alexander Bulekov <alxndr@bu.edu> wrote:
> > If I understand correctly, this is analogous to what happens with
> > Coverity reports. Access to Coverity is closed (not sure if there is a
> > process to apply for access). It also seems that there is a push to fix
> > CID issues prior to new releases. Maybe a similar process can be used for
> > fuzzing?
> 
> Coverity is only closed in the sense that you have to request
> an account on the website. Anybody who's a QEMU developer
> can look at the reports.
> 

OK thats good to know. Why should fuzzing reports be treated
differently? Is it because they come with a ready-to-use reproducer?

> The attempt to fix CID issues works because:
>  * Coverity reports a fairly small number of issues, so
>    "fix them all" is relatively tractable, and then once you
>    get down to "no outstanding issues" the only new ones
>    that get found are for new changes to QEMU (not entirely
>    true, but close enough)

I think fuzzing is quite similar. After an initial wave of reports,
they should slow to a trickle and eventually should just catch problems
in new changes.

>  * Mostly issues are reported soon after the offending code
>    goes into the tree, so it's often possible to quickly
>    identify the patch that introduced the issue and ask
>    the person who wrote that patch to fix the bug

While fuzzing can take some time to find issues after new code is
committed, I don't think the problem of reports on stale code is unique
to fuzzing. That should only be an issue for the initial wave of reports
(the same as I'm guessing it was was when Coverity started analyzing
QEMU in 2013).
Additionally, we can filter crashes based on where they occured, which
should give a similar level of control as the Coverity
components/patterns. If problems in e.g. ati or vmxnet are unlikely to
be looked at, we can
 1.) Not fuzz them (easy to do by removing an entry from
 tests/qtest/fuzz/generic_fuzz_configs.h)
 2.) Apply filters to ignore crash reports with ati.c or vmxnet.c in the
 callstack.

That said, IIUC main purpose of the Coverity componsnets/patterns is to
prevent false positives. This shouldn't be nearly as much of a problem
for oss-fuzz reports for which we can provide qtest reproducers.

>  * Coverity reports are categorized by kind-of-failure,
>    so it's easy to prioritize important stuff (buffer overflows)
>    and leave less significant stuff (dead code) for later

Fuzzer reports are the same. OSS-fuzz tells us if something is an
overflow, UAF, overlapping-memcpy, double-free, assertion-failure,
null-ptr derefs etc.
If noise from assertion-failure/null-ptr derefs reports is a concern,
maybe we can just ignore those for now?

>  * Coverity's reports include the automated analysis of
>    why Coverity thinks there's an issue -- this is not
>    always right but it's a solid head start on "what's the
>    bug here" compared to just having a repro case and an
>    assertion-failure message

Thats true - the types of bugs found by fuzzing rather than static
analysis usually are tough to automatically suggest (pretty) fixes for.
I have been thinking about ways to make this situation better, beyond
just enabling the relevant -trace events and hoping they provide context
and make life easier.

>  * There's a set of people who care enough about Coverity
>    reports to put the time in to fixing them...

I hope this set of people grows for fuzzing reports as well. Though
fuzzing reports are nothing compared to the ~1250 fixed coverity
defects, fuzzing has already helped highlight some serious issues that
have been hiding in the code for a long time. Unfortunately, I think
there is a gap between the types of problems reported by fuzzing and
Coverity, where I don't see someone picking up a dozen random fuzzing
reports and having a dozen patches ready by the end of the day. Multiple
people working on fuzzer-discovered issues have mentioned that they are
often quite time consuming to properly fix (for little preceived
reward). Maybe the solution is to limit the scope of fuzzer reports so
that they might be rarer, but are more likely to feature problems that
people will care about? This might mean having a narrower selection of
fuzzed devices than just "anything that works with KVM"

-Alex

> 
> thanks
> -- PMM

