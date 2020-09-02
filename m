Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19319C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE4D420767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4D420767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDTsg-0000NX-57
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 10:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDTsB-0008Nx-Vq
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:36:28 -0400
Received: from relay68.bu.edu ([128.197.228.73]:50269)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDTs9-0002dy-HI
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:36:27 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 082EZpg6007613
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 2 Sep 2020 10:35:54 -0400
Date: Wed, 2 Sep 2020 10:35:51 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] Fix oss-fuzz builds post-meson integration
Message-ID: <20200902143551.kiudougufezbhtlp@mozz.bu.edu>
References: <20200902142657.112879-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902142657.112879-1-alxndr@bu.edu>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 10:34:22
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
Cc: bonzini@redhat.com, darren.kenny@oracle.com, bsd@redhat.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series is missing a patch. Re-sending..

On 200902 1026, Alexander Bulekov wrote:
> QEMU stopped building on oss-fuzz, after the meson integration, due to
> some linking issues:
> 
> https://oss-fuzz-build-logs.storage.googleapis.com/log-3eaddfbd-7e05-4ddd-9d86-ee4b16c0fac6.txt
> 
> Those problems should be partially fixed by:
> 
> Depends-on: meson: fix libqos linking
> (https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg00802.html)
> 
> These patches:
> 1. Build on the above patch to fix the way we specify the linker script,
>    to ensure that it is not specified within start-group/end-group linker
>    pairs
> 2. Add support for running --enable-fuzzing with a custom LIB_FUZZING_ENGINE
> 3. Fix a problem with how we specify custom rpath in the oss-fuzz
>    build-script
> 
> Alexander Bulekov (2):
>   fuzz: Add support for custom fuzzing library
>   scripts/oss-fuzz/build.sh: fix rpath
> 
>  configure                    | 12 ++++++++++--
>  scripts/oss-fuzz/build.sh    |  2 +-
>  tests/qtest/fuzz/meson.build |  4 ++--
>  3 files changed, 13 insertions(+), 5 deletions(-)
> 
> -- 
> 2.28.0
> 

