Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3869AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8E52074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8E52074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhH2h-0002Km-8q
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 14:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jhH2C-0001vv-Cb
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 14:25:40 -0400
Received: from relay64.bu.edu ([128.197.228.104]:44521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jhH28-0006XE-OQ
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 14:25:39 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 055IOw5d004932
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 5 Jun 2020 14:25:02 -0400
Date: Fri, 5 Jun 2020 14:24:59 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH v2] fuzz: add oss-fuzz build.sh script
Message-ID: <20200605182459.akripxavanjpv6rb@mozz.bu.edu>
References: <20200605175028.5626-1-alxndr@bu.edu> <m2a71hv1gf.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2a71hv1gf.fsf@oracle.com>
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
Cc: bsd@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Darren,

On 200605 1858, Darren Kenny wrote:
> Hi Alex,
> 
> From looking at another OSS Fuzz project recently (a coincidence) I
> wonder if we could make this script work so that it can be run outside
> of the OSS-Fuzz environment?
> 
> Specifically, for example, if $OUT is not set, then creating a subdir in
> the build directory, and setting it to be that.
> 
For $OUT, do you think it would be better to require it as
a user-configurable environment variable? My concern is that making it
a subdirectory of the build dir would mean that the pc-bios files exist 
located in $OUT/../pc-bios. This doesn't reflect OSS-Fuzz, where we
specifically have to copy them to $OUT/pc-bios/

> Similarly for some other things like $LIB_FUZZING_ENGINE?
Will do.

> I'm just thinking that it might help someone that is not familiar with
> OSS-Fuzz to validate that the script still works without having to go
> through setting up the containers, etc that would be required to
> validate it.
> 
> Also, I would definitely recommend running ShellCheck against any script
> to ensure that you're catching any mistakes that can so easily be put in
> to shell scripts - speaking from experience here ;)
I will :)

> Thanks,
> 
> Darren.

Thanks for bringing these up!
-Alex

> 
> On Friday, 2020-06-05 at 13:50:28 -04, Alexander Bulekov wrote:
> > It is neater to keep this in the QEMU repo, since any change that
> > requires an update to the oss-fuzz build configuration, can make the
> > necessary changes in the same series.
> >
> > Suggested-by: Philippe Mathieu-Daude <f4bug@amsat.org>
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > ---
> >
> > v2 updates the script header comment.
> >
> >  scripts/oss-fuzz/build.sh | 50 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100755 scripts/oss-fuzz/build.sh
> >
> > diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
> > new file mode 100755
> > index 0000000000..e93d6f2e03
> > --- /dev/null
> > +++ b/scripts/oss-fuzz/build.sh
> > @@ -0,0 +1,50 @@
> > +#!/bin/sh
> > +#
> > +# OSS-Fuzz build script. See:
> > +# https://google.github.io/oss-fuzz/getting-started/new-project-guide/#buildsh
> > +#
> > +# This code is licensed under the GPL version 2 or later.  See
> > +# the COPYING file in the top-level directory.
> > +#
> > +
> > +# build project
> > +# e.g.
> > +# ./autogen.sh
> > +# ./configure
> > +# make -j$(nproc) all
> > +
> > +# build fuzzers
> > +# e.g.
> > +# $CXX $CXXFLAGS -std=c++11 -Iinclude \
> > +#     /path/to/name_of_fuzzer.cc -o $OUT/name_of_fuzzer \
> > +#     $LIB_FUZZING_ENGINE /path/to/library.a
> > +
> > +mkdir -p $OUT/lib/              # Shared libraries
> > +
> > +# Build once to get the list of dynamic lib paths, and copy them over
> > +./configure --datadir="./data/" --disable-werror --cc="$CC" --cxx="$CXX" \
> > +    --extra-cflags="$CFLAGS -U __OPTIMIZE__ "
> > +make CONFIG_FUZZ=y CFLAGS="$LIB_FUZZING_ENGINE" -j$(nproc) i386-softmmu/fuzz
> > +
> > +for i in $(ldd ./i386-softmmu/qemu-fuzz-i386  | cut -f3 -d' '); do 
> > +    cp $i $OUT/lib/
> > +done
> > +rm ./i386-softmmu/qemu-fuzz-i386
> > +
> > +# Build a second time to build the final binary with correct rpath
> > +./configure --datadir="./data/" --disable-werror --cc="$CC" --cxx="$CXX" \
> > +    --extra-cflags="$CFLAGS -U __OPTIMIZE__" \
> > +    --extra-ldflags="-Wl,-rpath,'\$\$ORIGIN/lib'"
> > +make CONFIG_FUZZ=y CFLAGS="$LIB_FUZZING_ENGINE" -j$(nproc) i386-softmmu/fuzz
> > +
> > +# Copy over the datadir
> > +cp  -r ./pc-bios/ $OUT/pc-bios
> > +
> > +# Run the fuzzer with no arguments, to print the help-string and get the list
> > +# of available fuzz-targets. Copy over the qemu-fuzz-i386, naming it according
> > +# to each available fuzz target (See 05509c8e6d fuzz: select fuzz target using
> > +# executable name)
> > +for target in $(./i386-softmmu/qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
> > +do
> > +    cp ./i386-softmmu/qemu-fuzz-i386 $OUT/qemu-fuzz-i386-target-$target
> > +done
> > -- 
> > 2.26.2

