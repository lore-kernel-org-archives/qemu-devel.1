Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435EDC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF84206B8
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF84206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFJQK-0002XG-QH
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 11:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kFJPh-0001iB-Im
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 11:50:37 -0400
Received: from relay64.bu.edu ([128.197.228.104]:56496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kFJPf-00025N-Lv
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 11:50:37 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 087FnoNU011983
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 7 Sep 2020 11:49:53 -0400
Date: Mon, 7 Sep 2020 11:49:49 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH v2 13/15] scripts/oss-fuzz: build the general-fuzzer
 configs
Message-ID: <20200907154949.7tvkwhwxdb27awrj@mozz.bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
 <20200819061110.1320568-14-alxndr@bu.edu>
 <m24kofrzgc.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m24kofrzgc.fsf@oracle.com>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 11:50:35
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, f4bug@amsat.org,
 bsd@redhat.com, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200903 1017, Darren Kenny wrote:
> On Wednesday, 2020-08-19 at 02:11:08 -04, Alexander Bulekov wrote:
> > Build general-fuzzer wrappers for each configuration defined in
> > general_fuzzer_configs.yml and move the actual general-fuzzer to a
> > subdirectory, so oss-fuzz doesn't treat it as a standalone fuzzer.
> 
> You didn't mention the removeal of *uhci* from the config below, should
> probably be at least referenced.

Must have made a mistake when I was fixup/rebasing. Shouldn't be there,
next time around.

Thanks
-Alex

> >
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> 
> With that,
> 
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> 
> Thanks,
> 
> Darren.
> 
> > ---
> >  scripts/oss-fuzz/build.sh                   | 8 +++++++-
> >  scripts/oss-fuzz/general_fuzzer_configs.yml | 2 +-
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
> > index a07b3022e8..2071e77ac2 100755
> > --- a/scripts/oss-fuzz/build.sh
> > +++ b/scripts/oss-fuzz/build.sh
> > @@ -38,7 +38,7 @@ OSS_FUZZ_BUILD_DIR="./build-oss-fuzz/"
> >  # remove it, resulting in an unresolved reference to qemu_build_not_reached
> >  # Undefine the __OPTIMIZE__ macro which compiler.h relies on to choose whether
> >  # to " #define qemu_build_not_reached()  g_assert_not_reached() "
> > -EXTRA_CFLAGS="$CFLAGS -U __OPTIMIZE__"
> > +EXTRA_CFLAGS="$CFLAGS -U __OPTIMIZE__ -DCONFIG_FUZZ=y"
> >  
> >  if ! { [ -e "./COPYING" ] &&
> >     [ -e "./MAINTAINERS" ] &&
> > @@ -101,5 +101,11 @@ do
> >      cp ./i386-softmmu/qemu-fuzz-i386 "$DEST_DIR/qemu-fuzz-i386-target-$target"
> >  done
> >  
> > +mkdir -p "$DEST_DIR/deps"
> > +mv "$DEST_DIR/qemu-fuzz-i386-target-general-fuzz" "$DEST_DIR/deps/"
> > +
> > +./scripts/oss-fuzz/build_general_fuzzers.py \
> > +    "./scripts/oss-fuzz/general_fuzzer_configs.yml" "$DEST_DIR/general-fuzz-"
> > +
> >  echo "Done. The fuzzers are located in $DEST_DIR"
> >  exit 0
> > diff --git a/scripts/oss-fuzz/general_fuzzer_configs.yml b/scripts/oss-fuzz/general_fuzzer_configs.yml
> > index 010e92a2a5..f70bacb243 100644
> > --- a/scripts/oss-fuzz/general_fuzzer_configs.yml
> > +++ b/scripts/oss-fuzz/general_fuzzer_configs.yml
> > @@ -92,7 +92,7 @@ configs:
> >          -device usb-braille,chardev=cd0 -device usb-ccid -device usb-ccid
> >          -device usb-kbd -device usb-mouse -device usb-serial,chardev=cd1
> >          -device usb-tablet -device usb-wacom-tablet -device usb-audio
> > -      objects: "*usb* *uhci* *xhci*"
> > +      objects: "*usb* *xhci*"
> >  
> >      - name: pc-i440fx
> >        args: -machine pc
> > -- 
> > 2.27.0

