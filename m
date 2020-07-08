Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9094C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D0B2065D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D0B2065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtFhH-0001NV-4C
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 15:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jtFgX-0000TV-BG
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 15:24:49 -0400
Received: from relay64.bu.edu ([128.197.228.104]:51716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jtFgU-0002a0-Vn
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 15:24:48 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 068JNdZs017662
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 8 Jul 2020 15:23:42 -0400
Date: Wed, 8 Jul 2020 15:23:39 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: build error of unused function as MACRO
 G_DEFINE_AUTOPTR_CLEANUP_FUNC expand
Message-ID: <20200708192339.ex4ygaebjekxk2qc@mozz.bu.edu>
References: <5F05E942.FB9110.20278@mail-m971.mail.163.com>
 <b02161d0-a027-5018-af05-8ccbc5c90cc9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b02161d0-a027-5018-af05-8ccbc5c90cc9@redhat.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 15:24:44
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: Li Qiang <liq3ea@163.com>, "liq3ea@gmail.com" <liq3ea@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Li,
I usually build the fuzzer with "make i386-softmmu/fuzz", so I must have
missed the nbd issue... I could not reproduce this locally since:

alxndr@mozz:qemu(master)$ dpkg -l "*glib2.0-bin*"
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name           Version      Architecture Description
+++-==============-============-============-=================================
ii  libglib2.0-bin 2.60.6-2     amd64        Programs for the GLib library

 The issue described in 9bda600b083 only shows up in versions older than
 2.57.2... 

After some digging, in ./configure:
...
  if test "$have_fuzzer" = "yes"; then
    FUZZ_LDFLAGS=" -fsanitize=address,fuzzer"
    FUZZ_CFLAGS=" -fsanitize=address,fuzzer"
    CFLAGS=" -fsanitize=address,fuzzer-no-link"

Thats probably the issue. Should be
    CFLAGS="$CFLAGS -fsanitize=address,fuzzer-no-link"

I'm also having trouble building, but for a different reason..

CC=clang-8 CXX=clang++-8  ./configure  --target-list="i386-softmmu" --enable-fuzzing
...
  CC      i386-softmmu/tests/qtest/fuzz/qtest_wrappers.o
/tmp/qemu/tests/qtest/fuzz/fuzz.c:215:5: error: implicit declaration of function 'rcu_enable_atfork' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
    rcu_enable_atfork();
    ^
45222b9a9016488289a1938a528239c3b83eddb1 is the first bad commit
commit 45222b9a9016488289a1938a528239c3b83eddb1
Author: Alexander Bulekov <alxndr@bu.edu>
Date:   Thu Jun 18 12:05:16 2020 -0400

    fuzz: fix broken qtest check at rcu_disable_atfork

Looks like I forgot a header... I'll send fixes for both of these
issues.

Thank you
-Alex

On 200708 1850, Philippe Mathieu-Daudé wrote:
> Cc'ing the fuzzing maintainers.
> 
> On 7/8/20 5:41 PM, Li Qiang wrote:
> > Hello all,
> > 
> >  
> > 
> > I build qemu with fuzzing enabled using clang and following error come.
> > 
> >  
> > 
> > nbd/server.c:1937:1: error: unused function
> > 'glib_listautoptr_cleanup_NBDExtentArray' [-Werror,-Wunused-function]
> > 
> > G_DEFINE_AUTOPTR_CLEANUP_FUNC(NBDExtentArray, nbd_extent_array_free);
> > 
> > ^
> > 
> > /usr/include/glib-2.0/glib/gmacros.h:462:22: note: expanded from macro
> > 'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
> > 
> >   static inline void _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName) (GList **_l)
> > { g_list_free_full (*_l, (GDestroyNotify) func); } \
> > 
> >                      ^
> > 
> > /usr/include/glib-2.0/glib/gmacros.h:443:48: note: expanded from macro
> > '_GLIB_AUTOPTR_LIST_FUNC_NAME'
> > 
> > #define _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName)
> > glib_listautoptr_cleanup_##TypeName
> > 
> >                                                ^
> > 
> > <scratch space>:170:1: note:   CC      crypto/hash-glib.o
> > 
> > expanded from here
> > 
> > glib_listautoptr_cleanup_NBDExtentArray
> > 
> > ^
> > 
> > nbd/server.c:1937:1: error: unused function
> > 'glib_slistautoptr_cleanup_NBDExtentArray' [-Werror,-Wunused-function]
> > 
> > /usr/include/glib-2.0/glib/gmacros.h:463:22: note: expanded from macro
> > 'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
> > 
> >   static inline void _GLIB_AUTOPTR_SLIST_FUNC_NAME(TypeName) (GSList
> > **_l) { g_slist_free_full (*_l, (GDestroyNotify) func); } \
> > 
> >                      ^
> > 
> > /usr/include/glib-2.0/glib/gmacros.h:445:49: note: expanded from macro
> > '_GLIB_AUTOPTR_SLIST_FUNC_NAME'
> > 
> > #define _GLIB_AUTOPTR_SLIST_FUNC_NAME(TypeName)
> > glib_slistautoptr_cleanup_##TypeName
> > 
> >                                                 ^
> > 
> > <scratch space>:171:1: note: expanded from here
> > 
> > glib_slistautoptr_cleanup_NBDExtentArray
> > 
> >  
> > 
> >  
> > 
> > I see Eric’s patch 9bda600b083(“build: Silence clang warning on older
> > glib autoptr usage”)
> > 
> > So I know there should be a ‘-Wno-unused-function’ in CFLAGS. It is
> > after ./configure:
> > 
> >  
> > 
> > CFLAGS            -g  -Wno-unused-function
> > 
> > QEMU_CFLAGS       -I/usr/include/pixman-1  -Werror  -pthread
> > -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
> > -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
> > -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef
> > -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common
> > -fwrapv -std=gnu99  -Wno-string-plus-int -Wno-typedef-redefinition
> > -Wno-initializer-overrides -Wexpansion-to-defined -Wendif-labels
> > -Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-body
> > -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self
> > -Wignored-qualifiers -Wold-style-definition -Wtype-limits
> > -fstack-protector-strong -I$(SRC_PATH)/capstone/include
> > 
> >  
> > 
> > However while I ‘make V=1’ I see the build nbd/serer.c using following
> > command:
> > 
> > clang-8 -iquote /home/test/qemu/nbd -iquote nbd -iquote
> > /home/test/qemu/tcg/i386 -isystem /home/test/qemu/linux-headers -isystem
> > /home/test/qemu/linux-headers -iquote . -iquote /home/test/qemu -iquote
> > /home/test/qemu/accel/tcg -iquote /home/test/qemu/include -iquote
> > /home/test/qemu/disas/libvixl -I/usr/include/pixman-1  -Werror  -pthread
> > -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
> > -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
> > -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef
> > -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common
> > -fwrapv -std=gnu99  -Wno-string-plus-int -Wno-typedef-redefinition
> > -Wno-initializer-overrides -Wexpansion-to-defined -Wendif-labels
> > -Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-body
> > -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self
> > -Wignored-qualifiers -Wold-style-definition -Wtype-limits
> > -fstack-protector-strong -I/home/test/qemu/capstone/include
> > -I/home/test/qemu/tests -I/home/test/qemu/tests/qtest -MMD -MP -MT
> > nbd/server.o -MF nbd/server.d -fsanitize=address,fuzzer-no-link  -c -o
> > nbd/server.o nbd/server.c
> > 
> >  
> > 
> > There’s no CFLAGS ‘-Wno-unused-function’.
> > 
> >  
> > 
> > So I want to know:
> > 
> > 1.    Wha’t the relation of CFLAGS and QEMU_CFLAGS, it seems the CFLAGS
> > doesn’t work in this.
> > 
> > 2.    Any hits to solve this? My env error or needs a patch?
> > 
> >  
> > 
> > I use following command in Ubuntu 18.04.1.
> > 
> > CC=clang-8 CXX=clang++-8  ./configure  --target-list="i386-softmmu" 
> > --enable-debug --enable-debug  --enable-kvm --enable-fuzzing
> > 
> >  
> > 
> >  
> > 
> > Thanks,
> > 
> > Li Qiang
> > 
> 

