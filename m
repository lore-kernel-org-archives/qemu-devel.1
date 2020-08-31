Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77096C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F002083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F002083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmt9-00016A-GZ
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kCmsT-00006K-9a
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:41:53 -0400
Received: from relay68.bu.edu ([128.197.228.73]:39345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kCmsR-00022L-6h
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:41:52 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 07VGelcD008404
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 31 Aug 2020 12:40:50 -0400
Date: Mon, 31 Aug 2020 12:40:47 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] gitlab-ci.yml: Run check-qtest and check-unit at the end
 of the fuzzer job
Message-ID: <20200831164047.z4njpacixgjhcvjs@mozz.bu.edu>
References: <20200831153228.229185-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831153228.229185-1-thuth@redhat.com>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 12:41:49
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200831 1732, Thomas Huth wrote:
> The fuzzer job finishes quite early, so we can run the unit tests and
> qtests with -fsanitize=address here without extending the total test time.
> 

Sounds good to me, though its too bad that this is limited to i386 and
we aren't using the --enable-sanitizers configure argument due to the
strange oss-fuzz build script.

Speaking of testing with sanitizers, does it make sense to have a job
that does check-qtest with --enable-tsan, now that we have
ThreadSanitizer support? 

Can --enable-sanitizers --enable-tsan be added to some existing job,
without severely increasing the pipeline's exeuction time?

Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .gitlab-ci.yml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 17f1f8fad9..417fda6909 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -256,13 +256,14 @@ build-oss-fuzz:
>      - mkdir build-oss-fuzz
>      - CC="clang" CXX="clang++" CFLAGS="-fsanitize=address"
>        ./scripts/oss-fuzz/build.sh
> +    - export ASAN_OPTIONS="fast_unwind_on_malloc=0"
>      - for fuzzer in $(find ./build-oss-fuzz/DEST_DIR/ -executable -type f
>                        | grep -v slirp); do
>          grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 || continue ;
>          echo Testing ${fuzzer} ... ;
> -        ASAN_OPTIONS="fast_unwind_on_malloc=0"
> -         "${fuzzer}" -runs=1000 -seed=1 || exit 1 ;
> +        "${fuzzer}" -runs=1000 -seed=1 || exit 1 ;
>        done
> +    - cd build-oss-fuzz && make check-qtest-i386 check-unit
>  
>  build-tci:
>    <<: *native_build_job_definition
> -- 
> 2.18.2
> 

