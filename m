Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C43BC35257
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A925206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A925206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOQ9a-0007OQ-Np
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 14:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>)
 id 1kOQ5d-0003hT-Kx; Fri, 02 Oct 2020 14:47:33 -0400
Received: from relay68.bu.edu ([128.197.228.73]:34463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>)
 id 1kOQ5b-0002yZ-Ux; Fri, 02 Oct 2020 14:47:33 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 092Il5kl001741
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 2 Oct 2020 14:47:09 -0400
Date: Fri, 2 Oct 2020 14:47:05 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] gitlab-ci.yml: Only run one test-case per fuzzer
Message-ID: <20201002184705.uipujm4cqujcyfyl@mozz.bu.edu>
References: <20201002143524.56930-1-alxndr@bu.edu>
 <6564a712-71e5-460b-c9d6-1d2c245ff6ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6564a712-71e5-460b-c9d6-1d2c245ff6ea@redhat.com>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 14:47:30
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.821, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 201002 1715, Thomas Huth wrote:
> On 02/10/2020 16.35, Alexander Bulekov wrote:
> > With 1000 runs, there is a non-negligible chance that the fuzzer can
> > trigger a crash. With this CI job, we care about catching build/runtime
> > issues in the core fuzzing code. Actual device fuzzing takes place on
> > oss-fuzz. For these purposes, only running one input should be
> > sufficient.
> > 
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > ---
> >  .gitlab-ci.yml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index a51c89554f..075c15d45c 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -303,7 +303,7 @@ build-oss-fuzz:
> >                        | grep -v slirp); do
> >          grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 || continue ;
> >          echo Testing ${fuzzer} ... ;
> > -        "${fuzzer}" -runs=1000 -seed=1 || exit 1 ;
> > +        "${fuzzer}" -runs=1 -seed=1 || exit 1 ;
> 
> ... but we're apparently already using a fixed seed for running the
> test, so it should be pretty much deterministic, shouldn't it? So the
> chance that the fuzzer hits a crash here for a pre-existing problem
> should be close to zero? ... so I'm not quite sure whether we really
> need this? Anyway, I certainly also won't object this patch, so in case
> anybody wants to merge it:

In addition to using an RNG+seed, libfuzzer also uses coverage
information to guide mutations. My guess is that as QEMU changes, this
coverage can change as well, so I wouldn't assume that using the same
seed will result in the same inputs generated, in the longer term.

Its true that the main benefit will probably be a few minutes shaved off
the 400 minute limit...
Thanks
-Alex

> 
> Acked-by: Thomas Huth <thuth@redhat.com>
> 

