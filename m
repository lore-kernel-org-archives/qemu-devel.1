Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1439DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D66207BB
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D66207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtWmP-0007jr-51
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 09:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>)
 id 1jtWlb-0006ax-25; Thu, 09 Jul 2020 09:39:11 -0400
Received: from relay64.bu.edu ([128.197.228.104]:46777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>)
 id 1jtWlY-0004SV-SD; Thu, 09 Jul 2020 09:39:10 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 069Dcf2H025248
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 9 Jul 2020 09:38:44 -0400
Date: Thu, 9 Jul 2020 09:38:41 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH-for-5.1 2/2] fuzz: add missing header for rcu_enable_atfork
Message-ID: <20200709133841.olbpg7jwaeklc6v6@mozz.bu.edu>
References: <20200708200104.21978-1-alxndr@bu.edu>
 <20200708200104.21978-3-alxndr@bu.edu>
 <75c61011-3be4-a450-3188-4b875703df07@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75c61011-3be4-a450-3188-4b875703df07@redhat.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 09:39:07
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 liq3ea@163.com, qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200709 0718, Thomas Huth wrote:
> On 08/07/2020 22.01, Alexander Bulekov wrote:
> > In 45222b9a90, I fixed a broken check for rcu_enable_atfork introduced
> > in d6919e4cb6. I added a call to rcu_enable_atfork after the
> > call to qemu_init in fuzz.c, but forgot to include the corresponding
> > header, breaking --enable-fuzzing --enable-werror builds.
> > 
> > Fixes: 45222b9a90 ("fuzz: fix broken qtest check at rcu_disable_atfork")
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > ---
> >  tests/qtest/fuzz/fuzz.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> > index a36d9038e0..0b66e43409 100644
> > --- a/tests/qtest/fuzz/fuzz.c
> > +++ b/tests/qtest/fuzz/fuzz.c
> > @@ -19,6 +19,7 @@
> >  #include "sysemu/runstate.h"
> >  #include "sysemu/sysemu.h"
> >  #include "qemu/main-loop.h"
> > +#include "qemu/rcu.h"
> >  #include "tests/qtest/libqtest.h"
> >  #include "tests/qtest/libqos/qgraph.h"
> >  #include "fuzz.h"
> 
> D'oh, mea culpa, I also apparently did not properly compile test that
> patch :-( I think we need a CI job that at least compile tests the
> fuzzing code - I can look into that once Alex Bennée's current testing
> pull request has been merged.

My bad - I should have done a clean build with a version of clang
that doesn't require me to -disable-werror

> Alexander, is there also a way to run a fuzzer just for some few
> minutes? E.g. a fuzzing test that finishes quickly, or an option to
> limit the time that a test is running? If so, we could also add that
> quick test to the CI pipeline, to make sure that the fuzzer code does
> not only compile, but is also able to run (at least a little bit).

Yes. I think the sequence could look something like:
CC=clang CXX=clang++ ../configure --enable-fuzzing --enable-sanitizers \
             --enable-werror
make i386-softmmu/fuzz
./i386-softmmu/qemu-fuzz-i386 --fuzz-target=i440fx-qtest-reboot-fuzz -runs=5000

This will run the i440fx fuzzer over 5000 inputs which should finish in
a second or so. I don't expect it to actually find any crashes in the
i440fx in such a short period, so, ideally, all errors would be
fuzzer-related.

Where can I get started with building out a CI job for this?

One aside: running this right now, QEMU exits and AddressSanitizer
complains about some leaks. There is a patch in Paolo's PR that should
fix this, but I was surprised that existing CI tests didn't catch it. Is
leak detection usually disabled in CI?

> For this patch here:
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!
-Alex

