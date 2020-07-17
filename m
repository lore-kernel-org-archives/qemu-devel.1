Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FA2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFFE52070A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFE52070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwQ3q-0004Ci-1R
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 09:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jwQ2p-0002lo-6t
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:04:55 -0400
Received: from relay68.bu.edu ([128.197.228.73]:38675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jwQ2n-0001Sh-1U
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:04:54 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 06HD3qFx032123
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 17 Jul 2020 09:03:56 -0400
Date: Fri, 17 Jul 2020 09:03:52 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] gitlab-ci.yml: Add oss-fuzz build tests
Message-ID: <20200717130352.u5x556xr5aspxgdk@mozz.bu.edu>
References: <20200716163330.29141-1-alxndr@bu.edu>
 <75839163-5e7c-3ff4-6d89-870d69ea5979@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75839163-5e7c-3ff4-6d89-870d69ea5979@redhat.com>
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

On 200717 0740, Thomas Huth wrote:
> On 16/07/2020 18.33, Alexander Bulekov wrote:
> > This tries to build and run the fuzzers with the same build-script used
> > by oss-fuzz. This doesn't guarantee that the builds on oss-fuzz will
> > also succeed, since oss-fuzz provides its own compiler and fuzzer vars,
> > but it can catch changes that are not compatible with the the
> > ./scripts/oss-fuzz/build.sh script.
> > The strange way of finding fuzzer binaries stems from the method used by
> > oss-fuzz:
> > https://github.com/google/oss-fuzz/blob/master/infra/base-images/base-runner/targets_list
> > 
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > ---
> > 
> > Similar to Thomas' patch:
> > 
> >> Note: This patch needs two other patches merged first to work correctly:
> > 
> >> - 'fuzz: Expect the cmdline in a freeable GString' from Alexander
> > 
> >> - 'qom: Plug memory leak in "info qom-tree"' from Markus
> > 
> > Otherwise the test will fail due to detected memory leaks.
> > 
> > Fair warning: I haven't been able to trigger this new job yet. I tried
> > to run the pipeline with these changes on my forked repo on gitlab, but
> > did not reach the build-oss-fuzz. I think this is due to some failures
> > in the Containers-layer-2 stage:
> > 
> > ...
> > Error response from daemon: manifest for
> > registry.gitlab.com/a1xndr/qemu/qemu/debian-all-test-cross:latest not
> > found: manifest unknown: manifest unknown
> > #2 [internal] load .dockerignore
> > #2 transferring context:
> > #2 transferring context: 2B 0.1s done
> > #2 DONE 0.1s
> > #1 [internal] load build definition from tmpg8j4xoop.docker
> > #1 transferring dockerfile: 2.21kB 0.1s done
> > #1 DONE 0.2s
> > #3 [internal] load metadata for docker.io/qemu/debian10:latest
> > #3 ERROR: pull access denied, repository does not exist or may require
> > authorization: server message: insufficient_scope: authorization failed
> 
> These look like the problems that we've seen with the main repo until
> two days ago, too, e.g.:
> 
>  https://gitlab.com/qemu-project/qemu/-/jobs/640410842
> 
> Maybe Alex (Bennée) can comment on how to resolve them?
> 
> > 
> >  .gitlab-ci.yml | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index e96f8794b9..a50df420c9 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -182,6 +182,20 @@ build-fuzzer:
> >              || exit 1 ;
> >        done
> 
> As mentioned in my other mail, I think you can replace my build-fuzzer
> job once this is working.
> 
> > +build-oss-fuzz:
> > +  <<: *native_build_job_definition
> > +  variables:
> > +    IMAGE: fedora
> > +  script:
> > +    - OUT_DIR="./build" CC=clang-9 CXX=clang++-9 CFLAGS="-fsanitize=address"
> > +      LIB_FUZZING_ENGINE="-fsanitize=fuzzer" CFL
> 
> That "CFL" at the end seems to be a typo (leftover from "CFLAGS")?

oops...

> Also the fedora container does not have clang-9 :
> 
>  https://gitlab.com/huth/qemu/-/jobs/643383032#L28
> 
> I think it is at clang 10 already, so maybe just use CC=clang (without
> version number)?
> 
For some reason my local machine doesn't have symlinks for clang and
clang++, and I forgot to remove the versions when I copied the command.

> > +      ./scripts/oss-fuzz/build.sh
> > +    - for fuzzer in $(find ./build-oss-fuzz/DEST_DIR/ -executable -type f); do
> > +        grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 || continue ;
> > +        echo Testing ${fuzzer} ... ;
> > +        "${fuzzer}" -runs=1000 || exit 1 ;
> > +      done
> 
> Should we exclude the virtio-net tests, since they could leak network
> traffic to the host?

Ah good point. I doubt that 1000 runs is enough to generate something
that slirp will forward, but we should probably skip over these targets
just to be on the safe side.

-Alex

>  Thomas
> 

