Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEE7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 934EC207D8
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934EC207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGTM-0004ns-SS
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jhGRN-0002bx-0g
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:47:37 -0400
Received: from relay64.bu.edu ([128.197.228.104]:41763)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jhGRK-00069B-A8
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:47:36 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 055Hl1un003624
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 5 Jun 2020 13:47:08 -0400
Date: Fri, 5 Jun 2020 13:47:01 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] fuzz: add oss-fuzz build.sh script
Message-ID: <20200605174701.qaqxqf6v3xpnm4df@mozz.bu.edu>
References: <20200605174036.4527-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605174036.4527-1-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 13:47:33
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: darren.kenny@oracle.com, bsd@redhat.com, f4bug@amsat.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200605 1340, Alexander Bulekov wrote:
> It is neater to keep this in the QEMU repo, since any change that
> requires an update to the oss-fuzz build configuration, can make the
> necessary changes in the same series.
> 
> Suggested-by: Philippe Mathieu-Daude <f4bug@amsat.org>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  scripts/oss-fuzz/build.sh | 47 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100755 scripts/oss-fuzz/build.sh
> 
> diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
> new file mode 100755
> index 0000000000..7be6dcce4c
> --- /dev/null
> +++ b/scripts/oss-fuzz/build.sh
> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +#
> +# Update syscall_nr.h files from linux headers asm-generic/unistd.h
This is obviously wrong... Sending v2.

> +#
> +# This code is licensed under the GPL version 2 or later.  See
> +# the COPYING file in the top-level directory.
> +#
> +
> +# build project
> +# e.g.
> +# ./autogen.sh
> +# ./configure
> +# make -j$(nproc) all
> +
> +# build fuzzers
> +# e.g.
> +# $CXX $CXXFLAGS -std=c++11 -Iinclude \
> +#     /path/to/name_of_fuzzer.cc -o $OUT/name_of_fuzzer \
> +#     $LIB_FUZZING_ENGINE /path/to/library.a
> +
> +mkdir -p $OUT/lib/              # Shared libraries
> +
> +# Build once to get the list of dynamic lib paths, and copy them over
> +./configure --datadir="./data/" --disable-werror --cc="$CC" --cxx="$CXX" \
> +    --extra-cflags="$CFLAGS -U __OPTIMIZE__ "
> +make CONFIG_FUZZ=y CFLAGS="$LIB_FUZZING_ENGINE" -j$(nproc) i386-softmmu/fuzz
> +
> +for i in $(ldd ./i386-softmmu/qemu-fuzz-i386  | cut -f3 -d' '); do 
> +    cp $i $OUT/lib/
> +done
> +rm ./i386-softmmu/qemu-fuzz-i386
> +
> +# Build a second time to build the final binary with correct rpath
> +./configure --datadir="./data/" --disable-werror --cc="$CC" --cxx="$CXX" \
> +    --extra-cflags="$CFLAGS -U __OPTIMIZE__" \
> +    --extra-ldflags="-Wl,-rpath,'\$\$ORIGIN/lib'"
> +make CONFIG_FUZZ=y CFLAGS="$LIB_FUZZING_ENGINE" -j$(nproc) i386-softmmu/fuzz
> +
> +# Copy over the datadir
> +cp  -r ./pc-bios/ $OUT/pc-bios
> +
> +# Copy over the qemu-fuzz-i386, naming it according to each available fuzz
> +# target (See 05509c8e6d fuzz: select fuzz target using executable name)
> +for target in $(./i386-softmmu/qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
> +do
> +    cp ./i386-softmmu/qemu-fuzz-i386 $OUT/qemu-fuzz-i386-target-$target
> +done
> -- 
> 2.26.2
> 

