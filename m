Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8C5C55178
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 13:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D619320724
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 13:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D619320724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb1hF-0007bY-Ri
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 08:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kb1gY-0006p4-KC
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 08:21:47 -0500
Received: from relay68.bu.edu ([128.197.228.73]:55967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kb1gW-0006nZ-4i
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 08:21:45 -0500
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 0A6DKV77014027
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 6 Nov 2020 08:20:35 -0500
Date: Fri, 6 Nov 2020 08:20:31 -0500
From: Alexander Bulekov <alxndr@bu.edu>
To: liqiuhao727 <liqiuhao727@outlook.com>
Subject: Re: [Question] Fuzz: No rule to make target 'i386-softmmu/fuzz'
Message-ID: <20201106132031.w4acn3ist6edan4p@mozz.bu.edu>
References: <MN2PR02MB6237838AECE9B6E768377EFAE0ED0@MN2PR02MB6237.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR02MB6237838AECE9B6E768377EFAE0ED0@MN2PR02MB6237.namprd02.prod.outlook.com>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 08:21:42
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 201106 2104, liqiuhao727 wrote:
> Hi,
> 
> I am a newbie to QEMU and trying to build the virtual-device fuzzer
> according to qemu/docs/devel/fuzzing.txt, which says:
> 
> ---
> Configure with (substitute the clang binaries with the version you
> installed).
> ...
>     CC=clang-8 CXX=clang++-8 /path/to/configure --enable-fuzzing \
>                                                 --enable-sanitizers
> Fuzz targets are built similarly to system/softmmu:

Ah, these instructions went out of date when QEMU switched to meson.
I'll send a patch to update them.

>     make i386-softmmu/fuzz
> This builds ./i386-softmmu/qemu-fuzz-i386

This should be:
make qemu-fuzz-i386

It looks like you are running these commands from the root qemu
directory, so the resulting binary should be
./build/qemu-fuzz-i386

There are a couple fixes to the fuzzers that should be applied soon, so
it might be a good idea to grab updated sources soon. They are part of
this pull-req:

https://lists.gnu.org/archive/html/qemu-devel/2020-11/msg01142.html

-Alex

> ---
> 
> But when I did this on my Ubuntu 20.04 x86-64 with qemu-5.2.0-rc0
> release code, the make complained it could not find the target:
> 
> ---
> root@iZj6canc2b2vgdozetp9foZ:~/qemu# CC=clang-10 CXX=clang++-10
> ./configure --enable-fuzzing --enable-sanitizers > configure.log
> root@iZj6canc2b2vgdozetp9foZ:~/qemu# make i386-softmmu/fuzz
> changing dir to build for make "i386-softmmu/fuzz"...
> make[1]: Entering directory '/root/qemu/build'
> /usr/bin/ninja  build.ninja && touch build.ninja.stamp
> ninja: no work to do.
> /usr/bin/python3 -B /root/qemu/meson/meson.py introspect --targets --
> tests --benchmarks | /usr/bin/python3 -B scripts/mtest2make.py >
> Makefile.mtest
> make[1]: *** No rule to make target 'i386-softmmu/fuzz'.  Stop.
> make[1]: Leaving directory '/root/qemu/build'
> make: *** [GNUmakefile:11: i386-softmmu/fuzz] Error 2
> ---
> 
> Did I missed something or misunderstood the instructions?
> Thanks.



