Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58071C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7312076A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7312076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZc1R-0000bJ-D9
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 11:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jZbzc-00060q-9h
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:11:20 -0400
Received: from relay64.bu.edu ([128.197.228.104]:57699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jZbzZ-00050n-8f
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:11:19 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 04FFAa7G009758
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 15 May 2020 11:10:39 -0400
Date: Fri, 15 May 2020 11:10:36 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 0/6] tests/fuzz: Review notes
Message-ID: <20200515151036.e5h26s65fokygbvr@mozz.bu.edu>
References: <20200514143433.18569-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200514143433.18569-1-philmd@redhat.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 11:11:14
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200514 1634, Philippe Mathieu-Daudé wrote:
> I took some code notes while testing Alex's toy.
> Sending them as patches.

Thank you for these! I'd send my review tags, if they weren't already
pulled.

> Alex, I had theses issues while building following
> docs/devel/fuzzing.txt:
> 
>     CC      nbd/server.o
>   nbd/server.c:1937:1: error: unused function 'glib_listautoptr_cleanup_NBDExtentArray' [-Werror,-Wunused-function]
>   G_DEFINE_AUTOPTR_CLEANUP_FUNC(NBDExtentArray, nbd_extent_array_free);
>   ^
>   /usr/include/glib-2.0/glib/gmacros.h:462:22: note: expanded from macro 'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
>     static inline void _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName) (GList **_l) { g_list_free_full (*_l, (GDestroyNotify) func); } \
>                        ^
>   /usr/include/glib-2.0/glib/gmacros.h:443:48: note: expanded from macro '_GLIB_AUTOPTR_LIST_FUNC_NAME'
>   #define _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName) glib_listautoptr_cleanup_##TypeName
>                                                  ^
> Solved by using './configure ... --extra-cflags=-Wno-unused-function'

Interesting that this doesn't show up for standard builds. I'll have to
look into this more.

>     LINK    i386-softmmu/qemu-fuzz-i386
>   /usr/lib64/clang/9.0.1/lib/linux/libclang_rt.asan-aarch64.a(asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfork' overridden by definition
>   /usr/lib64/clang/9.0.1/lib/linux/libclang_rt.asan-aarch64.a(asan_interceptors.cc.o): warning: defined here
> 
> I simply ignore this warning.

Yes, I get the same warning with this:

cat << EOF | clang-9 -Wl,--warn-common  -fsanitize=fuzzer,address -x c -
#include <sys/types.h>
#include <stdint.h>
int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) { return 0; }
EOF

Might report this to the LLVM/compiler-rt folks.

> Alex, could you provide few more examples (in particular about
> instantiating devices, or useful libfuzzer arguments)?

Yes - I'll send this out with my next fuzzing patches.

> Also, I suppose you are using a script to generate the bug reports:
> 
>   I can reproduce it in qemu 5.0 using:
> 
>   cat << EOF | qemu-system ...
>   outl 0xcf8 ...
>   outl 0xcfc ...
>   ...
>   EOF
> 
> Is this script available in the QEMU repository? I couldn't find it.

Right now I just added some unbuffered writes to qtest.c. I'll try to
find a clean way of doing this and I'll add a way to automatically
convert a crashing input to qemu arguments + qtest command sequence.

Thanks again!
-Alex

> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (6):
>   tests/fuzz/Makefile: Do not link code using unavailable devices
>   Makefile: List fuzz targets in 'make help'
>   tests/fuzz: Add missing space in test description
>   tests/fuzz: Remove unuseful/unused typedefs
>   tests/fuzz: Extract pciconfig_fuzz_qos() method
>   tests/fuzz: Extract ioport_fuzz_qtest() method
> 
>  Makefile                          |  6 +++-
>  tests/qtest/fuzz/i440fx_fuzz.c    | 47 ++++++++++++++++++++-----------
>  tests/qtest/fuzz/Makefile.include |  6 ++--
>  3 files changed, 38 insertions(+), 21 deletions(-)
> 
> -- 
> 2.21.3
> 

