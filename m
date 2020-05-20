Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE846C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 18:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7164B20671
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 18:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7164B20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbT93-0003OP-MQ
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 14:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jbT8T-0002ja-0L
 for qemu-devel@nongnu.org; Wed, 20 May 2020 14:08:09 -0400
Received: from relay68.bu.edu ([128.197.228.73]:54534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jbT8N-0003eY-Vb
 for qemu-devel@nongnu.org; Wed, 20 May 2020 14:08:08 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 04KI72rR001816
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 20 May 2020 14:07:05 -0400
Date: Wed, 20 May 2020 14:07:02 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/4] fuzz: add datadir for oss-fuzz compatability
Message-ID: <20200520180656.ddr77btsvxklatpz@mozz.bu.edu>
References: <20200512030133.29896-1-alxndr@bu.edu>
 <20200512030133.29896-2-alxndr@bu.edu>
 <18b02a81-1f0e-973a-1867-4ff30edbe128@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18b02a81-1f0e-973a-1867-4ff30edbe128@redhat.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 14:08:01
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, darren.kenny@oracle.com, bsd@redhat.com,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200520 1851, Philippe Mathieu-Daudé wrote:
> On 5/12/20 5:01 AM, Alexander Bulekov wrote:

-snip-
> > +        /*
> > +         * With oss-fuzz, the executable is kept in the root of a directory (we
> > +         * cannot assume the path). All data (including bios binaries) must be
> > +         * in the same dir, or a subdir. Thus, we cannot place the pc-bios so
> > +         * that it would be in exec_dir/../pc-bios.
> > +         * As a workaround, oss-fuzz allows us to use argv[0] to get the
> > +         * location of the executable. Using this we add exec_dir/pc-bios to
> > +         * the datadirs.
> 
> I don't understand well the problem. How do you run it?

On oss-fuzz, the build and execution happens in two separate containers.

1.) In the build container, we can do whatever we want, but we must
place the executable(s) we produce at the root of a directory /out/.
e.g. one output executable is /out/qemu-system-target-i440fx-fuzz

2.) In the runner, this "build artifact" directory is mounted at
some location(we can't assume the location). This runner container
automatically identifies the executable within the root of the  "build
artifact" dir and runs it. The path to the executable could now be 
/somedir/qemu-system-target-i440fx-fuzz

In the runner container we only have control over the files in /somedir/
(which was /out/ in the builder). Thus, in addition to copying over
shared-libs to /out/ we need to copy any data (pc-bios) that the binary
relies on. The problem is that we have to point qemu towards the
location of the bios. Normally qemu checks the /usr/share/... dir. For
local builds, qemu also examines the executable path and looks in
$executable_path/../pc-bios/. On the oss-fuzz runner we dont control
/somedir/../pc-bios, so we can't rely on this. This patch allows us to
specify /somedir/pc-bios as the datadir.

Hopefully that is not too confusing.

For reference, here is a draft of the build-script that I expect to
deploy to oss-fuzz:

# build project
# e.g.
# ./autogen.sh
# ./configure
# make -j$(nproc) all

# build fuzzers
# e.g.
# $CXX $CXXFLAGS -std=c++11 -Iinclude \
#     /path/to/name_of_fuzzer.cc -o $OUT/name_of_fuzzer \
#     $LIB_FUZZING_ENGINE /path/to/library.a

# make a dir for the shared libs
mkdir -p $OUT/lib/

#Build once to copy over the list of dynamic libs
./configure --datadir="./data/" --disable-werror --cc="$CC" --cxx="$CXX" --extra-cflags="$CFLAGS -U __OPTIMIZE__ "
make CONFIG_FUZZ=y CFLAGS="$LIB_FUZZING_ENGINE" -j$(nproc) i386-softmmu/fuzz

# copy over the shared libs
for i in $(ldd ./i386-softmmu/qemu-fuzz-i386  | cut -f3 -d' '); do
    cp $i $OUT/lib/
done
rm ./i386-softmmu/qemu-fuzz-i386

# Build second time to build the final binary with correct rpath
./configure --datadir="./data/" --disable-werror --cc="$CC" --cxx="$CXX" --extra-cflags="$CFLAGS -U __OPTIMIZE__" --extra-ldflags="-Wl,-rpath,'\$\$ORIGIN/lib'"
make CONFIG_FUZZ=y CFLAGS="$LIB_FUZZING_ENGINE" -j$(nproc) i386-softmmu/fuzz

# copy over bios data
cp  -r ./pc-bios/ $OUT/pc-bios
for target in $(./i386-softmmu/qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
do
    cp ./i386-softmmu/qemu-fuzz-i386 $OUT/qemu-fuzz-i386-target-$target
done

-Alex
> 
> > +         */
> > +        dir = g_build_filename(g_path_get_dirname(**argv), "pc-bios", NULL);
> > +        if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
> > +            qemu_add_data_dir(dir);
> > +        }
> > +        g_free(dir);
> >       } else if (*argc > 1) {  /* The target is specified as an argument */
> >           target_name = (*argv)[1];
> >           if (!strstr(target_name, "--fuzz-target=")) {
> > 
> 

