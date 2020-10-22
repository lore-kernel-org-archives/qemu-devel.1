Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2696CC388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EBAF22267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBAF22267
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVaG1-0004Zn-5v
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 09:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVaE6-0003We-Hh
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 09:01:54 -0400
Received: from relay68.bu.edu ([128.197.228.73]:43673)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVaE3-0000Y2-8p
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 09:01:53 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 09MD1NO7017845
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 22 Oct 2020 09:01:26 -0400
Date: Thu, 22 Oct 2020 09:01:23 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH v6 16/16] scripts/oss-fuzz: remove the generic-fuzz target
Message-ID: <20201022130123.5bjijh5cupwujeox@mozz.bu.edu>
References: <20201021210922.572955-1-alxndr@bu.edu>
 <20201021210922.572955-17-alxndr@bu.edu>
 <m2o8ku7ghw.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2o8ku7ghw.fsf@oracle.com>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 09:01:48
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.502, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, f4bug@amsat.org,
 bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 201022 1032, Darren Kenny wrote:
> Hi Alex,
> 
> On Wednesday, 2020-10-21 at 17:09:22 -04, Alexander Bulekov wrote:
> > generic-fuzz is not a standalone fuzzer - it requires some env variables
> > to be set. On oss-fuzz, we set these with some predefined
> > generic-fuzz-{...} targets, that are thin wrappers around generic-fuzz.
> > Remove generic-fuzz from the oss-fuzz build, so oss-fuzz does not treat
> > it as a standalone fuzzer.
> >
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > ---
> >  scripts/oss-fuzz/build.sh | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
> > index 0c3ca9e06f..37cd7f9e25 100755
> > --- a/scripts/oss-fuzz/build.sh
> > +++ b/scripts/oss-fuzz/build.sh
> > @@ -97,5 +97,11 @@ do
> 

Hi Darren,

> I'm presuming that the target that you're removing is being created by
> this line, maybe we should just specifically skip it here instead?

Sounds good.

> The comment below on the removal probably would still apply though.
> 
> >      cp qemu-fuzz-i386 "$DEST_DIR/qemu-fuzz-i386-target-$target"
> 
> Also, did you look into using hard-links, or even sym-links - they would
> require less duplication of the binaries, which may be important, or may
> not, and quicker creation too, e.g.
> 
>       ln qemu-fuzz-i386 "$DEST_DIR/qemu-fuzz-i386-target-$target"

This is what I tried, when I was putting together the patch-series, and
it raised an error when I was testing it in the oss-fuzz
docker-containers. I blamed it on Docker, originally, but I just took a
closer look, and the problem was that "qemu-fuzz-i386" isn't on the same
file-system as $DEST_DIR in the oss-fuzz Docker. If I copy
qemu-fuzz-i386 to $DEST_DIR/lib, and do 
    ln "$DEST_DIR/lib/qemu-fuzz-i386" \
       "$DEST_DIR/qemu-fuzz-i386-target-$target"
everything works :)
Thanks
-Alex

> 
> It's something that has been done for years, for example if you do:
> 
>       ls -il /sbin/{e2fsck,fsck.ext*}
> 
> you will see they share the same inode. Similarly for vi and ex, they
> use symlinks (hardlinks on some OSes, but seems not Linux):
> 
>       ls -il /bin/{vi,ex}
> 
> The main point is that argv[0] will be the name of link itself, not the
> thing pointed to.
> 
> Thanks,
> 
> Darren.
> 
> >  done
> >  
> > +# Remove the generic-fuzz target, as it requires some environment variables to
> > +# be configured. We have some generic-fuzz-{pc-q35, floppy, ...} targets that
> > +# are thin wrappers around this target that set the required environment
> > +# variables according to predefined configs.
> > +rm "$DEST_DIR/qemu-fuzz-i386-target-generic-fuzz"
> > +
> >  echo "Done. The fuzzers are located in $DEST_DIR"
> >  exit 0
> > -- 
> > 2.28.0

