Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48183C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C3B2064B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C3B2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwQJ7-0007Ag-CZ
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 09:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jwQIY-0006jC-3B
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:21:10 -0400
Received: from relay68.bu.edu ([128.197.228.73]:39840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jwQIV-0004bB-Vy
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:21:09 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 06HDK7jF014790
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 17 Jul 2020 09:20:08 -0400
Date: Fri, 17 Jul 2020 09:20:07 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] gitlab-ci.yml: Add oss-fuzz build tests
Message-ID: <20200717132007.bux2neofbktbl522@mozz.bu.edu>
References: <20200716163330.29141-1-alxndr@bu.edu>
 <75839163-5e7c-3ff4-6d89-870d69ea5979@redhat.com>
 <9ddec0a1-d106-e36a-b25e-d54235bf75b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ddec0a1-d106-e36a-b25e-d54235bf75b5@redhat.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 09:04:52
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200717 0951, Thomas Huth wrote:
> On 17/07/2020 07.40, Thomas Huth wrote:
> > On 16/07/2020 18.33, Alexander Bulekov wrote:
> >> This tries to build and run the fuzzers with the same build-script used
> >> by oss-fuzz. This doesn't guarantee that the builds on oss-fuzz will
> >> also succeed, since oss-fuzz provides its own compiler and fuzzer vars,
> >> but it can catch changes that are not compatible with the the
> >> ./scripts/oss-fuzz/build.sh script.
> >> The strange way of finding fuzzer binaries stems from the method used by
> >> oss-fuzz:
> >> https://github.com/google/oss-fuzz/blob/master/infra/base-images/base-runner/targets_list
> >>
> >> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> >> ---
> >>
> >> Similar to Thomas' patch:
> >>
> >>> Note: This patch needs two other patches merged first to work correctly:
> >>
> >>> - 'fuzz: Expect the cmdline in a freeable GString' from Alexander
> >>
> >>> - 'qom: Plug memory leak in "info qom-tree"' from Markus
> >>
> >> Otherwise the test will fail due to detected memory leaks.
> >>
> >> Fair warning: I haven't been able to trigger this new job yet. I tried
> >> to run the pipeline with these changes on my forked repo on gitlab, but
> >> did not reach the build-oss-fuzz. I think this is due to some failures
> >> in the Containers-layer-2 stage:
> 
> I think I've got it basically working like this:
> 
> build-oss-fuzz:
>   <<: *native_build_job_definition
>   variables:
>     IMAGE: fedora
>   script:
>     - mkdir build-oss-fuzz
>     - CC="clang" CXX="clang++" CFLAGS="-fsanitize=address"
>       ./scripts/oss-fuzz/build.sh
>     - for fuzzer in $(find build-oss-fuzz/DEST_DIR/ -executable -type f
>                       | grep -v slirp); do
>         grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 ||
> continue ;
>         echo Testing ${fuzzer} ... ;
>         "${fuzzer}" -runs=1000 || exit 1 ;
>       done
> 
> However, it still triggered a memory leak and thus the pipeline failed:
> 
>  https://gitlab.com/huth/qemu/-/jobs/643472695
> 
> ... and this was with all the other "leak fix" patches already applied.
> Is there an easy way to debug that issue? That information from the
> LeakSanitizer looks pretty sparse...

Strange... Especially since Philippe didn't get the same error. We
should probably add -seed=1 after -runs=1000, to make sure the fuzzer is
using the same rng seed. That said, I just ran the fuzzer for 50k
iterations, and still could not reproduce the leak...

This environment variable should fix the partial stacktrace, so we don't
have to guess next time:
ASAN_OPTIONS="fast_unwind_on_malloc=0"
-Alex

>  Thomas
> 

